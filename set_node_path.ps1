<#
.SYNOPSIS
    Set NODE_PATH environment variable for FKmermaid project
    
.DESCRIPTION
    This script sets the NODE_PATH environment variable to point to the moved
    node_modules folder at d:/farcry/node_modules so that npx can find the
    Mermaid CLI and other dependencies.
    
.EXAMPLE
    .\set_node_path.ps1
#>

Write-Host "🔧 Setting NODE_PATH for FKmermaid project..." -ForegroundColor Cyan

# Set the NODE_PATH environment variable for the current session
$nodeModulesPath = "D:/GIT/farcry/node_modules"
$env:NODE_PATH = $nodeModulesPath

Write-Host "✅ NODE_PATH set to: $env:NODE_PATH" -ForegroundColor Green

# Verify the path exists
if (Test-Path $nodeModulesPath) {
    Write-Host "✅ Node modules directory exists at: $nodeModulesPath" -ForegroundColor Green
    
    # Check if mermaid-cli is available
    $mermaidCliPath = Join-Path $nodeModulesPath ".bin\mmdc.cmd"
    if (Test-Path $mermaidCliPath) {
        Write-Host "✅ Mermaid CLI found at: $mermaidCliPath" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Mermaid CLI not found at expected location" -ForegroundColor Yellow
        Write-Host "   Expected: $mermaidCliPath" -ForegroundColor Gray
    }
} else {
    Write-Host "❌ Node modules directory not found at: $nodeModulesPath" -ForegroundColor Red
    Write-Host "   Please ensure the node_modules folder has been moved to the correct location" -ForegroundColor Yellow
}

Write-Host "`n💡 To make this permanent, add to your PowerShell profile:" -ForegroundColor Yellow
Write-Host "   `$env:NODE_PATH = 'd:/farcry/node_modules'" -ForegroundColor White

Write-Host "`n🚀 You can now run npx commands that will use the moved node_modules!" -ForegroundColor Green
