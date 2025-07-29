# FKmermaid Configuration Manager
# Handles centralized configuration management and path resolution

function Get-ProjectConfig {
    param(
        [string]$configPath = ""
    )
    
    # Determine config path
    if (-not $configPath) {
        $scriptDir = Split-Path $PSScriptRoot -Parent
        $configPath = Join-Path $scriptDir "config\project_config.json"
        
        # If not found, try relative to current directory
        if (-not (Test-Path $configPath)) {
            $currentDir = Get-Location
            $configPath = Join-Path $currentDir "config\project_config.json"
        }
    }
    
    # Load configuration
    try {
        if (Test-Path $configPath) {
            $config = Get-Content $configPath -Raw | ConvertFrom-Json
            return $config
        } else {
            Write-Warning "Project config not found at: $configPath"
            return $null
        }
    } catch {
        Write-Error "Failed to load project config: $($_.Exception.Message)"
        return $null
    }
}

function Get-ProjectPath {
    param(
        [string]$pathKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.paths.$pathKey) {
        return $config.paths.$pathKey
    } else {
        Write-Warning "Path key '$pathKey' not found in config"
        return $null
    }
}

function Get-ConfigFile {
    param(
        [string]$fileKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.files.$fileKey) {
        $configPath = Get-ProjectPath -pathKey "config" -config $config
        return Join-Path $configPath $config.files.$fileKey
    } else {
        Write-Warning "File key '$fileKey' not found in config"
        return $null
    }
}

function Get-PerformanceSetting {
    param(
        [string]$settingKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.performance.$settingKey) {
        return $config.performance.$settingKey
    } else {
        Write-Warning "Performance setting '$settingKey' not found in config"
        return $null
    }
}

function Get-ExportSetting {
    param(
        [string]$settingKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.export.$settingKey) {
        return $config.export.$settingKey
    } else {
        Write-Warning "Export setting '$settingKey' not found in config"
        return $null
    }
}

function Get-ConfluenceSetting {
    param(
        [string]$settingKey,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config -and $config.confluence.$settingKey) {
        return $config.confluence.$settingKey
    } else {
        Write-Warning "Confluence setting '$settingKey' not found in config"
        return $null
    }
}

function Set-ProjectPath {
    param(
        [string]$pathKey,
        [string]$newPath,
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    if ($config) {
        $configPath = Get-ProjectPath -pathKey "config" -config $config
        $projectConfigFile = Join-Path $configPath "project_config.json"
        
        $config.paths.$pathKey = $newPath
        
        try {
            $config | ConvertTo-Json -Depth 10 | Set-Content $projectConfigFile
            Write-Host "Updated path '$pathKey' to: $newPath" -ForegroundColor Green
            return $true
        } catch {
            Write-Error "Failed to update project config: $($_.Exception.Message)"
            return $false
        }
    }
    
    return $false
}

function Initialize-ProjectPaths {
    param(
        [string]$basePath = ""
    )
    
    if (-not $basePath) {
        $basePath = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
    }
    
    $config = Get-ProjectConfig
    
    if ($config) {
        # Update all paths to be relative to base path
        $paths = @{
            "projectRoot" = $basePath
            "config" = Join-Path $basePath "config"
            "exports" = Join-Path $basePath "exports"
            "src" = Join-Path $basePath "src"
            "tests" = Join-Path $basePath "tests"
            "styles" = Join-Path $basePath "styles"
            "results" = Join-Path $basePath "tests\results"
        }
        
        foreach ($pathKey in $paths.Keys) {
            Set-ProjectPath -pathKey $pathKey -newPath $paths[$pathKey] -config $config
        }
        
        Write-Host "Project paths initialized with base path: $basePath" -ForegroundColor Green
        return $true
    }
    
    return $false
}

function Test-ProjectStructure {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $missingPaths = @()
    
    foreach ($pathKey in $config.paths.PSObject.Properties.Name) {
        $path = $config.paths.$pathKey
        if (-not (Test-Path $path)) {
            $missingPaths += @{
                Key = $pathKey
                Path = $path
            }
        }
    }
    
    if ($missingPaths.Count -gt 0) {
        Write-Warning "Missing project paths:"
        foreach ($missing in $missingPaths) {
            Write-Warning "  $($missing.Key): $($missing.Path)"
        }
        return $false
    } else {
        Write-Host "All project paths exist" -ForegroundColor Green
        return $true
    }
}

# Test the configuration if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Configuration Manager..." -ForegroundColor Cyan
    
    $config = Get-ProjectConfig
    if ($config) {
        Write-Host "✅ Configuration loaded successfully" -ForegroundColor Green
        Write-Host "Project: $($config.project.name) v$($config.project.version)" -ForegroundColor Cyan
        
        $projectRoot = Get-ProjectPath -pathKey "projectRoot" -config $config
        Write-Host "Project Root: $projectRoot" -ForegroundColor Yellow
        
        $testResult = Test-ProjectStructure -config $config
        if ($testResult) {
            Write-Host "✅ Project structure is valid" -ForegroundColor Green
        } else {
            Write-Host "❌ Project structure has issues" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to load configuration" -ForegroundColor Red
    }
}