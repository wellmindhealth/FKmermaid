<#
.SYNOPSIS
    Generate configuration from CFC files
    
.DESCRIPTION
    Extracts table names from CFC files to create the scan configuration.
    This eliminates database dependency and makes the system self-contained.
    
.PARAMETER pluginsPath
    Path to plugins directory (default: D:\GIT\farcry\plugins)
    
.PARAMETER outputPath
    Output configuration file path (default: config/cfc_scan_config.json)
    
.PARAMETER Debug
    Enable debug logging
    
.EXAMPLE
    .\generate_cfc_scan_config_from_cfcs.ps1
    
.EXAMPLE
    .\generate_cfc_scan_config_from_cfcs.ps1 -Debug
#>

param(
    [string]$pluginsPath = "D:\GIT\farcry\plugins",
    [string]$outputPath = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json",
    [switch]$Debug
)

# Import logging modules
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
    
    # Initialize logging
    Initialize-ModuleLogging -ModuleName "cfc_scan" -Debug:$Debug
    Write-InfoLog "Starting CFC-based scan configuration generation" -Context "CFC_Scan"
} else {
    Write-Host "Warning: Logger module not found, using console output only" -ForegroundColor Yellow
}

Write-Host "🔍 Analyzing CFC files to extract table names..." -ForegroundColor Green

# Function to extract table name from CFC content
function Get-TableNameFromCFC {
    param([string]$cfcContent, [string]$fileName)
    
    # For now, just use filename without .cfc as the table name
    # This avoids the array-join table issues and is more reliable
    $tableName = $fileName.Replace('.cfc', '')
    
    return $tableName
}

# Function to extract entity name from CFC content
function Get-EntityNameFromCFC {
    param([string]$cfcContent, [string]$fileName)
    
    # Try to extract entity name from various patterns
    $entityName = $null
    
    # Pattern 1: @entityName annotation
    if ($cfcContent -match '@entityName\s+([^\s]+)') {
        $entityName = $matches[1]
    }
    # Pattern 2: displayName property in cfcomponent
    elseif ($cfcContent -match 'displayName\s*=\s*"([^"]+)"') {
        $entityName = $matches[1]
    }
    # Pattern 3: Default to filename without .cfc
    else {
        $entityName = $fileName.Replace('.cfc', '')
    }
    
    return $entityName
}

# Get all CFC files from explicit scan directories
$cfcFiles = @()

# Load centralized scan configuration
$exclusionsPath = Join-Path (Split-Path $outputPath) "exclusions.json"
$scanConfig = @{}

if (Test-Path $exclusionsPath) {
    try {
        $scanConfig = Invoke-WithErrorLogging -ScriptBlock {
            Get-Content -Path $exclusionsPath -Raw | ConvertFrom-Json
        } -Context "CFC_Scan" -AdditionalData @{ ExclusionsPath = $exclusionsPath }
        
        Write-Host "📋 Loaded centralized scan configuration from: $exclusionsPath" -ForegroundColor Green
        Write-InfoLog "Loaded centralized scan configuration" -Context "CFC_Scan" -Data @{
            ExclusionsPath = $exclusionsPath
            ScanDirectoryCount = $scanConfig.scanDirectories.Count
        }
    } catch {
        Write-Host "⚠️  Could not load centralized scan configuration, using defaults" -ForegroundColor Yellow
        Write-WarnLog "Could not load centralized scan configuration, using defaults" -Context "CFC_Scan" -Data @{
            ExclusionsPath = $exclusionsPath
            Exception = $_.Exception.Message
        }
    }
}

# Use scan directories from config or defaults
$scanDirectories = $scanConfig.scanDirectories
if (-not $scanDirectories) {
    $scanDirectories = @(
        "D:\GIT\farcry\plugins\pathway",
        "D:\GIT\farcry\plugins\api", 
        "D:\GIT\farcry\plugins\farcrycms",
        "D:\GIT\farcry\zfarcrycore\packages\types",
        "D:\GIT\farcry\zfarcrycore\packages\farcry"
    )
    Write-Host "📋 Using default scan directories: $($scanDirectories.Count) items" -ForegroundColor Yellow
} else {
    Write-Host "📋 Using centralized scan directories: $($scanDirectories.Count) items" -ForegroundColor Green
}

# Scan each directory explicitly
foreach ($scanDir in $scanDirectories) {
    if (Test-Path $scanDir) {
        $dirFiles = Invoke-WithPerformanceLogging -ScriptBlock {
            Get-ChildItem -Path $scanDir -Filter "*.cfc" -Recurse | 
                Where-Object { $_.FullName -notmatch "\\test\\" -and $_.FullName -notmatch "\\tests\\" }
        } -Operation "CFC File Discovery" -Context "CFC_Scan" -Metrics @{
            ScanDirectory = $scanDir
        }
        
        $cfcFiles += $dirFiles
        Write-Host "  📁 $($scanDir): $($dirFiles.Count) CFC files" -ForegroundColor Gray
    } else {
        Write-Host "  ⚠️  Directory not found: $scanDir" -ForegroundColor Yellow
    }
}

Write-Host "📊 Found $($cfcFiles.Count) total CFC files" -ForegroundColor Green
Write-InfoLog "Found $($cfcFiles.Count) CFC files" -Context "CFC_Scan" -Data @{
    CfcFileCount = $cfcFiles.Count
    ScanDirectories = $scanDirectories
}

# Validate we found enough files
if ($cfcFiles.Count -lt 10) {
    Write-Host "⚠️  Warning: Found only $($cfcFiles.Count) CFC files - this seems low" -ForegroundColor Yellow
    Write-WarnLog "Low CFC file count detected" -Context "CFC_Scan" -Data @{
        CfcFileCount = $cfcFiles.Count
        ExpectedMinimum = 10
    }
}

