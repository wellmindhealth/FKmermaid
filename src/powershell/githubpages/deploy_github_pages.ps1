# FKmermaid GitHub Pages Deployment Script
# Quick deployment for the ER Explorer interface

param(
    [Parameter(Mandatory=$false)]
    [switch]$DeployToGitHub,
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateLocalBuild,
    
    [Parameter(Mandatory=$false)]
    [switch]$OpenLocalBuild
)

# Import the integration module
$modulePath = Join-Path $PSScriptRoot "github_pages_integration.ps1"
if (Test-Path $modulePath) {
    . $modulePath
} else {
    Write-Host "❌ Integration module not found: $modulePath" -ForegroundColor Red
    exit 1
}

Write-Host "🚀 FKmermaid GitHub Pages Deployment" -ForegroundColor Magenta
Write-Host "=====================================" -ForegroundColor Magenta

# Set parameters - Fix paths to point to FKmermaid root
# Navigate from current directory (powershell/githubpages) to FKmermaid root
$fkRoot = (Join-Path (Get-Location) "..\..\..") | Resolve-Path
$params = @{
    DiagramSetPath = $fkRoot
    OutputPath = Join-Path $fkRoot "docs"
    RepositoryName = "FKmermaid"
    GitHubUsername = "wellmindhealth"
}

Write-Host "📁 FKmermaid Root: $fkRoot" -ForegroundColor Cyan
Write-Host "📁 Output Path: $($params.OutputPath)" -ForegroundColor Cyan

if ($DeployToGitHub) {
    $params.DeployToGitHub = $true
}

if ($CreateLocalBuild) {
    $params.CreateLocalBuild = $true
}

# Run deployment
try {
    $result = Start-GitHubPagesDeployment @params
    
    if ($result -and $OpenLocalBuild) {
        $docsPath = $params.OutputPath
        if (Test-Path $docsPath) {
            Write-Host "🌐 Opening local build..." -ForegroundColor Green
            Start-Process (Join-Path $docsPath "index.html")
        }
    }
    
} catch {
    Write-Host "❌ Deployment failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅ Deployment completed!" -ForegroundColor Green 