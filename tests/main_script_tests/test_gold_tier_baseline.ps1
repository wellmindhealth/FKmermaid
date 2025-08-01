# Test Gold Tier Baseline
# Captures the current gold tier behavior as a baseline for regression testing

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Gold Tier Baseline" -ForegroundColor Cyan
    Write-Host "======================" -ForegroundColor Cyan
    Write-Host "Captures current gold tier behavior as baseline" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Show detailed output" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"
$stylesPath = "D:\GIT\farcry\Cursor\FKmermaid\styles\mermaid_styles.mmd"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Capturing Gold Tier Baseline" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

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

# Define the specific test case that shows the gold tier issue
$testCase = @{
    Name = "Partner+Member Focus - Gold Tier Issue"
    Focus = "partner,member"
            Domains = "provider"
    DiagramType = "ER"
    Description = "This test captures the current gold tier issue where entities that should be gold (same domain AND directly related) are appearing as blue"
}

Set-Location $scriptPath

Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains)" -ForegroundColor White
Write-Host "Description: $($testCase.Description)" -ForegroundColor Gray

# Generate test diagram
$testOutput = "gold_tier_baseline.mmd"
$result = & ".\generate_erd_enhanced.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Diagram generated successfully" -ForegroundColor Green
    
    # Analyze the generated file
    $generatedFile = "$exportsPath\$testOutput"
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
            TestName = $testCase.Name
            Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Focus = $testCase.Focus
            Domains = $testCase.Domains
            DiagramType = $testCase.DiagramType
            Description = $testCase.Description
            ActualTiers = $actualTiers
            GeneratedFile = $testOutput
            IssueStatus = "Current gold tier issue captured as baseline"
        }
        
        # Save baseline result
        $baselineResult | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\gold_tier_baseline.json"
        
        Write-Host "`n✅ Gold tier baseline captured!" -ForegroundColor Green
        Write-Host "📁 Baseline saved to: $testResultsPath\gold_tier_baseline.json" -ForegroundColor Gray
        Write-Host "📁 Generated file: $generatedFile" -ForegroundColor Gray
        
        Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
        Write-Host "1. Fix the domain detection logic" -ForegroundColor White
        Write-Host "2. Run this test again to verify the fix" -ForegroundColor White
        Write-Host "3. Compare results to ensure gold tier entities are now correctly styled" -ForegroundColor White
        
        # Expected entities that should be gold tier (for future comparison)
        $expectedGoldEntities = @("pathway_center", "pathway_memberGroup", "pathway_referer", "zfarcrycore_dmProfile")
        Write-Host "`n🎯 Expected gold tier entities (after fix):" -ForegroundColor Yellow
        Write-Host "  $($expectedGoldEntities -join ', ')" -ForegroundColor Gray
        
    } else {
        Write-Host "❌ Generated file not found" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
    Write-Host $result -ForegroundColor Red
}