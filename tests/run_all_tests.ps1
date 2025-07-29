# Run All FKmermaid Tests
# Executes all test categories and generates a comprehensive report

param(
    [switch]$SkipBaselines,
    [switch]$SkipCFC,
    [switch]$SkipMain,
    [switch]$SkipIntegration,
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Run All FKmermaid Tests" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    Write-Host "Executes all test categories and generates a comprehensive report" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -SkipBaselines    Skip baseline generation tests" -ForegroundColor White
    Write-Host "  -SkipCFC          Skip CFC scan tests" -ForegroundColor White
    Write-Host "  -SkipMain         Skip main script tests" -ForegroundColor White
    Write-Host "  -SkipIntegration  Skip integration tests" -ForegroundColor White
    Write-Host "  -Verbose          Show detailed output" -ForegroundColor White
    Write-Host "  -Help             Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$testRoot = "D:\GIT\farcry\Cursor\FKmermaid\tests"
$resultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"

# Create results directory if it doesn't exist
if (-not (Test-Path $resultsPath)) {
    New-Item -ItemType Directory -Path $resultsPath -Force | Out-Null
}

Write-Host "🧪 FKmermaid Test Suite" -ForegroundColor Cyan
Write-Host "======================" -ForegroundColor Cyan
Write-Host "Starting comprehensive test execution..." -ForegroundColor White

$startTime = Get-Date
$testResults = @()
$overallSuccess = $true

# Test 1: CFC Scan Tests
if (-not $SkipCFC) {
    Write-Host "`n📋 Test Category 1: CFC Scan Tests" -ForegroundColor Yellow
    Write-Host "=================================" -ForegroundColor Yellow
    
    # Test CFC Scan Generation
    Write-Host "`n🔍 Running CFC Scan Generation Test..." -ForegroundColor White
    $cfcResult = & "$testRoot\cfc_scan_tests\test_cfc_scan_generation.ps1" 2>&1
    $cfcSuccess = $LASTEXITCODE -eq 0
    
    if ($cfcSuccess) {
        Write-Host "✅ CFC Scan Generation Test Passed" -ForegroundColor Green
    } else {
        Write-Host "❌ CFC Scan Generation Test Failed" -ForegroundColor Red
        $overallSuccess = $false
    }
    
    # Test Exclusions
    Write-Host "`n🔍 Running Exclusions Test..." -ForegroundColor White
    $exclusionsResult = & "$testRoot\cfc_scan_tests\test_exclusions.ps1" 2>&1
    $exclusionsSuccess = $LASTEXITCODE -eq 0
    
    if ($exclusionsSuccess) {
        Write-Host "✅ Exclusions Test Passed" -ForegroundColor Green
    } else {
        Write-Host "❌ Exclusions Test Failed" -ForegroundColor Red
        $overallSuccess = $false
    }
    
    $testResults += @{
        Category = "CFC Scan Tests"
        Tests = @(
            @{ Name = "CFC Scan Generation"; Success = $cfcSuccess },
            @{ Name = "Exclusions"; Success = $exclusionsSuccess }
        )
        OverallSuccess = $cfcSuccess -and $exclusionsSuccess
    }
} else {
    Write-Host "`n⏭️  Skipping CFC Scan Tests" -ForegroundColor Yellow
}

# Test 2: Main Script Tests
if (-not $SkipMain) {
    Write-Host "`n📋 Test Category 2: Main Script Tests" -ForegroundColor Yellow
    Write-Host "=====================================" -ForegroundColor Yellow
    
    # Test 4-Tier System
    Write-Host "`n🔍 Running 4-Tier System Test..." -ForegroundColor White
    $tierResult = & "$testRoot\main_script_tests\test_4_tier_system.ps1" 2>&1
    $tierSuccess = $LASTEXITCODE -eq 0
    
    if ($tierSuccess) {
        Write-Host "✅ 4-Tier System Test Passed" -ForegroundColor Green
    } else {
        Write-Host "❌ 4-Tier System Test Failed" -ForegroundColor Red
        $overallSuccess = $false
    }
    
    $testResults += @{
        Category = "Main Script Tests"
        Tests = @(
            @{ Name = "4-Tier System"; Success = $tierSuccess }
        )
        OverallSuccess = $tierSuccess
    }
} else {
    Write-Host "`n⏭️  Skipping Main Script Tests" -ForegroundColor Yellow
}

# Test 3: Baseline Tests
if (-not $SkipBaselines) {
    Write-Host "`n📋 Test Category 3: Baseline Tests" -ForegroundColor Yellow
    Write-Host "===================================" -ForegroundColor Yellow
    
    # Generate Baselines
    Write-Host "`n🔍 Generating Baselines..." -ForegroundColor White
    $baselineResult = & "$testRoot\baseline_tests\generate_baselines.ps1" 2>&1
    $baselineSuccess = $LASTEXITCODE -eq 0
    
    if ($baselineSuccess) {
        Write-Host "✅ Baseline Generation Passed" -ForegroundColor Green
    } else {
        Write-Host "❌ Baseline Generation Failed" -ForegroundColor Red
        $overallSuccess = $false
    }
    
    $testResults += @{
        Category = "Baseline Tests"
        Tests = @(
            @{ Name = "Baseline Generation"; Success = $baselineSuccess }
        )
        OverallSuccess = $baselineSuccess
    }
} else {
    Write-Host "`n⏭️  Skipping Baseline Tests" -ForegroundColor Yellow
}

# Test 4: Integration Tests
if (-not $SkipIntegration) {
    Write-Host "`n📋 Test Category 4: Integration Tests" -ForegroundColor Yellow
    Write-Host "======================================" -ForegroundColor Yellow
    
    # Test Full Workflow
    Write-Host "`n🔍 Running Full Workflow Test..." -ForegroundColor White
    
    # This is a simple integration test - generate a diagram and verify it opens
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    $integrationResult = & ".\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "partner,participant" -OutputFile "integration_test.mmd" 2>&1
    $integrationSuccess = $LASTEXITCODE -eq 0
    
    if ($integrationSuccess) {
        Write-Host "✅ Full Workflow Test Passed" -ForegroundColor Green
        
        # Clean up test file
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\integration_test.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
            Write-Host "✅ Cleaned up integration test file" -ForegroundColor Green
        }
    } else {
        Write-Host "❌ Full Workflow Test Failed" -ForegroundColor Red
        $overallSuccess = $false
    }
    
    $testResults += @{
        Category = "Integration Tests"
        Tests = @(
            @{ Name = "Full Workflow"; Success = $integrationSuccess }
        )
        OverallSuccess = $integrationSuccess
    }
} else {
    Write-Host "`n⏭️  Skipping Integration Tests" -ForegroundColor Yellow
}

