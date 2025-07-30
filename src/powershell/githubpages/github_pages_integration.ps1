# GitHub Pages Integration Module
# Handles automated deployment of FKmermaid ER Explorer to GitHub Pages

param(
    [Parameter(Mandatory=$false)]
    [string]$DiagramSetPath = ".",
    
    [Parameter(Mandatory=$false)]
    [string]$OutputPath = ".\docs",
    
    [Parameter(Mandatory=$false)]
    [switch]$DeployToGitHub,
    
    [Parameter(Mandatory=$false)]
    [switch]$CreateLocalBuild,
    
    [Parameter(Mandatory=$false)]
    [string]$RepositoryName = "FKmermaid",
    
    [Parameter(Mandatory=$false)]
    [string]$GitHubUsername = "wellmindhealth"
)

# Load environment variables
function Load-EnvironmentVariables {
    $envPath = Join-Path $PSScriptRoot "..\..\..\.env"
    if (Test-Path $envPath) {
        Get-Content $envPath | ForEach-Object {
            if ($_ -match "^([^=]+)=(.*)$") {
                [Environment]::SetEnvironmentVariable($matches[1], $matches[2], "Process")
            }
        }
        Write-Host "✅ Environment variables loaded" -ForegroundColor Green
    } else {
        Write-Host "⚠️  .env file not found at: $envPath" -ForegroundColor Yellow
    }
}

# Create GitHub Pages build directory
function New-GitHubPagesBuild {
    param([string]$SourcePath, [string]$OutputPath)
    
    Write-Host "🔨 Creating GitHub Pages build..." -ForegroundColor Blue
    
    # Create docs directory (GitHub Pages standard)
    if (!(Test-Path $OutputPath)) {
        New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
    }
    
    # Copy main interface
    $interfaceFile = Join-Path $SourcePath "index.html"
    Write-Host "🔍 Looking for interface file: $interfaceFile" -ForegroundColor Cyan
    Write-Host "📁 Source path: $SourcePath" -ForegroundColor Cyan
    if (Test-Path $interfaceFile) {
        Copy-Item $interfaceFile $OutputPath -Force
        Write-Host "✅ Copied interface to: $OutputPath\index.html" -ForegroundColor Green
    } else {
        Write-Host "❌ Interface file not found: $interfaceFile" -ForegroundColor Red
        Write-Host "📁 Source path exists: $(Test-Path $SourcePath)" -ForegroundColor Yellow
        Write-Host "📁 Files in source: $(Get-ChildItem $SourcePath -Name | Select-Object -First 5)" -ForegroundColor Yellow
        return $false
    }
    
    # Copy any generated diagrams
    $diagramFiles = Get-ChildItem -Path $SourcePath -Filter "*.mmd" -Recurse
    if ($diagramFiles) {
        $diagramsDir = Join-Path $OutputPath "diagrams"
        if (!(Test-Path $diagramsDir)) {
            New-Item -ItemType Directory -Path $diagramsDir -Force | Out-Null
        }
        
        foreach ($file in $diagramFiles) {
            Copy-Item $file.FullName $diagramsDir -Force
        }
        Write-Host "✅ Copied $($diagramFiles.Count) diagram files" -ForegroundColor Green
    }
    
    # Create GitHub Pages configuration
    $configContent = @"
# GitHub Pages Configuration
# This file enables GitHub Pages for this repository

# Site settings
title: FKmermaid ER Explorer
description: Interactive Entity Relationship Explorer for Wellmind Health
baseurl: "/$RepositoryName"
url: "https://$GitHubUsername.github.io"

# Build settings
markdown: kramdown
highlighter: rouge
relative_links:
  enabled: true
  collections: true

# Exclude from processing
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor/bundle/
  - vendor/cache/
  - vendor/gems/
  - vendor/ruby/
"@
    
    $configFile = Join-Path $OutputPath "_config.yml"
    $configContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "✅ Created GitHub Pages config: $configFile" -ForegroundColor Green
    
    return $true
}

