# Run All Tests
# Comprehensive test suite for the FarCry ERD Generator

Write-Host "🧪 FarCry ERD Generator - Comprehensive Test Suite" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan

# Test configuration
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"
$baselinesPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

# Test results tracking
$testResults = @()
$overallSuccess = $true

# Function to run a test and track results
function Run-Test {
    param(
        [string]$TestName,
        [string]$TestPath,
        [string]$Description
    )
    
    Write-Host "`n📋 Running: $TestName" -ForegroundColor Yellow
    Write-Host "   Description: $Description" -ForegroundColor Gray
    
    $startTime = Get-Date
    $result = & $TestPath 2>&1
    $endTime = Get-Date
    $duration = $endTime - $startTime
    
    $testResult = @{
        TestName = $TestName
        Description = $Description
        StartTime = $startTime
        EndTime = $endTime
        Duration = $duration
        ExitCode = $LASTEXITCODE
        Output = $result
        Success = ($LASTEXITCODE -eq 0)
    }
    
    if ($testResult.Success) {
        Write-Host "   ✅ PASSED ($($duration.TotalSeconds.ToString('F2'))s)" -ForegroundColor Green
    } else {
        Write-Host "   ❌ FAILED ($($duration.TotalSeconds.ToString('F2'))s)" -ForegroundColor Red
        $script:overallSuccess = $false
    }
    
    $script:testResults += $testResult
    return $testResult
}

# Test suite definition
$testSuite = @(
    @{
        Name = "CFC Scan Generation"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\cfc_scan_tests\test_cfc_scan_generation.ps1"
        Description = "Tests CFC scanning and relationship detection"
    },
    @{
        Name = "CFC Exclusions"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\cfc_scan_tests\test_exclusions.ps1"
        Description = "Tests CFC exclusion functionality"
    },
    @{
        Name = "5-Tier Semantic Styling"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\main_script_tests\test_5_tier_system.ps1"
        Description = "Tests 5-tier semantic styling system using baseline"
    },
    @{
        Name = "Domain Detection"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\main_script_tests\test_domain_detection.ps1"
        Description = "Tests domain detection and filtering"
    },
    @{
        Name = "Manual Verification"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\main_script_tests\test_manual_verification.ps1"
        Description = "Tests manual verification outputs against criteria"
    },
    @{
        Name = "Comprehensive Edge Cases"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\test_edge_cases.ps1"
        Description = "Tests all 26 edge case baselines for comprehensive validation"
    },
    @{
        Name = "Quick Diagram Generation Test"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\generate_all_cfc_diagrams_test.ps1"
        Description = "Tests quick generation of 6 diagrams (3 CFCs × 2 domains)"
    },
    @{
        Name = "CFC Cache Generation"
        Path = "D:\GIT\farcry\Cursor\FKmermaid\tests\test_cfc_cache_generation.ps1"
        Description = "Tests CFC cache generation with inheritance support"
    }
)

# Check if baselines exist
Write-Host "🔍 Checking baseline files..." -ForegroundColor Cyan
$baselineFiles = @(
    "Perfect_5-Tier_Test.mmd",  # Used by test_5_tier_system.ps1
    "Single_Domain_Test.mmd",  # Used by test_manual_verification.ps1
    "Multi_Domain_Test.mmd",  # Used by test_manual_verification.ps1
    "Programme_Focus_Test.mmd",  # Used by test_manual_verification.ps1
    "Class_Diagram_Test.mmd"  # Used by test_manual_verification.ps1
)

$missingBaselines = @()
foreach ($file in $baselineFiles) {
    $fullPath = Join-Path $baselinesPath $file
    if (-not (Test-Path $fullPath)) {
        $missingBaselines += $file
    }
}

if ($missingBaselines.Count -gt 0) {
    Write-Host "⚠️  Missing baseline files:" -ForegroundColor Yellow
    foreach ($file in $missingBaselines) {
        Write-Host "   - $file" -ForegroundColor Gray
    }
    Write-Host "   Run generate_baselines.ps1 to create missing baselines" -ForegroundColor Yellow
}

# Run all tests
Write-Host "`n🚀 Starting test execution..." -ForegroundColor Cyan

foreach ($test in $testSuite) {
    if (Test-Path $test.Path) {
        Run-Test -TestName $test.Name -TestPath $test.Path -Description $test.Description
    } else {
        Write-Host "`n❌ Test not found: $($test.Path)" -ForegroundColor Red
        $overallSuccess = $false
    }
}

# Generate test report
$report = @{
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    TotalTests = $testResults.Count
    PassedTests = ($testResults | Where-Object { $_.Success }).Count
    FailedTests = ($testResults | Where-Object { -not $_.Success }).Count
    OverallSuccess = $overallSuccess
    TestResults = $testResults
}

# Save detailed report
$report | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\test_report_$(Get-Date -Format 'yyyyMMdd_HHmmss').json"

# Summary
Write-Host "`n🏁 Test Suite Complete" -ForegroundColor Cyan
Write-Host "===================" -ForegroundColor Cyan
Write-Host "Total Tests: $($report.TotalTests)" -ForegroundColor White
Write-Host "Passed: $($report.PassedTests)" -ForegroundColor Green
Write-Host "Failed: $($report.FailedTests)" -ForegroundColor Red

if ($report.TotalTests -gt 0) {
    $successRate = [Math]::Round(($report.PassedTests / $report.TotalTests) * 100, 1)
    Write-Host "Success Rate: $successRate%" -ForegroundColor White
} else {
    Write-Host "Success Rate: N/A (no tests run)" -ForegroundColor Yellow
}

if ($overallSuccess) {
    Write-Host "`n🎉 All tests PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some tests FAILED!" -ForegroundColor Red
    Write-Host "Check detailed report: $testResultsPath" -ForegroundColor Yellow
    exit 1
}
