# Generate Component Diagrams for FarCry Pathway Plugin
# Dynamically scans CFC files and extracts properties, inheritance, and relationships
# 
# ⚠️  IMPORTANT: This script shares the cache file with generate_erd_domain_colors.ps1
#     DO NOT overwrite the cache structure - always preserve existing data!
#     The ER script expects: directFK, joinTables, entities, properties
#     This script adds: components
#     See the cache preservation logic below for details.
param(
    [string]$lDomains = "",
    [string]$lFocus = "",
    [string]$DiagramType = "Component",
    [switch]$RefreshCFCs = $false,
    [switch]$DebugScan = $false,
    [switch]$Help = $false,
    [string]$ConfigFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json",
    [string]$OutputFile = "",
    [switch]$ShowInheritance = $true,
    [switch]$ShowRelationships = $true,
    [switch]$LimitProperties = $true,
    [int]$MaxProperties = 10,
    [switch]$Debug
)

# Import logging modules
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
    
    # Initialize logging
    Initialize-ModuleLogging -ModuleName "component_diagram" -Debug:$Debug
    Write-InfoLog "Starting component diagram generation" -Context "Component_Diagram"
} else {
    Write-Host "Warning: Logger module not found, using console output only" -ForegroundColor Yellow
}

Write-Host "🏗️  FarCry Component Diagram Generator (Dynamic)" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
Write-Host "🎯 Focus: $lFocus | 📊 Type: $DiagramType | 🌍 Domains: $lDomains" -ForegroundColor Cyan

# Parameter validation
function Validate-Parameters {
    $errors = @()
    
    # Check required parameters
    if ([string]::IsNullOrWhiteSpace($lFocus)) {
        $errors += "ERROR: -lFocus parameter is REQUIRED. Example: -lFocus 'member'"
    }
    
    if ([string]::IsNullOrWhiteSpace($DiagramType)) {
        $errors += "ERROR: -DiagramType parameter is REQUIRED. Must be 'Component'"
    } elseif ($DiagramType -notin @("Component")) {
        $errors += "ERROR: -DiagramType must be 'Component', got: '$DiagramType'"
    }
    
    if ([string]::IsNullOrWhiteSpace($lDomains)) {
        # Allow null/empty domains - they will be handled by domain filtering
        # which will use all available domains
    } elseif ($lDomains -eq "all") {
        # Special case: 'all' means use all domains (same as empty)
        $lDomains = ""
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
        foreach ($errorMsg in $errors) {
            Write-Host $errorMsg -ForegroundColor Red
        }
        Write-Host "`n📖 USAGE EXAMPLES:`n" -ForegroundColor Yellow
        Write-Host "  .\generate_component_diagram.ps1 -lFocus 'member' -DiagramType 'Component' -lDomains 'participant,provider'" -ForegroundColor Cyan
        Write-Host "  .\generate_component_diagram.ps1 -lFocus 'activityDef' -DiagramType 'Component' -lDomains 'pathway'" -ForegroundColor Cyan
        Write-Host "  .\generate_component_diagram.ps1 -lFocus 'progRole' -DiagramType 'Component' -lDomains 'pathway,participant'" -ForegroundColor Cyan
        Write-Host "  .\generate_component_diagram.ps1 -lFocus 'farUser' -DiagramType 'Component' -lDomains 'all'" -ForegroundColor Cyan
        Write-Host "  .\generate_component_diagram.ps1 -lFocus 'partner' -DiagramType 'Component'" -ForegroundColor Cyan
        Write-Host "`n📚 See README.md for complete parameter documentation" -ForegroundColor Yellow
        exit 1
    }
}

