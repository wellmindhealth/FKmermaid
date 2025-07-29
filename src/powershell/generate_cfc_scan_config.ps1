# Generate configuration from database structure and folder locations
param(
    [string]$dbdumpPath = "D:\GIT\farcry\Cursor\FKmermaid\config\dbdump.sql",
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
    Write-InfoLog "Starting CFC scan configuration generation" -Context "CFC_Scan"
} else {
    Write-Host "Warning: Logger module not found, using console output only" -ForegroundColor Yellow
}

Write-Host "🔍 Analyzing database structure and folder locations..." -ForegroundColor Green

# Extract table names from dbdump.sql
$tableNames = @()
if (Test-Path $dbdumpPath) {
    $tableNames = Invoke-WithPerformanceLogging -ScriptBlock {
        Select-String -Path $dbdumpPath -Pattern "CREATE TABLE \[dbo\]\.\[([^\]]+)\]" | 
            ForEach-Object { $_.Matches[0].Groups[1].Value } | 
            Sort-Object -Unique
    } -Operation "Database Table Extraction" -Context "CFC_Scan" -Metrics @{
        FilePath = $dbdumpPath
    }
    
    Write-Host "📊 Found $($tableNames.Count) tables in database" -ForegroundColor Green
    Write-InfoLog "Found $($tableNames.Count) tables in database" -Context "CFC_Scan" -Data @{
        TableCount = $tableNames.Count
        DatabasePath = $dbdumpPath
    }
} else {
    $errorMsg = "Database dump not found: $dbdumpPath"
    Write-Host "❌ $errorMsg" -ForegroundColor Red
    Write-ErrorLog $errorMsg -Context "CFC_Scan" -Data @{ DatabasePath = $dbdumpPath }
    exit 1
}

# Get all folders in plugins directory to exclude non-workspace ones
$pluginsPath = "D:\GIT\farcry\plugins"
$allPluginFolders = @()
if (Test-Path $pluginsPath) {
    $allPluginFolders = Invoke-WithPerformanceLogging -ScriptBlock {
        Get-ChildItem -Path $pluginsPath -Directory | ForEach-Object { $_.Name }
    } -Operation "Plugin Folder Discovery" -Context "CFC_Scan" -Metrics @{
        PluginsPath = $pluginsPath
    }
}

# Define workspace folders (the ones we want to include)
$workspaceFolders = @("pathway", "api", "farcrycms")

# Find folders to exclude (present in plugins but not in workspace)
$foldersToExclude = $allPluginFolders | Where-Object { $workspaceFolders -notcontains $_ }

Write-Host "📁 Found $($allPluginFolders.Count) total plugin folders" -ForegroundColor Cyan
Write-Host "📁 Workspace folders: $($workspaceFolders -join ', ')" -ForegroundColor Green
Write-Host "📁 Excluding folders: $($foldersToExclude -join ', ')" -ForegroundColor Yellow

Write-InfoLog "Plugin folder analysis completed" -Context "CFC_Scan" -Data @{
    TotalFolders = $allPluginFolders.Count
    WorkspaceFolders = $workspaceFolders
    ExcludedFolders = $foldersToExclude
}

# Read existing config to get excludeFiles
$existingConfig = @{}
if (Test-Path $outputPath) {
    try {
        $existingConfig = Invoke-WithErrorLogging -ScriptBlock {
            Get-Content -Path $outputPath -Raw | ConvertFrom-Json
        } -Context "CFC_Scan" -AdditionalData @{ ConfigPath = $outputPath }
        
        Write-Host "📋 Found existing config file" -ForegroundColor Green
        Write-InfoLog "Loaded existing configuration" -Context "CFC_Scan" -Data @{
            ConfigPath = $outputPath
        }
    } catch {
        Write-Host "⚠️  Could not read existing config, using defaults" -ForegroundColor Yellow
        Write-WarnLog "Could not read existing config, using defaults" -Context "CFC_Scan" -Data @{
            ConfigPath = $outputPath
            Exception = $_.Exception.Message
        }
    }
}

# Get excludeFiles from existing config or use defaults
$excludeFiles = @("participant.cfc", "module.cfc", "moduleDef.cfc", "farFilter.cfc", "farTask.cfc", "ruleActivityDefListing.cfc")
if ($existingConfig.scanSettings.excludeFiles) {
    $excludeFiles = $existingConfig.scanSettings.excludeFiles
    Write-Host "📋 Using excludeFiles from existing config: $($excludeFiles.Count) items" -ForegroundColor Green
    Write-InfoLog "Using excludeFiles from existing config" -Context "CFC_Scan" -Data @{
        ExcludeFileCount = $excludeFiles.Count
        ExcludeFiles = $excludeFiles
    }
} else {
    Write-Host "📋 Using default excludeFiles: $($excludeFiles.Count) items" -ForegroundColor Yellow
    Write-InfoLog "Using default excludeFiles" -Context "CFC_Scan" -Data @{
        ExcludeFileCount = $excludeFiles.Count
        ExcludeFiles = $excludeFiles
    }
}

# Convert .cfc filenames to entity names for knownTables filtering
$excludeEntities = $excludeFiles | ForEach-Object { $_.Replace('.cfc', '') }

# Filter out excluded entities from knownTables
$knownTables = $tableNames | Where-Object { $excludeEntities -notcontains $_ }

Write-Host "✅ Generated configuration with $($knownTables.Count) tables from database" -ForegroundColor Green
Write-Host "🚫 Excluded entities from knownTables: $($excludeEntities -join ', ')" -ForegroundColor Yellow

Write-InfoLog "Configuration generation completed" -Context "CFC_Scan" -Data @{
    TotalTables = $tableNames.Count
    FilteredTables = $knownTables.Count
    ExcludedEntities = $excludeEntities
    ExcludedEntityCount = $excludeEntities.Count
}

# Generate the configuration
$config = @{
    scanSettings = @{
        farcryPath = "D:\GIT\farcry"
        scanDirectories = @(
            "D:\GIT\farcry\plugins",
            "D:\GIT\farcry\zfarcrycore"
        )
        excludeFolders = @("farcrycms", "social") + $foldersToExclude
        excludeFiles = $excludeFiles
        cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
        outputFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\plugins_full_erd.mmd"
    }
    entityConstraints = @{
        knownTables = $knownTables
    }
}

# Save the configuration
try {
    $configJson = $config | ConvertTo-Json -Depth 10
    $configJson | Out-File -FilePath $outputPath -Encoding UTF8
    
    Write-Host "✅ Configuration saved to: $outputPath" -ForegroundColor Green
    Write-InfoLog "Configuration saved successfully" -Context "CFC_Scan" -Data @{
        OutputPath = $outputPath
        ConfigSize = $configJson.Length
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
Write-Host "   - Total database tables: $($tableNames.Count)" -ForegroundColor White
Write-Host "   - Tables after exclusions: $($knownTables.Count)" -ForegroundColor White
Write-Host "   - Excluded entities: $($excludeEntities.Count)" -ForegroundColor White
Write-Host "   - Excluded folders: $($foldersToExclude.Count)" -ForegroundColor White
Write-Host "   - Workspace folders: $($workspaceFolders.Count)" -ForegroundColor White

Write-InfoLog "CFC scan configuration generation completed successfully" -Context "CFC_Scan" -Data @{
    Summary = @{
        TotalTables = $tableNames.Count
        FilteredTables = $knownTables.Count
        ExcludedEntities = $excludeEntities.Count
        ExcludedFolders = $foldersToExclude.Count
        WorkspaceFolders = $workspaceFolders.Count
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