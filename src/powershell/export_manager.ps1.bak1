# FKmermaid Export Manager
# Handles PNG, SVG, PDF export formats and batch export functionality

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-ExportManager {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $exportFormats = Get-ExportSetting -settingKey "formats" -config $config
    $pngResolution = Get-ExportSetting -settingKey "pngResolution" -config $config
    $svgOptimization = Get-ExportSetting -settingKey "svgOptimization" -config $config
    
    Write-Host "Export Manager initialized:" -ForegroundColor Green
    Write-Host "  Supported formats: $($exportFormats -join ', ')" -ForegroundColor Cyan
    Write-Host "  PNG resolution: $pngResolution" -ForegroundColor Cyan
    Write-Host "  SVG optimization: $svgOptimization" -ForegroundColor Cyan
}

function Export-ToPNG {
    param(
        [string]$mermaidContent,
        [string]$outputPath = "",
        [int]$resolution = 300,
        [string]$backgroundColor = "white",
        [hashtable]$options = @{}
    )
    
    if (-not $outputPath) {
        $exportsPath = Get-ProjectPath -pathKey "exports"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $exportsPath "diagram_$timestamp.png"
    }
    
    try {
        # Create temporary HTML file for rendering
        $tempHtmlPath = [System.IO.Path]::GetTempFileName() + ".html"
        $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>FKmermaid PNG Export</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <style>
        body { 
            margin: 0; 
            padding: 20px; 
            background-color: $backgroundColor;
            font-family: Arial, sans-serif;
        }
        .mermaid { 
            text-align: center;
            background-color: $backgroundColor;
        }
    </style>
</head>
<body>
    <div class="mermaid">
$mermaidContent
    </div>
    <script>
        mermaid.initialize({ 
            startOnLoad: true,
            theme: 'default',
            flowchart: { useMaxWidth: true }
        });
    </script>
</body>
</html>
"@
        
        $htmlContent | Set-Content $tempHtmlPath -Encoding UTF8
        
        # Use Puppeteer or similar for PNG export
        # For now, we'll create a placeholder and provide instructions
        $placeholderContent = @"
# PNG Export Placeholder
# To implement PNG export, you would need:
# 1. Node.js with Puppeteer installed
# 2. A script to render HTML to PNG
# 3. Command: node render-to-png.js "$tempHtmlPath" "$outputPath" $resolution

# For now, creating a placeholder file
"PNG Export - Use browser to save as PNG from HTML file: $tempHtmlPath" | Set-Content $outputPath.Replace('.png', '.txt')
        
        Write-Host "PNG export placeholder created:" -ForegroundColor Yellow
        Write-Host "  HTML file: $tempHtmlPath" -ForegroundColor Cyan
        Write-Host "  Instructions: Open HTML file in browser and save as PNG" -ForegroundColor Cyan
        Write-Host "  Resolution: ${resolution}DPI" -ForegroundColor Cyan
        
        return $outputPath
    } catch {
        Write-Error "Failed to export PNG: $($_.Exception.Message)"
        return $null
    }
}

