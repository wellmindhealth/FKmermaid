<#
.SYNOPSIS
    Enhanced FarCry ER Diagram Generator with Mermaid support
    
.DESCRIPTION
    Generates Entity-Relationship (ER) and Class diagrams from ColdFusion Component (CFC) files
    with comprehensive styling, relationship detection, and Mermaid syntax support.
    
.PARAMETER lFocus
    REQUIRED: The primary entity to focus on (e.g., "activityDef", "progRole", "member")
    
.PARAMETER DiagramType
    REQUIRED: Choose between "ER" or "Class" diagrams
    
.PARAMETER lDomains
    REQUIRED: Array of domains to filter relationships (e.g., "programme", "participant", "partner", "site")
    Multiple domains can be specified as comma-separated values: "programme,participant"
    
.PARAMETER RefreshCFCs
    OPTIONAL: Switch to force fresh CFC scanning (bypasses cache)
    
.PARAMETER ConfigFile
    OPTIONAL: Custom config file path (default: config/cfc_scan_config.json)
    
.PARAMETER OutputFile
    OPTIONAL: Custom output file path (default: auto-generated timestamped file)
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "programme"
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "Class" -lDomains "participant" -RefreshCFCs
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "programme,participant" -OutputFile "custom.mmd"
    
.NOTES
    - All parameters are validated before execution
    - Generated files are saved to the exports/ directory
    - HTML viewer opens automatically in browser
    - See README.md for complete documentation
#>