# Check for help parameter first
if ($Help) {
    Write-Host "FarCry Component Diagram Generator" -ForegroundColor Cyan
    Write-Host "==================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📚 COMPLETE PARAMETER REFERENCE:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🔴 REQUIRED PARAMETERS:" -ForegroundColor Red
    Write-Host "  -lFocus 'entityName'     # Focus entity (e.g., 'member', 'activityDef', 'progRole')" -ForegroundColor White
    Write-Host "  -DiagramType 'Component' # Diagram type (currently only 'Component')" -ForegroundColor White
    Write-Host "  -lDomains 'domain1,domain2' # Domains to include (e.g., 'participant,partner')" -ForegroundColor White
    Write-Host "                           # Use 'all' or omit for all domains" -ForegroundColor White
    Write-Host ""
    Write-Host "🟡 OPTIONAL PARAMETERS:" -ForegroundColor Yellow
    Write-Host "  -RefreshCFCs             # Force fresh CFC scanning (bypass cache)" -ForegroundColor White
    Write-Host "  -ConfigFile 'path'       # Custom config file path" -ForegroundColor White
    Write-Host "  -OutputFile 'path'       # Custom output file path" -ForegroundColor White
    Write-Host "  -Help                    # Show this help message" -ForegroundColor White
    Write-Host "  -Debug                   # Enable debug mode" -ForegroundColor White
    Write-Host ""
    Write-Host "💡 USAGE EXAMPLES:" -ForegroundColor Cyan
    Write-Host "  .\generate_component_diagram.ps1 -lFocus 'member' -DiagramType 'Component' -lDomains 'participant,partner'" -ForegroundColor Green
    Write-Host "  .\generate_component_diagram.ps1 -lFocus 'activityDef' -DiagramType 'Component' -lDomains 'programme' -RefreshCFCs" -ForegroundColor Green
    Write-Host "  .\generate_component_diagram.ps1 -lFocus 'progRole' -DiagramType 'Component' -lDomains 'programme,participant'" -ForegroundColor Green
    Write-Host "  .\generate_component_diagram.ps1 -lFocus 'farUser' -DiagramType 'Component' -lDomains 'all'" -ForegroundColor Green
    Write-Host "  .\generate_component_diagram.ps1 -lFocus 'partner' -DiagramType 'Component'" -ForegroundColor Green
    Write-Host ""
    Write-Host "📖 For complete documentation, see: README.md" -ForegroundColor Yellow
    exit 0
}

# Validate parameters before proceeding
Validate-Parameters

# Load configurations
$domainsPath = "D:\GIT\farcry\Cursor\FKmermaid\config\domains.json"
$cfcConfigPath = $ConfigFile
$cachePath = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"

# Initialize component styles hashtable
$componentStyles = @{}

# Function to parse Mermaid styles file and extract styles
function Get-MermaidStyles {
    param(
        [string]$stylesPath
    )
    
    $styles = @{}
    
    if (Test-Path $stylesPath) {
        $stylesContent = Get-Content $stylesPath -Raw
        
        # Parse Mermaid style rules using regex
        $stylePattern = 'style\s+(\w+)\s+([^\r\n]+)'
        $matches = [regex]::Matches($stylesContent, $stylePattern)
        
        foreach ($match in $matches) {
            $entityName = $match.Groups[1].Value
            $styleDefinition = $match.Groups[2].Value.Trim()
            $styles[$entityName] = $styleDefinition
        }
        
        Write-Host "📋 Loaded $($styles.Count) styles from Mermaid styles file" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Mermaid styles file not found: $stylesPath" -ForegroundColor Yellow
    }
    
    return $styles
}

