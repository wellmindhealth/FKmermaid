# FKmermaid Logger Module
# Provides centralized logging functionality with multiple levels and file output

param(
    [string]$LogLevel = "INFO",
    [string]$LogFile = "",
    [switch]$Verbose,
    [switch]$Debug,
    [switch]$Help
)

if ($Help) {
    Write-Host "FKmermaid Logger Module" -ForegroundColor Cyan
    Write-Host "=======================" -ForegroundColor Cyan
    Write-Host "Provides centralized logging functionality" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -LogLevel    Set minimum log level (DEBUG, INFO, WARN, ERROR)" -ForegroundColor White
    Write-Host "  -LogFile     Specify custom log file path" -ForegroundColor White
    Write-Host "  -Verbose     Enable verbose output" -ForegroundColor White
    Write-Host "  -Debug       Enable debug mode" -ForegroundColor White
    Write-Host "  -Help        Show this help" -ForegroundColor White
    exit
}

# Logger Configuration
$script:LoggerConfig = @{
    LogLevel = $LogLevel
    LogFile = $LogFile
    Verbose = $Verbose
    Debug = $Debug
    LogDir = "D:\GIT\farcry\Cursor\FKmermaid\logs"
    MaxLogSize = 10MB
    MaxLogFiles = 5
    TimestampFormat = "yyyy-MM-dd HH:mm:ss"
}

# Log Levels (in order of severity)
$script:LogLevels = @{
    "DEBUG" = 0
    "INFO" = 1
    "WARN" = 2
    "ERROR" = 3
    "FATAL" = 4
}

# Initialize logger
function Initialize-Logger {
    param(
        [string]$LogLevel = "INFO",
        [string]$LogFile = "",
        [switch]$Verbose,
        [switch]$Debug
    )
    
    # Set log level
    if ($Debug) { $script:LoggerConfig.LogLevel = "DEBUG" }
    elseif ($Verbose) { $script:LoggerConfig.LogLevel = "INFO" }
    else { $script:LoggerConfig.LogLevel = $LogLevel }
    
    # Set log file
    if ($LogFile) {
        $script:LoggerConfig.LogFile = $LogFile
    } else {
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $script:LoggerConfig.LogFile = Join-Path $script:LoggerConfig.LogDir "fkmermaid_$timestamp.log"
    }
    
    # Create log directory if it doesn't exist
    $logDir = Split-Path $script:LoggerConfig.LogFile -Parent
    if (-not (Test-Path $logDir)) {
        New-Item -ItemType Directory -Path $logDir -Force | Out-Null
    }
    
    # Log initialization
    Write-Log "INFO" "Logger initialized" -Context "Logger"
    Write-Log "INFO" "Log level: $($script:LoggerConfig.LogLevel)" -Context "Logger"
    Write-Log "INFO" "Log file: $($script:LoggerConfig.LogFile)" -Context "Logger"
}

# Write log message
function Write-Log {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("DEBUG", "INFO", "WARN", "ERROR", "FATAL")]
        [string]$Level,
        
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [string]$Context = "",
        [hashtable]$Data = @{},
        [string]$Function = "",
        [int]$Line = 0
    )
    
    # Check if we should log this level
    if ($script:LogLevels[$Level] -lt $script:LogLevels[$script:LoggerConfig.LogLevel]) {
        return
    }
    
    # Get timestamp
    $timestamp = Get-Date -Format $script:LoggerConfig.TimestampFormat
    
    # Get calling function if not provided
    if (-not $Function) {
        $callStack = Get-PSCallStack
        if ($callStack.Count -gt 1) {
            $Function = $callStack[1].FunctionName
        }
    }
    
    # Build log entry
    $logEntry = @{
        Timestamp = $timestamp
        Level = $Level
        Message = $Message
        Context = $Context
        Function = $Function
        Line = $Line
        Data = $Data
    }
    
    # Format log message
    $formattedMessage = Format-LogMessage -LogEntry $logEntry
    
    # Write to console with color
    Write-LogToConsole -Level $Level -Message $formattedMessage
    
    # Write to file
    Write-LogToFile -Message $formattedMessage
    
    # Rotate logs if needed
    Test-LogRotation
}

# Format log message
function Format-LogMessage {
    param([hashtable]$LogEntry)
    
    $parts = @(
        $LogEntry.Timestamp,
        "[$($LogEntry.Level)]",
        $LogEntry.Context,
        $LogEntry.Function,
        $LogEntry.Message
    )
    
    $message = $parts -join " "
    
    # Add data if present
    if ($LogEntry.Data.Count -gt 0) {
        $dataJson = $LogEntry.Data | ConvertTo-Json -Compress
        $message += " | Data: $dataJson"
    }
    
    return $message
}

