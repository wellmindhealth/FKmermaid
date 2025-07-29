# Debug Mermaid URL Encoding
# Test the URL encoding to see what's going wrong

# Import modules
. (Join-Path $PSScriptRoot "config_manager.ps1")
. (Join-Path $PSScriptRoot "relationship_visualizer.ps1")

Write-Host "🔍 Debugging Mermaid URL Encoding..." -ForegroundColor Cyan
Write-Host ""

# Create a simple test Mermaid content
$testMermaidContent = @"
graph TD
    A[Test Node] --> B[Another Node]
    B --> C[Final Node]
"@

Write-Host "📝 Original Mermaid Content:" -ForegroundColor Yellow
Write-Host $testMermaidContent -ForegroundColor Gray
Write-Host ""

# Test different encoding methods
Write-Host "🔧 Testing URL Encoding Methods:" -ForegroundColor Yellow

# Method 1: HttpUtility.UrlEncode
$encoded1 = [System.Web.HttpUtility]::UrlEncode($testMermaidContent)
Write-Host "Method 1 (HttpUtility.UrlEncode):" -ForegroundColor Cyan
Write-Host $encoded1 -ForegroundColor Gray
Write-Host ""

# Method 2: Uri.EscapeDataString
$encoded2 = [Uri]::EscapeDataString($testMermaidContent)
Write-Host "Method 2 (Uri.EscapeDataString):" -ForegroundColor Cyan
Write-Host $encoded2 -ForegroundColor Gray
Write-Host ""

# Method 3: Manual encoding for Mermaid
$encoded3 = $testMermaidContent -replace '\n', '%0A' -replace ' ', '%20' -replace '#', '%23' -replace '\[', '%5B' -replace '\]', '%5D'
Write-Host "Method 3 (Manual encoding):" -ForegroundColor Cyan
Write-Host $encoded3 -ForegroundColor Gray
Write-Host ""

# Test URLs
$url1 = "https://mermaid.live/edit#$encoded1"
$url2 = "https://mermaid.live/edit#$encoded2"
$url3 = "https://mermaid.live/edit#$encoded3"

Write-Host "🌐 Testing URLs:" -ForegroundColor Yellow
Write-Host "URL 1: $url1" -ForegroundColor Gray
Write-Host "URL 2: $url2" -ForegroundColor Gray
Write-Host "URL 3: $url3" -ForegroundColor Gray
Write-Host ""

# Test with a real relationship view
Write-Host "🧪 Testing with Real Relationship View:" -ForegroundColor Yellow

$testRelationships = @{
    directFK = @(
        @{ source = "partner"; target = "member" },
        @{ source = "member"; target = "programme" }
    )
    joinTables = @()
}

$testEntities = @("partner", "member", "programme")

$realMermaidContent = Generate-DependencyView -relationships $testRelationships -entities $testEntities

Write-Host "📝 Real Mermaid Content:" -ForegroundColor Yellow
Write-Host $realMermaidContent -ForegroundColor Gray
Write-Host ""

# Encode the real content
$realEncoded = [Uri]::EscapeDataString($realMermaidContent)
$realUrl = "https://mermaid.live/edit#$realEncoded"

Write-Host "🌐 Real URL:" -ForegroundColor Yellow
Write-Host $realUrl -ForegroundColor Gray
Write-Host ""

# Test opening the URL
Write-Host "🚀 Testing URL opening..." -ForegroundColor Yellow
try {
    Start-Process $realUrl
    Write-Host "✅ URL opened successfully" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to open URL: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "🔍 Debug completed. Check if the URL works now!" -ForegroundColor Cyan