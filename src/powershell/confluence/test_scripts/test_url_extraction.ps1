Write-Host "🔍 Testing URL Extraction" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

# Run a single diagram generation
$erScriptPath = Join-Path $PSScriptRoot "generate_erd_enhanced.ps1"
$tempOutput = Join-Path $PSScriptRoot "..\..\exports\pre_generated\test_url_extraction.txt"

$params = @{
    lFocus = "partner"
    lDomains = "partner"
    DiagramType = "ER"
    NoBrowser = $true
}

Write-Host "Running generate_erd_enhanced.ps1..." -ForegroundColor Yellow

# Run with output redirection
& $erScriptPath @params *>&1 | Out-File -FilePath $tempOutput

Write-Host "`n📋 Output file contents:" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

# Read and display the output
$output = Get-Content $tempOutput -Raw
Write-Host $output

Write-Host "`n🔍 Looking for URL pattern:" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

# Try different approaches
$patterns = @(
    "🔗 Mermaid\.live URL:",
    "https://mermaid\.live",
    "Mermaid\.live URL:"
)

foreach ($pattern in $patterns) {
    $matches = $output -split "`n" | Where-Object { $_ -match $pattern }
    if ($matches) {
        Write-Host "✅ Pattern '$pattern' found:" -ForegroundColor Green
        $matches | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
    } else {
        Write-Host "❌ Pattern '$pattern' NOT found" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Testing regex extraction:" -ForegroundColor Green
Write-Host "============================" -ForegroundColor Green

# Test the regex
if ($output -match "🔗 Mermaid\.live URL: (https://mermaid\.live/[^\s]+)") {
    Write-Host "✅ Regex match found: $($matches[1])" -ForegroundColor Green
} else {
    Write-Host "❌ Regex match failed" -ForegroundColor Red
}

# Clean up
if (Test-Path $tempOutput) {
    Remove-Item $tempOutput
} 