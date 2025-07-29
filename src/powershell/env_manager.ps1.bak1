# FKmermaid Environment Manager
# Handles .env file loading and environment variable management

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Load-EnvironmentConfig {
    param(
        [string]$envFile = ".env"
    )
    
    $envPath = Join-Path (Get-ProjectPath -pathKey "projectRoot") $envFile
    
    if (-not (Test-Path $envPath)) {
        Write-Warning "Environment file not found: $envPath"
        Write-Host "Please copy config/env.template to .env and configure your settings" -ForegroundColor Yellow
        return $null
    }
    
    $envConfig = @{}
    
    try {
        $lines = Get-Content $envPath -ErrorAction Stop
        
        foreach ($line in $lines) {
            # Skip comments and empty lines
            if ($line -match '^\s*#' -or $line -match '^\s*$') {
                continue
            }
            
            # Parse key=value pairs
            if ($line -match '^([^=]+)=(.*)$') {
                $key = $matches[1].Trim()
                $value = $matches[2].Trim()
                
                # Remove quotes if present
                if ($value -match '^["''](.*)["'']$') {
                    $value = $matches[1]
                }
                
                $envConfig[$key] = $value
            }
        }
        
        Write-Host "Environment configuration loaded successfully" -ForegroundColor Green
        return $envConfig
    } catch {
        Write-Error "Failed to load environment configuration: $($_.Exception.Message)"
        return $null
    }
}

function Get-ConfluenceConfig {
    param(
        [object]$envConfig = $null
    )
    
    if (-not $envConfig) {
        $envConfig = Load-EnvironmentConfig
    }
    
    if (-not $envConfig) {
        return $null
    }
    
    $confluenceConfig = @{
        Enabled = $envConfig["CONFLUENCE_ENABLED"] -eq "true"
        BaseUrl = $envConfig["CONFLUENCE_BASE_URL"]
        Username = $envConfig["CONFLUENCE_USERNAME"]
        ApiToken = $envConfig["CONFLUENCE_API_TOKEN"]
        SpaceKey = $envConfig["CONFLUENCE_SPACE_KEY"]
        ParentPageId = $envConfig["CONFLUENCE_PARENT_PAGE_ID"]
        ApiVersion = if ($envConfig["CONFLUENCE_API_VERSION"]) { $envConfig["CONFLUENCE_API_VERSION"] } else { "2" }
        TimeoutSeconds = if ($envConfig["CONFLUENCE_TIMEOUT_SECONDS"]) { [int]$envConfig["CONFLUENCE_TIMEOUT_SECONDS"] } else { 30 }
        MaxRetries = if ($envConfig["CONFLUENCE_MAX_RETRIES"]) { [int]$envConfig["CONFLUENCE_MAX_RETRIES"] } else { 3 }
        PageTemplate = if ($envConfig["CONFLUENCE_PAGE_TEMPLATE"]) { $envConfig["CONFLUENCE_PAGE_TEMPLATE"] } else { "default" }
        AutoPublish = $envConfig["CONFLUENCE_AUTO_PUBLISH"] -eq "true"
        VersionComment = $envConfig["CONFLUENCE_VERSION_COMMENT"] -eq "true"
        SslVerify = $envConfig["CONFLUENCE_SSL_VERIFY"] -ne "false"
        ProxyUrl = $envConfig["CONFLUENCE_PROXY_URL"]
        ProxyUsername = $envConfig["CONFLUENCE_PROXY_USERNAME"]
        ProxyPassword = $envConfig["CONFLUENCE_PROXY_PASSWORD"]
    }
    
    return $confluenceConfig
}

function Test-ConfluenceConfig {
    param(
        [object]$confluenceConfig = $null
    )
    
    if (-not $confluenceConfig) {
        $confluenceConfig = Get-ConfluenceConfig
    }
    
    if (-not $confluenceConfig) {
        Write-Warning "No Confluence configuration available"
        return $false
    }
    
    $errors = @()
    
    # Check if Confluence is enabled
    if (-not $confluenceConfig.Enabled) {
        Write-Host "Confluence integration is disabled" -ForegroundColor Yellow
        return $false
    }
    
    # Check required fields
    if ([string]::IsNullOrWhiteSpace($confluenceConfig.BaseUrl)) {
        $errors += "CONFLUENCE_BASE_URL is required"
    }
    
    if ([string]::IsNullOrWhiteSpace($confluenceConfig.Username)) {
        $errors += "CONFLUENCE_USERNAME is required"
    }
    
    if ([string]::IsNullOrWhiteSpace($confluenceConfig.ApiToken)) {
        $errors += "CONFLUENCE_API_TOKEN is required"
    }
    
    if ([string]::IsNullOrWhiteSpace($confluenceConfig.SpaceKey)) {
        $errors += "CONFLUENCE_SPACE_KEY is required"
    }
    
    if ([string]::IsNullOrWhiteSpace($confluenceConfig.ParentPageId)) {
        $errors += "CONFLUENCE_PARENT_PAGE_ID is required"
    }
    
    if ($errors.Count -gt 0) {
        Write-Warning "Confluence configuration errors:"
        foreach ($errorMsg in $errors) {
            Write-Warning "  $errorMsg"
        }
        return $false
    }
    
    Write-Host "Confluence configuration is valid" -ForegroundColor Green
    return $true
}

