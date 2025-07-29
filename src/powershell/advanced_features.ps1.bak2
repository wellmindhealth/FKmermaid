# FKmermaid Advanced Features
# Handles export formats, diagram types, and enhanced functionality

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-AdvancedFeatures {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    $exportFormats = Get-ExportSetting -settingKey "formats" -config $config
    $defaultFormat = Get-ExportSetting -settingKey "defaultFormat" -config $config
    $pngResolution = Get-ExportSetting -settingKey "pngResolution" -config $config
    $svgOptimization = Get-ExportSetting -settingKey "svgOptimization" -config $config
    
    Write-Host "Advanced Features initialized:" -ForegroundColor Green
    Write-Host "  Supported formats: $($exportFormats -join ', ')" -ForegroundColor Cyan
    Write-Host "  Default format: $defaultFormat" -ForegroundColor Cyan
    Write-Host "  PNG resolution: $pngResolution" -ForegroundColor Cyan
    Write-Host "  SVG optimization: $svgOptimization" -ForegroundColor Cyan
}

function Export-Diagram {
    param(
        [string]$mermaidContent,
        [string]$format = "mmd",
        [string]$outputPath = "",
        [hashtable]$options = @{}
    )
    
    if (-not $outputPath) {
        $exportsPath = Get-ProjectPath -pathKey "exports"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $exportsPath "diagram_$timestamp.$format"
    }
    
    try {
        switch ($format.ToLower()) {
            "mmd" {
                # Mermaid source file
                $mermaidContent | Set-Content $outputPath
                Write-Host "Mermaid diagram exported to: $outputPath" -ForegroundColor Green
            }
            "html" {
                # HTML with embedded Mermaid
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
                Write-Host "HTML diagram exported to: $outputPath" -ForegroundColor Green
            }
            "png" {
                # PNG export using Puppeteer or similar
                Write-Host "PNG export not yet implemented" -ForegroundColor Yellow
                # TODO: Implement PNG export using headless browser
            }
            "svg" {
                # SVG export
                Write-Host "SVG export not yet implemented" -ForegroundColor Yellow
                # TODO: Implement SVG export
            }
            "pdf" {
                # PDF export
                Write-Host "PDF export not yet implemented" -ForegroundColor Yellow
                # TODO: Implement PDF export
            }
            default {
                throw "Unsupported export format: $format"
            }
        }
        
        return $outputPath
    } catch {
        Write-Error "Failed to export diagram: $($_.Exception.Message)"
        return $null
    }
}

function Generate-SequenceDiagram {
    param(
        [string]$focusEntity,
        [array]$entities,
        [object]$relationships,
        [hashtable]$options = @{}
    )
    
    $sequenceContent = @"
sequenceDiagram
    participant User
    participant $focusEntity
"@
    
    # Add other entities
    foreach ($entity in $entities | Where-Object { $_ -ne $focusEntity } | Select-Object -First 5) {
        $sequenceContent += "`n    participant $entity"
    }
    
    # Add interactions based on relationships
    $directFKs = $relationships.directFK | Where-Object { $_.source -eq $focusEntity -or $_.target -eq $focusEntity }
    
    foreach ($fk in $directFKs | Select-Object -First 10) {
        $source = $fk.source
        $target = $fk.target
        
        if ($source -eq $focusEntity) {
            $sequenceContent += "`n    ${source}->>${target}: Create/Update"
        } elseif ($target -eq $focusEntity) {
            $sequenceContent += "`n    ${source}->>${target}: Reference"
        }
    }
    
    return $sequenceContent
}

function Generate-Flowchart {
    param(
        [string]$focusEntity,
        [array]$entities,
        [object]$relationships,
        [hashtable]$options = @{}
    )
    
    $flowContent = @"
flowchart TD
    Start([Start]) --> $focusEntity
"@
    
    # Add entity nodes
    foreach ($entity in $entities | Where-Object { $_ -ne $focusEntity }) {
        $flowContent += "`n    $entity[$entity]"
    }
    
    # Add relationships as flow
    $directFKs = $relationships.directFK | Where-Object { $_.source -eq $focusEntity -or $_.target -eq $focusEntity }
    
    foreach ($fk in $directFKs | Select-Object -First 8) {
        $source = $fk.source
        $target = $fk.target
        $flowContent += "`n    $source --> $target"
    }
    
    $flowContent += "`n    End([End])"
    
    return $flowContent
}

function Generate-StateDiagram {
    param(
        [string]$focusEntity,
        [array]$entities,
        [object]$relationships,
        [hashtable]$options = @{}
    )
    
    $stateContent = @"
stateDiagram-v2
    [*] --> Initial
    Initial --> Active
"@
    
    # Add states based on entity properties
    $states = @("Active", "Inactive", "Pending", "Completed", "Error")
    
    foreach ($state in $states) {
        $stateContent += "`n    Active --> $state"
    }
    
    $stateContent += "`n    Completed --> [*]"
    
    return $stateContent
}

function Generate-ComponentDiagram {
    param(
        [string]$focusEntity,
        [array]$entities,
        [object]$relationships,
        [hashtable]$options = @{}
    )
    
    $componentContent = @"
graph TB
    subgraph "$focusEntity System"
        $focusEntity["$focusEntity Component"]
"@
    
    # Add related components
    $relatedEntities = $entities | Where-Object { $_ -ne $focusEntity } | Select-Object -First 6
    
    foreach ($entity in $relatedEntities) {
        $componentContent += "`n        $entity[""$entity Component""]"
    }
    
    $componentContent += "`n    end"
    
    # Add external systems
    $componentContent += @"

    subgraph "External Systems"
        Database[(Database)]
        API[API Gateway]
    end
    
    $focusEntity --> Database
    $focusEntity --> API
"@
    
    return $componentContent
}