param(
    [string]$lDomains = "",
    [string]$lFocus = "",
    [string]$DiagramType = "ER",
    [switch]$RefreshCFCs = $false,
    [string]$ConfigFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json",
    [string]$OutputFile = ""
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

# Load domains configuration
function Load-DomainsConfig {
    param([string]$domainsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\domains.json")
    
    if (Test-Path $domainsFile) {
        try {
            $domainsConfig = Get-Content $domainsFile -Raw | ConvertFrom-Json
            return $domainsConfig.domains.PSObject.Properties.Name
        } catch {
            Write-Host "Error loading domains config: $($_.Exception.Message)"
            return @()
        }
    } else {
        Write-Host "Domains config file not found: $domainsFile"
        return @()
    }
}

# Validate domains and return valid ones
function Validate-Domains {
    param([string]$lDomains, [array]$validDomains)
    
    if ([string]::IsNullOrWhiteSpace($lDomains)) {
        Write-Host "📋 No domains specified - using ALL domains: $($validDomains -join ', ')" -ForegroundColor Cyan
        return $validDomains
    }
    
    $requestedDomains = $lDomains -split ',' | ForEach-Object { $_.Trim() }
    $validRequestedDomains = @()
    $invalidDomains = @()
    
    foreach ($domain in $requestedDomains) {
        if ($validDomains -contains $domain) {
            $validRequestedDomains += $domain
        } else {
            $invalidDomains += $domain
        }
    }
    
    if ($invalidDomains.Count -gt 0) {
        Write-Host "⚠️  WARNING: Invalid domains found and will be skipped: $($invalidDomains -join ', ')" -ForegroundColor Yellow
        Write-Host "   Valid domains are: $($validDomains -join ', ')" -ForegroundColor Cyan
    }
    
    if ($validRequestedDomains.Count -eq 0) {
        Write-Host "📋 No valid domains specified - using ALL domains: $($validDomains -join ', ')" -ForegroundColor Cyan
        return $validDomains
    }
    
    return $validRequestedDomains
}

# Parameter validation
function Validate-Parameters {
    $errors = @()
    
    # Check required parameters
    if ([string]::IsNullOrWhiteSpace($lFocus)) {
        $errors += "ERROR: -lFocus parameter is REQUIRED. Example: -lFocus 'activityDef'"
    }
    
    if ([string]::IsNullOrWhiteSpace($DiagramType)) {
        $errors += "ERROR: -DiagramType parameter is REQUIRED. Must be 'ER' or 'Class'"
    } elseif ($DiagramType -notin @("ER", "Class")) {
        $errors += "ERROR: -DiagramType must be 'ER' or 'Class', got: '$DiagramType'"
    }
    
    if ([string]::IsNullOrWhiteSpace($lDomains)) {
        $errors += "ERROR: -lDomains parameter is REQUIRED. Example: -lDomains 'programme' or -lDomains 'programme,participant'"
    }
    
    # Check optional parameters
    if ($OutputFile -and ![string]::IsNullOrWhiteSpace($OutputFile)) {
        $outputDir = Split-Path $OutputFile -Parent
        if ($outputDir -and !(Test-Path $outputDir)) {
            $errors += "ERROR: Output directory does not exist: $outputDir"
        }
    }
    
    if ($ConfigFile -and ![string]::IsNullOrWhiteSpace($ConfigFile) -and !(Test-Path $ConfigFile)) {
        $errors += "ERROR: Config file not found: $ConfigFile"
    }
    
    if ($errors.Count -gt 0) {
        Write-Host "`n❌ PARAMETER VALIDATION FAILED:`n" -ForegroundColor Red
        foreach ($error in $errors) {
            Write-Host $error -ForegroundColor Red
        }
        Write-Host "`n📖 USAGE EXAMPLES:`n" -ForegroundColor Yellow
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'activityDef' -DiagramType 'ER' -lDomains 'programme'" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'Class' -lDomains 'participant' -RefreshCFCs" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'progRole' -DiagramType 'ER' -lDomains 'programme,participant'" -ForegroundColor Cyan
        Write-Host "`n📚 See README.md for complete parameter documentation" -ForegroundColor Yellow
        exit 1
    }
}

# Validate parameters before proceeding
Validate-Parameters

# Load configuration
$config = Load-Config -configFile $ConfigFile
if ($null -eq $config) {
    Write-Host "Failed to load configuration. Exiting."
    exit 1
}

# Load and validate domains
$validDomains = Load-DomainsConfig
$validatedDomains = Validate-Domains -lDomains $lDomains -validDomains $validDomains

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
    
    # Count total files for progress bar
    $totalFiles = 0
    $processedFiles = 0
    
    # First pass: count total files
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
            foreach ($pluginFolder in $pluginFolders) {
                $typesPath = Join-Path $pluginFolder.FullName "packages\types"
                if (Test-Path $typesPath) {
                    $cfcFiles = Get-ChildItem -Path $typesPath -Filter "*.cfc" | Where-Object { $excludeFiles -notcontains $_.Name }
                    $totalFiles += $cfcFiles.Count
                }
            }
        }
    }
    
    Write-Host "📁 Found $totalFiles CFC files to scan..." -ForegroundColor Cyan
    
    # Second pass: process files with progress bar
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
                        $processedFiles++
                        $progressPercent = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                        
                        # Create progress bar
                        $progressBar = "█" * [math]::Floor($progressPercent / 2) + "░" * (50 - [math]::Floor($progressPercent / 2))
                        $currentFile = Split-Path $cfcFile.Name -Leaf
                        
                        Write-Host "`r🔍 Scanning: [$progressBar] $progressPercent% - $currentFile" -NoNewline -ForegroundColor Green
                        
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
    
    # Clear the progress line and show completion
    Write-Host "`r✅ Scan complete! Processed $processedFiles files" -ForegroundColor Green
    Write-Host ""
    
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
    param($relationships, $knownTables, [string]$lFocus = "", [array]$validatedDomains = @())
    
    $mermaidContent = "erDiagram`n"
    
    # Use validated domains
    $domainList = $validatedDomains
    
    # Filter entities based on parameters
    $filteredEntities = $relationships.entities | Where-Object {
        $entity = $_
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        # If focus entity is specified, only include it and its related entities
        if ($lFocus -and $lFocus -ne "") {
            if ($entityName -eq $lFocus) {
                return $true
            }
            # Also include entities that have relationships with the focus entity
            $hasRelationship = $relationships.directFK | Where-Object { 
                ($_.source -eq $lFocus -and $_.target -eq $entityName) -or 
                ($_.target -eq $lFocus -and $_.source -eq $entityName) 
            }
            $hasJoinRelationship = $relationships.joinTables | Where-Object {
                ($_.source -eq $lFocus -and $_.target -eq $entityName) -or 
                ($_.target -eq $lFocus -and $_.source -eq $entityName) -or
                ($_.joinTable -eq $entityName)
            }
            return ($hasRelationship -or $hasJoinRelationship)
        }
        
        # If domains are specified, only include entities from those domains
        if ($domainList.Count -gt 0) {
            return $domainList -contains $pluginName
        }
        
        # If no filters, include all entities
        return $true
    }
    
    # Get list of filtered entities that exist
    $existingEntities = $filteredEntities | ForEach-Object { $_.name }
    
    Write-Host "📊 Filtered to $($filteredEntities.Count) entities based on parameters:" -ForegroundColor Cyan
    if ($lFocus) { Write-Host "   Focus: $lFocus" -ForegroundColor Yellow }
    if ($domainList.Count -gt 0) { Write-Host "   Domains: $($domainList -join ', ')" -ForegroundColor Yellow }
    
    # Add entities with proper attributes
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        # Only include entities from known tables and ensure name is complete
        if ($knownTables -contains $entityName -and $entityName -and $entityName.Length -gt 0) {
            $entityDisplayName = "$pluginName - $entityName"
            
            $mermaidContent += "    `"$entityDisplayName`" {`n"
            $mermaidContent += "        UUID ObjectID`n"
            $mermaidContent += "        string name`n"
            $mermaidContent += "    }`n`n"
        }
    }
    
    # Add relationships
    foreach ($fk in $relationships.directFK) {
        $sourceEntity = $fk.source
        $targetEntity = $fk.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            
            $mermaidContent += "    `"$sourcePlugin - $sourceEntity`" }o--|| `"$targetPlugin - $targetEntity`" : $($fk.property)`n"
        }
    }

    foreach ($join in $relationships.joinTables) {
        $sourceEntity = $join.source
        $targetEntity = $join.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            
            $mermaidContent += "    `"$sourcePlugin - $sourceEntity`" }o--|| `"$targetPlugin - $targetEntity`" : $($join.joinTable)`n"
        }
    }

    # Add styling
    $mermaidContent += "`n    %% Entity Styling`n"
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        $entityDisplayName = "$pluginName - $entityName"
        $style = Get-EntityStyle -entityName $entityName -pluginName $pluginName
        
        # Use sanitized entity name for style definition (no spaces, hyphens, or quotes)
        $sanitizedEntityName = Get-SanitizedEntityName -entityName $entityDisplayName
        $mermaidContent += "    style $sanitizedEntityName $style`n"
    }
    
    return $mermaidContent
}

