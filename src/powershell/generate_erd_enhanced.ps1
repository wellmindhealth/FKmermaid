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
    REQUIRED: Array of domains to filter relationships (e.g., "pathway", "participant", "provider")
    Multiple domains can be specified as comma-separated values: "pathway,participant"
    
.PARAMETER ApplyDomainFilterAt
    OPTIONAL: Level at which domain filtering applies (default: 2)
    - Level 1: Focus entity only
    - Level 2+: Domain filtering applies (entities must be in domains.json)
    - Use 1 to show focus + all relationships regardless of domains.json
    - Use 3+ to show more levels before domain filtering kicks in
    
.PARAMETER RefreshCFCs
    OPTIONAL: Switch to force fresh CFC scanning (bypasses cache)
    
.PARAMETER ConfigFile
    OPTIONAL: Custom config file path (default: config/cfc_scan_config.json)
    
.PARAMETER OutputFile
    OPTIONAL: Custom output file path (default: auto-generated timestamped file)
    
.PARAMETER Debug
    OPTIONAL: Switch to enable debug mode
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "pathway"
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "Class" -lDomains "participant" -RefreshCFCs
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "pathway,participant" -OutputFile "custom.mmd"
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "dmImage" -DiagramType "ER" -lDomains "pathway" -OutputFile "custom.mmd"
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "farUser" -DiagramType "ER" -lDomains "all"
    
.EXAMPLE
    .\generate_erd_enhanced.ps1 -lFocus "partner" -DiagramType "ER"
    
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
    [switch]$DebugScan = $false,
    [switch]$Help = $false,
    [string]$ConfigFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json",
    [string]$OutputFile = "",
    [switch]$Debug,
    [string]$MermaidMode = "edit",
    [switch]$NoBrowser = $false,
    [string]$JsonOutputFile = "",
    [int]$ApplyDomainFilterAt = 2,
    [string]$ExcludeLayers = "",
    [string]$IncludeLayers = ""
)

# Import logging modules
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
    
    # Initialize logging
    Initialize-ModuleLogging -ModuleName "diagram_generation" -Debug:$Debug
    Write-InfoLog "Starting ER diagram generation" -Context "Diagram_Generation" -Data @{
        Focus = $lFocus
        DiagramType = $DiagramType
        Domains = $lDomains
        RefreshCFCs = $RefreshCFCs
        ConfigFile = $ConfigFile
    }
} else {
    Write-Host "Warning: Logger module not found, using console output only" -ForegroundColor Yellow
}

# Help function
function Show-Help {
    Write-Host "FarCry ERD Generator (Enhanced)" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📚 COMPLETE PARAMETER REFERENCE:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🔴 REQUIRED PARAMETERS:" -ForegroundColor Red
    Write-Host "  -lFocus 'entityName'     # Focus entity (e.g., 'activityDef', 'progRole', 'member')" -ForegroundColor White
    Write-Host "  -DiagramType 'ER|Class'  # Diagram type ('ER' or 'Class')" -ForegroundColor White
    Write-Host "  -lDomains 'domain1,domain2' # Domains to include (e.g., 'pathway,participant')" -ForegroundColor White
    Write-Host "                           # Use 'all' or omit for all domains" -ForegroundColor White
    Write-Host ""
    Write-Host "🟡 OPTIONAL PARAMETERS:" -ForegroundColor Yellow
    Write-Host "  -RefreshCFCs             # Force fresh CFC scanning (bypass cache)" -ForegroundColor White
    Write-Host "  -ConfigFile 'path'       # Custom config file path" -ForegroundColor White
    Write-Host "  -OutputFile 'path'       # Custom output file path" -ForegroundColor White
    Write-Host "  -Help                    # Show this help message" -ForegroundColor White
    Write-Host "  -Debug                   # Enable debug mode" -ForegroundColor White
    Write-Host "  -MermaidMode 'edit|view' # Mermaid.live mode ('edit' or 'view')" -ForegroundColor White
    Write-Host "  -NoBrowser              # Suppress browser opening (for automation)" -ForegroundColor White
    Write-Host "  -ApplyDomainFilterAt N   # Apply domain filtering at relationship level N (default: 2)" -ForegroundColor White
    Write-Host ""
    Write-Host "💡 USAGE EXAMPLES:" -ForegroundColor Cyan
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'activityDef' -DiagramType 'ER' -lDomains 'pathway'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'Class' -lDomains 'participant' -RefreshCFCs" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'progRole' -DiagramType 'ER' -lDomains 'pathway,participant'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'dmImage' -DiagramType 'ER' -lDomains 'pathway' -OutputFile 'custom.mmd'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'farUser' -DiagramType 'ER' -lDomains 'all'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'partner' -DiagramType 'ER'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'ER' -MermaidMode 'view'" -ForegroundColor Green
    Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'ER' -lDomains 'participant' -ApplyDomainFilterAt 3" -ForegroundColor Green
    Write-Host ""
    Write-Host "📖 For complete documentation, see: README.md" -ForegroundColor Yellow
    exit 0
}



# Node.js tools are available for Mermaid.live URL generation

# Function to generate unique filename with timestamp
function Get-UniqueFilename {
    param([string]$baseName, [string]$extension = "mmd")
    
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $uniqueId = [System.Guid]::NewGuid().ToString("N").Substring(0, 8)
    return "${baseName}_${timestamp}_${uniqueId}.${extension}"
}

# Function to clean old files
function Clean-OldFiles {
    param([string]$directory, [string]$pattern, [int]$maxAgeHours = 24, [string]$excludePattern = "")
    
    if (Test-Path $directory) {
        $cutoffTime = (Get-Date).AddHours(-$maxAgeHours)
        $oldFiles = Get-ChildItem -Path $directory -Filter $pattern | Where-Object { 
            $_.LastWriteTime -lt $cutoffTime -and 
            (-not $excludePattern -or $_.Name -notlike $excludePattern)
        }
        
        if ($oldFiles.Count -gt 0) {
            Write-Host "🧹 Cleaning $($oldFiles.Count) old files from $directory" -ForegroundColor Gray
            $oldFiles | Remove-Item -Force
        }
    }
}

# Load relationship detection module
$modulePath = Join-Path $PSScriptRoot "relationship_detection.ps1"
if (Test-Path $modulePath) {
    . $modulePath
    Write-Host "✅ Loaded relationship detection module" -ForegroundColor Green
} else {
    Write-Host "❌ Relationship detection module not found: $modulePath" -ForegroundColor Red
}



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
            return $domainsConfig.domains
        } catch {
            Write-Host "Error loading domains config: $($_.Exception.Message)"
            return @{}
        }
    } else {
        Write-Host "Domains config file not found: $domainsFile"
        return @{}
    }
}

# Check if an entity belongs to a domain
function Entity-BelongsToDomain {
    param([string]$entityName, [string]$domainName, [object]$domainsConfig)
    
    if (-not $domainsConfig -or -not $domainsConfig.$domainName) {
        return $false
    }
    
    $domain = $domainsConfig.$domainName
    $allEntities = @()
    
    # Collect all entities from all categories in the domain
    foreach ($category in $domain.entities.PSObject.Properties.Name) {
        # Handle entities as arrays (not space-separated strings)
        $categoryEntities = $domain.entities.$category
        if ($categoryEntities -is [array]) {
            $allEntities += $categoryEntities
        } else {
            # Fallback for string format
            $categoryEntities = $categoryEntities -split '\s+'
            $allEntities += $categoryEntities
        }
    }
    

    
    return $allEntities -contains $entityName
}

# Validate domains and return valid ones
function Validate-Domains {
    param([string]$lDomains, [object]$domainsConfig)
    
    $validDomains = $domainsConfig.PSObject.Properties.Name
    
    if ([string]::IsNullOrWhiteSpace($lDomains) -or $lDomains -eq "all") {
        Write-Host "📋 No domains specified or 'all' used - using ALL domains: $($validDomains -join ', ')" -ForegroundColor Cyan
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
        # Allow null/empty domains - they will be handled by Validate-Domains function
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
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'activityDef' -DiagramType 'ER' -lDomains 'pathway'" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'member' -DiagramType 'Class' -lDomains 'participant' -RefreshCFCs" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'progRole' -DiagramType 'ER' -lDomains 'pathway,participant'" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'dmImage' -DiagramType 'ER' -lDomains 'pathway' -OutputFile 'custom.mmd'" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'farUser' -DiagramType 'ER' -lDomains 'all'" -ForegroundColor Cyan
        Write-Host "  .\generate_erd_enhanced.ps1 -lFocus 'partner' -DiagramType 'ER'" -ForegroundColor Cyan
        Write-Host "`n📚 See README.md for complete parameter documentation" -ForegroundColor Yellow
        exit 1
    }
}

