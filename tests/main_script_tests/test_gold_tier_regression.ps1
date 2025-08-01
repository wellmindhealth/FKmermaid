# Test Gold Tier Regression
# Focused test to detect when gold tier entities are incorrectly styled as blue

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Gold Tier Regression" -ForegroundColor Cyan
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "Detects when gold tier entities are incorrectly styled as blue" -ForegroundColor White
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

Write-Host "🧪 Testing Gold Tier Regression" -ForegroundColor Cyan
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

# Define test cases that should show gold tier
$testCases = @(
    @{
        Name = "Partner Focus - Should Show Gold Tier"
        Focus = "partner"
        Domains = "provider"
        DiagramType = "ER"
        ExpectedGoldEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
    },
    @{
        Name = "Partner+Member Focus - Should Show Gold Tier"
        Focus = "partner,member"
        Domains = "provider"
        DiagramType = "ER"
        ExpectedGoldEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
    }
)

Set-Location $scriptPath

$testResults = @()

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains)" -ForegroundColor White
    
    # Generate test diagram
    $testOutput = "test_gold_$($testCase.Name -replace '\s+', '_').mmd"
    $result = & ".\generate_erd_enhanced.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Diagram generated successfully" -ForegroundColor Green
        
        # Analyze the generated file
        $generatedFile = "$exportsPath\$testOutput"
        if (Test-Path $generatedFile) {
            $content = Get-Content $generatedFile -Raw
            
            # Extract styling information
            $actualGoldEntities = @()
            $actualBlueEntities = @()
            
            # Parse style lines to extract entity-color mappings
            $styleLines = $content -split "`n" | Where-Object { $_ -match "style.*fill:#" }
            
            foreach ($line in $styleLines) {
                if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
                    $entity = $matches[1]
                    $color = $matches[2]
                    
                    if ($color -eq $styleColors["domain_related"]) {
                        $actualGoldEntities += $entity
                    } elseif ($color -eq $styleColors["related"]) {
                        $actualBlueEntities += $entity
                    }
                }
            }
            
            # Check for gold tier issues
            $goldTierIssues = @()
            $blueTierIssues = @()
            
            foreach ($expectedGoldEntity in $testCase.ExpectedGoldEntities) {
                if ($actualGoldEntities -notcontains $expectedGoldEntity) {
                    if ($actualBlueEntities -contains $expectedGoldEntity) {
                        $goldTierIssues += "❌ $expectedGoldEntity should be GOLD but is BLUE"
                    } else {
                        $goldTierIssues += "❌ $expectedGoldEntity should be GOLD but not found"
                    }
                }
            }
            
            # Report results
            if ($goldTierIssues.Count -eq 0) {
                Write-Host "✅ Gold tier working correctly" -ForegroundColor Green
                Write-Host "  Gold entities: $($actualGoldEntities.Count)" -ForegroundColor White
                Write-Host "  Blue entities: $($actualBlueEntities.Count)" -ForegroundColor White
            } else {
                Write-Host "❌ Gold tier issues detected:" -ForegroundColor Red
                foreach ($issue in $goldTierIssues) {
                    Write-Host "  $issue" -ForegroundColor Red
                }
            }
            
            # Save test result
            $testResult = @{
                TestName = $testCase.Name
                Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Focus = $testCase.Focus
                Domains = $testCase.Domains
                ExpectedGoldEntities = $testCase.ExpectedGoldEntities
                ActualGoldEntities = $actualGoldEntities
                ActualBlueEntities = $actualBlueEntities
                GoldTierIssues = $goldTierIssues
                HasIssues = ($goldTierIssues.Count -gt 0)
            }
            
            $testResults += $testResult
            
            # Clean up test file
            Remove-Item $generatedFile -Force
            Write-Host "✅ Cleaned up test file" -ForegroundColor Green
            
        } else {
            Write-Host "❌ Generated file not found" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}

# Save all test results
$testResults | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\gold_tier_regression_test_results.json"

Write-Host "`n🏁 Gold Tier Regression Test Complete" -ForegroundColor Cyan
Write-Host "📊 Test Results: $($testResults.Count) tests completed" -ForegroundColor White

# Summary
$testsWithIssues = ($testResults | Where-Object { $_.HasIssues }).Count
$totalTests = $testResults.Count

Write-Host "📈 Gold Tier Summary:" -ForegroundColor Cyan
Write-Host "  Tests with issues: $testsWithIssues/$totalTests" -ForegroundColor $(if ($testsWithIssues -eq 0) { "Green" } else { "Red" })

if ($testsWithIssues -gt 0) {
    Write-Host "⚠️  Gold tier issues detected!" -ForegroundColor Yellow
    Write-Host "   Domain detection logic needs investigation." -ForegroundColor Yellow
}