# Write log to console with colors
function Write-LogToConsole {
    param(
        [string]$Level,
        [string]$Message
    )
    
    $color = switch ($Level) {
        "DEBUG" { "Gray" }
        "INFO" { "White" }
        "WARN" { "Yellow" }
        "ERROR" { "Red" }
        "FATAL" { "Red" }
        default { "White" }
    }
    
    Write-Host $Message -ForegroundColor $color
}

# Write log to file
function Write-LogToFile {
    param([string]$Message)
    
    try {
        $Message | Out-File -FilePath $script:LoggerConfig.LogFile -Append -Encoding UTF8
    } catch {
        Write-Host "Failed to write to log file: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Test and rotate logs if needed
function Test-LogRotation {
    if (-not (Test-Path $script:LoggerConfig.LogFile)) {
        return
    }
    
    $logFile = Get-Item $script:LoggerConfig.LogFile
    if ($logFile.Length -gt $script:LoggerConfig.MaxLogSize) {
        Rotate-LogFiles
    }
}

# Rotate log files
function Rotate-LogFiles {
    $logDir = Split-Path $script:LoggerConfig.LogFile -Parent
    $logName = Split-Path $script:LoggerConfig.LogFile -LeafBase
    $logExt = Split-Path $script:LoggerConfig.LogFile -Extension
    
    # Remove oldest log file if we have too many
    $existingLogs = Get-ChildItem -Path $logDir -Filter "$logName*$logExt" | Sort-Object LastWriteTime -Descending
    if ($existingLogs.Count -ge $script:LoggerConfig.MaxLogFiles) {
        $oldestLog = $existingLogs | Select-Object -Last 1
        Remove-Item $oldestLog.FullName -Force
    }
    
    # Rename current log file
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $newLogName = "$logName`_$timestamp$logExt"
    $newLogPath = Join-Path $logDir $newLogName
    
    if (Test-Path $script:LoggerConfig.LogFile) {
        Move-Item $script:LoggerConfig.LogFile $newLogPath
    }
    
    Write-Log "INFO" "Log file rotated: $newLogPath" -Context "Logger"
}

# Convenience functions for different log levels
function Write-DebugLog {
    param([string]$Message, [string]$Context = "", [hashtable]$Data = @{})
    Write-Log "DEBUG" $Message -Context $Context -Data $Data
}

function Write-InfoLog {
    param([string]$Message, [string]$Context = "", [hashtable]$Data = @{})
    Write-Log "INFO" $Message -Context $Context -Data $Data
}

function Write-WarnLog {
    param([string]$Message, [string]$Context = "", [hashtable]$Data = @{})
    Write-Log "WARN" $Message -Context $Context -Data $Data
}

function Write-ErrorLog {
    param([string]$Message, [string]$Context = "", [hashtable]$Data = @{})
    Write-Log "ERROR" $Message -Context $Context -Data $Data
}

function Write-FatalLog {
    param([string]$Message, [string]$Context = "", [hashtable]$Data = @{})
    Write-Log "FATAL" $Message -Context $Context -Data $Data
}

# Performance logging
function Write-PerformanceLog {
    param(
        [string]$Operation,
        [timespan]$Duration,
        [hashtable]$Metrics = @{},
        [string]$Context = "Performance"
    )
    
    $data = @{
        Operation = $Operation
        Duration = $Duration.TotalMilliseconds
        Metrics = $Metrics
    }
    
    Write-InfoLog "Performance: $Operation completed in $($Duration.TotalMilliseconds)ms" -Context $Context -Data $data
}

# Error logging with exception details
function Write-ExceptionLog {
    param(
        [System.Exception]$Exception,
        [string]$Context = "",
        [hashtable]$AdditionalData = @{}
    )
    
    $data = @{
        ExceptionType = $Exception.GetType().Name
        ExceptionMessage = $Exception.Message
        StackTrace = $Exception.StackTrace
        AdditionalData = $AdditionalData
    }
    
    Write-ErrorLog "Exception: $($Exception.Message)" -Context $Context -Data $data
}

# Get log statistics
function Get-LogStatistics {
    if (-not (Test-Path $script:LoggerConfig.LogFile)) {
        return @{ Error = "Log file not found" }
    }
    
    $logContent = Get-Content $script:LoggerConfig.LogFile
    $stats = @{
        TotalLines = $logContent.Count
        Levels = @{}
        Contexts = @{}
        RecentErrors = @()
    }
    
    foreach ($line in $logContent) {
        if ($line -match '\[(DEBUG|INFO|WARN|ERROR|FATAL)\]') {
            $level = $matches[1]
            $stats.Levels[$level] = ($stats.Levels[$level] + 1)
            
            if ($level -in @("ERROR", "FATAL")) {
                $stats.RecentErrors += $line
            }
        }
        
        if ($line -match '\[([^\]]+)\]') {
            $context = $matches[1]
            if ($context -notin @("DEBUG", "INFO", "WARN", "ERROR", "FATAL")) {
                $stats.Contexts[$context] = ($stats.Contexts[$context] + 1)
            }
        }
    }
    
    return $stats
}