function Initialize-EnvironmentManager {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Environment Manager initialized:" -ForegroundColor Green
    
    # Load environment configuration
    $envConfig = Load-EnvironmentConfig
    if ($envConfig) {
        Write-Host "  Environment file loaded" -ForegroundColor Cyan
    } else {
        Write-Host "  Environment file not found" -ForegroundColor Yellow
    }
    
    # Test Confluence configuration
    $confluenceConfig = Get-ConfluenceConfig -envConfig $envConfig
    if ($confluenceConfig) {
        $confluenceValid = Test-ConfluenceConfig -confluenceConfig $confluenceConfig
        Write-Host "  Confluence integration: $(if ($confluenceValid) { 'Ready' } else { 'Not configured' })" -ForegroundColor $(if ($confluenceValid) { 'Green' } else { 'Yellow' })
    }
}

function Create-EnvironmentTemplate {
    param(
        [string]$outputPath = ".env"
    )
    
    $templatePath = Join-Path (Get-ProjectPath -pathKey "config") "env.template"
    $fullOutputPath = Join-Path (Get-ProjectPath -pathKey "projectRoot") $outputPath
    
    if (Test-Path $templatePath) {
        try {
            Copy-Item -Path $templatePath -Destination $fullOutputPath -Force
            Write-Host "Environment template created at: $fullOutputPath" -ForegroundColor Green
            Write-Host "Please edit the file and configure your Confluence settings" -ForegroundColor Yellow
            return $true
        } catch {
            Write-Error "Failed to create environment template: $($_.Exception.Message)"
            return $false
        }
    } else {
        Write-Error "Environment template not found at: $templatePath"
        return $false
    }
}

function Get-EnvironmentVariable {
    param(
        [string]$name,
        [string]$defaultValue = ""
    )
    
    $envConfig = Load-EnvironmentConfig
    if ($envConfig -and $envConfig.ContainsKey($name)) {
        return $envConfig[$name]
    }
    
    return $defaultValue
}

function Set-EnvironmentVariable {
    param(
        [string]$name,
        [string]$value,
        [string]$envFile = ".env"
    )
    
    $envPath = Join-Path (Get-ProjectPath -pathKey "projectRoot") $envFile
    
    if (-not (Test-Path $envPath)) {
        Write-Warning "Environment file not found, creating template..."
        Create-EnvironmentTemplate -outputPath $envFile
    }
    
    try {
        $content = Get-Content $envPath
        $updated = $false
        
        for ($i = 0; $i -lt $content.Count; $i++) {
            if ($content[$i] -match "^$name=") {
                $content[$i] = "$name=$value"
                $updated = $true
                break
            }
        }
        
        if (-not $updated) {
            $content += "$name=$value"
        }
        
        Set-Content -Path $envPath -Value $content
        Write-Host "Environment variable '$name' updated" -ForegroundColor Green
        return $true
    } catch {
        Write-Error "Failed to update environment variable: $($_.Exception.Message)"
        return $false
    }
}

# Initialize environment manager when module is loaded
Initialize-EnvironmentManager

# Test environment manager if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Environment Manager..." -ForegroundColor Cyan
    
    # Test environment loading
    $envConfig = Load-EnvironmentConfig
    if ($envConfig) {
        Write-Host "✅ Environment configuration loaded" -ForegroundColor Green
        Write-Host "Found $($envConfig.Count) environment variables" -ForegroundColor Cyan
    } else {
        Write-Host "❌ Environment configuration not found" -ForegroundColor Red
    }
    
    # Test Confluence configuration
    $confluenceConfig = Get-ConfluenceConfig -envConfig $envConfig
    if ($confluenceConfig) {
        $confluenceValid = Test-ConfluenceConfig -confluenceConfig $confluenceConfig
        Write-Host "Confluence configuration: $(if ($confluenceValid) { 'Valid' } else { 'Invalid' })" -ForegroundColor $(if ($confluenceValid) { 'Green' } else { 'Red' })
    } else {
        Write-Host "No Confluence configuration available" -ForegroundColor Yellow
    }
}