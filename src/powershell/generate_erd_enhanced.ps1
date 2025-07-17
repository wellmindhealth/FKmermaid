param(
    [string]$lDomains = "",
    [string]$lFocus = "",
    [switch]$RefreshCFCs = $false,
    [string]$ConfigFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json"
)

# Load configuration
function Load-Config {
    param([string]$configFile)
    
    if (Test-Path $configFile) {
        try {
            $config = Get-Content $configFile -Raw | ConvertFrom-Json
            return $config
        } catch {
            Write-Host "Error loading config file: $($_.Exception.Message)"
            return $null
        }
    } else {
        Write-Host "Config file not found: $configFile"
        return $null
    }
}

# Load configuration
$config = Load-Config -configFile $ConfigFile
if ($null -eq $config) {
    Write-Host "Failed to load configuration. Exiting."
    exit 1
}

# Extract settings from config
$pluginsPath = $config.scanSettings.pluginsPath
$excludeFolders = $config.scanSettings.excludeFolders
$excludeFiles = $config.scanSettings.excludeFiles
$cacheFile = $config.scanSettings.cacheFile
$outputFile = $config.scanSettings.outputFile
$knownTables = $config.entityConstraints.knownTables

# Function to scan CFCs and extract relationships
function Get-CFCRelationships {
    param([string]$basePath)
    
    $relationships = @{
        directFK = @()
        joinTables = @()
        entities = @()
        properties = @()
    }
    
    # Get scan directories from config
    $scanDirectories = $config.scanSettings.scanDirectories
    
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            # Scan all plugin folders except excluded ones
            $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
            
            foreach ($pluginFolder in $pluginFolders) {
                $pluginName = $pluginFolder.Name
                
                # Scan for CFC files in packages/types directory
                $typesPath = Join-Path $pluginFolder.FullName "packages\types"
                if (Test-Path $typesPath) {
                    $cfcFiles = Get-ChildItem -Path $typesPath -Filter "*.cfc" | Where-Object { $excludeFiles -notcontains $_.Name }
                    
                    foreach ($cfcFile in $cfcFiles) {
                        $content = Get-Content $cfcFile.FullName -Raw
                        
                        # Extract entity name from filename
                        $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                        
                        # Only process if entity is in known tables
                        if ($knownTables -contains $entityName) {
                            # Extract entity info
                            $relationships.entities += @{
                                name = $entityName
                                plugin = $pluginName
                                file = $cfcFile.FullName
                            }
                            
                            # Extract all properties with ftJoin using config pattern
                            $pattern = $config.relationshipPatterns.directFK.pattern
                            $propertyMatches = [regex]::Matches($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
                            foreach ($match in $propertyMatches) {
                                $propertyName = $match.Groups[1].Value
                                $targetEntity = $match.Groups[2].Value
                                
                                # Check if it's an array using config pattern
                                $arrayPattern = $config.relationshipPatterns.directFK.arrayPattern
                                $isArray = [regex]::IsMatch($content, "name=`"$propertyName`".*?$arrayPattern", [System.Text.RegularExpressions.RegexOptions]::Singleline)
                                
                                if ($isArray) {
                                    # Join table relationship using config naming pattern
                                    $joinTableName = $config.relationshipPatterns.joinTables.namingPattern -replace "{entity}", $entityName -replace "{target}", $targetEntity
                                    $relationships.joinTables += @{
                                        source = $entityName
                                        sourcePlugin = $pluginName
                                        target = $targetEntity
                                        property = $propertyName
                                        joinTable = $joinTableName
                                    }
                                } else {
                                    # Direct FK relationship
                                    $relationships.directFK += @{
                                        source = $entityName
                                        sourcePlugin = $pluginName
                                        target = $targetEntity
                                        property = $propertyName
                                    }
                                }
                                
                                # Store property info
                                $relationships.properties += @{
                                    entity = $entityName
                                    plugin = $pluginName
                                    property = $propertyName
                                    target = $targetEntity
                                    isArray = $isArray
                                }
                            }
                            
                            # Extract all properties for attributes (not just relationships)
                            $propertyPattern = $config.propertyExtraction.propertyPattern
                            $ftTypePattern = $config.propertyExtraction.ftTypePattern
                            $allPropertyMatches = [regex]::Matches($content, $propertyPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
                            foreach ($match in $allPropertyMatches) {
                                $propertyName = $match.Groups[1].Value
                                $propertyType = $match.Groups[2].Value
                                
                                # Get ftType if available
                                $ftTypeMatch = [regex]::Match($content, "name=`"$propertyName`".*?$ftTypePattern", [System.Text.RegularExpressions.RegexOptions]::Singleline)
                                $ftType = if ($ftTypeMatch.Success) { $ftTypeMatch.Groups[1].Value } else { $propertyType }
                                
                                # Only add if not already added as a relationship property
                                $existingProperty = $relationships.properties | Where-Object { $_.entity -eq $entityName -and $_.property -eq $propertyName }
                                if (-not $existingProperty) {
                                    $relationships.properties += @{
                                        entity = $entityName
                                        plugin = $pluginName
                                        property = $propertyName
                                        ftType = $ftType
                                        isArray = $false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    return $relationships
}

# Function to load cached relationships
function Load-CachedRelationships {
    param([string]$cacheFile)
    
    if (Test-Path $cacheFile) {
        try {
            $cachedData = Get-Content $cacheFile -Raw | ConvertFrom-Json
            return $cachedData
        } catch {
            Write-Host "Error loading cache file: $($_.Exception.Message)"
            return $null
        }
    }
    return $null
}

# Function to save relationships to cache
function Save-RelationshipsToCache {
    param($relationships, [string]$cacheFile)
    
    $cacheDir = Split-Path $cacheFile -Parent
    if (!(Test-Path $cacheDir)) {
        New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
    }
    
    try {
        $relationships | ConvertTo-Json -Depth 10 | Set-Content $cacheFile
        Write-Host "Cached relationships saved to: $cacheFile"
    } catch {
        Write-Host "Error saving cache file: $($_.Exception.Message)"
    }
}

# Function to get plugin prefix for an entity
function Get-EntityPluginPrefix {
    param([string]$entityName)
    
    $entityMapping = $config.entityConstraints.entityPluginMapping
    if ($entityMapping.$entityName) {
        return $entityMapping.$entityName
    } else {
        # Default to pathway if not specified
        return "pathway"
    }
}

# Function to generate Mermaid ER diagram
function Generate-MermaidERD {
    param($relationships, $knownTables)
    
    $mermaidContent = "erDiagram`n"
    
    # Get list of actual entities that exist
    $existingEntities = $relationships.entities | ForEach-Object { $_.name }
    
    # Add entities with proper attributes
    foreach ($entity in $relationships.entities) {
        $entityName = $entity.name
        $pluginPrefix = Get-EntityPluginPrefix -entityName $entityName
        
        # Only include entities from known tables and ensure name is complete
        if ($knownTables -contains $entityName -and $entityName -and $entityName.Length -gt 0) {
            $entityDisplayName = if ($config.outputSettings.includePluginPrefix) { "$pluginPrefix - $entityName" } else { $entityName }
            $mermaidContent += "    `"$entityDisplayName`" {`n"
            $mermaidContent += "        UUID ObjectID`n"
            
            # Add attributes if enabled
            if ($config.outputSettings.includeAttributes) {
                $entityProps = $relationships.properties | Where-Object { $_.entity -eq $entityName }
                $maxProps = $config.propertyExtraction.maxPropertiesPerEntity
                $excludeProps = $config.propertyExtraction.excludeProperties
                
                foreach ($prop in $entityProps | Select-Object -First $maxProps) {
                    if ($prop.property -and $prop.property.Length -gt 0 -and $excludeProps -notcontains $prop.property) {
                        if ($config.outputSettings.validatePropertyNames) {
                            $dataType = Get-PropertyDataType $prop.ftType
                            $sanitizedPropertyName = Get-SanitizedPropertyName $prop.property
                            $mermaidContent += "        $dataType $sanitizedPropertyName`n"
                        }
                    }
                }
            }
            $mermaidContent += "    }`n`n"
        }
    }
    
    # Add relationships if enabled
    if ($config.outputSettings.includeRelationships) {
        $mermaidContent += "    %% Direct FK Relationships`n"
        foreach ($rel in $relationships.directFK) {
            $sourceEntity = $rel.source
            $targetEntity = $rel.target
            $sourcePlugin = Get-EntityPluginPrefix -entityName $sourceEntity
            $targetPlugin = Get-EntityPluginPrefix -entityName $targetEntity
            $relationshipName = $rel.property
            
            # Only include if both entities exist, are in known tables, and have valid names
            # AND both entities are actually defined in the entity list
            if ($sourceEntity -and $targetEntity -and $relationshipName -and
                $existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity -and 
                $knownTables -contains $sourceEntity -and $knownTables -contains $targetEntity) {
                
                $sourceDisplayName = if ($config.outputSettings.includePluginPrefix) { "$sourcePlugin - $sourceEntity" } else { $sourceEntity }
                $targetDisplayName = if ($config.outputSettings.includePluginPrefix) { "$targetPlugin - $targetEntity" } else { $targetEntity }
                $cardinality = $config.relationshipPatterns.directFK.cardinality
                $mermaidContent += "    `"$sourceDisplayName`" $cardinality `"$targetDisplayName`" : $relationshipName`n"
            }
        }
        
        # Add join table relationships if enabled
        if ($config.outputSettings.includeJoinTables) {
            $mermaidContent += "`n    %% Join Table Relationships`n"
            foreach ($rel in $relationships.joinTables) {
                $joinTable = $rel.joinTable
                $sourceEntity = $rel.source
                $targetEntity = $rel.target
                $sourcePlugin = Get-EntityPluginPrefix -entityName $sourceEntity
                $targetPlugin = Get-EntityPluginPrefix -entityName $targetEntity
                $joinPlugin = Get-EntityPluginPrefix -entityName $joinTable
                
                # Only include if all entities exist, are in known tables, and have valid names
                # AND all entities are actually defined in the entity list
                if ($joinTable -and $sourceEntity -and $targetEntity -and
                    $existingEntities -contains $joinTable -and $existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity -and
                    $knownTables -contains $joinTable -and $knownTables -contains $sourceEntity -and $knownTables -contains $targetEntity) {
                    
                    $joinDisplayName = if ($config.outputSettings.includePluginPrefix) { "$joinPlugin - $joinTable" } else { $joinTable }
                    $sourceDisplayName = if ($config.outputSettings.includePluginPrefix) { "$sourcePlugin - $sourceEntity" } else { $sourceEntity }
                    $targetDisplayName = if ($config.outputSettings.includePluginPrefix) { "$targetPlugin - $targetEntity" } else { $targetEntity }
                    $mermaidContent += "    `"$joinDisplayName`" ||--|| `"$sourceDisplayName`" : parentid`n"
                    $mermaidContent += "    `"$joinDisplayName`" ||--|| `"$targetDisplayName`" : data`n"
                }
            }
        }
    }
    
    return $mermaidContent
}

# Function to get proper Mermaid data type
function Get-PropertyDataType {
    param([string]$ftType)
    
    $dataTypes = $config.propertyExtraction.dataTypes
    if ($dataTypes.$ftType) {
        return $dataTypes.$ftType
    } else {
        return $dataTypes.default
    }
}

# Function to sanitize property names for Mermaid
function Get-SanitizedPropertyName {
    param([string]$propertyName)
    
    # Replace spaces and special characters with underscores
    $sanitized = $propertyName -replace '[^a-zA-Z0-9_]', '_'
    # Remove multiple consecutive underscores
    $sanitized = $sanitized -replace '_+', '_'
    # Remove leading/trailing underscores
    $sanitized = $sanitized.Trim('_')
    # Ensure it starts with a letter or underscore
    if ($sanitized -match '^[0-9]') {
        $sanitized = "prop_$sanitized"
    }
    return $sanitized
}

# Main execution
Write-Host "FarCry ERD Generator (Enhanced)"
Write-Host "==============================="

# Determine whether to use fresh scan or cached data
if ($RefreshCFCs -or !(Test-Path $cacheFile)) {
    Write-Host "Scanning CFC files for relationships..."
    $relationships = Get-CFCRelationships -basePath $pluginsPath
    Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile
} else {
    Write-Host "Loading cached relationships from: $cacheFile"
    $relationships = Load-CachedRelationships -cacheFile $cacheFile
    if ($null -eq $relationships) {
        Write-Host "Cache file corrupted or empty, scanning CFC files..."
        $relationships = Get-CFCRelationships -basePath $pluginsPath
        Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile
    }
}

Write-Host "Found $($relationships.entities.Count) entities"
Write-Host "Found $($relationships.directFK.Count) direct FK relationships"
Write-Host "Found $($relationships.joinTables.Count) join table relationships"

# Generate Mermaid ERD
$mermaidContent = Generate-MermaidERD -relationships $relationships -knownTables $knownTables

# Ensure exports directory exists
$exportsDir = Split-Path $outputFile -Parent
if (!(Test-Path $exportsDir)) {
    New-Item -ItemType Directory -Path $exportsDir -Force | Out-Null
}

# Save to file in exports directory
$mermaidContent | Set-Content $outputFile
Write-Host "ERD saved to: $outputFile"

# Generate HTML file with embedded browser opening functionality
$ProjectRoot = "D:\GIT\farcry\Cursor\FKmermaid"
$htmlFile = Join-Path $ProjectRoot "exports\plugins_full_erd_$(Get-Date -Format 'yyyyMMddHHmmss').html"

$mermaidLiveHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Plugins Full ER Diagram - Mermaid Live Editor</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 0;
            height: 100vh;
            background: #f5f5f5;
        }
        .left-panel {
            width: 15%;
            min-width: 250px;
            padding: 12px;
            background: white;
            font-size: 12px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            overflow-y: auto;
        }
        .code-block {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-family: monospace;
            white-space: pre-wrap;
            margin: 8px 0;
            font-size: 12px;
            max-height: 60vh;
            overflow-y: auto;
            width: 100%;
            box-sizing: border-box;
            cursor: text;
            user-select: text;
        }
        .code-block:hover {
            border-color: #2196F3;
        }
        .button {
            background: #2196F3;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            margin: 4px 0;
            white-space: nowrap;
            width: 100%;
            text-align: center;
            text-decoration: none;
            display: block;
            box-sizing: border-box;
        }
        .button:hover {
            background: #1976D2;
        }
        .success-message {
            display: none;
            color: #4CAF50;
            margin: 4px 0;
            font-size: 12px;
            padding: 4px;
            background: #E8F5E9;
            border-radius: 4px;
            text-align: center;
        }
        .error-message {
            display: none;
            color: #FF9800;
            margin: 4px 0;
            font-size: 12px;
            padding: 4px;
            background: #FFF3E0;
            border-radius: 4px;
            text-align: center;
        }
        h1 { 
            margin: 0 0 8px 0; 
            font-size: 1.4em;
            font-weight: bold;
        }
        h2 {
            margin: 8px 0;
            font-size: 1.1em;
            font-weight: normal;
        }
        h3 {
            margin: 8px 0;
            font-size: 1em;
        }
        h4 {
            margin: 8px 0;
            font-size: 0.9em;
            font-weight: bold;
        }
        .instructions {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 4px;
            margin: 8px 0;
            font-size: 12px;
        }
        #paste-reminder {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background: #E3F2FD;
            padding: 12px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            z-index: 1000;
            font-size: 14px;
            animation: fadeInOut 5s forwards;
        }
        @keyframes fadeInOut {
            0% { opacity: 0; }
            10% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="left-panel">
        <h1>Plugins Full ER</h1>
        <h2>Complete plugins ER diagram with all relationships</h2>
        <h3>ER Diagram</h3>
        <div class="instructions">
            <h4>Quick Steps</h4>
            <ol>
                <li>Click "Open Editor & Copy"</li>
                <li>Wait for editor to load</li>
                <li>Press Ctrl+V to paste</li>
            </ol>
        </div>
        <button class="button" onclick="openEditorAndCopy()">Open Editor & Copy</button>
        <div id="copySuccess" class="success-message">✓ Code copied! Press Ctrl+V to paste</div>
        <div id="copyError" class="error-message">Failed to copy code. Please select and copy manually.</div>
        <button class="button" onclick="manualCopy()" style="background: #FF9800; margin-top: 8px;">📋 Manual Copy Only</button>
        <button class="button" onclick="showDebugInfo()" style="background: #9C27B0; margin-top: 4px;">🐛 Debug Info</button>
        <div class="code-block" id="mermaidSource">$mermaidContent</div>
    </div>

    <div id="paste-reminder">
        Press Ctrl+V to paste your diagram code!
    </div>

    <script>
    function showPasteReminder() {
        const reminder = document.getElementById('paste-reminder');
        reminder.style.display = 'block';
        setTimeout(() => {
            reminder.style.display = 'none';
        }, 5000);
    }

    function openEditorAndCopy() {
        // Get the code from the div instead of using a template string
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        
        console.log('Attempting to copy:', mermaidContent.substring(0, 100) + '...');
        console.log('Full content length:', mermaidContent.length);
        
        // Try modern clipboard API first
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(mermaidContent).then(() => {
                console.log('Clipboard API success');
                // Show success message
                const msg = document.getElementById('copySuccess');
                msg.style.display = 'block';
                setTimeout(() => msg.style.display = 'none', 3000);
                
                // Open Mermaid Live Editor in new tab
                window.open('https://mermaid.live/edit', '_blank');
                
                // Show paste reminder
                showPasteReminder();
            }).catch(err => {
                console.error('Clipboard API failed:', err);
                showCopyError();
            });
        } else {
            console.log('Using fallback copy method');
            fallbackCopy();
        }
        
        function fallbackCopy() {
            try {
                const textArea = document.createElement('textarea');
                textArea.value = mermaidContent;
                textArea.style.position = 'fixed';
                textArea.style.left = '-999999px';
                textArea.style.top = '-999999px';
                document.body.appendChild(textArea);
                textArea.focus();
                textArea.select();
                const successful = document.execCommand('copy');
                document.body.removeChild(textArea);
                
                if (successful) {
                    console.log('execCommand success');
                    const msg = document.getElementById('copySuccess');
                    msg.style.display = 'block';
                    msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                    setTimeout(() => msg.style.display = 'none', 3000);
                    
                    // Open editor with URL parameters
                    const editorUrl = 'https://mermaid.live/edit';
                    
                    // Open Mermaid Live Editor in new tab
                    window.open(editorUrl, '_blank');
                    
                    setTimeout(showPasteReminder, 1000);
                } else {
                    console.log('execCommand failed');
                    showCopyError();
                }
            } catch (err) {
                console.error('execCommand error:', err);
                showCopyError();
            }
        }

        function showCopyError() {
            const msg = document.getElementById('copyError');
            msg.style.display = 'block';
            setTimeout(() => msg.style.display = 'none', 5000);
        }
    }

    function manualCopy() {
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(mermaidContent).then(() => {
                const msg = document.getElementById('copySuccess');
                msg.style.display = 'block';
                msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                setTimeout(() => msg.style.display = 'none', 3000);
                console.log('Manual copy successful via Clipboard API');
            }).catch(err => {
                const msg = document.getElementById('copyError');
                msg.style.display = 'block';
                msg.textContent = 'Failed to copy code. Please select and copy manually.';
                setTimeout(() => msg.style.display = 'none', 5000);
                console.error('Manual copy failed via Clipboard API:', err);
            });
        } else {
            try {
                const textArea = document.createElement('textarea');
                textArea.value = mermaidContent;
                textArea.style.position = 'fixed';
                textArea.style.left = '-999999px';
                textArea.style.top = '-999999px';
                document.body.appendChild(textArea);
                textArea.focus();
                textArea.select();
                const successful = document.execCommand('copy');
                document.body.removeChild(textArea);
                if (successful) {
                    const msg = document.getElementById('copySuccess');
                    msg.style.display = 'block';
                    msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                    setTimeout(() => msg.style.display = 'none', 3000);
                    console.log('Manual copy successful via execCommand');
                } else {
                    const msg = document.getElementById('copyError');
                    msg.style.display = 'block';
                    msg.textContent = 'Failed to copy code. Please select and copy manually.';
                    setTimeout(() => msg.style.display = 'none', 5000);
                    console.log('Manual copy failed via execCommand');
                }
            } catch (err) {
                const msg = document.getElementById('copyError');
                msg.style.display = 'block';
                msg.textContent = 'Failed to copy code. Please select and copy manually.';
                setTimeout(() => msg.style.display = 'none', 5000);
                console.error('Manual copy failed via execCommand:', err);
            }
        }
    }

    function showDebugInfo() {
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        console.log('=== DEBUG INFO ===');
        console.log('Content length:', mermaidContent.length);
        console.log('First 200 chars:', mermaidContent.substring(0, 200));
        console.log('Last 100 chars:', mermaidContent.substring(mermaidContent.length - 100));
        console.log('Contains "erDiagram":', mermaidContent.includes('erDiagram'));
        console.log('Contains "classDiagram":', mermaidContent.includes('classDiagram'));
        console.log('Full content:');
        console.log(mermaidContent);
        
        // Show in an alert for easy viewing
        alert('Content length: ' + mermaidContent.length + '\n\nFirst 200 chars:\n' + mermaidContent.substring(0, 200) + '\n\nContains erDiagram: ' + mermaidContent.includes('erDiagram'));
    }
    </script>
</body>
</html>
"@

$mermaidLiveHtml | Set-Content -Path $htmlFile

# Open the HTML file in browser
Start-Process $htmlFile

Write-Host "✅ Enhanced ERD generation complete!"
Write-Host "📁 MMD file: $outputFile"
Write-Host "🌐 HTML file: $htmlFile"
Write-Host "🔗 Browser should have opened automatically" 