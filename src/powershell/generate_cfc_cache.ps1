# Pure CFC Cache Generation Script
# Focuses only on extracting component metadata and relationships
# Preserves existing cfc_cache.json structure for backward compatibility

param(
    [string]$pluginsPath = "D:\GIT\farcry\plugins",
    [string]$cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
)

# Import the relationship detection module
. "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\relationship_detection.ps1"

# Load configuration
$configFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json"
$exclusionsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\exclusions.json"

if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
    $knownTables = $config.entityConstraints.knownTables
    Write-Host "Loaded $($knownTables.Count) known tables" -ForegroundColor Cyan
} else {
    Write-Host "❌ Configuration file not found: $configFile" -ForegroundColor Red
    exit 1
}

# Load exclusions from the dedicated exclusions file
if (Test-Path $exclusionsFile) {
    $exclusions = Get-Content $exclusionsFile -Raw | ConvertFrom-Json
    $excludeFiles = $exclusions.excludeFiles
    Write-Host "Loaded $($excludeFiles.Count) excluded files" -ForegroundColor Cyan
} else {
    Write-Host "❌ Exclusions file not found: $exclusionsFile" -ForegroundColor Red
    exit 1
}

# Function to format description with proper line breaks
function Format-Description {
    param([string]$rawDescription)
    
    # Split by common section headers
    $sections = @()
    $currentSection = ""
    $lines = $rawDescription -split "`n"
    
    foreach ($line in $lines) {
        $trimmedLine = $line.Trim()
        
        # Check if this is a section header (ends with colon and is followed by content)
        if ($trimmedLine -match '^([^:]+):\s*$') {
            # If we have accumulated content, save the previous section
            if ($currentSection.Trim()) {
                $sections += $currentSection.Trim()
            }
            # Start new section with the header
            $currentSection = $trimmedLine + "`n"
        } else {
            # Add line to current section
            $currentSection += $trimmedLine + "`n"
        }
    }
    
    # Add the last section
    if ($currentSection.Trim()) {
        $sections += $currentSection.Trim()
    }
    
    # If no sections found, try to split by common patterns
    if ($sections.Count -eq 0) {
        # Look for common section patterns
        $patterns = @(
            'Business Context:',
            'Technical Role:',
            'Key Relationships:',
            'Clinical Context:',
            'Administrative Context:',
            'Data Management:',
            'Security Considerations:',
            'Integration Points:'
        )
        
        $formatted = $rawDescription
        foreach ($pattern in $patterns) {
            # Replace pattern with line break + pattern
            $formatted = $formatted -replace "($pattern)", "`n`n$1"
        }
        
        # Clean up extra whitespace
        $formatted = $formatted -replace "`n`n`n+", "`n`n"
        $formatted = $formatted.Trim()
        
        return $formatted
    }
    
    # Join sections with double line breaks
    $formatted = $sections -join "`n`n"
    
    return $formatted
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
    if ($content -match '<!---\s*@@Description:\s*([\s\S]*?)--->') {
        $rawDescription = $matches[1].Trim()
        
        # Format the description with proper line breaks
        $formattedDescription = Format-Description -rawDescription $rawDescription
        $metadata.description = $formattedDescription
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

# Function to enhance metadata with inheritance information
function Enhance-MetadataWithInheritance {
    param(
        [array]$componentMetadata
    )
    
    Write-Host "Enhancing metadata with inheritance information..." -ForegroundColor Cyan
    
    # Create a lookup table for quick access
    $metadataLookup = @{}
    foreach ($metadata in $componentMetadata) {
        $metadataLookup[$metadata.name] = $metadata
    }
    
    # Process each component to enhance with parent metadata
    foreach ($metadata in $componentMetadata) {
        if ($metadata.inheritance) {
            Write-Host "  🔍 Checking inheritance for $($metadata.name): $($metadata.inheritance)" -ForegroundColor Yellow
            
            # Traverse inheritance path to find best metadata
            $currentInheritance = $metadata.inheritance
            $abstractBaseClasses = @("types", "versions", "fourq", "forms", "security", "lib", "farcry")
            $bestHint = ""
            $bestDescription = ""
            $bestDisplayName = ""
            $bestFaIcon = ""
            $visitedComponents = @()  # Prevent infinite loops
            
            while ($currentInheritance) {
                # Extract component name from inheritance path
                $inheritanceParts = $currentInheritance.Split('.')
                $componentName = $inheritanceParts[-1]
                
                Write-Host "    📋 Checking: $componentName" -ForegroundColor Gray
                
                # Stop if we hit an abstract base class
                if ($abstractBaseClasses -contains $componentName) {
                    Write-Host "    ⚠️  Stopping at abstract base class: $componentName" -ForegroundColor Yellow
                    break
                }
                
                # Prevent infinite loops
                if ($visitedComponents -contains $componentName) {
                    Write-Host "    ⚠️  Circular reference detected: $componentName" -ForegroundColor Red
                    break
                }
                $visitedComponents += $componentName
                
                # Look for this component in cache
                if ($metadataLookup.ContainsKey($componentName)) {
                    $parent = $metadataLookup[$componentName]
                    Write-Host "    ✅ Found: $($parent.name) (plugin: $($parent.plugin))" -ForegroundColor Green
                    
                    # Track best metadata found
                    if ($parent.hint -and -not $bestHint) { $bestHint = $parent.hint }
                    if ($parent.description -and -not $bestDescription) { $bestDescription = $parent.description }
                    if ($parent.displayName -and -not $bestDisplayName) { $bestDisplayName = $parent.displayName }
                    if ($parent.faIcon -and -not $bestFaIcon) { $bestFaIcon = $parent.faIcon }
                    
                    # Continue up the inheritance chain
                    $currentInheritance = $parent.inheritance
                } else {
                    Write-Host "    ❌ Component '$componentName' not found in cache" -ForegroundColor Red
                    break
                }
            }
            
            # Apply best metadata found
            if ($bestHint -and [string]::IsNullOrWhiteSpace($metadata.hint)) {
                $metadata.hint = $bestHint
                Write-Host "    📋 $($metadata.name) inherited hint: '$bestHint'" -ForegroundColor Gray
            }
            
            if ($bestDescription -and [string]::IsNullOrWhiteSpace($metadata.description)) {
                $metadata.description = $bestDescription
                Write-Host "    📋 $($metadata.name) inherited description: '$bestDescription'" -ForegroundColor Gray
            }
            
            if ($bestDisplayName -and [string]::IsNullOrWhiteSpace($metadata.displayName)) {
                $metadata.displayName = $bestDisplayName
                Write-Host "    📋 $($metadata.name) inherited displayName: '$bestDisplayName'" -ForegroundColor Gray
            }
            
            if ($bestFaIcon -and [string]::IsNullOrWhiteSpace($metadata.faIcon)) {
                $metadata.faIcon = $bestFaIcon
                Write-Host "    📋 $($metadata.name) inherited faIcon: '$bestFaIcon'" -ForegroundColor Gray
            }
        }
    }
    
    Write-Host "Inheritance enhancement complete!" -ForegroundColor Green
    return $componentMetadata
}

# Function to extract all properties from CFC content
function Get-AllProperties {
    param(
        [string]$content,
        [string]$entityName
    )
    
    $properties = @()
    
    # Use the same regex patterns as relationship_detection.ps1
    $cfPropertyMatches = @()
    
    # First, try to find complete cfproperty tags (self-closing)
    $selfClosingMatches = [regex]::Matches($content, '<cfproperty[^>]*?>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $selfClosingMatches) {
        $cfPropertyMatches += $match
    }
    
    # Then find opening cfproperty tags that might span multiple lines
    $openingMatches = [regex]::Matches($content, '<cfproperty[^>]*>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $openingMatches) {
        # Skip if this is already a self-closing tag
        if ($match.Value -notmatch '>$') {
            $cfPropertyMatches += $match
        }
    }
    
    # Handle multiline cfproperty tags that don't close properly
    $multilineMatches = [regex]::Matches($content, '<cfproperty[^>]*?\/>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $multilineMatches) {
        # Skip if this is already captured by self-closing pattern
        if ($match.Value -notmatch '^<cfproperty[^>]*?>$') {
            $cfPropertyMatches += $match
        }
    }
    
    # Handle multiline cfproperty tags that end with > (not />)
    $multilineOpenMatches = [regex]::Matches($content, '<cfproperty[^>]*?[^\/]>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $multilineOpenMatches) {
        # Skip if this is already captured by opening pattern
        if ($match.Value -notmatch '^<cfproperty[^>]*>$') {
            $cfPropertyMatches += $match
        }
    }
    
    foreach ($match in $cfPropertyMatches) {
        $cfPropertyTag = $match.Value
        
        # Parse attributes from the opening tag
        $attributes = Parse-CFPropertyAttributes -cfPropertyTag $cfPropertyTag
        
        # Skip if attributes is null or no name attribute
        if (-not $attributes -or -not $attributes.ContainsKey("name")) { continue }
        
        $propertyName = $attributes["name"]
        
        # Create property object with all available attributes
        $property = @{
            name = $propertyName
            entity = $entityName
            type = $attributes.ContainsKey("type") ? $attributes["type"] : ""
            hint = $attributes.ContainsKey("hint") ? $attributes["hint"] : ""
            required = $attributes.ContainsKey("required") ? $attributes["required"] : ""
            default = $attributes.ContainsKey("default") ? $attributes["default"] : ""
            ftJoin = $attributes.ContainsKey("ftJoin") ? $attributes["ftJoin"] : ""
            ftType = $attributes.ContainsKey("ftType") ? $attributes["ftType"] : ""
            ftLabel = $attributes.ContainsKey("ftLabel") ? $attributes["ftLabel"] : ""
            ftSeq = $attributes.ContainsKey("ftSeq") ? $attributes["ftSeq"] : ""
            ftFieldset = $attributes.ContainsKey("ftFieldset") ? $attributes["ftFieldset"] : ""
            ftWizardStep = $attributes.ContainsKey("ftWizardStep") ? $attributes["ftWizardStep"] : ""
            ftRenderType = $attributes.ContainsKey("ftRenderType") ? $attributes["ftRenderType"] : ""
            ftLibraryData = $attributes.ContainsKey("ftLibraryData") ? $attributes["ftLibraryData"] : ""
            ftDefault = $attributes.ContainsKey("ftDefault") ? $attributes["ftDefault"] : ""
            ftHint = $attributes.ContainsKey("ftHint") ? $attributes["ftHint"] : ""
            displayName = $attributes.ContainsKey("displayName") ? $attributes["displayName"] : ""
        }
        
        $properties += $property
    }
    
    return $properties
}

# Function to scan CFCs and extract relationships and metadata
function Get-CFCRelationships {
    param([string]$basePath)
    
    # Match the exact structure that generate_erd_domain_colors.ps1 expects
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
            $cfcFiles = Get-ChildItem -Path $scanDir -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
            $matchingFiles = $cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }
            $totalFiles += $matchingFiles.Count
        }
    }
    
    Write-Host "Scanning CFC files for relationships and metadata... ($totalFiles files to process)" -ForegroundColor Cyan
    
    # Process files
    $processedFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            # Determine plugin name from path
            if ($scanDir -like "*zfarcrycore*") {
                $pluginName = "zfarcrycore"
            } else {
                # Extract plugin name from path (e.g., "D:\GIT\farcry\plugins\pathway" -> "pathway")
                $pluginName = Split-Path $scanDir -Leaf
            }
            
            $cfcFiles = Get-ChildItem -Path $scanDir -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
            
            foreach ($cfcFile in $cfcFiles) {
                $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                
                if ($knownTables -contains $entityName) {
                    $processedFiles++
                    $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                    Write-Host "`rProcessing: $entityName [$progress%]   " -NoNewline
                    
                    $content = Get-Content $cfcFile.FullName -Raw
                    
                    # Extract component metadata
                    $metadata = Get-ComponentMetadata -content $content -entityName $entityName -pluginName $pluginName -filePath $cfcFile.FullName
                    
                    # Extract all properties for this component
                    $allProperties = Get-AllProperties -content $content -entityName $entityName
                    $metadata.properties = $allProperties
                    
                    # Debug output for components with no properties
                    if ($allProperties.Count -eq 0) {
                        Write-Host "  ⚠️  No properties found for $entityName" -ForegroundColor Yellow
                    }
                    
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
    
    Write-Host "`nCFC scanning complete!" -ForegroundColor Green
    
    # Enhance metadata with inheritance information
    $relationships.componentMetadata = Enhance-MetadataWithInheritance -componentMetadata $relationships.componentMetadata
    
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

# Update catchall with uncategorized entities
Write-Host "`n🔄 Updating catchall with uncategorized entities..." -ForegroundColor Cyan

$domainsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\domains.json"
if (Test-Path $domainsFile) {
    # Load domains.json
    $domainsData = Get-Content $domainsFile -Raw | ConvertFrom-Json
    
    # Get all entities from cache
    $allEntities = $relationships.entities | ForEach-Object { $_.name }
    
    Write-Host "📊 Found $($allEntities.Count) total entities in cache" -ForegroundColor Green
    
    # Get all entities already categorized in domains
    $categorizedEntities = @()
    foreach ($domain in $domainsData.domains.PSObject.Properties) {
        foreach ($layer in $domain.Value.entities.PSObject.Properties) {
            $categorizedEntities += $layer.Value
        }
    }
    
    Write-Host "📊 Found $($categorizedEntities.Count) categorized entities" -ForegroundColor Green
    
    # Find uncategorized entities
    $uncategorizedEntities = $allEntities | Where-Object { $_ -notin $categorizedEntities }
    
    Write-Host "📊 Found $($uncategorizedEntities.Count) uncategorized entities" -ForegroundColor Yellow
    
    if ($uncategorizedEntities.Count -gt 0) {
        Write-Host "🔍 Uncategorized entities:" -ForegroundColor Yellow
        $uncategorizedEntities | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
        
        # Update catchall with uncategorized entities
        if (-not $domainsData.catchall) {
            $domainsData.catchall = @{
                "description" = "Auto-generated catch-all for uncategorized entities"
                "entities" = @{
                    "core" = @()
                    "utilities" = @()
                    "services" = @()
                    "auth" = @()
                    "audit" = @()
                }
            }
        }
        
        # Add all uncategorized entities to utilities layer
        $domainsData.catchall.entities.utilities = @($uncategorizedEntities)
        
        # Save updated domains.json
        $domainsData | ConvertTo-Json -Depth 10 | Set-Content $domainsFile
        
        Write-Host "✅ Updated catchall with $($uncategorizedEntities.Count) entities in utilities layer" -ForegroundColor Green
        Write-Host "📁 Saved to: $domainsFile" -ForegroundColor Cyan
    } else {
        Write-Host "✅ All entities are already categorized!" -ForegroundColor Green
    }
} else {
    Write-Host "⚠️  Domains file not found: $domainsFile" -ForegroundColor Yellow
} 