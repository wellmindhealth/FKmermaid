<#
.SYNOPSIS
    Generate PNG previews from Mermaid .mmd files
    
.DESCRIPTION
    Uses Mermaid CLI to convert .mmd files to PNG images for Confluence previews.
    Reads the 165_diagrams_results.json to get the list of diagrams and generates
    PNG previews for each one.
    
.EXAMPLE
    .\generate_png_previews.ps1
#>

Write-Host "🖼️  Generating PNG Previews" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

# Load the results from the 165 diagrams generation
$resultsFile = Join-Path $PSScriptRoot "..\..\exports\pre_generated\165_diagrams_results.json"
$results = Get-Content $resultsFile -Raw | ConvertFrom-Json

# Create PNG output directory
$pngOutputDir = Join-Path $PSScriptRoot "..\..\exports\pre_generated\png_previews"
if (-not (Test-Path $pngOutputDir)) {
    New-Item -ItemType Directory -Path $pngOutputDir -Force | Out-Null
    Write-Host "📁 Created PNG output directory: $pngOutputDir" -ForegroundColor Green
}

# Get the list of .mmd files from the exports directory
$mmdFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot "..\..\exports") -Filter "*.mmd" | Sort-Object LastWriteTime -Descending

Write-Host "`n📊 Found $($mmdFiles.Count) .mmd files to convert" -ForegroundColor Yellow

$successCount = 0
$failedCount = 0

foreach ($mmdFile in $mmdFiles) {
    $pngFileName = [System.IO.Path]::GetFileNameWithoutExtension($mmdFile.Name) + ".png"
    $pngFilePath = Join-Path $pngOutputDir $pngFileName
    
    Write-Host "🔄 Converting: $($mmdFile.Name) → $pngFileName" -ForegroundColor Blue
    
    try {
        # Use local Mermaid CLI via npx to convert .mmd to PNG
        $mmdcArgs = @(
            "mmdc",
            "-i", $mmdFile.FullName,
            "-o", $pngFilePath,
            "-b", "transparent",
            "-s", "1.5"
        )
        
        # Run from the FKmermaid root directory where package.json is located
        $rootDir = Join-Path $PSScriptRoot "..\.."
        & npx @mmdcArgs -WorkingDirectory $rootDir
        
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
Write-Host "`n📈 PNG Generation Complete!" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host "Total files: $($mmdFiles.Count)" -ForegroundColor White
Write-Host "Successful: $successCount" -ForegroundColor Green
Write-Host "Failed: $failedCount" -ForegroundColor Red
Write-Host "PNG files saved to: $pngOutputDir" -ForegroundColor Green

if ($successCount -gt 0) {
    Write-Host "`n🎯 PNG previews ready for Confluence integration!" -ForegroundColor Green
}

Write-Host "`n💡 Next steps:" -ForegroundColor Yellow
Write-Host "1. Review PNG quality and sizing" -ForegroundColor White
Write-Host "2. Create Confluence page with PNG previews" -ForegroundColor White
Write-Host "3. Add navigation and filtering" -ForegroundColor White 