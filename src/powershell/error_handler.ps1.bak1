# FKmermaid Error Handler
# Comprehensive exception handling, logging, and recovery mechanisms

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

# Global error tracking
$script:ErrorLog = @()
$script:ErrorCount = 0
$script:LastError = $null

function Initialize-ErrorHandler {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $logLevel = Get-LoggingSetting -settingKey "level" -config $config
    $logFile = Get-LoggingSetting -settingKey "file" -config $config
    $maxSize = Get-LoggingSetting -settingKey "maxSize" -config $config
    $backupCount = Get-LoggingSetting -settingKey "backupCount" -config $config
    
    $script:LogLevel = $logLevel
    $script:LogFile = $logFile
    $script:MaxLogSize = $maxSize
    $script:LogBackupCount = $backupCount
    
    Write-Host "Error Handler initialized:" -ForegroundColor Green
    Write-Host "  Log Level: $LogLevel" -ForegroundColor Cyan
    Write-Host "  Log File: $LogFile" -ForegroundColor Cyan
    Write-Host "  Max Size: $MaxLogSize" -ForegroundColor Cyan
    Write-Host "  Backup Count: $LogBackupCount" -ForegroundColor Cyan
}

function Get-LoggingSetting {
    param(
        [string]$settingKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.logging.$settingKey) {
        return $config.logging.$settingKey
    } else {
        Write-Warning "Logging setting '$settingKey' not found in config"
        return $null
    }
}