# Function to generate Mermaid Class diagram with full styling
function Generate-MermaidClassDiagram {
    param($relationships, $knownTables, [string]$lFocus = "", [array]$validatedDomains = @())
    
    $mermaidContent = "classDiagram`n"
    
    # Use validated domains
    $domainList = $validatedDomains
    
    # Filter entities based on parameters (same logic as ER diagram)
    $filteredEntities = $relationships.entities | Where-Object {
        $entity = $_
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        # If focus entity is specified, only include it and its related entities
        if ($lFocus -and $lFocus -ne "") {
            if ($entityName -eq $lFocus) {
                return $true
            }
            # Also include entities that have relationships with the focus entity
            $hasRelationship = $relationships.directFK | Where-Object { 
                ($_.source -eq $lFocus -and $_.target -eq $entityName) -or 
                ($_.target -eq $lFocus -and $_.source -eq $entityName) 
            }
            $hasJoinRelationship = $relationships.joinTables | Where-Object {
                ($_.source -eq $lFocus -and $_.target -eq $entityName) -or 
                ($_.target -eq $lFocus -and $_.source -eq $entityName) -or
                ($_.joinTable -eq $entityName)
            }
            return ($hasRelationship -or $hasJoinRelationship)
        }
        
        # If domains are specified, only include entities from those domains
        if ($domainList.Count -gt 0) {
            return $domainList -contains $pluginName
        }
        
        # If no filters, include all entities
        return $true
    }
    
    # Get list of filtered entities that exist
    $existingEntities = $filteredEntities | ForEach-Object { $_.name }
    
    Write-Host "📊 Filtered to $($filteredEntities.Count) entities based on parameters:" -ForegroundColor Cyan
    if ($lFocus) { Write-Host "   Focus: $lFocus" -ForegroundColor Yellow }
    if ($domainList.Count -gt 0) { Write-Host "   Domains: $($domainList -join ', ')" -ForegroundColor Yellow }
    
    # Add entities with proper attributes
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        # Only include entities from known tables and ensure name is complete
        if ($knownTables -contains $entityName -and $entityName -and $entityName.Length -gt 0) {
            $entityDisplayName = "$pluginName - $entityName"
            
            # Sanitize class name for classDiagram (no spaces, hyphens, or special chars)
            $sanitizedClassName = $entityDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedClassName = $sanitizedClassName -replace '_+', '_'
            $sanitizedClassName = $sanitizedClassName.Trim('_')
            
            $mermaidContent += "    class $sanitizedClassName {`n"
            $mermaidContent += "        +UUID ObjectID`n"
            $mermaidContent += "        +string name`n"
            $mermaidContent += "    }`n`n"
        }
    }
    
    # Add relationships
    foreach ($fk in $relationships.directFK) {
        $sourceEntity = $fk.source
        $targetEntity = $fk.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            
            # Sanitize class names for relationships
            $sourceDisplayName = "$sourcePlugin - $sourceEntity"
            $targetDisplayName = "$targetPlugin - $targetEntity"
            $sanitizedSourceName = $sourceDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedSourceName = $sanitizedSourceName -replace '_+', '_'
            $sanitizedSourceName = $sanitizedSourceName.Trim('_')
            $sanitizedTargetName = $targetDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedTargetName = $sanitizedTargetName -replace '_+', '_'
            $sanitizedTargetName = $sanitizedTargetName.Trim('_')
            
            $mermaidContent += "    $sanitizedSourceName --> $sanitizedTargetName : $($fk.property)`n"
        }
    }

    foreach ($join in $relationships.joinTables) {
        $sourceEntity = $join.source
        $targetEntity = $join.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            
            # Sanitize class names for relationships
            $sourceDisplayName = "$sourcePlugin - $sourceEntity"
            $targetDisplayName = "$targetPlugin - $targetEntity"
            $sanitizedSourceName = $sourceDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedSourceName = $sanitizedSourceName -replace '_+', '_'
            $sanitizedSourceName = $sanitizedSourceName.Trim('_')
            $sanitizedTargetName = $targetDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedTargetName = $sanitizedTargetName -replace '_+', '_'
            $sanitizedTargetName = $sanitizedTargetName.Trim('_')
            
            $mermaidContent += "    $sanitizedSourceName --> $sanitizedTargetName : $($join.joinTable)`n"
        }
    }

    # Add styling for class diagram (full color support)
    $mermaidContent += "`n    %% Entity Styling`n"
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        $entityDisplayName = "$pluginName - $entityName"
        $style = Get-EntityStyle -entityName $entityName -pluginName $pluginName
        
        # Sanitize entity name for style definition (same as class names)
        $sanitizedEntityName = $entityDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedEntityName = $sanitizedEntityName -replace '_+', '_'
        $sanitizedEntityName = $sanitizedEntityName.Trim('_')
        
        $mermaidContent += "    style $sanitizedEntityName $style`n"
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

