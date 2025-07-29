# FKmermaid Performance Manager
# Handles caching, memory optimization, and parallel processing

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-PerformanceManager {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    # Set performance settings
    $script:CacheTTL = Get-PerformanceSetting -settingKey "cacheTTL" -config $config
    $script:MaxFileAge = Get-PerformanceSetting -settingKey "maxFileAge" -config $config
    $script:ParallelProcessing = Get-PerformanceSetting -settingKey "parallelProcessing" -config $config
    $script:MemoryLimit = Get-PerformanceSetting -settingKey "memoryLimit" -config $config
    
    Write-Host "Performance Manager initialized:" -ForegroundColor Green
    Write-Host "  Cache TTL: $CacheTTL hours" -ForegroundColor Cyan
    Write-Host "  Max File Age: $MaxFileAge hours" -ForegroundColor Cyan
    Write-Host "  Parallel Processing: $ParallelProcessing" -ForegroundColor Cyan
    Write-Host "  Memory Limit: $MemoryLimit" -ForegroundColor Cyan
}

function Test-CacheValidity {
    param(
        [string]$cacheFile,
        [int]$ttlHours = 168
    )
    
    if (-not (Test-Path $cacheFile)) {
        return $false
    }
    
    $fileInfo = Get-Item $cacheFile
    $ageHours = (Get-Date) - $fileInfo.LastWriteTime | ForEach-Object { $_.TotalHours }
    
    return $ageHours -lt $ttlHours
}

function Optimize-MemoryUsage {
    param(
        [int]$targetMemoryMB = 2048
    )
    
    $currentMemory = [System.GC]::GetTotalMemory($false) / 1MB
    Write-Host "Current memory usage: $([math]::Round($currentMemory, 2)) MB" -ForegroundColor Yellow
    
    if ($currentMemory -gt $targetMemoryMB) {
        Write-Host "Memory usage high, forcing garbage collection..." -ForegroundColor Yellow
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        [System.GC]::Collect()
        
        $newMemory = [System.GC]::GetTotalMemory($false) / 1MB
        Write-Host "Memory after cleanup: $([math]::Round($newMemory, 2)) MB" -ForegroundColor Green
    }
}

function Invoke-ParallelProcessing {
    param(
        [scriptblock]$scriptBlock,
        [array]$items,
        [int]$maxThreads = 4
    )
    
    if (-not $script:ParallelProcessing) {
        Write-Host "Parallel processing disabled, using sequential processing" -ForegroundColor Yellow
        return $items | ForEach-Object { & $scriptBlock $_ }
    }
    
    Write-Host "Processing $($items.Count) items with parallel processing (max $maxThreads threads)" -ForegroundColor Green
    
    $results = @()
    $jobs = @()
    
    foreach ($item in $items) {
        # Limit concurrent jobs
        while ((Get-Job -State Running).Count -ge $maxThreads) {
            Start-Sleep -Milliseconds 100
        }
        
        $job = Start-Job -ScriptBlock $scriptBlock -ArgumentList $item
        $jobs += $job
    }
    
    # Wait for all jobs to complete
    Wait-Job -Job $jobs | Out-Null
    
    # Collect results
    foreach ($job in $jobs) {
        $result = Receive-Job -Job $job
        $results += $result
        Remove-Job -Job $job
    }
    
    return $results
}

function Get-IncrementalChanges {
    param(
        [string]$basePath,
        [datetime]$since
    )
    
    $changedFiles = @()
    
    try {
        $files = Get-ChildItem -Path $basePath -Filter "*.cfc" -Recurse -File
        $changedFiles = $files | Where-Object { $_.LastWriteTime -gt $since }
        
        Write-Host "Found $($changedFiles.Count) changed files since $since" -ForegroundColor Green
    } catch {
        Write-Error "Failed to get incremental changes: $($_.Exception.Message)"
    }
    
    return $changedFiles
}

function Optimize-CacheStorage {
    param(
        [string]$cacheDir,
        [int]$maxAgeHours = 168
    )
    
    try {
        $cacheFiles = Get-ChildItem -Path $cacheDir -Filter "*.json" -File
        $cutoffTime = (Get-Date).AddHours(-$maxAgeHours)
        
        $oldFiles = $cacheFiles | Where-Object { $_.LastWriteTime -lt $cutoffTime }
        
        if ($oldFiles.Count -gt 0) {
            Write-Host "Cleaning up $($oldFiles.Count) old cache files..." -ForegroundColor Yellow
            
            foreach ($file in $oldFiles) {
                Remove-Item $file.FullName -Force
                Write-Host "Removed: $($file.Name)" -ForegroundColor Gray
            }
            
            Write-Host "Cache cleanup completed" -ForegroundColor Green
        } else {
            Write-Host "No old cache files to clean up" -ForegroundColor Green
        }
    } catch {
        Write-Error "Failed to optimize cache storage: $($_.Exception.Message)"
    }
}

function Measure-Performance {
    param(
        [string]$operation,
        [scriptblock]$scriptBlock
    )
    
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    $initialMemory = [System.GC]::GetTotalMemory($false) / 1MB
    
    try {
        $result = & $scriptBlock
        $stopwatch.Stop()
        
        $finalMemory = [System.GC]::GetTotalMemory($false) / 1MB
        $memoryUsed = $finalMemory - $initialMemory
        
        Write-Host "Performance measurement for '$operation':" -ForegroundColor Cyan
        Write-Host "  Duration: $($stopwatch.Elapsed.TotalSeconds.ToString('F2')) seconds" -ForegroundColor White
        Write-Host "  Memory used: $([math]::Round($memoryUsed, 2)) MB" -ForegroundColor White
        
        return @{
            Operation = $operation
            Duration = $stopwatch.Elapsed
            MemoryUsed = $memoryUsed
            Result = $result
        }
    } catch {
        $stopwatch.Stop()
        Write-Error "Performance measurement failed for '$operation': $($_.Exception.Message)"
        return $null
    }
}

function Get-SystemResources {
    $cpu = Get-Counter "\Processor(_Total)\% Processor Time" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
    $memory = Get-Counter "\Memory\Available MBytes" | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
    
    return @{
        CPUUsage = [math]::Round($cpu, 2)
        AvailableMemory = [math]::Round($memory, 2)
        Timestamp = Get-Date
    }
}

function Test-PerformanceThresholds {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $resources = Get-SystemResources
    $warnings = @()
    
    # Check CPU usage
    if ($resources.CPUUsage -gt 80) {
        $warnings += "High CPU usage: $($resources.CPUUsage)%"
    }
    
    # Check available memory
    if ($resources.AvailableMemory -lt 1024) {
        $warnings += "Low available memory: $($resources.AvailableMemory) MB"
    }
    
    if ($warnings.Count -gt 0) {
        Write-Warning "Performance warnings detected:"
        foreach ($warning in $warnings) {
            Write-Warning "  $warning"
        }
        return $false
    } else {
        Write-Host "System resources are within acceptable limits" -ForegroundColor Green
        return $true
    }
}

# Initialize performance manager when module is loaded
Initialize-PerformanceManager

# Export functions for use in other modules
Export-ModuleMember -Function @(
    'Initialize-PerformanceManager',
    'Test-CacheValidity',
    'Optimize-MemoryUsage',
    'Invoke-ParallelProcessing',
    'Get-IncrementalChanges',
    'Optimize-CacheStorage',
    'Measure-Performance',
    'Get-SystemResources',
    'Test-PerformanceThresholds'
)