# Pure CFC Cache Generation Script
# Focuses only on extracting component metadata and relationships
# Preserves existing cfc_cache.json structure for backward compatibility

param(
    [string]$pluginsPath = "D:\GIT\farcry\plugins",
    [string]$cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
)

# Import the relationship detection module
. ".\relationship_detection.ps1"

# Load configuration
$configFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json"
if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
    $knownTables = $config.entityConstraints.knownTables
    $excludeFiles = $config.scanSettings.excludeFiles
    $excludeFolders = $config.scanSettings.excludeFolders
    Write-Host "Loaded $($knownTables.Count) known tables" -ForegroundColor Cyan
} else {
    Write-Host "❌ Configuration file not found: $configFile" -ForegroundColor Red
    exit 1
}

# Function to extract component metadata from CFC content
function Get-ComponentMetadata {
    param(
        [string]$content,
        [string]$entityName,
        [string]$pluginName,
        [string]$filePath
    )
    
    $metadata = @{
        name = $entityName
        plugin = $pluginName
        file = $filePath
        filePath = ""  # Full path from /farcry down
        displayName = ""
        description = ""
        hint = ""
        inheritance = ""
        faIcon = ""
        displayTitle = ""
        bAudit = ""
        bArchive = ""
        bRefObjects = ""
        bObjectBroker = ""
        bSystem = ""
        bCustomType = ""
        bUseInTree = ""
        bFriendly = ""
        fuAlias = ""
        ObjectBrokerMaxObjects = ""
    }
    
    # Extract full path from /farcry down
    if ($filePath -match '.*?farcry[\/\\](.+)$') {
        $metadata.filePath = "/farcry/" + $matches[1].Replace('\', '/')
    } else {
        $metadata.filePath = $filePath
    }
    
    # Extract @@Description from HTML comments (multi-line)
    if ($content -match '<!---\s*@@Description:\s*([^-]+)--->') {
        $metadata.description = $matches[1].Trim()
    }
    
    # Extract displayname from cfcomponent tag
    if ($content -match 'displayname\s*=\s*"([^"]+)"') {
        $metadata.displayName = $matches[1]
    }
    
    # Extract hint from cfcomponent tag
    if ($content -match 'hint\s*=\s*"([^"]+)"') {
        $metadata.hint = $matches[1]
    }
    
    # Extract icon from cfcomponent tag
    if ($content -match 'icon\s*=\s*"([^"]+)"') {
        $metadata.faIcon = $matches[1]
    }
    
    # Extract inheritance (extends) from cfcomponent tag
    if ($content -match 'extends\s*=\s*"([^"]+)"') {
        $metadata.inheritance = $matches[1]
    }
    
    # Extract boolean attributes
    if ($content -match 'bAudit\s*=\s*"([^"]+)"') {
        $metadata.bAudit = $matches[1]
    }
    
    if ($content -match 'bArchive\s*=\s*"([^"]+)"') {
        $metadata.bArchive = $matches[1]
    }
    
    if ($content -match 'bRefObjects\s*=\s*"([^"]+)"') {
        $metadata.bRefObjects = $matches[1]
    }
    
    if ($content -match 'bObjectBroker\s*=\s*"([^"]+)"') {
        $metadata.bObjectBroker = $matches[1]
    }
    
    if ($content -match 'bSystem\s*=\s*"([^"]+)"') {
        $metadata.bSystem = $matches[1]
    }
    
    if ($content -match 'bCustomType\s*=\s*"([^"]+)"') {
        $metadata.bCustomType = $matches[1]
    }
    
    if ($content -match 'bUseInTree\s*=\s*"([^"]+)"') {
        $metadata.bUseInTree = $matches[1]
    }
    
    if ($content -match 'bFriendly\s*=\s*"([^"]+)"') {
        $metadata.bFriendly = $matches[1]
    }
    
    if ($content -match 'fuAlias\s*=\s*"([^"]+)"') {
        $metadata.fuAlias = $matches[1]
    }
    
    if ($content -match 'ObjectBrokerMaxObjects\s*=\s*"([^"]+)"') {
        $metadata.ObjectBrokerMaxObjects = $matches[1]
    }
    
    # If no displayName found, use the entity name
    if ([string]::IsNullOrWhiteSpace($metadata.displayName)) {
        $metadata.displayName = $entityName
    }
    
    # If no displayTitle found, use displayName
    if ([string]::IsNullOrWhiteSpace($metadata.displayTitle)) {
        $metadata.displayTitle = $metadata.displayName
    }
    
    return $metadata
}

# Function to scan CFCs and extract relationships and metadata
function Get-CFCRelationships {
    param([string]$basePath)
    
    # Match the exact structure that generate_erd_enhanced.ps1 expects
$relationships = @{
    directFK = @()
    joinTables = @()
    entities = @()
    properties = @()
    componentMetadata = @()  # New section for component metadata
}
    
    # Get scan directories from config
    $scanDirectories = $config.scanSettings.scanDirectories
    
    # Count total files to process
    $totalFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            if ($scanDir -like "*zfarcrycore*") {
                $packagesPath = Join-Path $scanDir "packages"
                if (Test-Path $packagesPath) {
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    $matchingFiles = $cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }
                    $totalFiles += $matchingFiles.Count
                }
            } else {
                $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
                foreach ($pluginFolder in $pluginFolders) {
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    if (Test-Path $packagesPath) {
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        $matchingFiles = $cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }
                        $totalFiles += $matchingFiles.Count
                    }
                }
            }
        }
    }
    
    Write-Host "Scanning CFC files for relationships and metadata... ($totalFiles files to process)" -ForegroundColor Cyan
    
    # Process files
    $processedFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            if ($scanDir -like "*zfarcrycore*") {
                $pluginName = "zfarcrycore"
                $packagesPath = Join-Path $scanDir "packages"
                if (Test-Path $packagesPath) {
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    
                    foreach ($cfcFile in $cfcFiles) {
                        $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                        
                        if ($knownTables -contains $entityName) {
                            $processedFiles++
                            $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                            Write-Host "`rProcessing: $entityName [$progress%]   " -NoNewline
                            
                            $content = Get-Content $cfcFile.FullName -Raw
                            
                            # Extract component metadata
                            $metadata = Get-ComponentMetadata -content $content -entityName $entityName -pluginName $pluginName -filePath $cfcFile.FullName
                            $relationships.componentMetadata += $metadata
                            
                            # Extract entity info (preserve existing structure)
                            $relationships.entities += @{
                                name = $entityName
                                plugin = $pluginName
                                file = $cfcFile.FullName
                            }
                            
                            # Use the relationship detection module
                            $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                            
                            # Merge relationships (match ERD script structure exactly)
                            $relationships.directFK += $entityRelationships.directFK
                            $relationships.joinTables += $entityRelationships.joinTables
                            $relationships.properties += $entityRelationships.properties
                        }
                    }
                }
            } else {
                $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
                
                foreach ($pluginFolder in $pluginFolders) {
                    $pluginName = $pluginFolder.Name
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    
                    if (Test-Path $packagesPath) {
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        
                        foreach ($cfcFile in $cfcFiles) {
                            $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                            
                            if ($knownTables -contains $entityName) {
                                $processedFiles++
                                $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                                Write-Host "`rProcessing: $entityName [$progress%]   " -NoNewline
                                
                                $content = Get-Content $cfcFile.FullName -Raw
                                
                                # Extract component metadata
                                $metadata = Get-ComponentMetadata -content $content -entityName $entityName -pluginName $pluginName -filePath $cfcFile.FullName
                                $relationships.componentMetadata += $metadata
                                
                                # Extract entity info (preserve existing structure)
                                $relationships.entities += @{
                                    name = $entityName
                                    plugin = $pluginName
                                    file = $cfcFile.FullName
                                }
                                
                                # Use the relationship detection module
                                $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                                
                                # Merge relationships (match ERD script structure exactly)
                                $relationships.directFK += $entityRelationships.directFK
                                $relationships.joinTables += $entityRelationships.joinTables
                                $relationships.properties += $entityRelationships.properties
                            }
                        }
                    }
                }
            }
        }
    }
    
    Write-Host "`nCFC scanning complete!" -ForegroundColor Green
    return $relationships
}