function Write-ErrorLog {
    param(
        [string]$level,
        [string]$message,
        [object]$exception = $null,
        [string]$operation = "",
        [object]$context = $null
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = @{
        Timestamp = $timestamp
        Level = $level
        Message = $message
        Operation = $operation
        Exception = if ($exception) { $exception.ToString() } else { $null }
        Context = $context
    }
    
    $script:ErrorLog += $logEntry
    $script:ErrorCount++
    
    # Write to console based on log level
    $color = switch ($level) {
        "ERROR" { "Red" }
        "WARN" { "Yellow" }
        "INFO" { "Green" }
        "DEBUG" { "Gray" }
        default { "White" }
    }
    
    Write-Host "[$timestamp] [$level] $message" -ForegroundColor $color
    
    # Write to file if configured
    if ($script:LogFile) {
        try {
            $logPath = Get-ProjectPath -pathKey "config"
            $fullLogPath = Join-Path $logPath $script:LogFile
            
            $logLine = "[$timestamp] [$level] $message"
            if ($exception) {
                $logLine += "`nException: $($exception.ToString())"
            }
            if ($operation) {
                $logLine += "`nOperation: $operation"
            }
            if ($context) {
                $logLine += "`nContext: $($context | ConvertTo-Json -Depth 2)"
            }
            $logLine += "`n" + "-" * 80 + "`n"
            
            Add-Content -Path $fullLogPath -Value $logLine -ErrorAction SilentlyContinue
        } catch {
            Write-Warning "Failed to write to log file: $($_.Exception.Message)"
        }
    }
}

function Invoke-SafeOperation {
    param(
        [string]$operation,
        [scriptblock]$scriptBlock,
        [string]$errorMessage = "Operation failed",
        [scriptblock]$recoveryBlock = $null,
        [object]$context = $null
    )
    
    try {
        Write-ErrorLog -level "INFO" -message "Starting operation: $operation" -operation $operation -context $context
        $result = & $scriptBlock
        Write-ErrorLog -level "INFO" -message "Operation completed successfully: $operation" -operation $operation
        return $result
    } catch {
        $script:LastError = $_
        Write-ErrorLog -level "ERROR" -message "${errorMessage}: $($_.Exception.Message)" -operation $operation -exception $_ -context $context
        
        # Attempt recovery if provided
        if ($recoveryBlock) {
            try {
                Write-ErrorLog -level "WARN" -message "Attempting recovery for operation: $operation" -operation $operation
                $recoveryResult = & $recoveryBlock
                Write-ErrorLog -level "INFO" -message "Recovery completed for operation: $operation" -operation $operation
                return $recoveryResult
            } catch {
                Write-ErrorLog -level "ERROR" -message "Recovery failed for operation: $operation" -operation $operation -exception $_
                throw
            }
        } else {
            throw
        }
    }
}

function Test-OperationPrerequisites {
    param(
        [string]$operation,
        [hashtable]$prerequisites
    )
    
    $failures = @()
    
    foreach ($prereq in $prerequisites.GetEnumerator()) {
        $test = $prereq.Key
        $description = $prereq.Value
        
        try {
            $result = & $test
            if (-not $result) {
                $failures += "Prerequisite failed: $description"
            }
        } catch {
            $failures += "Prerequisite error: $description - $($_.Exception.Message)"
        }
    }
    
    if ($failures.Count -gt 0) {
        Write-ErrorLog -level "ERROR" -message "Prerequisites failed for operation: $operation" -operation $operation -context @{ Failures = $failures }
        return $false
    }
    
    Write-ErrorLog -level "INFO" -message "All prerequisites passed for operation: $operation" -operation $operation
    return $true
}

function Get-ErrorSummary {
    return @{
        TotalErrors = $script:ErrorCount
        ErrorLog = $script:ErrorLog
        LastError = $script:LastError
        LogFile = $script:LogFile
    }
}

function Clear-ErrorLog {
    $script:ErrorLog = @()
    $script:ErrorCount = 0
    $script:LastError = $null
    Write-ErrorLog -level "INFO" -message "Error log cleared"
}

function Test-SystemHealth {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $healthChecks = @{
        "Config File" = { Test-Path (Get-ConfigFile -fileKey "cfcScanConfig" -config $config) }
        "Domains File" = { Test-Path (Get-ConfigFile -fileKey "domainsConfig" -config $config) }
        "Project Structure" = { Test-ProjectStructure -config $config }
        "Exports Directory" = { Test-Path (Get-ProjectPath -pathKey "exports" -config $config) }
        "Source Directory" = { Test-Path (Get-ProjectPath -pathKey "src" -config $config) }
    }
    
    $results = @{}
    $overallHealth = $true
    
    foreach ($check in $healthChecks.GetEnumerator()) {
        $testName = $check.Key
        $testScript = $check.Value
        
        try {
            $result = & $testScript
            $results[$testName] = $result
            if (-not $result) {
                $overallHealth = $false
            }
        } catch {
            $results[$testName] = $false
            $overallHealth = $false
            Write-ErrorLog -level "ERROR" -message "Health check failed: $testName" -exception $_
        }
    }
    
    Write-ErrorLog -level "INFO" -message "System health check completed" -context @{ Results = $results; OverallHealth = $overallHealth }
    
    return @{
        OverallHealth = $overallHealth
        Results = $results
    }
}

function Invoke-GracefulDegradation {
    param(
        [string]$operation,
        [scriptblock]$primaryOperation,
        [scriptblock]$fallbackOperation,
        [object]$context = $null
    )
    
    try {
        Write-ErrorLog -level "INFO" -message "Attempting primary operation: $operation" -operation $operation -context $context
        $result = & $primaryOperation
        Write-ErrorLog -level "INFO" -message "Primary operation succeeded: $operation" -operation $operation
        return $result
    } catch {
        Write-ErrorLog -level "WARN" -message "Primary operation failed, attempting fallback: $operation" -operation $operation -exception $_ -context $context
        
        try {
            $fallbackResult = & $fallbackOperation
            Write-ErrorLog -level "INFO" -message "Fallback operation succeeded: $operation" -operation $operation
            return $fallbackResult
        } catch {
            Write-ErrorLog -level "ERROR" -message "Both primary and fallback operations failed: $operation" -operation $operation -exception $_ -context $context
            throw
        }
    }
}

function Get-RecoveryOptions {
    param(
        [string]$errorType,
        [object]$context = $null
    )
    
    $recoveryOptions = @{
        "FileNotFound" = @{
            "Retry" = { Start-Sleep -Seconds 2; return $true }
            "Skip" = { return $false }
            "Create" = { return $true }
        }
        "PermissionDenied" = @{
            "Retry" = { Start-Sleep -Seconds 5; return $true }
            "Skip" = { return $false }
            "Elevate" = { return $true }
        }
        "NetworkError" = @{
            "Retry" = { Start-Sleep -Seconds 10; return $true }
            "Skip" = { return $false }
            "Offline" = { return $true }
        }
        "MemoryError" = @{
            "Retry" = { [System.GC]::Collect(); return $true }
            "Skip" = { return $false }
            "ReduceScope" = { return $true }
        }
    }
    
    if ($recoveryOptions.ContainsKey($errorType)) {
        return $recoveryOptions[$errorType]
    } else {
        return @{
            "Retry" = { Start-Sleep -Seconds 1; return $true }
            "Skip" = { return $false }
        }
    }
}

# Initialize error handler when module is loaded
Initialize-ErrorHandler

# Test error handler if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Error Handler..." -ForegroundColor Cyan
    
    # Test basic logging
    Write-ErrorLog -level "INFO" -message "Error handler test started"
    Write-ErrorLog -level "WARN" -message "This is a test warning"
    Write-ErrorLog -level "ERROR" -message "This is a test error"
    
    # Test safe operation
    $result = Invoke-SafeOperation -operation "Test Operation" -scriptBlock { 
        Write-Host "Test operation executed" 
        return "Success"
    } -errorMessage "Test operation failed"
    
    Write-Host "Safe operation result: $result" -ForegroundColor Green
    
    # Test system health
    $health = Test-SystemHealth
    Write-Host "System health: $($health.OverallHealth)" -ForegroundColor $(if ($health.OverallHealth) { "Green" } else { "Red" })
    
    # Show error summary
    $summary = Get-ErrorSummary
    Write-Host "Error summary: $($summary.TotalErrors) errors logged" -ForegroundColor Yellow
}