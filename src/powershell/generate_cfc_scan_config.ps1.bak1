# Generate configuration from database structure and folder locations
param(
    [string]$dbdumpPath = "D:\GIT\farcry\Cursor\FKmermaid\config\dbdump.sql",
    [string]$outputPath = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json"
)

Write-Host "🔍 Analyzing database structure and folder locations..." -ForegroundColor Green

# Extract table names from dbdump.sql
$tableNames = @()
if (Test-Path $dbdumpPath) {
    $tableNames = Select-String -Path $dbdumpPath -Pattern "CREATE TABLE \[dbo\]\.\[([^\]]+)\]" | 
        ForEach-Object { $_.Matches[0].Groups[1].Value } | 
        Sort-Object -Unique
    Write-Host "📊 Found $($tableNames.Count) tables in database" -ForegroundColor Green
} else {
    Write-Host "❌ Database dump not found: $dbdumpPath" -ForegroundColor Red
    exit 1
}

# Get all folders in plugins directory to exclude non-workspace ones
$pluginsPath = "D:\GIT\farcry\plugins"
$allPluginFolders = @()
if (Test-Path $pluginsPath) {
    $allPluginFolders = Get-ChildItem -Path $pluginsPath -Directory | ForEach-Object { $_.Name }
}

# Define workspace folders (the ones we want to include)
$workspaceFolders = @("pathway", "api", "farcrycms")

# Find folders to exclude (present in plugins but not in workspace)
$foldersToExclude = $allPluginFolders | Where-Object { $workspaceFolders -notcontains $_ }

Write-Host "📁 Found $($allPluginFolders.Count) total plugin folders" -ForegroundColor Cyan
Write-Host "📁 Workspace folders: $($workspaceFolders -join ', ')" -ForegroundColor Green
Write-Host "📁 Excluding folders: $($foldersToExclude -join ', ')" -ForegroundColor Yellow

# Read existing config to get excludeFiles
$existingConfig = @{}
if (Test-Path $outputPath) {
    try {
        $existingConfig = Get-Content -Path $outputPath -Raw | ConvertFrom-Json
        Write-Host "📋 Found existing config file" -ForegroundColor Green
    } catch {
        Write-Host "⚠️  Could not read existing config, using defaults" -ForegroundColor Yellow
    }
}

# Get excludeFiles from existing config or use defaults
$excludeFiles = @("participant.cfc", "module.cfc", "moduleDef.cfc", "farFilter.cfc", "farTask.cfc", "ruleActivityDefListing.cfc")
if ($existingConfig.scanSettings.excludeFiles) {
    $excludeFiles = $existingConfig.scanSettings.excludeFiles
    Write-Host "📋 Using excludeFiles from existing config: $($excludeFiles.Count) items" -ForegroundColor Green
} else {
    Write-Host "📋 Using default excludeFiles: $($excludeFiles.Count) items" -ForegroundColor Yellow
}

# Convert .cfc filenames to entity names for knownTables filtering
$excludeEntities = $excludeFiles | ForEach-Object { $_.Replace('.cfc', '') }

# Filter out excluded entities from knownTables
$knownTables = $tableNames | Where-Object { $excludeEntities -notcontains $_ }

Write-Host "✅ Generated configuration with $($knownTables.Count) tables from database" -ForegroundColor Green
Write-Host "🚫 Excluded entities from knownTables: $($excludeEntities -join ', ')" -ForegroundColor Yellow

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
$configJson = $config | ConvertTo-Json -Depth 10
$configJson | Out-File -FilePath $outputPath -Encoding UTF8

Write-Host "✅ Configuration saved to: $outputPath" -ForegroundColor Green
Write-Host "📊 Summary:" -ForegroundColor Yellow
Write-Host "   - Total database tables: $($tableNames.Count)" -ForegroundColor White
Write-Host "   - Tables after exclusions: $($knownTables.Count)" -ForegroundColor White
Write-Host "   - Excluded entities: $($excludeEntities.Count)" -ForegroundColor White
Write-Host "   - Excluded folders: $($foldersToExclude.Count)" -ForegroundColor White
Write-Host "   - Workspace folders: $($workspaceFolders.Count)" -ForegroundColor White 