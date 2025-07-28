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

# Use all table names from database (no filtering by folder structure)
$knownTables = $tableNames

Write-Host "✅ Generated configuration with $($knownTables.Count) tables from database" -ForegroundColor Green

# Generate the configuration
$config = @{
    scanSettings = @{
        farcryPath = "D:\GIT\farcry"
        scanDirectories = @(
            "D:\GIT\farcry\plugins",
            "D:\GIT\farcry\zfarcrycore"
        )
        excludeFolders = @("farcrycms", "social") + $foldersToExclude
        excludeFiles = @("participant.cfc", "module.cfc", "moduleDef.cfc")
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
Write-Host "   - Excluded folders: $($foldersToExclude.Count)" -ForegroundColor White
Write-Host "   - Workspace folders: $($workspaceFolders.Count)" -ForegroundColor White 