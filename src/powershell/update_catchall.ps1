# Update Catchall with All Uncategorized Entities
# This script automatically populates the catchall section in domains.json
# with all entities that aren't already categorized in specific domains

param(
    [string]$domainsFile = "D:\GIT\farcry\Cursor\FKmermaid\config\domains.json",
    [string]$cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
)

Write-Host "🔄 Updating catchall with uncategorized entities..." -ForegroundColor Cyan

# Load domains.json
$domainsData = Get-Content $domainsFile -Raw | ConvertFrom-Json

# Load cfc_cache.json
$cacheData = Get-Content $cacheFile -Raw | ConvertFrom-Json

# Get all entities from cache
$allEntities = $cacheData.entities.PSObject.Properties.Name

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
}

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