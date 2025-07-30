<#
.SYNOPSIS
    Count the exact scope of single entity diagrams across domains
    
.DESCRIPTION
    Analyzes domains.json to count:
    1. Unique CFCs
    2. Single entity diagrams per domain
    3. All-domain combinations
    
.EXAMPLE
    .\count_diagram_scope.ps1
#>

Write-Host "📊 Diagram Scope Analysis" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

# Load domains.json
$domainsPath = Join-Path $PSScriptRoot "..\..\config\domains.json"
$domains = Get-Content $domainsPath | ConvertFrom-Json

# Collect all unique CFCs
$allCfcs = @()

foreach ($domainName in $domains.domains.PSObject.Properties.Name) {
    $domain = $domains.domains.$domainName
    foreach ($categoryName in $domain.entities.PSObject.Properties.Name) {
        $cfcs = $domain.entities.$categoryName
        foreach ($cfc in $cfcs) {
            # Skip non-CFC properties
            $skipCfcs = @(
                "defaultMediaID", "aCuePointActivities", "aMediaIDs", "onEndID", 
                "aInteract1Activities", "aInteract2Activities", "aInteract3Activities", 
                "aInteract4Activities", "aInteract5Activities"
            )
            if ($cfc -notin $skipCfcs) {
                $allCfcs += $cfc
            }
        }
    }
}

# Get unique CFCs
$uniqueCfcs = $allCfcs | Sort-Object | Get-Unique

Write-Host "`n🔍 Analysis Results:" -ForegroundColor Yellow
Write-Host "==================" -ForegroundColor Yellow

Write-Host "📋 Unique CFCs found: $($uniqueCfcs.Count)" -ForegroundColor Green
Write-Host "   $($uniqueCfcs -join ', ')" -ForegroundColor Gray

# Count diagrams per domain
$domainCounts = @{}
$totalSingleDomain = 0

foreach ($domainName in $domains.domains.PSObject.Properties.Name) {
    $domain = $domains.domains.$domainName
    $domainCfcs = @()
    
    foreach ($categoryName in $domain.entities.PSObject.Properties.Name) {
        $cfcs = $domain.entities.$categoryName
        foreach ($cfc in $cfcs) {
            $skipCfcs = @(
                "defaultMediaID", "aCuePointActivities", "aMediaIDs", "onEndID", 
                "aInteract1Activities", "aInteract2Activities", "aInteract3Activities", 
                "aInteract4Activities", "aInteract5Activities"
            )
            if ($cfc -notin $skipCfcs) {
                $domainCfcs += $cfc
            }
        }
    }
    
    $uniqueDomainCfcs = $domainCfcs | Sort-Object | Get-Unique
    $domainCounts[$domainName] = $uniqueDomainCfcs.Count
    $totalSingleDomain += $uniqueDomainCfcs.Count
    
    Write-Host "`n🏷️  $domainName domain:" -ForegroundColor Cyan
    Write-Host "   CFCs: $($uniqueDomainCfcs.Count)" -ForegroundColor White
    Write-Host "   List: $($uniqueDomainCfcs -join ', ')" -ForegroundColor Gray
}

# Count all-domain combinations
$totalAllDomain = $uniqueCfcs.Count

Write-Host "`n📈 Diagram Counts:" -ForegroundColor Yellow
Write-Host "=================" -ForegroundColor Yellow

Write-Host "🎯 Single domain diagrams:" -ForegroundColor Green
Write-Host "   Partner: $($domainCounts['partner'])" -ForegroundColor White
Write-Host "   Participant: $($domainCounts['participant'])" -ForegroundColor White
Write-Host "   Programme: $($domainCounts['programme'])" -ForegroundColor White
Write-Host "   Site: $($domainCounts['site'])" -ForegroundColor White
Write-Host "   Total: $totalSingleDomain" -ForegroundColor Cyan

Write-Host "`n🌐 All-domain diagrams:" -ForegroundColor Green
Write-Host "   Total: $totalAllDomain" -ForegroundColor White

$grandTotal = $totalSingleDomain + $totalAllDomain

Write-Host "`n🎯 GRAND TOTAL:" -ForegroundColor Yellow
Write-Host "=============" -ForegroundColor Yellow
Write-Host "📊 Total diagrams: $grandTotal" -ForegroundColor Green
Write-Host "   Single domain: $totalSingleDomain" -ForegroundColor Gray
Write-Host "   All domains: $totalAllDomain" -ForegroundColor Gray

Write-Host "`n💡 Summary:" -ForegroundColor Yellow
Write-Host "===========" -ForegroundColor Yellow
Write-Host "✅ Manageable scope: $grandTotal diagrams" -ForegroundColor Green
Write-Host "✅ Single domain focus: $totalSingleDomain diagrams" -ForegroundColor Green
Write-Host "✅ All domain option: $totalAllDomain diagrams" -ForegroundColor Green 