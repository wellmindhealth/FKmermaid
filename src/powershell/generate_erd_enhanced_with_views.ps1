# FKmermaid Enhanced ER Diagram Generator with Multiple Views
# Integrates relationship views as new diagramType options

# Import required modules
. (Join-Path $PSScriptRoot "config_manager.ps1")
. (Join-Path $PSScriptRoot "relationship_visualizer.ps1")

param(
    [string]$FocusEntity = "",
    [string]$lDomains = "",
    [string]$DiagramType = "ER",
    [string]$OutputFile = "",
    [switch]$ShowHelp
)

# Enhanced diagram type validation - now supports relationship views
$validDiagramTypes = @("ER", "Class", "dependency", "influence", "hierarchy", "network", "timeline", "comparison")

if ($ShowHelp) {
    Write-Host "FKmermaid Enhanced ER Diagram Generator with Multiple Views" -ForegroundColor Cyan
    Write-Host "=========================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -FocusEntity: Entity to focus on (optional)" -ForegroundColor White
    Write-Host "  -lDomains: Comma-separated list of domains or 'all' (optional)" -ForegroundColor White
    Write-Host "  -DiagramType: Type of diagram to generate" -ForegroundColor White
    Write-Host "    • ER: Standard Entity-Relationship diagram" -ForegroundColor Gray
    Write-Host "    • Class: Class diagram" -ForegroundColor Gray
    Write-Host "    • dependency: Shows what depends on what" -ForegroundColor Gray
    Write-Host "    • influence: Shows what influences what" -ForegroundColor Gray
    Write-Host "    • hierarchy: Shows parent-child relationships" -ForegroundColor Gray
    Write-Host "    • network: Shows all connections as a network" -ForegroundColor Gray
    Write-Host "    • timeline: Shows entity complexity over time" -ForegroundColor Gray
    Write-Host "    • comparison: Side-by-side domain comparison" -ForegroundColor Gray
    Write-Host "  -OutputFile: Output file path (optional)" -ForegroundColor White
    Write-Host "  -ShowHelp: Show this help message" -ForegroundColor White
    Write-Host ""
    Write-Host "Examples:" -ForegroundColor Yellow
    Write-Host "  .\generate_erd_enhanced_with_views.ps1 -FocusEntity 'partner' -DiagramType 'dependency'" -ForegroundColor White
    Write-Host "  .\generate_erd_enhanced_with_views.ps1 -DiagramType 'network' -lDomains 'all'" -ForegroundColor White
    Write-Host "  .\generate_erd_enhanced_with_views.ps1 -DiagramType 'hierarchy' -OutputFile 'hierarchy_view.mmd'" -ForegroundColor White
    return
}

# Validate diagram type
if ($DiagramType -notin $validDiagramTypes) {
    Write-Host "❌ Invalid diagram type: $DiagramType" -ForegroundColor Red
    Write-Host "Valid types: $($validDiagramTypes -join ', ')" -ForegroundColor Yellow
    return
}

Write-Host "🎨 FKmermaid Enhanced Diagram Generator" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "Diagram Type: $DiagramType" -ForegroundColor Yellow
Write-Host "Focus Entity: $FocusEntity" -ForegroundColor Yellow
Write-Host "Domains: $lDomains" -ForegroundColor Yellow
Write-Host ""

# Load configuration
$config = Get-ProjectConfig
if (-not $config) {
    Write-Host "❌ Failed to load configuration" -ForegroundColor Red
    return
}

# Get paths
$cfcScanConfigPath = Get-ProjectPath -pathKey "cfcScanConfig"
$exportsPath = Get-ProjectPath -pathKey "exports"

# Ensure exports directory exists
if (-not (Test-Path $exportsPath)) {
    New-Item -ItemType Directory -Path $exportsPath -Force | Out-Null
}

# Load CFC scan configuration
if (-not (Test-Path $cfcScanConfigPath)) {
    Write-Host "❌ CFC scan configuration not found: $cfcScanConfigPath" -ForegroundColor Red
    return
}

$cfcConfig = Get-Content $cfcScanConfigPath | ConvertFrom-Json

# Generate CFC scan
Write-Host "🔍 Scanning CFC files..." -ForegroundColor Cyan
$scanResult = & (Join-Path $PSScriptRoot "generate_cfc_scan_config.ps1") -FocusEntity $FocusEntity -lDomains $lDomains

