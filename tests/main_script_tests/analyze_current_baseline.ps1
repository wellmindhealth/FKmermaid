# Analyze Current Baseline
# Analyzes the current plugins_full_erd.mmd file to capture the gold tier baseline

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Analyze Current Baseline" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    Write-Host "Analyzes current plugins_full_erd.mmd to capture baseline" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Show detailed output" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"
$stylesPath = "D:\GIT\farcry\Cursor\FKmermaid\styles\mermaid_styles.mmd"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Analyzing Current Gold Tier Baseline" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

# Function to load colors from styles file
function Get-StyleColors {
    param([string]$stylesPath)
    
    $colors = @{}
    if (Test-Path $stylesPath) {
        $content = Get-Content $stylesPath
        foreach ($line in $content) {
            if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
                $styleName = $matches[1]
                $color = $matches[2]
                $colors[$styleName] = $color
            }
        }
    }
    return $colors
}

# Load current colors from styles file
$styleColors = Get-StyleColors -stylesPath $stylesPath

Write-Host "📋 Current style colors:" -ForegroundColor White
Write-Host "  Focus: $($styleColors['focus'])" -ForegroundColor Gray
Write-Host "  Domain Related (Gold): $($styleColors['domain_related'])" -ForegroundColor Gray
Write-Host "  Related (Blue): $($styleColors['related'])" -ForegroundColor Gray

# Analyze the current file
$generatedFile = "$exportsPath\plugins_full_erd.mmd"
if (Test-Path $generatedFile) {
    $content = Get-Content $generatedFile -Raw
    
    # Extract styling information
    $actualTiers = @{
        Focus = @()
        GoldTier = @()
        BlueTier = @()
        BlueGreyTier = @()
        DarkGreyTier = @()
    }
    
    # Parse style lines to extract entity-tier mappings
    $styleLines = $content -split "`n" | Where-Object { $_ -match "style.*fill:#" }
    
    foreach ($line in $styleLines) {
        if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
            $entity = $matches[1]
            $color = $matches[2]
            
            # Map colors to tiers based on current styles
            switch ($color) {
                $styleColors["focus"] { $actualTiers.Focus += $entity }
                $styleColors["domain_related"] { $actualTiers.GoldTier += $entity }
                $styleColors["related"] { $actualTiers.BlueTier += $entity }
                $styleColors["domain_other"] { $actualTiers.BlueGreyTier += $entity }
                $styleColors["secondary"] { $actualTiers.DarkGreyTier += $entity }
            }
        }
    }
    
    # Report what we actually found
    Write-Host "`n📊 Current Baseline Results:" -ForegroundColor White
    Write-Host "  Focus entities: $($actualTiers.Focus.Count) - $($actualTiers.Focus -join ', ')" -ForegroundColor Gray
    Write-Host "  Gold tier entities: $($actualTiers.GoldTier.Count) - $($actualTiers.GoldTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Blue tier entities: $($actualTiers.BlueTier.Count) - $($actualTiers.BlueTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Blue-grey tier entities: $($actualTiers.BlueGreyTier.Count) - $($actualTiers.BlueGreyTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Dark grey tier entities: $($actualTiers.DarkGreyTier.Count) - $($actualTiers.DarkGreyTier -join ', ')" -ForegroundColor Gray
    
    # Save baseline result
    $baselineResult = @{
        TestName = "Partner+Member Focus - Gold Tier Issue"
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Focus = "partner,member"
        Domains = "provider"
        DiagramType = "ER"
        Description = "This test captures the current gold tier issue where entities that should be gold (same domain AND directly related) are appearing as blue"
        ActualTiers = $actualTiers
        GeneratedFile = "plugins_full_erd.mmd"
        IssueStatus = "Current gold tier issue captured as baseline"
    }
    
    # Save baseline result
    $baselineResult | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\gold_tier_baseline.json"
    
    Write-Host "`n✅ Gold tier baseline captured!" -ForegroundColor Green
    Write-Host "📁 Baseline saved to: $testResultsPath\gold_tier_baseline.json" -ForegroundColor Gray
    Write-Host "📁 Analyzed file: $generatedFile" -ForegroundColor Gray
    
    Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
    Write-Host "1. Fix the domain detection logic" -ForegroundColor White
    Write-Host "2. Run this test again to verify the fix" -ForegroundColor White
    Write-Host "3. Compare results to ensure gold tier entities are now correctly styled" -ForegroundColor White
    
    # Expected entities that should be gold tier (for future comparison)
    $expectedGoldEntities = @("pathway_center", "pathway_memberGroup", "pathway_referer", "zfarcrycore_dmProfile")
    Write-Host "`n🎯 Expected gold tier entities (after fix):" -ForegroundColor Yellow
    Write-Host "  $($expectedGoldEntities -join ', ')" -ForegroundColor Gray
    
    # Show the issue clearly
    Write-Host "`n🚨 GOLD TIER ISSUE CONFIRMED:" -ForegroundColor Red
    foreach ($expectedEntity in $expectedGoldEntities) {
        if ($actualTiers.BlueTier -contains $expectedEntity) {
            Write-Host "  ❌ $expectedEntity should be GOLD but is BLUE" -ForegroundColor Red
        } elseif ($actualTiers.GoldTier -contains $expectedEntity) {
            Write-Host "  ✅ $expectedEntity is correctly GOLD" -ForegroundColor Green
        } else {
            Write-Host "  ❓ $expectedEntity not found in any tier" -ForegroundColor Yellow
        }
    }
    
} else {
    Write-Host "❌ Generated file not found: $generatedFile" -ForegroundColor Red
}