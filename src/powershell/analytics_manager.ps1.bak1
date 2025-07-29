# FKmermaid Analytics Manager
# Handles performance metrics, usage analytics, and error tracking

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

# Global analytics tracking
$script:AnalyticsData = @{
    Operations = @()
    Performance = @()
    Errors = @()
    Usage = @()
    StartTime = Get-Date
}

function Initialize-AnalyticsManager {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Analytics Manager initialized:" -ForegroundColor Green
    Write-Host "  Start time: $($script:AnalyticsData.StartTime)" -ForegroundColor Cyan
    Write-Host "  Tracking enabled: Performance, Usage, Errors" -ForegroundColor Cyan
}

function Track-Operation {
    param(
        [string]$operation,
        [string]$type = "general",
        [object]$parameters = $null,
        [object]$result = $null,
        [timespan]$duration = [timespan]::Zero,
        [int]$memoryUsed = 0,
        [bool]$success = $true,
        [string]$errorMessage = ""
    )
    
    $operationData = @{
        Timestamp = Get-Date
        Operation = $operation
        Type = $type
        Parameters = $parameters
        Result = $result
        Duration = $duration
        MemoryUsed = $memoryUsed
        Success = $success
        ErrorMessage = $errorMessage
    }
    
    $script:AnalyticsData.Operations += $operationData
    
    # Log to console if verbose
    $status = if ($success) { "✅" } else { "❌" }
    Write-Host "$status $operation ($($duration.TotalSeconds.ToString('F2'))s, ${memoryUsed}MB)" -ForegroundColor $(if ($success) { "Green" } else { "Red" })
}

function Track-Performance {
    param(
        [string]$metric,
        [double]$value,
        [string]$unit = "",
        [string]$category = "general"
    )
    
    $performanceData = @{
        Timestamp = Get-Date
        Metric = $metric
        Value = $value
        Unit = $unit
        Category = $category
    }
    
    $script:AnalyticsData.Performance += $performanceData
}

function Track-Error {
    param(
        [string]$operation,
        [string]$errorType,
        [string]$message,
        [object]$context = $null,
        [string]$severity = "ERROR"
    )
    
    $errorData = @{
        Timestamp = Get-Date
        Operation = $operation
        ErrorType = $errorType
        Message = $message
        Context = $context
        Severity = $severity
    }
    
    $script:AnalyticsData.Errors += $errorData
}

function Track-Usage {
    param(
        [string]$feature,
        [string]$action,
        [object]$parameters = $null,
        [bool]$success = $true
    )
    
    $usageData = @{
        Timestamp = Get-Date
        Feature = $feature
        Action = $action
        Parameters = $parameters
        Success = $success
    }
    
    $script:AnalyticsData.Usage += $usageData
}

function Get-PerformanceMetrics {
    param(
        [string]$category = "all",
        [int]$limit = 100
    )
    
    if ($category -eq "all") {
        return $script:AnalyticsData.Performance | Select-Object -Last $limit
    } else {
        return $script:AnalyticsData.Performance | Where-Object { $_.Category -eq $category } | Select-Object -Last $limit
    }
}

function Get-OperationStats {
    param(
        [string]$operation = "all",
        [timespan]$timeWindow = [timespan]::FromHours(24)
    )
    
    $cutoffTime = (Get-Date) - $timeWindow
    $operations = $script:AnalyticsData.Operations | Where-Object { $_.Timestamp -gt $cutoffTime }
    
    if ($operation -ne "all") {
        $operations = $operations | Where-Object { $_.Operation -eq $operation }
    }
    
    if ($operations.Count -eq 0) {
        return @{
            TotalOperations = 0
            SuccessRate = 0
            AverageDuration = [timespan]::Zero
            AverageMemory = 0
            TotalErrors = 0
        }
    }
    
    $successful = $operations | Where-Object { $_.Success }
    $failed = $operations | Where-Object { -not $_.Success }
    
    $totalDuration = ($operations | ForEach-Object { $_.Duration }).TotalMilliseconds
    $totalMemory = ($operations | ForEach-Object { $_.MemoryUsed }) | Measure-Object -Sum | Select-Object -ExpandProperty Sum
    
    return @{
        TotalOperations = $operations.Count
        SuccessRate = [math]::Round(($successful.Count / $operations.Count) * 100, 2)
        AverageDuration = [timespan]::FromMilliseconds($totalDuration / $operations.Count)
        AverageMemory = [math]::Round($totalMemory / $operations.Count, 2)
        TotalErrors = $failed.Count
        SuccessfulOperations = $successful.Count
        FailedOperations = $failed.Count
    }
}