# Function to save relationships to cache
function Save-RelationshipsToCache {
    param(
        [object]$relationships,
        [string]$cacheFile
    )
    
    Write-Host "Saving relationships and metadata to cache: $cacheFile"
    
    # Ensure directory exists
    $cacheDir = Split-Path $cacheFile -Parent
    if (!(Test-Path $cacheDir)) {
        New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
    }
    
    # Convert to JSON and save
    $jsonContent = $relationships | ConvertTo-Json -Depth 10
    $jsonContent | Set-Content $cacheFile -Encoding UTF8
    
    Write-Host "Cache saved successfully!" -ForegroundColor Green
}

# Main execution
Write-Host "Regenerating CFC Cache..." -ForegroundColor Yellow
Write-Host "Scanning plugins path: $pluginsPath" -ForegroundColor Cyan

# Scan CFC files for relationships and metadata
$relationships = Get-CFCRelationships -basePath $pluginsPath

# Save to cache
Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile

Write-Host "Cache regeneration complete!" -ForegroundColor Green
Write-Host "Found $($relationships.entities.Count) entities" -ForegroundColor Cyan
Write-Host "Found $($relationships.componentMetadata.Count) component metadata entries" -ForegroundColor Cyan
Write-Host "Found $($relationships.directFK.Count) direct FK relationships" -ForegroundColor Cyan
Write-Host "Found $($relationships.joinTables.Count) join table relationships" -ForegroundColor Cyan
Write-Host "Found $($relationships.properties.Count) properties" -ForegroundColor Cyan

# Show some sample metadata
Write-Host "`nSample component metadata:" -ForegroundColor Yellow
$sampleMetadata = $relationships.componentMetadata | Select-Object -First 3
foreach ($metadata in $sampleMetadata) {
    Write-Host "  $($metadata.name): $($metadata.displayName) ($($metadata.plugin))" -ForegroundColor Cyan
    if ($metadata.description) {
        Write-Host "    Description: $($metadata.description)" -ForegroundColor Gray
    }
    if ($metadata.inheritance) {
        Write-Host "    Extends: $($metadata.inheritance)" -ForegroundColor Gray
    }
} 