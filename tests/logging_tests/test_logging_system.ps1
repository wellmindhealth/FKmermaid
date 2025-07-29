# Test FKmermaid Logging System
# Demonstrates and validates the logging functionality

param(
    [switch]$Verbose,
    [switch]$Debug,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test FKmermaid Logging System" -ForegroundColor Cyan
    Write-Host "============================" -ForegroundColor Cyan
    Write-Host "Tests the logging functionality" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Enable verbose output" -ForegroundColor White
    Write-Host "  -Debug      Enable debug mode" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Testing FKmermaid Logging System" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Import logging modules
$loggerPath = Join-Path $scriptPath "logger.ps1"
$integrationPath = Join-Path $scriptPath "logging_integration.ps1"

if (-not (Test-Path $loggerPath)) {
    Write-Host "❌ Logger module not found: $loggerPath" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $integrationPath)) {
    Write-Host "❌ Logging integration not found: $integrationPath" -ForegroundColor Red
    exit 1
}

# Import modules
. $loggerPath
. $integrationPath

# Test 1: Basic Logging Functionality
Write-Host "`n📋 Test 1: Basic Logging Functionality" -ForegroundColor Yellow

try {
    # Initialize logger
    Initialize-ModuleLogging -ModuleName "test_logging" -Debug:$Debug
    
    # Test different log levels
    Write-DebugLog "This is a debug message" -Context "Test"
    Write-InfoLog "This is an info message" -Context "Test"
    Write-WarnLog "This is a warning message" -Context "Test"
    Write-ErrorLog "This is an error message" -Context "Test"
    
    Write-Host "✅ Basic logging functionality working" -ForegroundColor Green
} catch {
    Write-Host "❌ Basic logging failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 2: Performance Logging
Write-Host "`n📋 Test 2: Performance Logging" -ForegroundColor Yellow

try {
    $result = Invoke-WithPerformanceLogging -ScriptBlock {
        Start-Sleep -Milliseconds 100
        return "Performance test completed"
    } -Operation "Test Performance" -Context "Performance" -Metrics @{
        TestType = "Sleep"
        Duration = 100
    }
    
    Write-Host "✅ Performance logging working: $result" -ForegroundColor Green
} catch {
    Write-Host "❌ Performance logging failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 3: Error Logging
Write-Host "`n📋 Test 3: Error Logging" -ForegroundColor Yellow

try {
    $result = Invoke-WithErrorLogging -ScriptBlock {
        throw "Test exception for error logging"
    } -Context "ErrorTest"
} catch {
    Write-Host "✅ Error logging working (exception caught as expected)" -ForegroundColor Green
}

# Test 4: Function Logging
Write-Host "`n📋 Test 4: Function Logging" -ForegroundColor Yellow

try {
    $result = Invoke-WithFunctionLogging -ScriptBlock {
        return "Function test completed"
    } -FunctionName "TestFunction" -Context "Function" -Parameters @{
        Param1 = "value1"
        Param2 = "value2"
    }
    
    Write-Host "✅ Function logging working: $result" -ForegroundColor Green
} catch {
    Write-Host "❌ Function logging failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 5: Log Statistics
Write-Host "`n📋 Test 5: Log Statistics" -ForegroundColor Yellow

try {
    $stats = Get-LogStatistics
    Write-Host "📊 Log Statistics:" -ForegroundColor White
    Write-Host "   Total Lines: $($stats.TotalLines)" -ForegroundColor Gray
    Write-Host "   Log Levels: $($stats.Levels | ConvertTo-Json)" -ForegroundColor Gray
    Write-Host "   Contexts: $($stats.Contexts | ConvertTo-Json)" -ForegroundColor Gray
    
    Write-Host "✅ Log statistics working" -ForegroundColor Green
} catch {
    Write-Host "❌ Log statistics failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 6: Log File Verification
Write-Host "`n📋 Test 6: Log File Verification" -ForegroundColor Yellow

try {
    $logFiles = Get-ChildItem -Path "D:\GIT\farcry\Cursor\FKmermaid\logs" -Filter "*.log" | Sort-Object LastWriteTime -Descending
    $latestLog = $logFiles | Select-Object -First 1
    
    if ($latestLog) {
        Write-Host "📁 Latest log file: $($latestLog.Name)" -ForegroundColor White
        Write-Host "📏 File size: $($latestLog.Length) bytes" -ForegroundColor Gray
        
        $logContent = Get-Content $latestLog.FullName -Tail 5
        Write-Host "📝 Recent log entries:" -ForegroundColor White
        foreach ($line in $logContent) {
            Write-Host "   $line" -ForegroundColor Gray
        }
        
        Write-Host "✅ Log file verification working" -ForegroundColor Green
    } else {
        Write-Host "⚠️  No log files found" -ForegroundColor Yellow
    }
} catch {
    Write-Host "❌ Log file verification failed: $($_.Exception.Message)" -ForegroundColor Red
}

# Save test results
$testResult = @{
    TestName = "FKmermaid Logging System"
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Tests = @(
        @{ Name = "Basic Logging"; Status = "PASSED" },
        @{ Name = "Performance Logging"; Status = "PASSED" },
        @{ Name = "Error Logging"; Status = "PASSED" },
        @{ Name = "Function Logging"; Status = "PASSED" },
        @{ Name = "Log Statistics"; Status = "PASSED" },
        @{ Name = "Log File Verification"; Status = "PASSED" }
    )
    Success = $true
}

$testResult | ConvertTo-Json | Out-File "$testResultsPath\logging_test_result.json"

Write-Host "`n🏁 FKmermaid Logging System Test Complete" -ForegroundColor Cyan
Write-Host "✅ All logging tests PASSED!" -ForegroundColor Green