function Get-ErrorSummary {
    param(
        [timespan]$timeWindow = [timespan]::FromHours(24)
    )
    
    $cutoffTime = (Get-Date) - $timeWindow
    $errors = $script:AnalyticsData.Errors | Where-Object { $_.Timestamp -gt $cutoffTime }
    
    if ($errors.Count -eq 0) {
        return @{
            TotalErrors = 0
            ErrorTypes = @{}
            Operations = @{}
            Severity = @{}
        }
    }
    
    $errorTypes = $errors | Group-Object ErrorType | ForEach-Object { @{ $_.Name = $_.Count } }
    $operations = $errors | Group-Object Operation | ForEach-Object { @{ $_.Name = $_.Count } }
    $severity = $errors | Group-Object Severity | ForEach-Object { @{ $_.Name = $_.Count } }
    
    return @{
        TotalErrors = $errors.Count
        ErrorTypes = $errorTypes
        Operations = $operations
        Severity = $severity
        RecentErrors = $errors | Select-Object -Last 10
    }
}

function Get-UsageAnalytics {
    param(
        [timespan]$timeWindow = [timespan]::FromHours(24)
    )
    
    $cutoffTime = (Get-Date) - $timeWindow
    $usage = $script:AnalyticsData.Usage | Where-Object { $_.Timestamp -gt $cutoffTime }
    
    if ($usage.Count -eq 0) {
        return @{
            TotalUsage = 0
            Features = @{}
            Actions = @{}
            SuccessRate = 0
        }
    }
    
    $features = $usage | Group-Object Feature | ForEach-Object { @{ $_.Name = $_.Count } }
    $actions = $usage | Group-Object Action | ForEach-Object { @{ $_.Name = $_.Count } }
    $successful = $usage | Where-Object { $_.Success }
    
    return @{
        TotalUsage = $usage.Count
        Features = $features
        Actions = $actions
        SuccessRate = [math]::Round(($successful.Count / $usage.Count) * 100, 2)
        RecentUsage = $usage | Select-Object -Last 10
    }
}

function Export-AnalyticsReport {
    param(
        [string]$outputPath = "",
        [string]$format = "json"
    )
    
    if (-not $outputPath) {
        $resultsPath = Get-ProjectPath -pathKey "results"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $resultsPath "analytics_report_$timestamp.$format"
    }
    
    $report = @{
        GeneratedAt = Get-Date
        TimeWindow = (Get-Date) - $script:AnalyticsData.StartTime
        OperationStats = Get-OperationStats
        ErrorSummary = Get-ErrorSummary
        UsageAnalytics = Get-UsageAnalytics
        PerformanceMetrics = Get-PerformanceMetrics
        RawData = $script:AnalyticsData
    }
    
    try {
        if ($format -eq "json") {
            $report | ConvertTo-Json -Depth 10 | Set-Content $outputPath
        } elseif ($format -eq "csv") {
            # Export key metrics to CSV
            $csvData = @()
            foreach ($op in $script:AnalyticsData.Operations) {
                $csvData += [PSCustomObject]@{
                    Timestamp = $op.Timestamp
                    Operation = $op.Operation
                    Type = $op.Type
                    Duration = $op.Duration.TotalSeconds
                    MemoryUsed = $op.MemoryUsed
                    Success = $op.Success
                    ErrorMessage = $op.ErrorMessage
                }
            }
            $csvData | Export-Csv -Path $outputPath -NoTypeInformation
        }
        
        Write-Host "Analytics report exported to: $outputPath" -ForegroundColor Green
        return $outputPath
    } catch {
        Write-Error "Failed to export analytics report: $($_.Exception.Message)"
        return $null
    }
}

