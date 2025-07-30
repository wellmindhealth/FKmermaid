<#
.SYNOPSIS
    Test PNG generation from a few .mmd files
    
.DESCRIPTION
    Tests the PNG generation process with just a few files to verify it works
    before running the full 165 diagrams.
    
.EXAMPLE
    .\test_png_generation.ps1
#>

Write-Host "🧪 Testing PNG Generation" -ForegroundColor Cyan
Write-Host "=======================" -ForegroundColor Cyan

# Create PNG output directory
$pngOutputDir = Join-Path $PSScriptRoot "..\..\exports\pre_generated\png_previews"
if (-not (Test-Path $pngOutputDir)) {
    New-Item -ItemType Directory -Path $pngOutputDir -Force | Out-Null
    Write-Host "📁 Created PNG output directory: $pngOutputDir" -ForegroundColor Green
}

# Get just the 3 most recent .mmd files for testing
$mmdFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot "..\..\exports") -Filter "*.mmd" | Sort-Object LastWriteTime -Descending | Select-Object -First 3

Write-Host "`n📊 Testing with $($mmdFiles.Count) .mmd files" -ForegroundColor Yellow

$successCount = 0
$failedCount = 0

foreach ($mmdFile in $mmdFiles) {
    $pngFileName = [System.IO.Path]::GetFileNameWithoutExtension($mmdFile.Name) + ".png"
    $pngFilePath = Join-Path $pngOutputDir $pngFileName
    
    Write-Host "`n🔄 Converting: $($mmdFile.Name) → $pngFileName" -ForegroundColor Blue
    
    try {
        # Use local Mermaid CLI via npx to convert .mmd to PNG
        $mmdcArgs = @(
            "mmdc",
            "-i", $mmdFile.FullName,
            "-o", $pngFilePath,
            "-b", "transparent",
            "-s", "3.0",
            "-w", "2000"
        )
        
        # Run from the FKmermaid root directory where package.json is located
        $rootDir = Join-Path $PSScriptRoot "..\.."
        Push-Location $rootDir
        & npx @mmdcArgs
        Pop-Location
        
        if (Test-Path $pngFilePath) {
            $fileSize = (Get-Item $pngFilePath).Length
            $fileSizeKB = [math]::Round($fileSize / 1KB, 1)
            Write-Host "✅ Success: $pngFileName ($fileSizeKB KB)" -ForegroundColor Green
            $successCount++
        } else {
            Write-Host "❌ Failed: PNG file not created" -ForegroundColor Red
            $failedCount++
        }
    } catch {
        Write-Host "❌ Failed: $($_.Exception.Message)" -ForegroundColor Red
        $failedCount++
    }
}

# Summary
Write-Host "`n📈 Test Complete!" -ForegroundColor Cyan
Write-Host "===============" -ForegroundColor Cyan
Write-Host "Total files: $($mmdFiles.Count)" -ForegroundColor White
Write-Host "Successful: $successCount" -ForegroundColor Green
Write-Host "Failed: $failedCount" -ForegroundColor Red

if ($successCount -gt 0) {
    Write-Host "`n🎯 PNG generation test successful! Ready for full run." -ForegroundColor Green
} else {
    Write-Host "`n⚠️ PNG generation test failed. Need to debug." -ForegroundColor Yellow
} 