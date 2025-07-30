Write-Host "🔍 Debugging Output Capture" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan

# Call generate_erd_enhanced.ps1 and capture output
$erScriptPath = Join-Path $PSScriptRoot "generate_erd_enhanced.ps1"

$params = @{
    lFocus = "partner"
    lDomains = "partner"
    DiagramType = "ER"
    NoBrowser = $true
}

Write-Host "Running generate_erd_enhanced.ps1 with output redirection..." -ForegroundColor Yellow

# Create temp file for output
$tempFile = Join-Path $PSScriptRoot "..\..\exports\pre_generated\debug_output.txt"

# Run with output redirection
& $erScriptPath @params *>&1 | Out-File -FilePath $tempFile

# Read the captured output
$output = Get-Content $tempFile

Write-Host "`n📋 Captured Output:" -ForegroundColor Green
Write-Host "==================" -ForegroundColor Green
$output | ForEach-Object { Write-Host $_ }

Write-Host "`n🔍 Looking for Mermaid URLs:" -ForegroundColor Green
Write-Host "============================" -ForegroundColor Green

# Try different patterns
$patterns = @(
    "🔗 Mermaid\.live URL:",
    "https://mermaid\.live",
    "Mermaid\.live URL:",
    "🔗"
)

foreach ($pattern in $patterns) {
    $matches = $output | Where-Object { $_ -match $pattern }
    if ($matches) {
        Write-Host "✅ Pattern '$pattern' found:" -ForegroundColor Green
        $matches | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
    } else {
        Write-Host "❌ Pattern '$pattern' NOT found" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Testing URL extraction:" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

$mermaidUrl = $output | Where-Object { $_ -match "🔗 Mermaid\.live URL:" } | Select-Object -First 1

if ($mermaidUrl) {
    Write-Host "✅ Found URL line: $mermaidUrl" -ForegroundColor Green
    $cleanUrl = $mermaidUrl -replace "🔗 Mermaid\.live URL: ", ""
    Write-Host "✅ Clean URL: $cleanUrl" -ForegroundColor Green
} else {
    Write-Host "❌ No URL found with current pattern" -ForegroundColor Red
}

# Clean up
if (Test-Path $tempFile) {
    Remove-Item $tempFile
} 