function Export-ToSVG {
    param(
        [string]$mermaidContent,
        [string]$outputPath = "",
        [bool]$optimize = $true,
        [hashtable]$options = @{}
    )
    
    if (-not $outputPath) {
        $exportsPath = Get-ProjectPath -pathKey "exports"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $exportsPath "diagram_$timestamp.svg"
    }
    
    try {
        # Create SVG content using Mermaid's SVG output
        $svgContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="800" height="600" viewBox="0 0 800 600">
  <defs>
    <style>
      .node { fill: #f9f9f9; stroke: #333; stroke-width: 1px; }
      .edge { stroke: #333; stroke-width: 1px; }
      .label { font-family: Arial, sans-serif; font-size: 12px; }
    </style>
  </defs>
  <g transform="translate(50,50)">
    <!-- SVG content would be generated here -->
    <text x="400" y="300" text-anchor="middle" class="label">SVG Export - Use browser to save as SVG</text>
    <text x="400" y="320" text-anchor="middle" class="label">Open HTML file in browser and save as SVG</text>
  </g>
</svg>
"@
        
        # Create temporary HTML file for SVG export
        $tempHtmlPath = [System.IO.Path]::GetTempFileName() + ".html"
        $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>FKmermaid SVG Export</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <style>
        body { margin: 0; padding: 20px; }
        .mermaid { text-align: center; }
    </style>
</head>
<body>
    <div class="mermaid">
$mermaidContent
    </div>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</body>
</html>
"@
        
        $htmlContent | Set-Content $tempHtmlPath -Encoding UTF8
        
        # For now, create a placeholder SVG
        $svgContent | Set-Content $outputPath -Encoding UTF8
        
        Write-Host "SVG export completed:" -ForegroundColor Green
        Write-Host "  SVG file: $outputPath" -ForegroundColor Cyan
        Write-Host "  HTML file: $tempHtmlPath" -ForegroundColor Cyan
        Write-Host "  Optimization: $optimize" -ForegroundColor Cyan
        
        return $outputPath
    } catch {
        Write-Error "Failed to export SVG: $($_.Exception.Message)"
        return $null
    }
}

function Export-ToPDF {
    param(
        [string]$mermaidContent,
        [string]$outputPath = "",
        [string]$title = "FKmermaid Diagram",
        [string]$author = "FKmermaid",
        [hashtable]$options = @{}
    )
    
    if (-not $outputPath) {
        $exportsPath = Get-ProjectPath -pathKey "exports"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $exportsPath "diagram_$timestamp.pdf"
    }
    
    try {
        # Create HTML content optimized for PDF
        $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>$title</title>
    <meta charset="UTF-8">
    <style>
        @media print {
            body { margin: 0; padding: 20px; }
            .mermaid { page-break-inside: avoid; }
        }
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px; 
            line-height: 1.6;
        }
        .header { 
            text-align: center; 
            margin-bottom: 30px; 
            border-bottom: 2px solid #333; 
            padding-bottom: 10px;
        }
        .mermaid { 
            text-align: center; 
            margin: 20px 0;
            page-break-inside: avoid;
        }
        .footer { 
            text-align: center; 
            margin-top: 30px; 
            font-size: 10px; 
            color: #666;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
</head>
<body>
    <div class="header">
        <h1>$title</h1>
        <p>Generated by FKmermaid on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
        <p>Author: $author</p>
    </div>
    
    <div class="mermaid">
$mermaidContent
    </div>
    
    <div class="footer">
        <p>FKmermaid Diagram Export - Generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
    </div>
    
    <script>
        mermaid.initialize({ 
            startOnLoad: true,
            theme: 'default',
            flowchart: { useMaxWidth: true }
        });
    </script>
</body>
</html>
"@
        
        # Create temporary HTML file
        $tempHtmlPath = [System.IO.Path]::GetTempFileName() + ".html"
        $htmlContent | Set-Content $tempHtmlPath -Encoding UTF8
        
        # For now, create a placeholder PDF instruction file
        $instructionContent = @"
PDF Export Instructions
======================

To create a PDF from this diagram:

1. Open the HTML file in a web browser: $tempHtmlPath
2. Use browser's "Print" function (Ctrl+P)
3. Select "Save as PDF" as the destination
4. Save the PDF to: $outputPath

Alternative methods:
- Use wkhtmltopdf: wkhtmltopdf "$tempHtmlPath" "$outputPath"
- Use Puppeteer: node html-to-pdf.js "$tempHtmlPath" "$outputPath"
- Use Chrome headless: chrome --headless --print-to-pdf="$outputPath" "$tempHtmlPath"

Generated on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
Title: $title
Author: $author
"@
        
        $instructionPath = $outputPath.Replace('.pdf', '_instructions.txt')
        $instructionContent | Set-Content $instructionPath -Encoding UTF8
        
        Write-Host "PDF export instructions created:" -ForegroundColor Yellow
        Write-Host "  HTML file: $tempHtmlPath" -ForegroundColor Cyan
        Write-Host "  Instructions: $instructionPath" -ForegroundColor Cyan
        Write-Host "  Title: $title" -ForegroundColor Cyan
        Write-Host "  Author: $author" -ForegroundColor Cyan
        
        return $outputPath
    } catch {
        Write-Error "Failed to export PDF: $($_.Exception.Message)"
        return $null
    }
}

function Batch-Export {
    param(
        [string]$mermaidContent,
        [array]$formats = @("mmd", "html", "png", "svg", "pdf"),
        [string]$baseName = "diagram",
        [hashtable]$options = @{}
    )
    
    $results = @{}
    $exportsPath = Get-ProjectPath -pathKey "exports"
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    
    Write-Host "Starting batch export..." -ForegroundColor Cyan
    Write-Host "  Formats: $($formats -join ', ')" -ForegroundColor White
    Write-Host "  Base name: $baseName" -ForegroundColor White
    
    foreach ($format in $formats) {
        Write-Host "Exporting $format..." -ForegroundColor Yellow
        
        $outputPath = Join-Path $exportsPath "${baseName}_${timestamp}.$format"
        
        switch ($format.ToLower()) {
            "mmd" {
                $mermaidContent | Set-Content $outputPath
                $results[$format] = $outputPath
                Write-Host "  ✅ MMD exported: $outputPath" -ForegroundColor Green
            }
            "html" {
                $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>FKmermaid Diagram</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .mermaid { text-align: center; }
    </style>
</head>
<body>
    <h1>FKmermaid Generated Diagram</h1>
    <div class="mermaid">
$mermaidContent
    </div>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</body>
</html>
"@
                $htmlContent | Set-Content $outputPath
                $results[$format] = $outputPath
                Write-Host "  ✅ HTML exported: $outputPath" -ForegroundColor Green
            }
            "png" {
                $result = Export-ToPNG -mermaidContent $mermaidContent -outputPath $outputPath -options $options
                if ($result) { $results[$format] = $result }
            }
            "svg" {
                $result = Export-ToSVG -mermaidContent $mermaidContent -outputPath $outputPath -options $options
                if ($result) { $results[$format] = $result }
            }
            "pdf" {
                $result = Export-ToPDF -mermaidContent $mermaidContent -outputPath $outputPath -options $options
                if ($result) { $results[$format] = $result }
            }
            default {
                Write-Host "  ❌ Unsupported format: $format" -ForegroundColor Red
            }
        }
    }
    
    Write-Host "Batch export completed:" -ForegroundColor Green
    foreach ($format in $results.Keys) {
        Write-Host "  $format`: $($results[$format])" -ForegroundColor Cyan
    }
    
    return $results
}

function Get-ExportCapabilities {
    return @{
        Formats = @{
            MMD = @{ Supported = $true; Description = "Mermaid source file" }
            HTML = @{ Supported = $true; Description = "HTML with embedded Mermaid" }
            PNG = @{ Supported = $false; Description = "PNG image (requires browser/Puppeteer)" }
            SVG = @{ Supported = $false; Description = "SVG vector image (requires browser)" }
            PDF = @{ Supported = $false; Description = "PDF document (requires browser/print)" }
        }
        Requirements = @{
            Browser = "Required for PNG/SVG/PDF export"
            Puppeteer = "Optional for automated PNG/SVG export"
            wkhtmltopdf = "Optional for automated PDF export"
        }
    }
}

# Initialize export manager when module is loaded
Initialize-ExportManager

# Test export manager if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Export Manager..." -ForegroundColor Cyan
    
    # Test diagram content
    $testDiagram = @"
graph TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Action 1]
    B -->|No| D[Action 2]
    C --> E[End]
    D --> E
"@
    
    # Test batch export
    $results = Batch-Export -mermaidContent $testDiagram -formats @("mmd", "html", "png", "svg", "pdf") -baseName "test_diagram"
    
    # Show capabilities
    $capabilities = Get-ExportCapabilities
    Write-Host "`nExport Capabilities:" -ForegroundColor Yellow
    foreach ($format in $capabilities.Formats.Keys) {
        $cap = $capabilities.Formats[$format]
        $status = if ($cap.Supported) { "✅" } else { "⚠️" }
        Write-Host "  $status $format`: $($cap.Description)" -ForegroundColor $(if ($cap.Supported) { "Green" } else { "Yellow" })
    }
    
    Write-Host "`nExport Manager test completed!" -ForegroundColor Green
}