# Function to sanitize entity names for Mermaid compatibility
function Get-SanitizedEntityName {
    param([string]$entityName)
    
    # Replace spaces and special characters with underscores
    $sanitized = $entityName -replace '[^a-zA-Z0-9_]', '_'
    # Remove multiple consecutive underscores
    $sanitized = $sanitized -replace '_+', '_'
    # Remove leading/trailing underscores
    $sanitized = $sanitized.Trim('_')
    return $sanitized
}

# Function to get entity styling based on importance and type
function Get-EntityStyle {
    param([string]$entityName, [string]$pluginName)
    
    # Define styling rules - keeping only SSQ entities for now
    $stylingRules = @{
        # SSQ entities - special styling (keeping these as requested)
        "SSQ_arthritis01" = "fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222"
        "SSQ_pain01" = "fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222"
        "SSQ_stress01" = "fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222"
        "SSQ_HUB" = "fill:#e0e0e0,stroke:#bdbdbd,stroke-width:0px,color:#333"
    }
    
    # Check for exact match first
    if ($stylingRules.ContainsKey($entityName)) {
        return $stylingRules[$entityName]
    }
    
    # Check for plugin-specific styling
    $pluginEntityKey = "$pluginName - $entityName"
    if ($stylingRules.ContainsKey($pluginEntityKey)) {
        return $stylingRules[$pluginEntityKey]
    }
    
    # Default styling for all other entities
    return "fill:#9e9e9e,stroke:#fff,stroke-width:1px,color:#fff"
}

