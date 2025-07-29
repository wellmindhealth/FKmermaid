# FKmermaid Logging Integration
# Provides easy access to logging functionality for other modules

# Import the logger module
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
if (Test-Path $loggerPath) {
    . $loggerPath
} else {
    Write-Host "Warning: Logger module not found at $loggerPath" -ForegroundColor Yellow
}

# Load logging configuration
function Load-LoggingConfig {
    $configPath = "D:\GIT\farcry\Cursor\FKmermaid\config\logging.json"
    
    if (Test-Path $configPath) {
        try {
            $config = Get-Content $configPath | ConvertFrom-Json
            return $config.logging
        } catch {
            Write-Host "Error loading logging config: $($_.Exception.Message)" -ForegroundColor Red
            return $null
        }
    } else {
        Write-Host "Warning: Logging config not found at $configPath" -ForegroundColor Yellow
        return $null
    }
}

# Initialize logging for a module
function Initialize-ModuleLogging {
    param(
        [string]$ModuleName,
        [string]$LogLevel = "INFO",
        [switch]$Debug
    )
    
    $config = Load-LoggingConfig
    
    if ($config) {
        # Get module-specific log level
        $moduleLevel = if ($config.contexts.$ModuleName) { $config.contexts.$ModuleName } else { $LogLevel }
        
        # Initialize logger
        Initialize-Logger -LogLevel $moduleLevel -Debug:$Debug
        
        Write-InfoLog "Module logging initialized: $ModuleName" -Context "Logging"
    } else {
        # Fallback initialization
        Initialize-Logger -LogLevel $LogLevel -Debug:$Debug
        Write-InfoLog "Module logging initialized (fallback): $ModuleName" -Context "Logging"
    }
}

# Performance monitoring wrapper
function Invoke-WithPerformanceLogging {
    param(
        [Parameter(Mandatory=$true)]
        [scriptblock]$ScriptBlock,
        
        [string]$Operation,
        [string]$Context = "Performance",
        [hashtable]$Metrics = @{}
    )
    
    $startTime = Get-Date
    $result = $null
    $exception = $null
    
    try {
        $result = & $ScriptBlock
        $duration = (Get-Date) - $startTime
        
        Write-PerformanceLog -Operation $Operation -Duration $duration -Metrics $Metrics -Context $Context
        
        return $result
    } catch {
        $exception = $_
        $duration = (Get-Date) - $startTime
        
        Write-ErrorLog "Performance operation failed: $Operation" -Context $Context -Data @{
            Duration = $duration.TotalMilliseconds
            Exception = $exception.Message
            Metrics = $Metrics
        }
        
        throw $exception
    }
}

# Error handling wrapper
function Invoke-WithErrorLogging {
    param(
        [Parameter(Mandatory=$true)]
        [scriptblock]$ScriptBlock,
        
        [string]$Context = "ErrorHandling",
        [hashtable]$AdditionalData = @{}
    )
    
    try {
        $result = & $ScriptBlock
        return $result
    } catch {
        Write-ExceptionLog -Exception $_.Exception -Context $Context -AdditionalData $AdditionalData
        throw
    }
}

# Log function entry and exit
function Invoke-WithFunctionLogging {
    param(
        [Parameter(Mandatory=$true)]
        [scriptblock]$ScriptBlock,
        
        [string]$FunctionName,
        [string]$Context = "Function",
        [hashtable]$Parameters = @{}
    )
    
    Write-DebugLog "Function entered: $FunctionName" -Context $Context -Data $Parameters
    
    try {
        $result = & $ScriptBlock
        Write-DebugLog "Function completed: $FunctionName" -Context $Context
        return $result
    } catch {
        Write-ErrorLog "Function failed: $FunctionName" -Context $Context -Data @{
            Exception = $_.Exception.Message
            Parameters = $Parameters
        }
        throw
    }
}