# Extract table names and entity mappings from CFC files
$tableNames = @()
$entityPluginMapping = @{}

foreach ($cfcFile in $cfcFiles) {
    try {
        $content = Get-Content $cfcFile.FullName -Raw
        $fileName = $cfcFile.Name
        
        # Extract table name
        $tableName = Get-TableNameFromCFC -cfcContent $content -fileName $fileName
        
        # Extract entity name
        $entityName = Get-EntityNameFromCFC -cfcContent $content -fileName $fileName
        
        # Determine plugin from path
        $pluginName = $cfcFile.Directory.Name
        
        if ($tableName) {
            $tableNames += $tableName
            $entityPluginMapping[$entityName] = $pluginName
            
            Write-Host "  📋 $fileName → $tableName (plugin: $pluginName)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "⚠️  Error processing $($cfcFile.Name): $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

# Remove duplicates and sort
$tableNames = $tableNames | Sort-Object -Unique

Write-Host "📊 Extracted $($tableNames.Count) unique table names from CFC files" -ForegroundColor Green
Write-InfoLog "Extracted table names from CFC files" -Context "CFC_Scan" -Data @{
    TableCount = $tableNames.Count
    EntityMappingCount = $entityPluginMapping.Count
}

# Use excludeFiles from centralized configuration
$excludeFiles = $scanConfig.excludeFiles
if (-not $excludeFiles) {
    $excludeFiles = @("participant.cfc", "module.cfc", "moduleDef.cfc", "farFilter.cfc", "farTask.cfc", "ruleActivityDefListing.cfc")
    Write-Host "📋 Using default excludeFiles: $($excludeFiles.Count) items" -ForegroundColor Yellow
} else {
    Write-Host "📋 Using centralized excludeFiles: $($excludeFiles.Count) items" -ForegroundColor Green
}

# Convert .cfc filenames to entity names for knownTables filtering
$excludeEntities = $excludeFiles | ForEach-Object { $_.Replace('.cfc', '') }

# Filter out excluded entities from knownTables
$knownTables = $tableNames | Where-Object { $excludeEntities -notcontains $_ }

# Validate the results
if ($knownTables.Count -eq 0) {
    $errorMsg = "No tables found after filtering - check exclusions and CFC files"
    Write-Host "❌ $errorMsg" -ForegroundColor Red
    Write-ErrorLog $errorMsg -Context "CFC_Scan" -Data @{
        TotalTables = $tableNames.Count
        ExcludedEntities = $excludeEntities
        FilteredTables = $knownTables.Count
    }
    exit 1
}

if ($knownTables.Count -lt 50) {
    Write-Host "⚠️  Warning: Found only $($knownTables.Count) tables - this seems low" -ForegroundColor Yellow
    Write-WarnLog "Low table count detected" -Context "CFC_Scan" -Data @{
        TableCount = $knownTables.Count
        ExpectedMinimum = 50
    }
}

Write-Host "✅ Generated configuration with $($knownTables.Count) tables from CFC analysis" -ForegroundColor Green
Write-Host "🚫 Excluded entities from knownTables: $($excludeEntities -join ', ')" -ForegroundColor Yellow

# Create the configuration object
$config = @{
    entityConstraints = @{
        knownTables = $knownTables
        entityPluginMapping = $entityPluginMapping
    }
    scanSettings = @{
        farcryPath = "D:\GIT\farcry"
        scanDirectories = $scanDirectories
        excludeFiles = $excludeFiles
        cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
        outputFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\plugins_full_erd.mmd"
    }
    metadata = @{
        generatedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        source = "CFC Analysis"
        tableCount = $knownTables.Count
        entityMappingCount = $entityPluginMapping.Count
    }
}

# Save the configuration
try {
    $config | ConvertTo-Json -Depth 10 | Set-Content -Path $outputPath
    Write-Host "📄 Configuration saved to: $outputPath" -ForegroundColor Green
    Write-InfoLog "Configuration saved successfully" -Context "CFC_Scan" -Data @{
        OutputPath = $outputPath
        TableCount = $knownTables.Count
        EntityMappingCount = $entityPluginMapping.Count
    }
} catch {
    $errorMsg = "Failed to save configuration: $($_.Exception.Message)"
    Write-Host "❌ $errorMsg" -ForegroundColor Red
    Write-ErrorLog $errorMsg -Context "CFC_Scan" -Data @{
        OutputPath = $outputPath
        Exception = $_.Exception.Message
    }
    exit 1
}

Write-Host "📊 Summary:" -ForegroundColor Yellow
Write-Host "   - Total CFC tables: $($tableNames.Count)" -ForegroundColor White
Write-Host "   - Tables after exclusions: $($knownTables.Count)" -ForegroundColor White
Write-Host "   - Excluded entities: $($excludeEntities.Count)" -ForegroundColor White
Write-Host "   - Scan directories: $($scanDirectories.Count)" -ForegroundColor White
Write-Host "   - Entity mappings: $($entityPluginMapping.Count)" -ForegroundColor White

Write-InfoLog "CFC scan configuration generation completed successfully" -Context "CFC_Scan" -Data @{
    Summary = @{
        TotalTables = $tableNames.Count
        FilteredTables = $knownTables.Count
        ExcludedEntities = $excludeEntities.Count
        ScanDirectories = $scanDirectories.Count
        EntityMappings = $entityPluginMapping.Count
    }
}

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

Write-Host "`n🎯 CFC-based configuration generation complete!" -ForegroundColor Cyan
Write-Host "📊 Tables: $($knownTables.Count)" -ForegroundColor White
Write-Host "📊 Entity Mappings: $($entityPluginMapping.Count)" -ForegroundColor White
Write-Host "📁 Output: $outputPath" -ForegroundColor White 