if (-not $scanResult) {
    Write-Host "❌ Failed to generate CFC scan" -ForegroundColor Red
    return
}

# Parse scan results
$entities = $scanResult.entities
$relationships = $scanResult.relationships

Write-Host "📊 Found $($entities.Count) entities and $($relationships.directFK.Count) relationships" -ForegroundColor Green

# Generate diagram based on type
$mermaidContent = ""

switch ($DiagramType) {
    "ER" {
        Write-Host "📋 Generating Entity-Relationship Diagram..." -ForegroundColor Cyan
        $mermaidContent = Generate-MermaidERD -entities $entities -relationships $relationships -focusEntity $FocusEntity
    }
    "Class" {
        Write-Host "📋 Generating Class Diagram..." -ForegroundColor Cyan
        $mermaidContent = Generate-MermaidClassDiagram -entities $entities -relationships $relationships -focusEntity $FocusEntity
    }
    "dependency" {
        Write-Host "📋 Generating Dependency View..." -ForegroundColor Cyan
        $mermaidContent = Generate-DependencyView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
    "influence" {
        Write-Host "📋 Generating Influence View..." -ForegroundColor Cyan
        $mermaidContent = Generate-InfluenceView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
    "hierarchy" {
        Write-Host "📋 Generating Hierarchy View..." -ForegroundColor Cyan
        $mermaidContent = Generate-HierarchyView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
    "network" {
        Write-Host "📋 Generating Network View..." -ForegroundColor Cyan
        $mermaidContent = Generate-NetworkView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
    "timeline" {
        Write-Host "📋 Generating Timeline View..." -ForegroundColor Cyan
        $mermaidContent = Generate-TimelineView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
    "comparison" {
        Write-Host "📋 Generating Comparison View..." -ForegroundColor Cyan
        $mermaidContent = Generate-ComparisonView -relationships $relationships -entities $entities -focusEntity $FocusEntity
    }
}

if (-not $mermaidContent) {
    Write-Host "❌ Failed to generate diagram content" -ForegroundColor Red
    return
}

# Determine output file
if ($OutputFile) {
    $outputPath = $OutputFile
} else {
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $outputPath = Join-Path $exportsPath "${DiagramType}_diagram_$timestamp.mmd"
}

# Save diagram
try {
    $mermaidContent | Set-Content $outputPath
    Write-Host "✅ Diagram saved to: $outputPath" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to save diagram: $($_.Exception.Message)" -ForegroundColor Red
    return
}

# Open in browser
try {
    # Use the same working Pako method as the base script
    $nodeScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "src\node\generate_url.js"
    
    # Check if Node.js tool exists
    if (Test-Path $nodeScriptPath) {
        # Use the working Node.js tool for proper pako compression
        $mermaidLiveUrl = $mermaidContent | node $nodeScriptPath
        
        Write-Host "🌐 Opening in Mermaid.live: $mermaidLiveUrl" -ForegroundColor Cyan
        
        # Non-blocking browser launch to prevent hanging
        Start-Job -ScriptBlock { param($url) Start-Process $url -WindowStyle Hidden } -ArgumentList $mermaidLiveUrl | Out-Null
        Write-Host "🚀 Diagram opened in Mermaid.live with Pako compression" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Node.js tool not found, falling back to URL encoding" -ForegroundColor Yellow
        # Fallback to URL encoding
        $encodedContent = [Uri]::EscapeDataString($mermaidContent)
        $mermaidUrl = "https://mermaid.live/edit#$encodedContent"
        Start-Process $mermaidUrl
        Write-Host "🚀 Diagram opened in Mermaid.live" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠️ Failed to open in browser, but diagram is saved" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎯 Diagram Type: $DiagramType" -ForegroundColor Cyan
Write-Host "📁 Output: $outputPath" -ForegroundColor Cyan
Write-Host "🌐 Interactive: $mermaidUrl" -ForegroundColor Cyan

# Test the enhanced script if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host ""
    Write-Host "🧪 Testing enhanced diagram generator..." -ForegroundColor Yellow
    Write-Host "Try: .\generate_erd_enhanced_with_views.ps1 -DiagramType 'dependency' -ShowHelp" -ForegroundColor Gray
}