# Generate Test Report
$endTime = Get-Date
$duration = $endTime - $startTime

$testReport = @{
    TestSuite = "FKmermaid Test Suite"
    StartTime = $startTime.ToString("yyyy-MM-dd HH:mm:ss")
    EndTime = $endTime.ToString("yyyy-MM-dd HH:mm:ss")
    Duration = $duration.ToString("hh\:mm\:ss")
    OverallSuccess = $overallSuccess
    Categories = $testResults
    Summary = @{
        TotalCategories = $testResults.Count
        PassedCategories = ($testResults | Where-Object { $_.OverallSuccess }).Count
        FailedCategories = ($testResults | Where-Object { -not $_.OverallSuccess }).Count
        TotalTests = ($testResults | ForEach-Object { $_.Tests.Count } | Measure-Object -Sum).Sum
        PassedTests = ($testResults | ForEach-Object { ($_.Tests | Where-Object { $_.Success }).Count } | Measure-Object -Sum).Sum
        FailedTests = ($testResults | ForEach-Object { ($_.Tests | Where-Object { -not $_.Success }).Count } | Measure-Object -Sum).Sum
    }
}

# Save test report
$testReport | ConvertTo-Json -Depth 10 | Out-File "$resultsPath\test_report.json"

# Display summary
Write-Host "`n🏁 Test Suite Complete" -ForegroundColor Cyan
Write-Host "====================" -ForegroundColor Cyan
Write-Host "Duration: $($duration.ToString("hh\:mm\:ss"))" -ForegroundColor White
Write-Host "Overall Success: $(if ($overallSuccess) { '✅ PASSED' } else { '❌ FAILED' })" -ForegroundColor $(if ($overallSuccess) { 'Green' } else { 'Red' })

Write-Host "`n📊 Category Summary:" -ForegroundColor Yellow
foreach ($category in $testResults) {
    $status = if ($category.OverallSuccess) { "✅ PASSED" } else { "❌ FAILED" }
    $color = if ($category.OverallSuccess) { "Green" } else { "Red" }
    Write-Host "  $($category.Category): $status" -ForegroundColor $color
}

Write-Host "`n📁 Test results saved to: $resultsPath" -ForegroundColor White

if ($overallSuccess) {
    Write-Host "🎉 All tests passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "💥 Some tests failed. Check the results for details." -ForegroundColor Red
    exit 1
}