# Function to get component styling based on importance and type
function Get-ComponentStyle {
    param(
        [string]$componentName, 
        [string]$domain, 
        [string]$focusComponent, 
        [hashtable]$cssStyles
    )
    
    # Focus component styling
    if ($componentName -eq $focusComponent) {
        if ($cssStyles.ContainsKey("focus")) {
            return $cssStyles["focus"]
        }
        return "fill:#ffc107,stroke:#f57c00,stroke-width:4px,color:#000"
    }
    
    # Check for SSQ components
    if ($componentName -like "SSQ_*") {
        if ($cssStyles.ContainsKey("ssq_group")) {
            return $cssStyles["ssq_group"]
        }
    }
    
    # Domain-based styling
    switch ($domain) {
        "participant" {
            if ($cssStyles.ContainsKey("domain_related")) {
                return $cssStyles["domain_related"]
            }
            return "fill:#2196f3,stroke:#000,stroke-width:2px,color:#fff"
        }
        "partner" {
            if ($cssStyles.ContainsKey("domain_other")) {
                return $cssStyles["domain_other"]
            }
            return "fill:#ff5722,stroke:#000,stroke-width:2px,color:#fff"
        }
        "programme" {
            if ($cssStyles.ContainsKey("other_group")) {
                return $cssStyles["other_group"]
            }
            return "fill:#4caf50,stroke:#000,stroke-width:2px,color:#fff"
        }
        "site" {
            if ($cssStyles.ContainsKey("other_group")) {
                return $cssStyles["other_group"]
            }
            return "fill:#9c27b0,stroke:#000,stroke-width:2px,color:#fff"
        }
        default {
            if ($cssStyles.ContainsKey("secondary")) {
                return $cssStyles["secondary"]
            }
            return "fill:#1a1a1a,stroke:#0d0d0d,stroke-width:1px,color:#fff"
        }
    }
}

# Function to get meaningful component descriptions
function Get-ComponentDescription {
    param(
        [string]$componentName,
        [string]$domain
    )
    
    # Component-specific descriptions
    $descriptions = @{
        "member" = "User/patient record with personal info, preferences, and activity tracking"
        "activityDef" = "Step definition in a programme with media, interactions, and progression logic"
        "programme" = "Complete treatment programme with activities, pricing, and lifecycle management"
        "progMember" = "User's enrollment in a specific programme with progress tracking"
        "activity" = "User's interaction with a specific activity step"
        "journal" = "User's personal notes and reflections during treatment"
        "tracker" = "User's self-assessment data and progress metrics"
        "partner" = "Healthcare organization or clinic providing services"
        "center" = "Physical location where services are delivered"
        "referer" = "Healthcare professional referring patients"
        "media" = "Video, audio, or document content for treatment"
        "farUser" = "System user account for healthcare staff"
        "farRole" = "Permission group for system access control"
        "farPermission" = "Specific permission for system functionality"
        "memberGroup" = "Group of users with shared access and settings"
        "intake" = "Patient enrollment session with capacity limits"
        "guide" = "Healthcare professional providing guidance"
        "journalDef" = "Template for structured journal entries"
        "trackerDef" = "Template for assessment questionnaires"
        "progRole" = "Role definition within a programme"
        "dmProfile" = "System user profile with preferences and settings"
    }
    
    # Domain-based descriptions for unknown components
    $domainDescriptions = @{
        "participant" = "User-facing component for patient interaction and data"
        "partner" = "Healthcare organization and staff management component"
        "programme" = "Treatment programme and content management component"
        "site" = "System administration and configuration component"
    }
    
    # Return specific description if available, otherwise domain-based
    if ($descriptions.ContainsKey($componentName)) {
        return $descriptions[$componentName]
    } elseif ($domainDescriptions.ContainsKey($domain)) {
        return "$domainDescriptions[$domain] - $componentName"
    } else {
        return "$domain component - $componentName"
    }
}

# Load Mermaid styles
$stylesPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "styles\mermaid_styles.mmd"
$cssStyles = Get-MermaidStyles -stylesPath $stylesPath

if (Test-Path $domainsPath) {
    $domainsConfig = Get-Content $domainsPath -Raw | ConvertFrom-Json
    Write-Host "✅ Loaded domains configuration" -ForegroundColor Green
} else {
    Write-Host "❌ Domains configuration not found: $domainsPath" -ForegroundColor Red
    exit 1
}