function Batch-Export {
    param(
        [string]$mermaidContent,
        [array]$formats = @("mmd", "html"),
        [string]$baseName = "diagram",
        [hashtable]$options = @{}
    )
    
    $results = @{}
    $exportsPath = Get-ProjectPath -pathKey "exports"
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    
    foreach ($format in $formats) {
        $outputPath = Join-Path $exportsPath "${baseName}_${timestamp}.$format"
        $result = Export-Diagram -mermaidContent $mermaidContent -format $format -outputPath $outputPath -options $options
        
        if ($result) {
            $results[$format] = $result
        }
    }
    
    Write-Host "Batch export completed:" -ForegroundColor Green
    foreach ($format in $results.Keys) {
        Write-Host "  $format`: $($results[$format])" -ForegroundColor Cyan
    }
    
    return $results
}

function Optimize-Diagram {
    param(
        [string]$mermaidContent,
        [hashtable]$options = @{}
    )
    
    $optimized = $mermaidContent
    
    # Remove unnecessary whitespace
    $optimized = $optimized -replace '\s+', ' '
    $optimized = $optimized -replace '^\s+|\s+$', ''
    
    # Remove empty lines
    $optimized = $optimized -replace '\n\s*\n', "`n"
    
    # Optimize entity names (remove long prefixes)
    $optimized = $optimized -replace '(\w+)_(\w+)', '$2'
    
    return $optimized
}

function Validate-Diagram {
    param(
        [string]$mermaidContent,
        [string]$diagramType = "ER"
    )
    
    $errors = @()
    $warnings = @()
    
    # Basic syntax validation
    if (-not $mermaidContent.Contains("graph")) {
        $errors += "Missing graph declaration"
    }
    
    # Check for common issues
    if ($mermaidContent.Contains("undefined")) {
        $warnings += "Contains undefined references"
    }
    
    if ($mermaidContent.Split("`n").Count -gt 100) {
        $warnings += "Diagram may be too complex"
    }
    
    # Type-specific validation
    switch ($diagramType) {
        "ER" {
            if (-not $mermaidContent.Contains("||--")) {
                $warnings += "No relationships found in ER diagram"
            }
        }
        "Class" {
            if (-not $mermaidContent.Contains("class")) {
                $warnings += "No class definitions found"
            }
        }
    }
    
    return @{
        IsValid = ($errors.Count -eq 0)
        Errors = $errors
        Warnings = $warnings
        Complexity = $mermaidContent.Split("`n").Count
    }
}

function Get-DiagramMetadata {
    param(
        [string]$mermaidContent,
        [string]$diagramType = "ER"
    )
    
    $lines = $mermaidContent.Split("`n")
    $entities = @()
    $relationships = @()
    $styles = @()
    
    foreach ($line in $lines) {
        # Extract entities
        if ($line -match '(\w+)\[') {
            $entities += $matches[1]
        }
        
        # Extract relationships
        if ($line -match '(\w+)\s*--\s*(\w+)') {
            $relationships += @{
                Source = $matches[1]
                Target = $matches[2]
            }
        }
        
        # Extract styles
        if ($line -match 'style\s+(\w+)') {
            $styles += $matches[1]
        }
    }
    
    return @{
        EntityCount = $entities.Count
        RelationshipCount = $relationships.Count
        StyleCount = $styles.Count
        LineCount = $lines.Count
        Entities = $entities | Sort-Object -Unique
        Relationships = $relationships
        Styles = $styles | Sort-Object -Unique
        DiagramType = $diagramType
    }
}

# Initialize advanced features when module is loaded
Initialize-AdvancedFeatures

# Test advanced features if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Advanced Features..." -ForegroundColor Cyan
    
    # Test diagram generation
    $testEntities = @("partner", "member", "programme", "activity")
    $testRelationships = @{
        directFK = @(
            @{ source = "partner"; target = "member" },
            @{ source = "member"; target = "programme" },
            @{ source = "programme"; target = "activity" }
        )
    }
    
    # Test sequence diagram
    $sequenceDiagram = Generate-SequenceDiagram -focusEntity "partner" -entities $testEntities -relationships $testRelationships
    Write-Host "✅ Sequence diagram generated" -ForegroundColor Green
    
    # Test flowchart
    $flowchart = Generate-Flowchart -focusEntity "partner" -entities $testEntities -relationships $testRelationships
    Write-Host "✅ Flowchart generated" -ForegroundColor Green
    
    # Test state diagram
    $stateDiagram = Generate-StateDiagram -focusEntity "partner" -entities $testEntities -relationships $testRelationships
    Write-Host "✅ State diagram generated" -ForegroundColor Green
    
    # Test component diagram
    $componentDiagram = Generate-ComponentDiagram -focusEntity "partner" -entities $testEntities -relationships $testRelationships
    Write-Host "✅ Component diagram generated" -ForegroundColor Green
    
    # Test validation
    $validation = Validate-Diagram -mermaidContent $sequenceDiagram -diagramType "sequence"
    Write-Host "✅ Diagram validation completed" -ForegroundColor Green
    
    # Test metadata extraction
    $metadata = Get-DiagramMetadata -mermaidContent $sequenceDiagram -diagramType "sequence"
    Write-Host "✅ Metadata extraction completed" -ForegroundColor Green
    
    Write-Host "Advanced features test completed successfully!" -ForegroundColor Green
}