# Main execution
Write-Host "FarCry ERD Generator (Enhanced)"
Write-Host "==============================="

# Echo chosen parameters
Write-Host "📋 PARAMETERS:" -ForegroundColor Cyan
Write-Host "   Focus Entity: $lFocus" -ForegroundColor Yellow
Write-Host "   Diagram Type: $DiagramType" -ForegroundColor Yellow
Write-Host "   Domains: $lDomains" -ForegroundColor Yellow
Write-Host "   Refresh CFCs: $RefreshCFCs" -ForegroundColor Yellow
Write-Host "   Config File: $ConfigFile" -ForegroundColor Yellow
Write-Host "   Output File: $OutputFile" -ForegroundColor Yellow
Write-Host ""

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

# Generate Mermaid diagrams based on type
if ($DiagramType -eq "ER") {
    $mermaidContent = Generate-MermaidERD -relationships $relationships -knownTables $knownTables -lFocus $lFocus -validatedDomains $validatedDomains
} else {
    $mermaidContent = Generate-MermaidClassDiagram -relationships $relationships -knownTables $knownTables -lFocus $lFocus -validatedDomains $validatedDomains
}

# Ensure exports directory exists
$exportsDir = Split-Path $outputFile -Parent
if (!(Test-Path $exportsDir)) {
    New-Item -ItemType Directory -Path $exportsDir -Force | Out-Null
}

# Save to file in exports directory
$mermaidContent | Set-Content $outputFile
Write-Host "$DiagramType diagram saved to: $outputFile"

# Generate HTML file with embedded browser opening functionality
$ProjectRoot = "D:\GIT\farcry\Cursor\FKmermaid"
$htmlFile = Join-Path $ProjectRoot "exports\plugins_full_erd_$(Get-Date -Format 'yyyyMMddHHmmss').html"

# Create dynamic titles based on parameters
$focusTitle = if ($lFocus) { "Focus: $lFocus" } else { "All Entities" }
$domainsTitle = if ($lDomains) { "Domains: $lDomains" } else { "All Domains" }
$fullTitle = "$focusTitle - $domainsTitle"

$mermaidLiveHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>$fullTitle - Mermaid Live Editor</title>
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
        <h1>$lFocus</h1>
        <h2>$focusTitle - $domainsTitle</h2>
        <h3>$DiagramType Diagram</h3>
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

# Display comprehensive usage information
Write-Host "`n📚 COMPLETE PARAMETER REFERENCE:" -ForegroundColor Yellow
Write-Host "`n🔴 REQUIRED PARAMETERS:" -ForegroundColor Red
Write-Host "  -lFocus 'entityName'     # Focus entity (e.g., 'activityDef', 'progRole', 'member')" -ForegroundColor White
Write-Host "  -DiagramType 'ER|Class'  # Diagram type ('ER' or 'Class')" -ForegroundColor White
Write-Host "  -lDomains 'domain1,domain2' # Domains to include (e.g., 'programme,participant')" -ForegroundColor White

Write-Host "`n🟡 OPTIONAL PARAMETERS:" -ForegroundColor Yellow
Write-Host "  -RefreshCFCs             # Force fresh CFC scanning (bypass cache)" -ForegroundColor White
Write-Host "  -ConfigFile 'path'       # Custom config file path" -ForegroundColor White
Write-Host "  -OutputFile 'path'       # Custom output file path" -ForegroundColor White

Write-Host "`n💡 USAGE EXAMPLES:" -ForegroundColor Cyan
Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'activityDef' -DiagramType 'ER' -lDomains 'programme'" -ForegroundColor Green
Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'Class' -lDomains 'participant' -RefreshCFCs" -ForegroundColor Green
Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'progRole' -DiagramType 'ER' -lDomains 'programme,participant'" -ForegroundColor Green
Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'dmImage' -DiagramType 'ER' -lDomains 'site' -OutputFile 'custom.mmd'" -ForegroundColor Green

Write-Host "`n📖 For complete documentation, see: README.md" -ForegroundColor Yellow 