if (Test-Path $cfcConfigPath) {
    $cfcConfig = Get-Content $cfcConfigPath -Raw | ConvertFrom-Json
    Write-Host "✅ Loaded CFC scan configuration" -ForegroundColor Green
} else {
    Write-Host "❌ CFC scan configuration not found: $cfcConfigPath" -ForegroundColor Red
    exit 1
}

# Function to scan CFC files and extract component information
function Scan-CFCComponents {
    param(
        [string]$ScanPath,
        [array]$ExcludeFolders,
        [array]$ExcludeFiles,
        [object]$Config
    )
    
    Write-Host "🔍 Scanning CFC files in: $ScanPath" -ForegroundColor Cyan
    
    $components = @{}
    $cfcFiles = Get-ChildItem -Path $ScanPath -Recurse -Include "*.cfc" | 
        Where-Object { 
            $_.Directory.Name -notin $ExcludeFolders -and 
            $_.Name -notin $ExcludeFiles 
        }
    
    foreach ($cfcFile in $cfcFiles) {
        $componentName = $cfcFile.BaseName
        $content = Get-Content $cfcFile.FullName -Raw
        
        # Extract extends information
        $extendsMatch = [regex]::Match($content, 'extends\s*=\s*[""]([^""]+)[""]')
        $extends = if ($extendsMatch.Success) { $extendsMatch.Groups[1].Value } else { $null }
        

        
        # Extract properties using the proven patterns from relationship_detection.ps1
        $properties = @()
        $exclusionPatterns = $Config.relationshipPatterns.exclusions.patterns
        
        # Handle multiline cfproperty tags properly (borrowed from relationship_detection.ps1)
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
        $multilineMatches = [regex]::Matches($content, '<cfproperty.*?/>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        foreach ($match in $multilineMatches) {
            # Skip if this is already captured by self-closing pattern
            if ($match.Value -notmatch '^<cfproperty[^>]*?>$') {
                $cfPropertyMatches += $match
            }
        }
        

        
        foreach ($match in $cfPropertyMatches) {
            $cfPropertyTag = $match.Value
            
            # Parse attributes from the opening tag (borrowed from relationship_detection.ps1)
            $attributes = @{}
            $attributeMatches = [regex]::Matches($cfPropertyTag, '(\w+)="([^"]*)"')
            foreach ($attrMatch in $attributeMatches) {
                $attributeName = $attrMatch.Groups[1].Value
                $attributeValue = $attrMatch.Groups[2].Value
                $attributes[$attributeName] = $attributeValue
            }
            
            # Skip if no name attribute
            if (-not $attributes.ContainsKey("name")) { continue }
            
            $propertyName = $attributes["name"]
            
            # Skip system properties
            if ($propertyName -in @("ObjectID", "versionID", "status", "createdby", "datetimecreated", "datetimelastupdated", "lastupdatedby", "locked", "lockedBy", "ownedby")) {
                continue
            }
            
            # Check for exclusions using the proven pattern from relationship_detection.ps1
            if ($exclusionPatterns) {
                $isExcluded = $false
                foreach ($pattern in $exclusionPatterns) {
                    foreach ($attrName in $attributes.Keys) {
                        $attrValue = $attributes[$attrName]
                        $attrPair = "$attrName=`"$attrValue`""
                        if ($attrPair -match $pattern) {
                            $isExcluded = $true
                            break
                        }
                    }
                    if ($isExcluded) { break }
                }
                if ($isExcluded) { continue }
            }
            
            # Add property if not already added
            if ($propertyName -notin $properties) {
                $properties += $propertyName
            }
        }
        
        # Determine domain based on domains.json
        $domain = "unknown"
        foreach ($domainName in $domainsConfig.domains.PSObject.Properties.Name) {
            $domainConfig = $domainsConfig.domains.$domainName
            foreach ($category in $domainConfig.entities.PSObject.Properties.Name) {
                if ($componentName -in $domainConfig.entities.$category) {
                    $domain = $domainName
                    break
                }
            }
            if ($domain -ne "unknown") { break }
        }
        
        $components[$componentName] = @{
            extends = $extends
            domain = $domain
            properties = $properties
            filePath = $cfcFile.FullName
        }
    }
    
    Write-Host "📊 Found $($components.Count) components" -ForegroundColor Green
    return $components
}

# Function to extract relationships from properties
function Extract-ComponentRelationships {
    param(
        [hashtable]$Components
    )
    
    $relationships = @()
    
    foreach ($componentName in $Components.Keys) {
        $component = $Components[$componentName]
        
        foreach ($property in $component.properties) {
            # Look for properties that reference other components
            if ($property -match "(.+)ID$" -and $Components.ContainsKey($matches[1])) {
                $targetComponent = $matches[1]
                $relationships += @{
                    from = $componentName
                    to = $targetComponent
                    type = "FK"
                    property = $property
                }
            }
            
            # Look for array properties that reference other components
            if ($property -match "^a(.+)$" -and $Components.ContainsKey($matches[1])) {
                $targetComponent = $matches[1]
                $relationships += @{
                    from = $componentName
                    to = $targetComponent
                    type = "Array"
                    property = $property
                }
            }
        }
    }
    
    return $relationships
}

# Scan components (use cache unless RefreshCFCs is specified)
$components = @{}
if (-not $RefreshCFCs -and (Test-Path $cachePath)) {
    try {
        $cachedData = Get-Content $cachePath -Raw | ConvertFrom-Json
        $components = @{}
        
        # Check if cache has the new structure with components property
        if ($cachedData.PSObject.Properties.Name -contains "components") {
            # New structure: components stored under 'components' property
            foreach ($property in $cachedData.components.PSObject.Properties) {
                $components[$property.Name] = $property.Value
            }
        } else {
            # Old structure: components stored directly
            foreach ($property in $cachedData.PSObject.Properties) {
                $components[$property.Name] = $property.Value
            }
        }
        
        Write-Host "✅ Loaded cached components from: $cachePath" -ForegroundColor Green
        Write-Host "📊 Total components loaded: $($components.Count)" -ForegroundColor Cyan
        # Debug: Check a few components
        $sampleComponents = $components.GetEnumerator() | Select-Object -First 5
        foreach ($sample in $sampleComponents) {
            Write-Host "  Sample: $($sample.Key) -> domain: '$($sample.Value.domain)'" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "⚠️  Could not load cache, scanning CFC files..." -ForegroundColor Yellow
        $components = @{}
        foreach ($scanDir in $cfcConfig.scanSettings.scanDirectories) {
            Write-Host "🔍 Scanning directory: $scanDir" -ForegroundColor Cyan
            $dirComponents = Scan-CFCComponents -ScanPath $scanDir -ExcludeFolders $cfcConfig.scanSettings.excludeFolders -ExcludeFiles $cfcConfig.scanSettings.excludeFiles -Config $cfcConfig
            foreach ($key in $dirComponents.Keys) {
                $components[$key] = $dirComponents[$key]
            }
        }
    }
} else {
    $components = @{}
    foreach ($scanDir in $cfcConfig.scanSettings.scanDirectories) {
        Write-Host "🔍 Scanning directory: $scanDir" -ForegroundColor Cyan
        $dirComponents = Scan-CFCComponents -ScanPath $scanDir -ExcludeFolders $cfcConfig.scanSettings.excludeFolders -ExcludeFiles $cfcConfig.scanSettings.excludeFiles -Config $cfcConfig
        foreach ($key in $dirComponents.Keys) {
            $components[$key] = $dirComponents[$key]
        }
    }
    
    # ⚠️  CACHE PRESERVATION: This script shares cache with generate_erd_domain_colors.ps1
    #     DO NOT overwrite the cache structure - always preserve existing data!
    #     The ER script expects: directFK, joinTables, entities, properties
    #     This script adds: components
    $existingCache = @{}
    if (Test-Path $cachePath) {
        try {
            $existingData = Get-Content $cachePath -Raw | ConvertFrom-Json
            # Preserve existing cache structure for ER script compatibility
            if ($existingData.PSObject.Properties.Name -contains "directFK") {
                $existingCache.directFK = $existingData.directFK
            }
            if ($existingData.PSObject.Properties.Name -contains "joinTables") {
                $existingCache.joinTables = $existingData.joinTables
            }
            if ($existingData.PSObject.Properties.Name -contains "entities") {
                $existingCache.entities = $existingData.entities
            }
            if ($existingData.PSObject.Properties.Name -contains "properties") {
                $existingCache.properties = $existingData.properties
            }
        } catch {
            Write-Host "⚠️  Could not read existing cache, creating new structure" -ForegroundColor Yellow
        }
    }
    
    # Add component data to existing cache
    $existingCache.components = $components
    
    $existingCache | ConvertTo-Json -Depth 10 | Out-File -FilePath $cachePath -Encoding UTF8
    Write-Host "✅ Saved component cache to: $cachePath (preserved existing structure)" -ForegroundColor Green
}

# Filter components by domains
$targetDomains = $lDomains.Split(" ") | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne "" }
Write-Host "🔍 Filtering for domains: $($targetDomains -join ', ')" -ForegroundColor Cyan
$filteredComponents = @{}
foreach ($componentName in $components.Keys) {
    $component = $components[$componentName]
    if ($component.domain -in $targetDomains) {
        $filteredComponents[$componentName] = $component
    }
}

Write-Host "📊 Found $($filteredComponents.Count) components in target domains: $($targetDomains -join ', ')" -ForegroundColor Green

# Extract relationships
$relationships = Extract-ComponentRelationships -Components $filteredComponents

# Generate Mermaid component diagram
$mermaidContent = @"
classDiagram
    %% Parameters:
    %%   Focus: $lFocus
    %%   Domains: $lDomains
    %%   Chart Type: $DiagramType
    %%   Show Inheritance: $ShowInheritance
    %%   Show Relationships: $ShowRelationships

"@

# Add inheritance hierarchy if requested
if ($ShowInheritance) {
    $mermaidContent += @"

    %% FarCry Core Inheritance Hierarchy
    class farcry.core.packages.schema.schema {
        <<abstract>>
    }
    
    class farcry.core.packages.fourq.fourq {
        <<abstract>>
    }
    
    class farcry.core.packages.types.types {
        <<abstract>>
    }
    
    class farcry.core.packages.types.versions {
        <<abstract>>
        +versionID
        +status
    }
    
    farcry.core.packages.schema.schema <|-- farcry.core.packages.fourq.fourq
    farcry.core.packages.fourq.fourq <|-- farcry.core.packages.types.types
    farcry.core.packages.types.types <|-- farcry.core.packages.types.versions

"@
}

# Add components
foreach ($componentName in $filteredComponents.Keys) {
    $component = $filteredComponents[$componentName]
    $isFocus = $componentName -eq $lFocus
    
    # Limit properties if requested
    $displayProperties = $component.properties
    if ($LimitProperties -and $component.properties.Count -gt $MaxProperties) {
        $displayProperties = $component.properties | Select-Object -First $MaxProperties
        $displayProperties += "... (+$($component.properties.Count - $MaxProperties) more)"
    }
    
    # Add component description based on domain and name
    $description = Get-ComponentDescription -componentName $componentName -domain $component.domain
    
    $mermaidContent += @"
    
    %% $($component.domain.ToUpper()) Domain Component
    class $componentName {
        <<$($component.domain)>>
        $($displayProperties -join "`n        ")
    }
    
"@
    
    # Add inheritance relationship
    if ($ShowInheritance -and $component.extends) {
        $mermaidContent += "    $($component.extends) <|-- $componentName`n"
    } else {
        # Ensure proper newline even when no inheritance
        $mermaidContent += "`n"
    }
    
    # Store component style for later (will be added at the end)
    $componentStyle = Get-ComponentStyle -componentName $componentName -domain $component.domain -focusComponent $lFocus -cssStyles $cssStyles
    $componentStyles[$componentName] = $componentStyle
}

# Add component relationships if requested
if ($ShowRelationships) {
    $mermaidContent += "`n`n    %% Component Relationships (Dynamically Extracted)`n"
    
    foreach ($rel in $relationships) {
        $cardinality = if ($rel.type -eq "FK") { "||--||" } else { "||--o{" }
        $mermaidContent += "    $($rel.from) $cardinality $($rel.to) : `"$($rel.property)`"`n"
    }
}

# Add component styling at the end (like ER script)
$mermaidContent += "`n    %% Component Styling`n"
foreach ($componentName in $componentStyles.Keys) {
    $style = $componentStyles[$componentName]
    $mermaidContent += "    style $componentName $style`n"
}

# Generate unique output filename if not specified
if ($OutputFile -eq "") {
    $baseName = "component"
    if ($lFocus) {
        $baseName = $lFocus -replace ',', '_'
    }
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $uniqueId = [System.Guid]::NewGuid().ToString("N").Substring(0, 8)
    $filename = "${baseName}_${DiagramType}_${timestamp}_${uniqueId}.mmd"
    $outputFile = Join-Path "D:\GIT\farcry\Cursor\FKmermaid\exports" $filename
} else {
    # If OutputFile is specified, use the provided path
    $outputFile = $OutputFile
    # Ensure the directory exists
    $outputDir = Split-Path $outputFile -Parent
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
}

# Save the diagram
$mermaidContent | Out-File -FilePath $outputFile -Encoding UTF8

Write-Host "✅ Component diagram saved to: $outputFile" -ForegroundColor Green
Write-InfoLog "Component diagram generated successfully" -Context "Component_Diagram" -Data @{
    OutputFile = $outputFile
    Focus = $lFocus
    Domains = $lDomains
    DiagramType = $DiagramType
    ComponentCount = $filteredComponents.Count
    RelationshipCount = $relationships.Count
    ShowInheritance = $ShowInheritance
    ShowRelationships = $ShowRelationships
}

# Open in Mermaid.live using proper pako compression
Write-Host "🌐 Opening Mermaid.live with content..." -ForegroundColor Cyan

# Use the working Node.js tool for proper pako compression
$nodeScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "src\node\generate_url.js"
$mermaidLiveUrl = $mermaidContent | node $nodeScriptPath

Write-Host "✅ Generated compressed Mermaid.live URL" -ForegroundColor Green

# Non-blocking browser launch to prevent hanging
try {
    # Use Start-Job to make it truly non-blocking
    Start-Job -ScriptBlock { param($url) Start-Process $url -WindowStyle Hidden } -ArgumentList $mermaidLiveUrl | Out-Null
    Write-Host "🌐 Opened Mermaid.live directly with content" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Could not open browser automatically. Please copy this URL:" -ForegroundColor Yellow
    Write-Host $mermaidLiveUrl -ForegroundColor Cyan
}

Write-Host "✅ Component diagram generation complete!" -ForegroundColor Green
Write-Host "📁 MMD file: $outputFile" -ForegroundColor Cyan
Write-Host "🔗 Browser should have opened automatically" -ForegroundColor Cyan

# Check for errors in log file
$logFiles = Get-ChildItem -Path "D:\GIT\farcry\Cursor\FKmermaid\logs" -Filter "*.log" | Sort-Object LastWriteTime -Descending
if ($logFiles) {
    $latestLog = $logFiles | Select-Object -First 1
    $errorCount = (Get-Content $latestLog.FullName | Select-String "\[ERROR\]" | Measure-Object).Count
    
    if ($errorCount -gt 0) {
        Write-Host "⚠️  Found $errorCount error(s) in log file: $($latestLog.Name)" -ForegroundColor Yellow
    } else {
        Write-Host "✅ No errors found in log file" -ForegroundColor Green
    }
} 