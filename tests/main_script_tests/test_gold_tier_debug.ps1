# Test Gold Tier Debug (KNOWN TO FAIL - TEMPORARY)
# This test is currently expected to fail due to a known domain detection bug
# TODO: Remove this test once the gold tier issue is fixed

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Gold Tier Debug (KNOWN TO FAIL)" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "Temporary debug test for gold tier issue - EXPECTED TO FAIL" -ForegroundColor White
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

Write-Host "🧪 Gold Tier Debug Test (KNOWN TO FAIL)" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "⚠️  This test is EXPECTED TO FAIL due to known domain detection bug" -ForegroundColor Yellow
Write-Host "📝 TEMPORARY: Remove once gold tier issue is fixed" -ForegroundColor Yellow

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

# Define the test case
$testCase = @{
    Name = "Partner+Member Focus - Gold Tier Debug"
    Focus = "partner,member"
    Domains = "partner"
    DiagramType = "ER"
    Description = "Temporary debug test for gold tier issue - EXPECTED TO FAIL"
    ExpectedGoldEntities = @("pathway_center", "pathway_memberGroup", "pathway_referer", "zfarcrycore_dmProfile")
}

Set-Location $scriptPath

Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains)" -ForegroundColor White
Write-Host "Description: $($testCase.Description)" -ForegroundColor Gray

# Generate test diagram
$testOutput = "gold_tier_debug.mmd"
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
        Write-Host "`n📊 Current Results:" -ForegroundColor White
        Write-Host "  Focus entities: $($actualTiers.Focus.Count) - $($actualTiers.Focus -join ', ')" -ForegroundColor Gray
        Write-Host "  Gold tier entities: $($actualTiers.GoldTier.Count) - $($actualTiers.GoldTier -join ', ')" -ForegroundColor Gray
        Write-Host "  Blue tier entities: $($actualTiers.BlueTier.Count) - $($actualTiers.BlueTier -join ', ')" -ForegroundColor Gray
        Write-Host "  Blue-grey tier entities: $($actualTiers.BlueGreyTier.Count) - $($actualTiers.BlueGreyTier -join ', ')" -ForegroundColor Gray
        Write-Host "  Dark grey tier entities: $($actualTiers.DarkGreyTier.Count) - $($actualTiers.DarkGreyTier -join ', ')" -ForegroundColor Gray
        
        # Check for gold tier issues
        $goldTierIssues = @()
        $testPassed = $true
        
        Write-Host "`n🎯 Expected gold tier entities:" -ForegroundColor Yellow
        Write-Host "  $($testCase.ExpectedGoldEntities -join ', ')" -ForegroundColor Gray
        
        Write-Host "`n🚨 GOLD TIER ISSUE ANALYSIS:" -ForegroundColor Red
        foreach ($expectedEntity in $testCase.ExpectedGoldEntities) {
            if ($actualTiers.BlueTier -contains $expectedEntity) {
                Write-Host "  ❌ $expectedEntity should be GOLD but is BLUE" -ForegroundColor Red
                $goldTierIssues += $expectedEntity
                $testPassed = $false
            } elseif ($actualTiers.GoldTier -contains $expectedEntity) {
                Write-Host "  ✅ $expectedEntity is correctly GOLD" -ForegroundColor Green
            } else {
                Write-Host "  ❓ $expectedEntity not found in any tier" -ForegroundColor Yellow
                $testPassed = $false
            }
        }
        
        # Save debug result
        $debugResult = @{
            TestName = $testCase.Name
            Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Focus = $testCase.Focus
            Domains = $testCase.Domains
            DiagramType = $testCase.DiagramType
            Description = $testCase.Description
            ExpectedGoldEntities = $testCase.ExpectedGoldEntities
            ActualTiers = $actualTiers
            GeneratedFile = $testOutput
            GoldTierIssues = $goldTierIssues
            TestPassed = $testPassed
            Status = "KNOWN TO FAIL - TEMPORARY DEBUG TEST"
        }
        
        # Save debug result
        $debugResult | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\gold_tier_debug.json"
        
        Write-Host "`n📁 Debug result saved to: $testResultsPath\gold_tier_debug.json" -ForegroundColor Gray
        Write-Host "📁 Generated file: $generatedFile" -ForegroundColor Gray
        
        # Expected result for a debug test
        if ($testPassed) {
            Write-Host "`n🎉 SURPRISE! Test PASSED - Gold tier issue may be fixed!" -ForegroundColor Green
            Write-Host "   Consider removing this debug test and creating a proper regression test" -ForegroundColor White
        } else {
            Write-Host "`n⚠️  Test FAILED as expected (known issue)" -ForegroundColor Yellow
            Write-Host "   This confirms the gold tier issue still exists" -ForegroundColor White
            Write-Host "   TODO: Fix domain detection logic, then remove this debug test" -ForegroundColor White
        }
        
    } else {
        Write-Host "❌ Generated file not found" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
    Write-Host $result -ForegroundColor Red
}