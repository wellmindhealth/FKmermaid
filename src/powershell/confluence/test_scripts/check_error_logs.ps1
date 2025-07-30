# Check Error Logs Utility
# Automatically checks for errors in the latest log file

param(
    [string]$LogDirectory = "D:\GIT\farcry\Cursor\FKmermaid\logs",
    [int]$ErrorCount = 3,
    [switch]$ShowAll,
    [switch]$Help
)

if ($Help) {
    Write-Host "Check Error Logs Utility" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    Write-Host "Checks for errors in the latest log file" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -LogDirectory  Log directory path" -ForegroundColor White
    Write-Host "  -ErrorCount    Number of recent errors to show (default: 3)" -ForegroundColor White
    Write-Host "  -ShowAll       Show all errors instead of just recent ones" -ForegroundColor White
    Write-Host "  -Help          Show this help" -ForegroundColor White
    exit
}

# Import logging modules for consistency
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
}

Write-Host "🔍 Checking for errors in log files..." -ForegroundColor Cyan

# Get latest log file
$logFiles = Get-ChildItem -Path $LogDirectory -Filter "*.log" | Sort-Object LastWriteTime -Descending
if (-not $logFiles) {
    Write-Host "❌ No log files found in: $LogDirectory" -ForegroundColor Red
    exit 1
}

$latestLog = $logFiles | Select-Object -First 1
Write-Host "📁 Latest log file: $($latestLog.Name)" -ForegroundColor White
Write-Host "📏 File size: $($latestLog.Length) bytes" -ForegroundColor Gray
Write-Host "🕒 Last modified: $($latestLog.LastWriteTime)" -ForegroundColor Gray

# Check for errors
$errorLines = Get-Content $latestLog.FullName | Select-String "\[ERROR\]"
$errorCount = $errorLines.Count

if ($errorCount -eq 0) {
    Write-Host "✅ No errors found in log file" -ForegroundColor Green
} else {
    Write-Host "⚠️  Found $errorCount error(s) in log file" -ForegroundColor Yellow
    
    if ($ShowAll) {
        Write-Host "📝 All errors:" -ForegroundColor Yellow
        foreach ($errorLine in $errorLines) {
            Write-Host "   $($errorLine.Line)" -ForegroundColor Red
        }
    } else {
        Write-Host "📝 Recent errors (last $ErrorCount):" -ForegroundColor Yellow
        $recentErrors = $errorLines | Select-Object -Last $ErrorCount
        foreach ($errorLine in $recentErrors) {
            Write-Host "   $($errorLine.Line)" -ForegroundColor Red
        }
    }
}

# Check for warnings
$warnLines = Get-Content $latestLog.FullName | Select-String "\[WARN\]"
$warnCount = $warnLines.Count

if ($warnCount -gt 0) {
    Write-Host "⚠️  Found $warnCount warning(s) in log file" -ForegroundColor Yellow
    if (-not $ShowAll) {
        $recentWarns = $warnLines | Select-Object -Last $ErrorCount
        foreach ($warn in $recentWarns) {
            Write-Host "   $($warn.Line)" -ForegroundColor Yellow
        }
    }
}

# Get log statistics
try {
    $stats = Get-LogStatistics
    Write-Host "📊 Log Statistics:" -ForegroundColor White
    Write-Host "   Total Lines: $($stats.TotalLines)" -ForegroundColor Gray
    Write-Host "   Log Levels: $($stats.Levels | ConvertTo-Json)" -ForegroundColor Gray
    
    if ($stats.Contexts.Count -gt 0) {
        Write-Host "   Contexts: $($stats.Contexts | ConvertTo-Json)" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠️  Could not get log statistics: $($_.Exception.Message)" -ForegroundColor Yellow
}

# Summary
Write-Host "`n📋 Summary:" -ForegroundColor Cyan
Write-Host "   - Log file: $($latestLog.Name)" -ForegroundColor White
Write-Host "   - Total errors: $errorCount" -ForegroundColor $(if ($errorCount -eq 0) { "Green" } else { "Red" })
Write-Host "   - Total warnings: $warnCount" -ForegroundColor $(if ($warnCount -eq 0) { "Green" } else { "Yellow" })
Write-Host "   - File size: $($latestLog.Length) bytes" -ForegroundColor White

if ($errorCount -gt 0) {
    Write-Host "❌ Errors detected - please review the log file" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✅ No errors detected" -ForegroundColor Green
    exit 0
}