# Deploy to GitHub Pages
function Deploy-ToGitHubPages {
    param([string]$BuildPath, [string]$RepositoryName, [string]$GitHubUsername)
    
    Write-Host "🚀 Deploying to GitHub Pages..." -ForegroundColor Blue
    
    # Check if we're in a git repository
    if (!(Test-Path ".git")) {
        Write-Host "❌ Not in a git repository" -ForegroundColor Red
        return $false
    }
    
    # Check if we have a remote origin
    $remoteUrl = git remote get-url origin 2>$null
    if (!$remoteUrl) {
        Write-Host "❌ No remote origin found" -ForegroundColor Red
        return $false
    }
    
    Write-Host "📡 Remote URL: $remoteUrl" -ForegroundColor Cyan
    
    # Create gh-pages branch or use docs folder
    $currentBranch = git branch --show-current
    
    if ($currentBranch -eq "master" -or $currentBranch -eq "main") {
        Write-Host "✅ On main branch, using docs folder for GitHub Pages" -ForegroundColor Green
        
        # Add all files to git
        git add .
        git commit -m "Update GitHub Pages build - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" 2>$null
        
        # Push to remote
        git push origin $currentBranch
        Write-Host "✅ Pushed to GitHub" -ForegroundColor Green
        
        # Instructions for enabling GitHub Pages
        Write-Host ""
        Write-Host "🎯 Next Steps:" -ForegroundColor Yellow
        Write-Host "1. Go to: https://github.com/$GitHubUsername/$RepositoryName/settings/pages" -ForegroundColor Cyan
        Write-Host "2. Under 'Source', select 'Deploy from a branch'" -ForegroundColor Cyan
        Write-Host "3. Choose '$currentBranch' branch and '/docs' folder" -ForegroundColor Cyan
        Write-Host "4. Click 'Save'" -ForegroundColor Cyan
        Write-Host "5. Your site will be at: https://$GitHubUsername.github.io/$RepositoryName/" -ForegroundColor Cyan
        Write-Host ""
        
    } else {
        Write-Host "⚠️  Not on main branch, creating gh-pages branch..." -ForegroundColor Yellow
        
        # Create gh-pages branch
        git checkout -b gh-pages 2>$null
        git add .
        git commit -m "Update GitHub Pages build - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        git push origin gh-pages
        
        # Switch back to original branch
        git checkout $currentBranch
        
        Write-Host "✅ Created gh-pages branch" -ForegroundColor Green
        Write-Host "🎯 Enable GitHub Pages with gh-pages branch in repository settings" -ForegroundColor Yellow
    }
    
    return $true
}

# Create alternative hosting options
function New-AlternativeHosting {
    param([string]$BuildPath)
    
    Write-Host "🌐 Creating alternative hosting options..." -ForegroundColor Blue
    
    # Netlify deployment
    $netlifyFile = Join-Path $BuildPath "_redirects"
    @"
/*    /index.html   200
"@ | Out-File -FilePath $netlifyFile -Encoding UTF8
    Write-Host "✅ Created Netlify redirects" -ForegroundColor Green
    
    # Vercel deployment
    $vercelFile = Join-Path $BuildPath "vercel.json"
    @"
{
  "version": 2,
  "builds": [
    {
      "src": "**/*",
      "use": "@vercel/static"
    }
  ]
}
"@ | Out-File -FilePath $vercelFile -Encoding UTF8
    Write-Host "✅ Created Vercel config" -ForegroundColor Green
    
    # Instructions
    Write-Host ""
    Write-Host "🌐 Alternative Hosting Options:" -ForegroundColor Yellow
    Write-Host "• Netlify: Drag $BuildPath folder to https://app.netlify.com/" -ForegroundColor Cyan
    Write-Host "• Vercel: Install Vercel CLI and run 'vercel' in $BuildPath" -ForegroundColor Cyan
    Write-Host "• AWS S3: Upload $BuildPath contents to S3 bucket with static hosting" -ForegroundColor Cyan
    Write-Host ""
}

# Main execution
function Start-GitHubPagesDeployment {
    Load-EnvironmentVariables
    
    Write-Host "🔍 FKmermaid GitHub Pages Deployment" -ForegroundColor Magenta
    Write-Host "=====================================" -ForegroundColor Magenta
    
    # Create build
    $buildSuccess = New-GitHubPagesBuild -SourcePath $DiagramSetPath -OutputPath $OutputPath
    
    if ($buildSuccess) {
        Write-Host "✅ Build created successfully" -ForegroundColor Green
        
        if ($DeployToGitHub) {
            Deploy-ToGitHubPages -BuildPath $OutputPath -RepositoryName $RepositoryName -GitHubUsername $GitHubUsername
        }
        
        if ($CreateLocalBuild) {
            Write-Host "📁 Local build available at: $OutputPath" -ForegroundColor Green
            Start-Process $OutputPath
        }
        
        New-AlternativeHosting -BuildPath $OutputPath
        
    } else {
        Write-Host "❌ Build failed" -ForegroundColor Red
        return $false
    }
    
    return $true
}

# Auto-execute if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Start-GitHubPagesDeployment
} 