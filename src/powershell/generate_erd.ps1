param(
    [string]$FocusEntity,
    [ValidateSet("ER", "Class")]
    [string]$DiagramType,
    [string[]]$lDomains,
    [bool]$BroadenSpread = $true
)

# Set up paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$outputFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).mmd"

# Create exports directory if it doesn't exist
$exportsDir = Join-Path $ProjectRoot "exports"
if (!(Test-Path $exportsDir)) {
    New-Item -Path $exportsDir -ItemType Directory -Force | Out-Null
}

# Overwrite output file
if (Test-Path $outputFile) { Remove-Item $outputFile -Force }
New-Item -Path $outputFile -ItemType File -Force | Out-Null

# Read the domain configuration
$domainConfigPath = Join-Path $ProjectRoot "config\domains.json"
$domainConfig = Get-Content $domainConfigPath | ConvertFrom-Json

# Filter domains based on input
$allEntities = @()
foreach ($domainName in $lDomains) {
    if ($domainConfig.domains.$domainName) {
        $domain = $domainConfig.domains.$domainName
        foreach ($entityGroup in $domain.entities.PSObject.Properties) {
            $allEntities += $entityGroup.Value
        }
    }
}

# Remove duplicates and sort
$allEntities = $allEntities | Sort-Object -Unique

# Find the focus entity and ensure it's first in the list
$focusEntity = $allEntities | Where-Object { $_ -eq $FocusEntity } | Select-Object -First 1
if (!$focusEntity) {
    $focusEntity = $allEntities[0]
}

# Reorder entities to put focus entity first
$orderedEntities = @($focusEntity)
$orderedEntities += $allEntities | Where-Object { $_ -ne $focusEntity }

# Generate Mermaid diagram content
$mermaidLines = @()

if ($DiagramType -eq "ER") {
    $mermaidLines += "erDiagram"
} else {
    $mermaidLines += "classDiagram"
}

# Add entities/classes
foreach ($entity in $orderedEntities) {
    if ($DiagramType -eq "ER") {
        $mermaidLines += "    $entity {"
        $mermaidLines += "        string id"
        $mermaidLines += "        string name"
        $mermaidLines += "    }"
    } else {
        $mermaidLines += "    class $entity {"
        $mermaidLines += "        +String id"
        $mermaidLines += "        +String name"
        $mermaidLines += "    }"
    }
}

# Add relationships (simplified for now)
$mermaidLines += ""
$mermaidLines += "    %% Relationships"
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity) {
        if ($DiagramType -eq "ER") {
            $mermaidLines += "    $focusEntity ||--o{ $entity : `"related to`""
        } else {
            $mermaidLines += "    $focusEntity --> $entity : `"related to`""
        }
    }
}

# Write to file
$mermaidLines | Set-Content -Path $outputFile

# Also create an HTML file with embedded diagram
$htmlFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).html"
$diagramTitle = if ($DiagramType -eq "ER") { "ER Diagram" } else { "Class Diagram" }
$mermaidContentForHtml = $mermaidLines -join "`n"
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>$FocusEntity $diagramTitle</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</head>
<body>
    <h1>$FocusEntity $diagramTitle</h1>
    <div class="mermaid">
$mermaidContentForHtml
    </div>
</body>
</html>
"@

$htmlContent | Set-Content -Path $htmlFile

# Open the local HTML file (most reliable method)
Write-Host "✅ Generated diagram successfully!"
Write-Host ""
Write-Host "📁 Files created:"
Write-Host "   • Mermaid source: $outputFile"
Write-Host "   • HTML viewer: $htmlFile"
Write-Host ""

Write-Host "🌐 Opening local HTML file (most reliable):"
try {
    Start-Process "chrome.exe" -ArgumentList $htmlFile -ErrorAction Stop
    Write-Host "✅ Opened local HTML file: $htmlFile"
} catch {
    Write-Host "❌ Failed to open local HTML file. Please open manually: $htmlFile"
}

Write-Host ""
Write-Host "📋 Manual copy-paste to Mermaid Live Editor:"
Write-Host "1. Go to https://mermaid.live/edit"
Write-Host "2. Copy the content from: $outputFile"
Write-Host "3. Paste it into the editor"
Write-Host ""

Write-Host "📊 Generated Mermaid content:"
Write-Host "---"
Write-Host $mermaidContentForHtml
Write-Host "---" 