function Show-AnalyticsDashboard {
    param(
        [timespan]$timeWindow = [timespan]::FromHours(24)
    )
    
    Write-Host "📊 FKmermaid Analytics Dashboard" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Operation Statistics
    $opStats = Get-OperationStats -timeWindow $timeWindow
    Write-Host "🔧 Operation Statistics (Last $($timeWindow.TotalHours) hours):" -ForegroundColor Yellow
    Write-Host "  Total Operations: $($opStats.TotalOperations)" -ForegroundColor White
    Write-Host "  Success Rate: $($opStats.SuccessRate)%" -ForegroundColor $(if ($opStats.SuccessRate -gt 90) { "Green" } else { "Yellow" })
    Write-Host "  Average Duration: $($opStats.AverageDuration.TotalSeconds.ToString('F2'))s" -ForegroundColor White
    Write-Host "  Average Memory: $($opStats.AverageMemory)MB" -ForegroundColor White
    Write-Host "  Total Errors: $($opStats.TotalErrors)" -ForegroundColor $(if ($opStats.TotalErrors -eq 0) { "Green" } else { "Red" })
    Write-Host ""
    
    # Error Summary
    $errorSummary = Get-ErrorSummary -timeWindow $timeWindow
    Write-Host "❌ Error Summary (Last $($timeWindow.TotalHours) hours):" -ForegroundColor Yellow
    Write-Host "  Total Errors: $($errorSummary.TotalErrors)" -ForegroundColor $(if ($errorSummary.TotalErrors -eq 0) { "Green" } else { "Red" })
    if ($errorSummary.TotalErrors -gt 0) {
        Write-Host "  Most Common Error Types:" -ForegroundColor White
        foreach ($errorType in $errorSummary.ErrorTypes.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 3) {
            Write-Host "    $($errorType.Key): $($errorType.Value)" -ForegroundColor Gray
        }
    }
    Write-Host ""
    
    # Usage Analytics
    $usageAnalytics = Get-UsageAnalytics -timeWindow $timeWindow
    Write-Host "📈 Usage Analytics (Last $($timeWindow.TotalHours) hours):" -ForegroundColor Yellow
    Write-Host "  Total Usage Events: $($usageAnalytics.TotalUsage)" -ForegroundColor White
    Write-Host "  Success Rate: $($usageAnalytics.SuccessRate)%" -ForegroundColor $(if ($usageAnalytics.SuccessRate -gt 90) { "Green" } else { "Yellow" })
    Write-Host "  Most Used Features:" -ForegroundColor White
    foreach ($feature in $usageAnalytics.Features.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 3) {
        Write-Host "    $($feature.Key): $($feature.Value)" -ForegroundColor Gray
    }
    Write-Host ""
    
    # Performance Metrics
    $perfMetrics = Get-PerformanceMetrics -limit 5
    if ($perfMetrics.Count -gt 0) {
        Write-Host "⚡ Recent Performance Metrics:" -ForegroundColor Yellow
        foreach ($metric in $perfMetrics) {
            Write-Host "  $($metric.Metric): $($metric.Value)$($metric.Unit) ($($metric.Category))" -ForegroundColor White
        }
    }
}

function Clear-AnalyticsData {
    $script:AnalyticsData = @{
        Operations = @()
        Performance = @()
        Errors = @()
        Usage = @()
        StartTime = Get-Date
    }
    Write-Host "Analytics data cleared" -ForegroundColor Green
}

# Initialize analytics manager when module is loaded
Initialize-AnalyticsManager

# Test analytics manager if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Analytics Manager..." -ForegroundColor Cyan
    
    # Track some test operations
    Track-Operation -operation "Test Operation 1" -type "test" -duration ([timespan]::FromSeconds(1.5)) -memoryUsed 50 -success $true
    Track-Operation -operation "Test Operation 2" -type "test" -duration ([timespan]::FromSeconds(0.8)) -memoryUsed 25 -success $false -errorMessage "Test error"
    Track-Operation -operation "Test Operation 3" -type "test" -duration ([timespan]::FromSeconds(2.1)) -memoryUsed 75 -success $true
    
    # Track performance metrics
    Track-Performance -metric "CPU Usage" -value 45.2 -unit "%" -category "system"
    Track-Performance -metric "Memory Usage" -value 1024.5 -unit "MB" -category "system"
    Track-Performance -metric "Response Time" -value 1.2 -unit "s" -category "performance"
    
    # Track errors
    Track-Error -operation "Test Operation" -errorType "FileNotFound" -message "Test error message" -severity "WARN"
    
    # Track usage
    Track-Usage -feature "ER Diagram" -action "generate" -success $true
    Track-Usage -feature "Class Diagram" -action "generate" -success $true
    Track-Usage -feature "Export" -action "png" -success $false
    
    # Show dashboard
    Show-AnalyticsDashboard
    
    # Export report
    $reportPath = Export-AnalyticsReport
    if ($reportPath) {
        Write-Host "Analytics report exported to: $reportPath" -ForegroundColor Green
    }
}