# Check for help parameter first (before validation)
if ($Help) {
    Show-Help
}

# Debug mode - just check directories (bypass validation)


# Validate parameters before proceeding
Validate-Parameters

# Load configuration
$config = Load-Config -configFile $ConfigFile
if ($null -eq $config) {
    Write-Host "Failed to load configuration. Exiting."
    exit 1
}



# Load and validate domains
$domainsConfig = Load-DomainsConfig
$validatedDomains = Validate-Domains -lDomains $lDomains -domainsConfig $domainsConfig

# Extract settings from config
$pluginsPath = $config.scanSettings.pluginsPath
$excludeFolders = $config.scanSettings.excludeFolders
$excludeFiles = $config.scanSettings.excludeFiles
$cacheFile = $config.scanSettings.cacheFile
$knownTables = $config.entityConstraints.knownTables

# Generate unique output filename if not specified
if ($OutputFile -eq "") {
    $baseName = "erd"
    if ($lFocus) {
        $baseName = $lFocus -replace ',', '_'
    }
    $uniqueFilename = Get-UniqueFilename -baseName $baseName -extension "mmd"
    $outputFile = Join-Path "D:\GIT\farcry\Cursor\FKmermaid\exports" $uniqueFilename
} else {
    # If OutputFile is specified, use the provided path
    $outputFile = $OutputFile
    # Ensure the directory exists
    $outputDir = Split-Path $outputFile -Parent
    if ($outputDir -and -not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
}

# Clean old files before generating new ones (only if outputting to exports directory)
if ($OutputFile -eq "" -or (Split-Path $outputFile -Parent) -eq "D:\GIT\farcry\Cursor\FKmermaid\exports") {
    Clean-OldFiles -directory "D:\GIT\farcry\Cursor\FKmermaid\exports" -pattern "*.mmd" -maxAgeHours 168 -excludePattern "baseline_*"
}

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
    
    # First pass: count total files to process for progress bar
    $totalFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            if ($scanDir -like "*zfarcrycore*") {
                $packagesPath = Join-Path $scanDir "packages"
                if (Test-Path $packagesPath) {
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    $totalFiles += ($cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }).Count
                }
            } else {
            $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
            foreach ($pluginFolder in $pluginFolders) {
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    if (Test-Path $packagesPath) {
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        $totalFiles += ($cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }).Count
                    }
                }
            }
        }
    }
    
    Write-Host "📁 Scanning CFC files for relationships... ($totalFiles files to process)" -ForegroundColor Cyan
    
    # Second pass: process files with progress bar
    $processedFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            # Handle zfarcrycore differently (it's not a plugin)
            if ($scanDir -like "*zfarcrycore*") {
                $pluginName = "zfarcrycore"
                
                # Scan for CFC files in packages subdirectories
                $packagesPath = Join-Path $scanDir "packages"
                if (Test-Path $packagesPath) {
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    
                    foreach ($cfcFile in $cfcFiles) {
                        # Extract entity name from filename first (before reading file)
                        $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                        
                        # Only process if entity is in known tables (skip reading file if not needed)
                        if ($knownTables -contains $entityName) {
                            $processedFiles++
                            $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                            Write-Host "`r📁 Processing: $entityName [$progress%]   " -NoNewline
                            
                            $content = Get-Content $cfcFile.FullName -Raw
                            # Extract entity info
                            $relationships.entities += @{
                                name = $entityName
                                plugin = $pluginName
                                file = $cfcFile.FullName
                            }
                            
                            # Use the optimized relationship detection from the module
                            $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                            
                            # Merge relationships
                            $relationships.directFK += $entityRelationships.directFK
                            $relationships.joinTables += $entityRelationships.joinTables
                            $relationships.properties += $entityRelationships.properties
                        }
                    }
                }
            } else {
                # Scan all plugin folders except excluded ones
                $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
                
                foreach ($pluginFolder in $pluginFolders) {
                    $pluginName = $pluginFolder.Name
                    
                    # Scan for CFC files in all packages subdirectories
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    if (Test-Path $packagesPath) {
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        
                        foreach ($cfcFile in $cfcFiles) {
                            # Extract entity name from filename first (before reading file)
                            $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                            
                            # Only process if entity is in known tables (skip reading file if not needed)
                            if ($knownTables -contains $entityName) {
                                $processedFiles++
                                $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                                Write-Host "`r📁 Processing: $entityName [$progress%]   " -NoNewline
                                
                                $content = Get-Content $cfcFile.FullName -Raw
                                # Extract entity info
                                $relationships.entities += @{
                                    name = $entityName
                                    plugin = $pluginName
                                    file = $cfcFile.FullName
                                }
                                
                                # Use the optimized relationship detection from the module
                                $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                                
                                # Merge relationships
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
    
    Write-Host "`n✅ CFC scanning complete!" -ForegroundColor Green
    
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

# Function to generate unique filename with timestamp
function Get-UniqueFilename {
    param([string]$baseName, [string]$extension = "mmd")
    
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $uniqueId = [System.Guid]::NewGuid().ToString("N").Substring(0, 8)
    return "${baseName}_${timestamp}_${uniqueId}.${extension}"
}

# Function to clean old files
function Clean-OldFiles {
    param([string]$directory, [string]$pattern, [int]$maxAgeHours = 24, [string]$excludePattern = "")
    
    if (Test-Path $directory) {
        $cutoffTime = (Get-Date).AddHours(-$maxAgeHours)
        $oldFiles = Get-ChildItem -Path $directory -Filter $pattern | Where-Object { 
            $_.LastWriteTime -lt $cutoffTime -and 
            (-not $excludePattern -or $_.Name -notlike $excludePattern)
        }
        
        if ($oldFiles.Count -gt 0) {
            Write-Host "🧹 Cleaning $($oldFiles.Count) old files from $directory" -ForegroundColor Gray
            $oldFiles | Remove-Item -Force
        }
    }
}

# Function to calculate relationship levels for entities
function Get-EntityRelationshipLevels {
    param($relationships, [string]$lFocus, [int]$ApplyDomainFilterAt)
    
    $entityLevels = @{}
    $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
    
    # Level 0: Focus entities
    foreach ($focusEntity in $focusEntities) {
        $entityLevels[$focusEntity] = 0
    }
    
    # Level 1: Direct relationships to focus entities
    $level1Entities = @()
    foreach ($focusEntity in $focusEntities) {
        # Direct FK relationships
        foreach ($fk in $relationships.directFK) {
            if ($fk.source -eq $focusEntity) {
                $entityLevels[$fk.target] = 1
                $level1Entities += $fk.target
            }
            if ($fk.target -eq $focusEntity) {
                $entityLevels[$fk.source] = 1
                $level1Entities += $fk.source
            }
        }
        # Join table relationships
        foreach ($join in $relationships.joinTables) {
            if ($join.source -eq $focusEntity) {
                $entityLevels[$join.target] = 1
                $level1Entities += $join.target
            }
            if ($join.target -eq $focusEntity) {
                $entityLevels[$join.source] = 1
                $level1Entities += $join.source
            }
        }
    }
    
    # Level 2+: Further relationships (recursive)
    $currentLevel = 2
    $previousLevelEntities = $level1Entities
    
    while ($previousLevelEntities.Count -gt 0 -and $currentLevel -le 10) { # Max 10 levels to prevent infinite loops
        $currentLevelEntities = @()
        
        foreach ($entity in $previousLevelEntities) {
            # Direct FK relationships
            foreach ($fk in $relationships.directFK) {
                if ($fk.source -eq $entity -and -not $entityLevels.ContainsKey($fk.target)) {
                    $entityLevels[$fk.target] = $currentLevel
                    $currentLevelEntities += $fk.target
                }
                if ($fk.target -eq $entity -and -not $entityLevels.ContainsKey($fk.source)) {
                    $entityLevels[$fk.source] = $currentLevel
                    $currentLevelEntities += $fk.source
                }
            }
            # Join table relationships
            foreach ($join in $relationships.joinTables) {
                if ($join.source -eq $entity -and -not $entityLevels.ContainsKey($join.target)) {
                    $entityLevels[$join.target] = $currentLevel
                    $currentLevelEntities += $join.target
                }
                if ($join.target -eq $entity -and -not $entityLevels.ContainsKey($join.source)) {
                    $entityLevels[$join.source] = $currentLevel
                    $currentLevelEntities += $join.source
                }
            }
        }
        
        $previousLevelEntities = $currentLevelEntities
        $currentLevel++
    }
    
    return $entityLevels
}

# Function to generate Mermaid ER diagram
function Generate-MermaidERD {
    param($relationships, $knownTables, [string]$lFocus = "", [array]$validatedDomains = @(), [object]$domainsConfig = @{}, [hashtable]$cssStyles = @{}, [int]$ApplyDomainFilterAt = 2)
    
    $mermaidContent = "erDiagram`n"
    
                # Add parameters as a comment since ER diagrams may not support notes properly
        $paramComment = @"
%% Parameters:
%%   Focus: $lFocus
%%   Domains: $($validatedDomains -join ', ')
%%   Chart Type: ER
"@
        $mermaidContent += "    $paramComment`n"
    
    # Use validated domains
    $domainList = $validatedDomains
    
    # Calculate relationship levels for all entities
    $entityLevels = Get-EntityRelationshipLevels -relationships $relationships -lFocus $lFocus -ApplyDomainFilterAt $ApplyDomainFilterAt
    
    # Filter entities based on parameters and relationship levels
    $filteredEntities = $relationships.entities | Where-Object {
        $entity = $_
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        $includeEntity = $false
        
        # If focus entity is specified, check if this entity is focus or related
        if ($lFocus -and $lFocus -ne "") {
            # Split focus entities if comma-separated
            $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
            
            # Check if this entity is one of the focus entities (Level 0)
            if ($focusEntities -contains $entityName) {
                $includeEntity = $true
            } else {
                # Check if entity has a relationship level assigned
                if ($entityLevels.ContainsKey($entityName)) {
                    $entityLevel = $entityLevels[$entityName]
                    
                    # If entity level is below ApplyDomainFilterAt, include it (no domain filtering)
                    if ($entityLevel -lt $ApplyDomainFilterAt) {
                        $includeEntity = $true
                    } else {
                        # Entity level is at or above ApplyDomainFilterAt - apply domain filtering
                        if ($domainList.Count -gt 0) {
                            $domainMatch = $false
                            foreach ($domain in $domainList) {
                                if (Entity-BelongsToDomain -entityName $entityName -domainName $domain -domainsConfig $domainsConfig) {
                                    $domainMatch = $true
                                    break
                                }
                            }
                            $includeEntity = $domainMatch
                        } else {
                            # No domains specified, include all entities at this level
                            $includeEntity = $true
                        }
                    }
                }
            }
        }
        
        # If no focus specified, use domain filtering only
        if (-not $lFocus -and $domainList.Count -gt 0) {
            $domainMatch = $false
            foreach ($domain in $domainList) {
                if (Entity-BelongsToDomain -entityName $entityName -domainName $domain -domainsConfig $domainsConfig) {
                    $domainMatch = $true
                    break
                }
            }
            $includeEntity = $domainMatch
        }
        
        # If no filters, include all entities
        if (-not $lFocus -and $domainList.Count -eq 0) {
            $includeEntity = $true
        }
        
        return $includeEntity
    }
    
    # Get list of filtered entities that exist
    $existingEntities = $filteredEntities | ForEach-Object { $_.name }
    
    # Consolidate duplicate entities (same entity name in different plugins)
    $consolidatedEntities = @{}
    $consolidatedFilteredEntities = @()
    
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        if (-not $consolidatedEntities.ContainsKey($entityName)) {
            # First occurrence of this entity name
            $consolidatedEntities[$entityName] = @($pluginName)
            $consolidatedFilteredEntities += $entity
        } else {
            # Duplicate entity name - add plugin to existing list
            $consolidatedEntities[$entityName] += $pluginName
            # Don't add duplicate entity to filtered list
        }
    }
    
    # Update filtered entities to use consolidated list
    $filteredEntities = $consolidatedFilteredEntities
    $existingEntities = $filteredEntities | ForEach-Object { $_.name }
    
    # Log consolidation results
    $duplicateEntities = $consolidatedEntities | Where-Object { $_.Value.Count -gt 1 }
    if ($duplicateEntities.Count -gt 0) {
        Write-Host "🔗 Consolidated duplicate entities:" -ForegroundColor Yellow
        foreach ($entity in $duplicateEntities) {
            Write-Host "   $($entity.Key): $($entity.Value -join ', ')" -ForegroundColor Cyan
        }
    }
    

    
    Write-Host "📊 Filtered to $($filteredEntities.Count) entities based on parameters:" -ForegroundColor Cyan
    if ($lFocus) { Write-Host "   Focus: $lFocus" -ForegroundColor Yellow }
    if ($domainList.Count -gt 0) { Write-Host "   Domains: $($domainList -join ', ')" -ForegroundColor Yellow }
    
    # Write-Host "🔍 DEBUG: Filtered entities:" -ForegroundColor Magenta
    # foreach ($entity in $filteredEntities) {
    #     Write-Host "  - $($entity.name) (plugin: $($entity.plugin))" -ForegroundColor Cyan
    # }
    
    # Add entities with proper attributes
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        # Only include entities from known tables and ensure name is complete
        if ($knownTables -contains $entityName -and $entityName -and $entityName.Length -gt 0) {
            $entityDisplayName = "$pluginName - $entityName"
            
            # Sanitize entity name for ER diagram (same as class diagram)
            $sanitizedEntityName = $entityDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedEntityName = $sanitizedEntityName -replace '_+', '_'
            $sanitizedEntityName = $sanitizedEntityName.Trim('_')
            
            # Get layer icon for this entity
            $layerInfo = Get-EntityLayerIcon -entityName $entityName -domainsConfig $domainsConfig -catchallConfig $catchallConfig
            
            $mermaidContent += "    `"$sanitizedEntityName`" {`n"
            $mermaidContent += "        $($layerInfo.Display) UUID ObjectID`n"
            $mermaidContent += "    }`n`n"
        }
    }
    
    # Process direct FK relationships for self-referencing
    $selfRefDirectFK = @()
    $otherDirectFK = @()
    
    foreach ($fk in $relationships.directFK) {
        $sourceEntity = $fk.source
        $targetEntity = $fk.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            if ($sourceEntity -eq $targetEntity) {
                # Self-referencing direct FK relationship
                $selfRefDirectFK += $fk
            } else {
                # Cross-entity direct FK relationship
                $otherDirectFK += $fk
            }
        }
    }
    
    # Add non-self-referencing direct FK relationships
    if ($otherDirectFK.Count -gt 0) {
        $mermaidContent += "    %% Direct FK Relationships`n"
        foreach ($fk in $otherDirectFK) {
            $sourceEntity = $fk.source
            $targetEntity = $fk.target
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            
            # Sanitize entity names for relationships
            $sourceDisplayName = "$sourcePlugin - $sourceEntity"
            $targetDisplayName = "$targetPlugin - $targetEntity"
            $sanitizedSourceName = $sourceDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedSourceName = $sanitizedSourceName -replace '_+', '_'
            $sanitizedSourceName = $sanitizedSourceName.Trim('_')
            $sanitizedTargetName = $targetDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedTargetName = $sanitizedTargetName -replace '_+', '_'
            $sanitizedTargetName = $sanitizedTargetName.Trim('_')
            
            $mermaidContent += "    `"$sanitizedSourceName`" ||--|| `"$sanitizedTargetName`" : $($fk.property)`n"
        }
        $mermaidContent += "    %% End Direct FK Relationships`n`n"
    }

    # Add special joins (complex relationships not detected by cfproperty parsing)
    $mermaidContent += "    %% Special Joins`n"
    
    # farUser > dmProfile special join via userID = userName + '_' + userDirectory
    $farUserExists = $existingEntities -contains "farUser"
    $dmProfileExists = $existingEntities -contains "dmProfile"
    if ($farUserExists -or $dmProfileExists) {
        # Get plugin info for existing entities, use proper names for missing ones
        if ($farUserExists) {
            $farUserPlugin = ($filteredEntities | Where-Object { $_.name -eq "farUser" }).plugin
            $farUserDisplayName = "$farUserPlugin - farUser"
        } else {
            $farUserDisplayName = "zfarcrycore - farUser"
        }
        
        if ($dmProfileExists) {
            $dmProfilePlugin = ($filteredEntities | Where-Object { $_.name -eq "dmProfile" }).plugin
            $dmProfileDisplayName = "$dmProfilePlugin - dmProfile"
        } else {
            $dmProfileDisplayName = "zfarcrycore - dmProfile"
        }
        
        $sanitizedFarUser = $farUserDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedFarUser = $sanitizedFarUser -replace '_+', '_'
        $sanitizedFarUser = $sanitizedFarUser.Trim('_')
        $sanitizedDmProfile = $dmProfileDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedDmProfile = $sanitizedDmProfile -replace '_+', '_'
        $sanitizedDmProfile = $sanitizedDmProfile.Trim('_')
        
        $mermaidContent += "    `"$sanitizedFarUser`" ||--|| `"$sanitizedDmProfile`" : userID_to_userName_userDirectory`n"
    }
    
    $mermaidContent += "    %% End Special Joins`n`n"
    
    # Add missing entities that are referenced in special joins but not in filtered entities
    if ($farUserExists -or $dmProfileExists) {
        if (-not $farUserExists) {
            $farUserLayerInfo = Get-EntityLayerIcon -entityName "farUser" -domainsConfig $domainsConfig -catchallConfig $catchallConfig
            $mermaidContent += "    `"zfarcrycore_farUser`" {`n"
            $mermaidContent += "        $($farUserLayerInfo.Display) UUID ObjectID`n"
            $mermaidContent += "    }`n`n"
        }
        if (-not $dmProfileExists) {
            $dmProfileLayerInfo = Get-EntityLayerIcon -entityName "dmProfile" -domainsConfig $domainsConfig -catchallConfig $catchallConfig
            $mermaidContent += "    `"zfarcrycore_dmProfile`" {`n"
            $mermaidContent += "        $($dmProfileLayerInfo.Display) UUID ObjectID`n"
            $mermaidContent += "    }`n`n"
        }
    }

    # Process join table relationships for self-referencing
    $selfRefGroups = @{}
    $otherJoinRelationships = @()

    foreach ($join in $relationships.joinTables) {
        $sourceEntity = $join.source
        $targetEntity = $join.target
        
        # Only include if both entities are in our filtered list
        if ($existingEntities -contains $sourceEntity -and $existingEntities -contains $targetEntity) {
            if ($sourceEntity -eq $targetEntity) {
                # Self-referencing relationship (ftJoin points to same entity)
                if (-not $selfRefGroups.ContainsKey($sourceEntity)) {
                    $selfRefGroups[$sourceEntity] = @()
                }
                $selfRefGroups[$sourceEntity] += $join
            } else {
                # Cross-entity relationship
                $otherJoinRelationships += $join
            }
        }
    }
    
    # Output self-referencing groups per entity (including both direct FK and join table relationships)
    foreach ($entityName in $selfRefGroups.Keys) {
        $group = $selfRefGroups[$entityName]
        $mermaidContent += "    %% Self-Referencing Relationships for $entityName`n"
        
        # Collect all self-referencing relationships for this entity
        $allSelfRefRelationships = @()
        
        # Add self-referencing direct FK relationships for this entity
        foreach ($fk in $selfRefDirectFK) {
            if ($fk.source -eq $entityName) {
                $allSelfRefRelationships += $fk.property
            }
        }
        
        # Add self-referencing join table relationships for this entity
        foreach ($join in $group) {
            $allSelfRefRelationships += $join.property
        }
        
        # Add comment listing all the self-referencing relationships
        $relationshipList = $allSelfRefRelationships -join ', '
        $mermaidContent += "    %% Self-refs include: $relationshipList`n"
        
        # Create a short placeholder label for consolidated self-referencing relationships
        $consolidatedLabel = "self_refs"
        
        # Get entity display names
        $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $entityName }).plugin
        $sourceDisplayName = "$sourcePlugin - $entityName"
        $sanitizedSourceName = $sourceDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedSourceName = $sanitizedSourceName -replace '_+', '_'
        $sanitizedSourceName = $sanitizedSourceName.Trim('_')
        
        # Add single consolidated relationship line
        $mermaidContent += "    `"$sanitizedSourceName`" ||--|| `"$sanitizedSourceName`" : $consolidatedLabel`n"
        
        $mermaidContent += "    %% End Self-Referencing Relationships for $entityName`n`n"
    }

    # Add other join table relationships
    if ($otherJoinRelationships.Count -gt 0) {
        $mermaidContent += "    %% Join Table Relationships`n"
        foreach ($join in $otherJoinRelationships) {
            $sourceEntity = $join.source
            $targetEntity = $join.target
            $sourcePlugin = ($filteredEntities | Where-Object { $_.name -eq $sourceEntity }).plugin
            $targetPlugin = ($filteredEntities | Where-Object { $_.name -eq $targetEntity }).plugin
            $sourceDisplayName = "$sourcePlugin - $sourceEntity"
            $targetDisplayName = "$targetPlugin - $targetEntity"
            $sanitizedSourceName = $sourceDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedSourceName = $sanitizedSourceName -replace '_+', '_'
            $sanitizedSourceName = $sanitizedSourceName.Trim('_')
            $sanitizedTargetName = $targetDisplayName -replace '[^a-zA-Z0-9_]', '_'
            $sanitizedTargetName = $sanitizedTargetName -replace '_+', '_'
            $sanitizedTargetName = $sanitizedTargetName.Trim('_')
            $mermaidContent += "    `"$sanitizedSourceName`" }o--|| `"$sanitizedTargetName`" : $($join.property)`n"
        }
        $mermaidContent += "    %% End Join Table Relationships`n`n"
    }

    # Add styling
    $mermaidContent += "`n    %% Entity Styling`n"
    # Get related entities based on actual relationships with focus entities
    $relatedEntities = @()
    if ($lFocus) {
        # Split focus entities if comma-separated
        $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
        
        foreach ($focusEntity in $focusEntities) {
            # Find entities that have direct FK relationships with the focus entity
            $directRelated = $relationships.directFK | Where-Object { 
                $_.source -eq $focusEntity -or $_.target -eq $focusEntity 
            } | ForEach-Object { 
                if ($_.source -eq $focusEntity) { $_.target } else { $_.source }
            }
            
            # Find entities that have join table relationships with the focus entity
            $joinRelated = $relationships.joinTables | Where-Object {
                $_.source -eq $focusEntity -or $_.target -eq $focusEntity -or $_.joinTable -eq $focusEntity
            } | ForEach-Object { 
                if ($_.source -eq $focusEntity) { $_.target } 
                elseif ($_.target -eq $focusEntity) { $_.source }
                else { $_.joinTable }
            }
            
            # Convert base entity names to full entity names with plugin prefixes
            $fullDirectRelated = @()
            foreach ($baseEntity in $directRelated) {
                $entityInfo = $relationships.entities | Where-Object { $_.name -eq $baseEntity } | Select-Object -First 1
                if ($entityInfo) {
                    $fullDirectRelated += "$($entityInfo.plugin)_$baseEntity"
                }
            }
            
            $fullJoinRelated = @()
            foreach ($baseEntity in $joinRelated) {
                $entityInfo = $relationships.entities | Where-Object { $_.name -eq $baseEntity } | Select-Object -First 1
                if ($entityInfo) {
                    $fullJoinRelated += "$($entityInfo.plugin)_$baseEntity"
                }
            }
            
            # Add all related entities to the list
            $relatedEntities += $fullDirectRelated
            $relatedEntities += $fullJoinRelated
        }
        
        # Add special join relationships with full names
        # farUser <-> dmProfile special join
        if ($focusEntities -contains "dmProfile") {
            $relatedEntities += "zfarcrycore_farUser"
        }
        if ($focusEntities -contains "farUser") {
            $relatedEntities += "zfarcrycore_dmProfile"
        }
        
        # Remove duplicates and focus entities themselves
        $relatedEntities = $relatedEntities | Where-Object { $focusEntities -notcontains $_ } | Sort-Object -Unique
        
        # Debug logging
    }
    
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        $entityDisplayName = "$pluginName - $entityName"
        
        # Construct full focus entity name with plugin prefix
        $fullFocusEntity = $lFocus
        if ($lFocus -and $lFocus -ne "") {
            # Split focus entities and check each one
            $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
            $missingEntities = @()
            $excludedEntities = @()
            
            foreach ($focusEntity in $focusEntities) {
                # Find the plugin for the focus entity
                $focusEntityInfo = $relationships.entities | Where-Object { $_.name -eq $focusEntity } | Select-Object -First 1
                if (-not $focusEntityInfo) {
                    # Focus entity not found - check if it's excluded
                    $excludeFiles = @()
                    $exclusionsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\exclusions.json"
                    if (Test-Path $exclusionsFile) {
                        $exclusions = Get-Content $exclusionsFile -Raw | ConvertFrom-Json
                        $excludeFiles = $exclusions.excludeFiles
                    }
                    
                    $excludedFile = "$focusEntity.cfc"
                    if ($excludeFiles -contains $excludedFile) {
                        $excludedEntities += $focusEntity
                    } else {
                        $missingEntities += $focusEntity
                    }
                }
            }
            
            # Report any missing or excluded entities
            if ($excludedEntities.Count -gt 0) {
                Write-Host "❌ ERROR: Focus entities are excluded from scanning (found in exclusions.json)" -ForegroundColor Red
                foreach ($excluded in $excludedEntities) {
                    Write-Host "   Excluded file: $excluded.cfc" -ForegroundColor Yellow
                }
                Write-Host "   Please remove these files from exclusions.json if you want to focus on these entities" -ForegroundColor Yellow
                exit 1
            }
            
            if ($missingEntities.Count -gt 0) {
                Write-Host "❌ ERROR: Focus entities not found in cache: $($missingEntities -join ', ')" -ForegroundColor Red
                Write-Host "   Available entities: $($relationships.entities.name -join ', ')" -ForegroundColor Yellow
                exit 1
            }
            
            # Pass all focus entities to Get-EntityStyle (it handles comma-separated format)
            $fullFocusEntity = $focusEntities -join ','
        }
        
        $style = Get-EntityStyle -entityName $entityName -pluginName $pluginName -focusEntity $fullFocusEntity -relatedEntities $relatedEntities -cssStyles $cssStyles -validatedDomains $validatedDomains -domainsConfig $domainsConfig
        
        # Determine style name by finding which CSS style this matches
        $styleName = "secondary"  # default
        foreach ($cssKey in $cssStyles.Keys) {
            if ($style -eq $cssStyles[$cssKey]) {
                $styleName = $cssKey
                break
            }
        }
        
        # Use sanitized entity name for style definition (no spaces, hyphens, or quotes)
        $sanitizedEntityName = Get-SanitizedEntityName -entityName $entityDisplayName
        $mermaidContent += "    %% $styleName tier`n"
        $mermaidContent += "    style $sanitizedEntityName $style`n"
    }
    
                        # Add consistent styling for special join entities
                    if ($farUserExists -or $dmProfileExists) {
                        # Style special join entities consistently regardless of domain
                        $mermaidContent += "    %% special join entity`n"
                        # $mermaidContent += "    style zfarcrycore_farUser $($cssStyles["special_join"])`n"
                        # $mermaidContent += "    style zfarcrycore_dmProfile $($cssStyles["special_join"])`n"
                    }
    
    return $mermaidContent
}

# Function to group self-referencing relationships
function Group-SelfReferences {
    param($relationships, $existingEntities)
    
    $selfReferenceGroups = @{}
    
    # Group direct FK self-references
    foreach ($fk in $relationships.directFK) {
        if ($fk.source -eq $fk.target -and $existingEntities -contains $fk.source) {
            $entityName = $fk.source
            if (-not $selfReferenceGroups.ContainsKey($entityName)) {
                $selfReferenceGroups[$entityName] = @()
            }
            $selfReferenceGroups[$entityName] += $fk.property
        }
    }
    
    # Group join table self-references
    foreach ($join in $relationships.joinTables) {
        if ($join.source -eq $join.target -and $existingEntities -contains $join.source) {
            $entityName = $join.source
            if (-not $selfReferenceGroups.ContainsKey($entityName)) {
                $selfReferenceGroups[$entityName] = @()
            }
            $selfReferenceGroups[$entityName] += $join.property
        }
    }
    
    return $selfReferenceGroups
}

# Function to generate Mermaid Class diagram with full styling
function Generate-MermaidClassDiagram {
    param($relationships, $knownTables, [string]$lFocus = "", [array]$validatedDomains = @(), [object]$domainsConfig = @{}, [hashtable]$cssStyles = @{}, [int]$ApplyDomainFilterAt = 2)
    
    $mermaidContent = "classDiagram`n"
    
    # Add parameters as a comment since Class diagrams may not support notes properly
    $paramComment = @"
%% Parameters:
%%   Focus: $lFocus
%%   Domains: $($validatedDomains -join ', ')
%%   Chart Type: Class
"@
    $mermaidContent += "    $paramComment`n"
    
    # Use validated domains
    $domainList = $validatedDomains
    
    # Calculate relationship levels for all entities
    $entityLevels = Get-EntityRelationshipLevels -relationships $relationships -lFocus $lFocus -ApplyDomainFilterAt $ApplyDomainFilterAt
    
    # Filter entities based on parameters and relationship levels (same logic as ER diagram)
    $filteredEntities = $relationships.entities | Where-Object {
        $entity = $_
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        $includeEntity = $false
        
        # If focus entity is specified, check if this entity is focus or related
        if ($lFocus -and $lFocus -ne "") {
            # Split focus entities if comma-separated
            $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
            
            # Check if this entity is one of the focus entities (Level 0)
            if ($focusEntities -contains $entityName) {
                $includeEntity = $true
            } else {
                # Check if entity has a relationship level assigned
                if ($entityLevels.ContainsKey($entityName)) {
                    $entityLevel = $entityLevels[$entityName]
                    
                    # If entity level is below ApplyDomainFilterAt, include it (no domain filtering)
                    if ($entityLevel -lt $ApplyDomainFilterAt) {
                        $includeEntity = $true
                    } else {
                        # Entity level is at or above ApplyDomainFilterAt - apply domain filtering
                        if ($domainList.Count -gt 0) {
                            $domainMatch = $false
                            foreach ($domain in $domainList) {
                                if (Entity-BelongsToDomain -entityName $entityName -domainName $domain -domainsConfig $domainsConfig) {
                                    $domainMatch = $true
                                    break
                                }
                            }
                            $includeEntity = $domainMatch
                        } else {
                            # No domains specified, include all entities at this level
                            $includeEntity = $true
                        }
                    }
                }
            }
        }
        
        # If no focus specified, use domain filtering only
        if (-not $lFocus -and $domainList.Count -gt 0) {
            $domainMatch = $false
            foreach ($domain in $domainList) {
                if (Entity-BelongsToDomain -entityName $entityName -domainName $domain -domainsConfig $domainsConfig) {
                    $domainMatch = $true
                    break
                }
            }
            $includeEntity = $domainMatch
        }
        
        # If no filters, include all entities
        if (-not $lFocus -and $domainList.Count -eq 0) {
            $includeEntity = $true
        }
        
        return $includeEntity
    }
    
    # Consolidate duplicate entities (same entity name in different plugins) - same logic as ER diagram
    $consolidatedEntities = @{}
    $consolidatedFilteredEntities = @()
    
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        
        if (-not $consolidatedEntities.ContainsKey($entityName)) {
            # First occurrence of this entity name
            $consolidatedEntities[$entityName] = @($pluginName)
            $consolidatedFilteredEntities += $entity
        } else {
            # Duplicate entity name - add plugin to existing list
            $consolidatedEntities[$entityName] += $pluginName
            # Don't add duplicate entity to filtered list
        }
    }
    
    # Update filtered entities to use consolidated list
    $filteredEntities = $consolidatedFilteredEntities
    $existingEntities = $filteredEntities | ForEach-Object { $_.name }
    
    # Log consolidation results
    $duplicateEntities = $consolidatedEntities | Where-Object { $_.Value.Count -gt 1 }
    if ($duplicateEntities.Count -gt 0) {
        Write-Host "🔗 Consolidated duplicate entities:" -ForegroundColor Yellow
        foreach ($entity in $duplicateEntities) {
            Write-Host "   $($entity.Key): $($entity.Value -join ', ')" -ForegroundColor Cyan
        }
    }
    
    Write-Host "📊 Filtered to $($filteredEntities.Count) entities based on parameters:" -ForegroundColor Cyan
    if ($lFocus) { Write-Host "   Focus: $lFocus" -ForegroundColor Yellow }
    if ($domainList.Count -gt 0) { Write-Host "   Domains: $($domainList -join ', ')" -ForegroundColor Yellow }
    Write-Host "   ApplyDomainFilterAt: $ApplyDomainFilterAt" -ForegroundColor Yellow
    
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
    
    # Group self-references and add relationships
    $selfReferenceGroups = Group-SelfReferences -relationships $relationships -existingEntities $existingEntities
    
    # Add non-self-referencing relationships
    foreach ($fk in $relationships.directFK) {
        $sourceEntity = $fk.source
        $targetEntity = $fk.target
        
        # Skip self-references (they'll be handled separately)
        if ($sourceEntity -eq $targetEntity) {
            continue
        }
        
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
        
        # Skip self-references (they'll be handled separately)
        if ($sourceEntity -eq $targetEntity) {
            continue
        }
        
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
            
            $mermaidContent += "    $sanitizedSourceName --> $sanitizedTargetName : $($join.property)`n"
        }
    }
    
    # Add grouped self-references
    foreach ($entityName in $selfReferenceGroups.Keys) {
        $properties = $selfReferenceGroups[$entityName]
        if ($properties.Count -gt 0) {
            $entityInfo = $filteredEntities | Where-Object { $_.name -eq $entityName } | Select-Object -First 1
            if ($entityInfo) {
                $pluginName = $entityInfo.plugin
                $entityDisplayName = "$pluginName - $entityName"
                $sanitizedEntityName = $entityDisplayName -replace '[^a-zA-Z0-9_]', '_'
                $sanitizedEntityName = $sanitizedEntityName -replace '_+', '_'
                $sanitizedEntityName = $sanitizedEntityName.Trim('_')
                
                # Create grouped label for self-references
                $groupedLabel = $properties -join ', '
                $mermaidContent += "    $sanitizedEntityName --> $sanitizedEntityName : $groupedLabel`n"
            }
        }
    }
    
    # Add special joins (complex relationships not detected by cfproperty parsing)
    $mermaidContent += "`n    %% Special Joins`n"
    
    # farUser > dmProfile special join via userID = userName + '_' + userDirectory
    $farUserExists = $existingEntities -contains "farUser"
    $dmProfileExists = $existingEntities -contains "dmProfile"
    if ($farUserExists -or $dmProfileExists) {
        # Get plugin info for existing entities, use proper names for missing ones
        if ($farUserExists) {
            $farUserPlugin = ($filteredEntities | Where-Object { $_.name -eq "farUser" }).plugin
            $farUserDisplayName = "$farUserPlugin - farUser"
        } else {
            $farUserDisplayName = "zfarcrycore - farUser"
        }
        
        if ($dmProfileExists) {
            $dmProfilePlugin = ($filteredEntities | Where-Object { $_.name -eq "dmProfile" }).plugin
            $dmProfileDisplayName = "$dmProfilePlugin - dmProfile"
        } else {
            $dmProfileDisplayName = "zfarcrycore - dmProfile"
        }
        
        $sanitizedFarUser = $farUserDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedFarUser = $sanitizedFarUser -replace '_+', '_'
        $sanitizedFarUser = $sanitizedFarUser.Trim('_')
        $sanitizedDmProfile = $dmProfileDisplayName -replace '[^a-zA-Z0-9_]', '_'
        $sanitizedDmProfile = $sanitizedDmProfile -replace '_+', '_'
        $sanitizedDmProfile = $sanitizedDmProfile.Trim('_')
        
        $mermaidContent += "    $sanitizedFarUser --> $sanitizedDmProfile : userID_to_userName_userDirectory`n"
    }
    
    $mermaidContent += "    %% End Special Joins`n`n"
    
    # Add missing entities that are referenced in special joins but not in filtered entities
    if ($farUserExists -or $dmProfileExists) {
        if (-not $farUserExists) {
            $mermaidContent += "    class zfarcrycore_farUser {`n"
            $mermaidContent += "        +UUID ObjectID`n"
            $mermaidContent += "        +string name`n"
            $mermaidContent += "    }`n`n"
        }
        if (-not $dmProfileExists) {
            $mermaidContent += "    class zfarcrycore_dmProfile {`n"
            $mermaidContent += "        +UUID ObjectID`n"
            $mermaidContent += "        +string name`n"
            $mermaidContent += "    }`n`n"
        }
    }
    
    # Add styling for class diagram (full color support)
    $mermaidContent += "`n    %% Entity Styling`n"
    
    # Get related entities based on actual relationships with focus entities
    $relatedEntities = @()
    if ($lFocus) {
        # Split focus entities if comma-separated
        $focusEntities = $lFocus -split ',' | ForEach-Object { $_.Trim() }
        
        foreach ($focusEntity in $focusEntities) {
            # Find entities that have direct FK relationships with the focus entity
            $directRelated = $relationships.directFK | Where-Object { 
                $_.source -eq $focusEntity -or $_.target -eq $focusEntity 
            } | ForEach-Object { 
                if ($_.source -eq $focusEntity) { $_.target } else { $_.source }
            }
            
            # Find entities that have join table relationships with the focus entity
            $joinRelated = $relationships.joinTables | Where-Object {
                $_.source -eq $focusEntity -or $_.target -eq $focusEntity -or $_.joinTable -eq $focusEntity
            } | ForEach-Object { 
                if ($_.source -eq $focusEntity) { $_.target } 
                elseif ($_.target -eq $focusEntity) { $_.source }
                else { $_.joinTable }
            }
            
            # Convert base entity names to full entity names with plugin prefixes
            $fullDirectRelated = @()
            foreach ($baseEntity in $directRelated) {
                $entityInfo = $relationships.entities | Where-Object { $_.name -eq $baseEntity } | Select-Object -First 1
                if ($entityInfo) {
                    $fullDirectRelated += "$($entityInfo.plugin)_$baseEntity"
                }
            }
            
            $fullJoinRelated = @()
            foreach ($baseEntity in $joinRelated) {
                $entityInfo = $relationships.entities | Where-Object { $_.name -eq $baseEntity } | Select-Object -First 1
                if ($entityInfo) {
                    $fullJoinRelated += "$($entityInfo.plugin)_$baseEntity"
                }
            }
            
            # Add all related entities to the list
            $relatedEntities += $fullDirectRelated
            $relatedEntities += $fullJoinRelated
        }
        # Remove duplicates and focus entities themselves
        $relatedEntities = $relatedEntities | Where-Object { $focusEntities -notcontains $_ } | Sort-Object -Unique
        
        # Debug logging
    }
    
    foreach ($entity in $filteredEntities) {
        $entityName = $entity.name
        $pluginName = $entity.plugin
        $entityDisplayName = "$pluginName - $entityName"
        
        # Construct full focus entity name with plugin prefix
        $fullFocusEntity = $lFocus
        if ($lFocus -and $lFocus -ne "") {
            # Find the plugin for the focus entity
            $focusEntityInfo = $relationships.entities | Where-Object { $_.name -eq $lFocus } | Select-Object -First 1
            if ($focusEntityInfo) {
                $fullFocusEntity = "$($focusEntityInfo.plugin)_$lFocus"
            }
        }
        
        $style = Get-EntityStyle -entityName $entityName -pluginName $pluginName -focusEntity $fullFocusEntity -relatedEntities $relatedEntities -cssStyles $cssStyles -validatedDomains $validatedDomains -domainsConfig $domainsConfig
        
        # Use sanitized entity name for style definition (no spaces, hyphens, or quotes)
        $sanitizedEntityName = Get-SanitizedEntityName -entityName $entityDisplayName
        $mermaidContent += "    style $sanitizedEntityName $style`n"
    }
    
    # Add consistent styling for special join entities
    if ($farUserExists -or $dmProfileExists) {
        # Style special join entities consistently regardless of domain
        # $mermaidContent += "    style zfarcrycore_farUser $($cssStyles["special_join"])`n"
        # $mermaidContent += "    style zfarcrycore_dmProfile $($cssStyles["special_join"])`n"
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

# Function to get Unicode icon and layer for an entity
function Get-EntityLayerIcon {
    param([string]$entityName, [object]$domainsConfig, [object]$catchallConfig)
    

    
    # Unicode icons for each layer
    $layerIcons = @{
        'core' = '🔥'
        'utilities' = '💧'
        'services' = '📞'
        'auth' = '🛡️'
        'audit' = '🔎'
    }
    
    # Entity name is already the base entity name, no prefix stripping needed
    $baseEntityName = $entityName
    # Write-Host "🔍 DEBUG: Get-EntityLayerIcon called for entityName='$entityName'" -ForegroundColor Yellow
    # Write-Host "🔍 DEBUG: entityName='$entityName', baseEntityName='$baseEntityName'" -ForegroundColor Magenta
    
    # Find which layer this entity belongs to
    foreach ($domain in $domainsConfig.PSObject.Properties) {
        foreach ($layer in $domain.Value.entities.PSObject.Properties) {
            if ($layer.Value -contains $baseEntityName) {
                $layerKey = $layer.Name
                $icon = $layerIcons[$layerKey]
                if ($icon) {
                    # Write-Host "🔍 DEBUG: Found $baseEntityName in $($domain.Name).$($layer.Name)" -ForegroundColor Green
                    return @{
                        Layer = $layerKey
                        Icon = $icon
                        Display = "$icon $($layerKey.ToUpper())"
                    }
                }
            }
        }
    }
    
    # Check catchall section if it exists
    if ($catchallConfig -and $catchallConfig.entities) {
        foreach ($layer in $catchallConfig.entities.PSObject.Properties) {
            if ($layer.Value -contains $baseEntityName) {
                $layerKey = $layer.Name
                $icon = $layerIcons[$layerKey]
                if ($icon) {
                    # Write-Host "🔍 DEBUG: Found $baseEntityName in catchall.$($layer.Name)" -ForegroundColor Green
                    return @{
                        Layer = $layerKey
                        Icon = $icon
                        Display = "$icon $($layerKey.ToUpper())"
                    }
                }
            }
        }
    }
    
    # Default fallback
    return @{
        Layer = 'unknown'
        Icon = '📦'
        Display = '📦 UNKNOWN'
    }
}

# Function to get entity styling based on importance and type
function Get-EntityStyle {
    param([string]$entityName, [string]$pluginName, [string]$focusEntity, [string[]]$relatedEntities, [hashtable]$cssStyles, [string[]]$validatedDomains, [object]$domainsConfig)
    
    # Construct full entity name for comparison with relatedEntities
    $fullEntityName = "${pluginName}_$entityName"
    
    # Check for exact match first
    if ($cssStyles.ContainsKey($entityName)) {
        return $cssStyles[$entityName]
    }
    
    # Check for plugin-specific styling
    $pluginEntityKey = "$pluginName - $entityName"
    if ($cssStyles.ContainsKey($pluginEntityKey)) {
        return $cssStyles[$pluginEntityKey]
    }
    
    # Split focus entities if comma-separated
    $focusEntities = $focusEntity -split ',' | ForEach-Object { $_.Trim() }
    
    # Focus entity styling - use CSS if available, otherwise fallback
    # Extract base entity name from focus entities for comparison
    $baseFocusEntities = @()
    foreach ($focus in $focusEntities) {
        # Focus entities are already base entity names, don't strip prefixes
        $baseFocus = $focus
                      $baseFocusEntities += $baseFocus
          }
          
          # Entity name is already the base entity name, no prefix stripping needed
          $baseEntityName = $entityName
          
          if ($baseFocusEntities -contains $baseEntityName) {
        if ($cssStyles.ContainsKey("focus")) {
            return $cssStyles["focus"]
        }
        return $cssStyles["error"]  # Fallback to error style if focus not found
    }
    

    
    # Check if entity is in the same domain as ANY of the focus entities
    $isInSameDomainAsFocus = $false
    $focusDomain = $null
    if ($validatedDomains -and $domainsConfig) {
        # Find which domain ANY of the focus entities belongs to
        foreach ($focus in $focusEntities) {
            foreach ($domain in $validatedDomains) {
                if ($domainsConfig.PSObject.Properties.Name -contains $domain) {
                    $domainEntities = @()
                    foreach ($category in $domainsConfig.$domain.entities.PSObject.Properties) {
                        $domainEntities += $category.Value
                    }
                    
                    # Focus entities are already base entity names, don't strip prefixes
                    $baseFocusEntity = $focus
                    
                    if ($domainEntities -contains $baseFocusEntity) {
                        $focusDomain = $domain
                        break
                    }
                }
            }
            if ($focusDomain) { break }
        }
        
        # Debug logging for domain detection
        
        # Check if current entity is in the same domain as focus
        if ($focusDomain -and $domainsConfig.PSObject.Properties.Name -contains $focusDomain) {
            $focusDomainEntities = @()
            foreach ($category in $domainsConfig.$focusDomain.entities.PSObject.Properties) {
                $focusDomainEntities += $category.Value
            }
            
            # Entity name is already the base entity name, no prefix stripping needed
            $baseEntityName = $entityName
            
            if ($focusDomainEntities -contains $baseEntityName) {
                $isInSameDomainAsFocus = $true
            }
        }
    }
    
    # NEW: Same domain AND directly related - GOLD tier
    if ($isInSameDomainAsFocus -and $relatedEntities -and $relatedEntities.Contains($fullEntityName)) {
        if ($cssStyles.ContainsKey("domain_related")) {
            return $cssStyles["domain_related"]
        }
        return $cssStyles["error"]  # Fallback to error style if domain_related not found
    }
    
    # Directly related (but not same domain) - BLUE tier
    if ($relatedEntities -and $relatedEntities.Contains($fullEntityName)) {
        if ($cssStyles.ContainsKey("related")) {
            return $cssStyles["related"]
        }
        return $cssStyles["error"]  # Fallback to error style if related not found
    }
    
    # Same domain but NOT directly related - BLUE-GREY tier
    if ($isInSameDomainAsFocus) {
        if ($cssStyles.ContainsKey("domain_other")) {
            return $cssStyles["domain_other"]
        }
        return $cssStyles["error"]  # Fallback to error style if domain_other not found
    }
    
    # Default styling for all other entities - DARK GREY tier
    if ($cssStyles.ContainsKey("secondary")) {
        return $cssStyles["secondary"]
    }
    return $cssStyles["error"]  # Fallback to error style if secondary not found
}

# Main execution
Write-Host "FarCry ERD Generator (Enhanced)"
Write-Host "==============================="

# Load domains configuration
$domainsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\domains.json"
$domainsConfig = @{}
$validatedDomains = @()

if (Test-Path $domainsFile) {
    try {
        $domainsData = Get-Content $domainsFile -Raw | ConvertFrom-Json
        $domainsConfig = $domainsData.domains
        $catchallConfig = $domainsData.catchall
        Write-Host "📋 Loaded domains configuration from: $domainsFile" -ForegroundColor Green
        Write-Host "   Available domains: $($domainsConfig.PSObject.Properties.Name -join ', ')" -ForegroundColor Cyan
        Write-Host "   Catchall config loaded: $($catchallConfig -ne $null)" -ForegroundColor Cyan
    } catch {
        Write-Host "⚠️  Error loading domains config: $($_.Exception.Message)" -ForegroundColor Yellow
        $domainsConfig = @{}
        $catchallConfig = $null
    }
} else {
    Write-Host "⚠️  Domains config file not found: $domainsFile" -ForegroundColor Yellow
    $domainsConfig = @{}
    $catchallConfig = $null
}

# Set validated domains based on lDomains parameter
if ([string]::IsNullOrWhiteSpace($lDomains) -or $lDomains -eq "all") {
    $validatedDomains = $domainsConfig.PSObject.Properties.Name
    Write-Host "📋 Using ALL domains: $($validatedDomains -join ', ')" -ForegroundColor Cyan
} else {
    $requestedDomains = $lDomains -split ',' | ForEach-Object { $_.Trim() }
    $validatedDomains = @()
    foreach ($domain in $requestedDomains) {
        if ($domainsConfig.PSObject.Properties.Name -contains $domain) {
            $validatedDomains += $domain
        } else {
            Write-Host "⚠️  Invalid domain: $domain" -ForegroundColor Yellow
        }
    }
    if ($validatedDomains.Count -gt 0) {
        Write-Host "📋 Using domains: $($validatedDomains -join ', ')" -ForegroundColor Cyan
    } else {
        Write-Host "📋 No valid domains specified, using ALL domains" -ForegroundColor Cyan
        $validatedDomains = $domainsConfig.PSObject.Properties.Name
    }
}

# Load Mermaid styles once
$stylesPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "styles\mermaid_styles.mmd"
$cssStyles = Get-MermaidStyles -stylesPath $stylesPath

# Echo chosen parameters
Write-Host "📋 Loaded $($cssStyles.Count) styles from Mermaid styles file" -ForegroundColor Green
Write-Host "🎯 Focus: $lFocus | 📊 Type: $DiagramType | 🌍 Domains: $lDomains" -ForegroundColor Cyan

# Determine whether to use fresh scan or cached data
if ($RefreshCFCs -or !(Test-Path $cacheFile)) {
    Write-Host "Regenerating cache using dedicated cache generation script..."
    $cacheScriptPath = Join-Path $PSScriptRoot "generate_cfc_cache.ps1"
    if (Test-Path $cacheScriptPath) {
        & $cacheScriptPath
        Write-Host "Cache regeneration completed via dedicated script"
    } else {
        Write-Host "Warning: Cache generation script not found, falling back to internal generation..."
        $relationships = Get-CFCRelationships -basePath $pluginsPath
        Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile
    }
}

Write-Host "Loading cached relationships from: $cacheFile"
$relationships = Load-CachedRelationships -cacheFile $cacheFile
if ($null -eq $relationships) {
    Write-Host "Cache file corrupted or empty, regenerating..."
    $cacheScriptPath = Join-Path $PSScriptRoot "generate_cfc_cache.ps1"
    if (Test-Path $cacheScriptPath) {
        & $cacheScriptPath
    } else {
        Write-Host "Warning: Cache generation script not found, falling back to internal generation..."
        $relationships = Get-CFCRelationships -basePath $pluginsPath
        Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile
    }
    $relationships = Load-CachedRelationships -cacheFile $cacheFile
}

Write-Host "Found $($relationships.entities.Count) entities"
Write-Host "Found $($relationships.directFK.Count) direct FK relationships"
Write-Host "Found $($relationships.joinTables.Count) join table relationships"

# Generate Mermaid diagrams based on type
if ($DiagramType -eq "ER") {
    $mermaidContent = Generate-MermaidERD -relationships $relationships -knownTables $knownTables -lFocus $lFocus -validatedDomains $validatedDomains -domainsConfig $domainsConfig -cssStyles $cssStyles -ApplyDomainFilterAt $ApplyDomainFilterAt
} else {
    $mermaidContent = Generate-MermaidClassDiagram -relationships $relationships -knownTables $knownTables -lFocus $lFocus -validatedDomains $validatedDomains -domainsConfig $domainsConfig -cssStyles $cssStyles -ApplyDomainFilterAt $ApplyDomainFilterAt
}

# Ensure exports directory exists
$exportsDir = Split-Path $outputFile -Parent
if ($exportsDir -and !(Test-Path $exportsDir)) {
    New-Item -ItemType Directory -Path $exportsDir -Force | Out-Null
}

# Save to file in exports directory
$mermaidContent | Set-Content $outputFile
Write-Host "$DiagramType diagram saved to: $outputFile"

# Clean up exports folder - keep only last 3 files (only if output is in exports directory)
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
if ((Split-Path $outputFile) -eq $exportsPath) {
    $allFiles = Get-ChildItem -Path $exportsPath -File | Sort-Object LastWriteTime -Descending
    if ($allFiles.Count -gt 3) {
        $filesToDelete = $allFiles | Select-Object -Skip 3
        foreach ($file in $filesToDelete) {
            Remove-Item $file.FullName -Force
            Write-Host "🗑️  Cleaned up: $($file.Name)" -ForegroundColor Yellow
        }
        Write-Host "🧹 Kept last 3 files in exports folder" -ForegroundColor Green
    }
}

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
    <link rel="stylesheet" href="styles/mermaid_styles.mmd">
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

# COMMENTED OUT: HTML generation for direct Mermaid.live spawn
# $mermaidLiveHtml | Set-Content -Path $htmlFile

# Generate compressed Mermaid.live URL
Write-Host "🔗 Generating Mermaid.live URL..." -ForegroundColor Yellow

# Use the working Node.js tool for proper pako compression
$nodeScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "src\node\generate_url.js"
$mermaidLiveUrl = $mermaidContent | node $nodeScriptPath $MermaidMode

Write-Host "✅ Generated compressed Mermaid.live URL" -ForegroundColor Green

# JSON output if specified
if ($JsonOutputFile -ne "") {
    $jsonOutput = @{
        Focus = $lFocus
        Domains = $lDomains
        DiagramType = $DiagramType
        MermaidUrl = $mermaidLiveUrl
        GeneratedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        Status = "Success"
    }
    
    $jsonOutput | ConvertTo-Json -Depth 10 | Set-Content -Path $JsonOutputFile
    Write-Host "📄 JSON output written to: $JsonOutputFile" -ForegroundColor Green
}

# Browser launch (controlled by NoBrowser parameter)
if (-not $NoBrowser) {
    try {
        # Use Start-Job to make it truly non-blocking
        Start-Job -ScriptBlock { param($url) Start-Process $url -WindowStyle Hidden } -ArgumentList $mermaidLiveUrl | Out-Null
        Write-Host "🌐 Opened Mermaid.live in browser" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  Could not open browser automatically. Please copy this URL:" -ForegroundColor Yellow
        Write-Host $mermaidLiveUrl -ForegroundColor Cyan
    }
} else {
    Write-Host "🚫 Browser opening suppressed (NoBrowser parameter)" -ForegroundColor Yellow
    Write-Host "🔗 Mermaid.live URL: $mermaidLiveUrl" -ForegroundColor Cyan
}

Write-Host "✅ Enhanced ERD generation complete!"
Write-Host "📁 MMD file: $outputFile"
Write-Host "🔗 Browser should have opened automatically"

# Check for errors in log file
$logFiles = Get-ChildItem -Path "D:\GIT\farcry\Cursor\FKmermaid\logs" -Filter "*.log" | Sort-Object LastWriteTime -Descending
if ($logFiles) {
    $latestLog = $logFiles | Select-Object -First 1
    $errorCount = (Get-Content $latestLog.FullName | Select-String "\[ERROR\]" | Measure-Object).Count
    
    if ($errorCount -gt 0) {
        Write-Host "⚠️  Found $errorCount error(s) in log file: $($latestLog.Name)" -ForegroundColor Yellow
        Write-Host "📝 Recent errors:" -ForegroundColor Yellow
        Get-Content $latestLog.FullName | Select-String "\[ERROR\]" | Select-Object -Last 3 | ForEach-Object {
            Write-Host "   $($_.Line)" -ForegroundColor Red
        }
    } else {
        Write-Host "✅ No errors found in log file" -ForegroundColor Green
    }
}

# Log completion
if (Test-Path $loggerPath) {
    # Count entities in the generated content
    $entityCount = ($mermaidContent -split "`n" | Where-Object { $_ -match '^\s*"[^"]+"\s*{' }).Count
    $relationshipCount = ($mermaidContent -split "`n" | Where-Object { $_ -match '\|\|--\|\||\}o--\|\|' }).Count
    
    Write-InfoLog "ER diagram generation completed successfully" -Context "Diagram_Generation" -Data @{
        OutputFile = $outputFile
        EntityCount = $entityCount
        RelationshipCount = $relationshipCount
        DiagramType = $DiagramType
    }
}

