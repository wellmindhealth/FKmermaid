# FKmermaid Relationship Visualizer
# Provides different views of the same relationships for better understanding

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-RelationshipVisualizer {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Relationship Visualizer initialized:" -ForegroundColor Green
    Write-Host "  Multiple view perspectives enabled" -ForegroundColor Cyan
    Write-Host "  Interactive visualization ready" -ForegroundColor Cyan
    Write-Host "  Export capabilities active" -ForegroundColor Cyan
}

function Generate-DependencyView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "🔗 Generating Dependency View..." -ForegroundColor Cyan
    
    $mermaidContent = "graph TD`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Dependency
%%   Description: Shows what depends on what
"@
    $mermaidContent += "    $paramComment`n"
    
    # Add styling definitions
    $mermaidContent += "    %% Dependency View - Shows what depends on what`n"
    $mermaidContent += "    classDef focus fill:#ff6b6b,stroke:#333,stroke-width:2px`n"
    $mermaidContent += "    classDef dependency fill:#4ecdc4,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef dependent fill:#45b7d1,stroke:#333,stroke-width:1px`n"
    
    # Add focus entity if specified
    if ($focusEntity) {
        $mermaidContent += "    $focusEntity[`"$focusEntity`"]:::focus`n"
    }
    
    # Add direct FK relationships
    foreach ($fk in $relationships.directFK) {
        $source = $fk.source
        $target = $fk.target
        
        if ($focusEntity -and ($source -eq $focusEntity -or $target -eq $focusEntity)) {
            $mermaidContent += "    $source --> $target`n"
            if ($source -eq $focusEntity) {
                $mermaidContent += ":::dependent`n"
            } else {
                $mermaidContent += ":::dependency`n"
            }
        } elseif (-not $focusEntity) {
            $mermaidContent += "    $source --> $target`n"
        }
    }
    
    return $mermaidContent
}

function Generate-InfluenceView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "🎯 Generating Influence View..." -ForegroundColor Cyan
    
    $mermaidContent = "graph LR`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Influence
%%   Description: Shows what influences what
"@
    $mermaidContent += "    $paramComment`n"
    
    # Add styling definitions
    $mermaidContent += "    %% Influence View - Shows what influences what`n"
    $mermaidContent += "    classDef influencer fill:#ff9ff3,stroke:#333,stroke-width:2px`n"
    $mermaidContent += "    classDef influenced fill:#feca57,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef neutral fill:#48dbfb,stroke:#333,stroke-width:1px`n"
    
    # Add focus entity if specified
    if ($focusEntity) {
        $mermaidContent += "    $focusEntity[`"$focusEntity`"]:::influencer`n"
    }
    
    # Add relationships with influence direction
    foreach ($fk in $relationships.directFK) {
        $source = $fk.source
        $target = $fk.target
        
        if ($focusEntity -and ($source -eq $focusEntity -or $target -eq $focusEntity)) {
            $mermaidContent += "    $source -.-> $target`n"
            if ($source -eq $focusEntity) {
                $mermaidContent += ":::influenced`n"
            } else {
                $mermaidContent += ":::influencer`n"
            }
        } elseif (-not $focusEntity) {
            $mermaidContent += "    $source -.-> $target`n"
        }
    }
    
    return $mermaidContent
}

function Generate-HierarchyView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "🏗️ Generating Hierarchy View..." -ForegroundColor Cyan
    
    $mermaidContent = "graph TB`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Hierarchy
%%   Description: Shows parent-child relationships
"@
    $mermaidContent += "    $paramComment`n"
    
    # Add styling definitions
    $mermaidContent += "    %% Hierarchy View - Shows parent-child relationships`n"
    $mermaidContent += "    classDef root fill:#ff6b6b,stroke:#333,stroke-width:2px`n"
    $mermaidContent += "    classDef parent fill:#4ecdc4,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef child fill:#45b7d1,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef leaf fill:#96ceb4,stroke:#333,stroke-width:1px`n"
    
    # Build hierarchy from relationships
    $hierarchy = @{}
    $children = @{}
    $parents = @{}
    
    foreach ($fk in $relationships.directFK) {
        $parent = $fk.source
        $child = $fk.target
        
        if (-not $hierarchy.ContainsKey($parent)) {
            $hierarchy[$parent] = @()
        }
        $hierarchy[$parent] += $child
        
        if (-not $children.ContainsKey($child)) {
            $children[$child] = @()
        }
        $children[$child] += $parent
        
        if (-not $parents.ContainsKey($parent)) {
            $parents[$parent] = $true
        }
    }
    
    # Find root entities (no parents)
    $roots = @()
    foreach ($entity in $hierarchy.Keys) {
        if (-not $children.ContainsKey($entity)) {
            $roots += $entity
        }
    }
    
    # Add root entities
    foreach ($root in $roots | Select-Object -First 5) {
        $mermaidContent += "    $root[`"$root`"]:::root`n"
    }
    
    # Add hierarchy relationships
    foreach ($parent in $hierarchy.Keys | Select-Object -First 10) {
        foreach ($child in $hierarchy[$parent] | Select-Object -First 3) {
            $mermaidContent += "    $parent --> $child`n"
        }
    }
    
    return $mermaidContent
}

function Generate-NetworkView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "🌐 Generating Network View..." -ForegroundColor Cyan
    
    $mermaidContent = "graph TD`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Network
%%   Description: Shows all connections as a network
"@
    $mermaidContent += "    $paramComment`n"
    
    # Add styling definitions
    $mermaidContent += "    %% Network View - Shows all connections as a network`n"
    $mermaidContent += "    classDef hub fill:#ff6b6b,stroke:#333,stroke-width:3px`n"
    $mermaidContent += "    classDef node fill:#4ecdc4,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef connector fill:#45b7d1,stroke:#333,stroke-width:1px`n"
    
    # Calculate connection counts
    $connectionCounts = @{}
    foreach ($fk in $relationships.directFK) {
        $source = $fk.source
        $target = $fk.target
        
        if (-not $connectionCounts.ContainsKey($source)) {
            $connectionCounts[$source] = 0
        }
        if (-not $connectionCounts.ContainsKey($target)) {
            $connectionCounts[$target] = 0
        }
        
        $connectionCounts[$source]++
        $connectionCounts[$target]++
    }
    
    # Find hub entities (highly connected)
    $hubs = $connectionCounts.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5
    
    # Add hub entities
    foreach ($hub in $hubs) {
        $entity = $hub.Key
        $count = $hub.Value
        $mermaidContent += "    $entity[`"$entity ($count)`"]:::hub`n"
    }
    
    # Add network connections
    foreach ($fk in $relationships.directFK | Select-Object -First 15) {
        $source = $fk.source
        $target = $fk.target
        $mermaidContent += "    $source --- $target`n"
    }
    
    return $mermaidContent
}

function Generate-TimelineView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "⏰ Generating Timeline View..." -ForegroundColor Cyan
    
    $mermaidContent = "gantt`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Timeline
%%   Description: Shows entity complexity over time
"@
    $mermaidContent += "    $paramComment`n"
    
    $mermaidContent += "    title Relationship Timeline View`n"
    $mermaidContent += "    dateFormat  YYYY-MM-DD`n"
    $mermaidContent += "    section Core Entities`n"
    
    # Create timeline based on entity complexity/relationships
    $entityTimeline = @{}
    foreach ($entity in $entities | Select-Object -First 10) {
        $relatedCount = ($relationships.directFK | Where-Object { $_.source -eq $entity -or $_.target -eq $entity }).Count
        $entityTimeline[$entity] = $relatedCount
    }
    
    # Sort by relationship count (complexity)
    $sortedEntities = $entityTimeline.GetEnumerator() | Sort-Object Value -Descending
    
    $startDate = Get-Date
    foreach ($entity in $sortedEntities) {
        $name = $entity.Key
        $complexity = $entity.Value
        $duration = [math]::Max(1, [math]::Round($complexity / 2))
        
        $mermaidContent += "    $name : $name, $($startDate.ToString('yyyy-MM-dd')), ${duration}d`n"
        $startDate = $startDate.AddDays($duration)
    }
    
    return $mermaidContent
}

function Generate-ComparisonView {
    param(
        [object]$relationships,
        [array]$entities,
        [string]$focusEntity = "",
        [array]$domains = @(),
        [hashtable]$options = @{}
    )
    
    Write-Host "📊 Generating Comparison View..." -ForegroundColor Cyan
    
    $mermaidContent = "graph LR`n"
    
    # Add parameters as a comment (following base script pattern)
    $focusDisplay = if ($focusEntity) { $focusEntity } else { "None" }
    $domainsDisplay = if ($domains.Count -gt 0) { $domains -join ', ' } else { "All" }
    
    $paramComment = @"
%% Parameters:
%%   Focus: $focusDisplay
%%   Domains: $domainsDisplay
%%   View Type: Comparison
%%   Description: Side-by-side domain comparison
"@
    $mermaidContent += "    $paramComment`n"
    
    # Add styling definitions
    $mermaidContent += "    %% Comparison View - Side-by-side entity comparison`n"
    $mermaidContent += "    classDef primary fill:#ff6b6b,stroke:#333,stroke-width:2px`n"
    $mermaidContent += "    classDef secondary fill:#4ecdc4,stroke:#333,stroke-width:1px`n"
    $mermaidContent += "    classDef tertiary fill:#45b7d1,stroke:#333,stroke-width:1px`n"
    
    # Group entities by domain
    $domains = @{
        "partner" = @()
        "participant" = @()
        "programme" = @()
        "site" = @()
    }
    
    foreach ($entity in $entities) {
        foreach ($domain in $domains.Keys) {
            if ($entity -like "*$domain*") {
                $domains[$domain] += $entity
                break
            }
        }
    }
    
    # Create comparison sections
    $mermaidContent += "    subgraph Partner Domain`n"
    foreach ($entity in $domains["partner"] | Select-Object -First 3) {
        $mermaidContent += "        $entity[`"$entity`"]:::primary`n"
    }
    $mermaidContent += "    end`n"
    
    $mermaidContent += "    subgraph Participant Domain`n"
    foreach ($entity in $domains["participant"] | Select-Object -First 3) {
        $mermaidContent += "        $entity[`"$entity`"]:::secondary`n"
    }
    $mermaidContent += "    end`n"
    
    $mermaidContent += "    subgraph Programme Domain`n"
    foreach ($entity in $domains["programme"] | Select-Object -First 3) {
        $mermaidContent += "        $entity[`"$entity`"]:::tertiary`n"
    }
    $mermaidContent += "    end`n"
    
    return $mermaidContent
}

function Show-VisualizationMenu {
    param(
        [object]$relationships,
        [array]$entities
    )
    
    Write-Host "🎨 FKmermaid Relationship Visualization Menu" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Available Views:" -ForegroundColor Yellow
    Write-Host "  1. Dependency View - Shows what depends on what" -ForegroundColor White
    Write-Host "  2. Influence View - Shows what influences what" -ForegroundColor White
    Write-Host "  3. Hierarchy View - Shows parent-child relationships" -ForegroundColor White
    Write-Host "  4. Network View - Shows all connections as a network" -ForegroundColor White
    Write-Host "  5. Timeline View - Shows entity complexity over time" -ForegroundColor White
    Write-Host "  6. Comparison View - Side-by-side domain comparison" -ForegroundColor White
    Write-Host "  7. All Views - Generate all visualizations" -ForegroundColor White
    Write-Host ""
    Write-Host "Enter your choice (1-7): " -ForegroundColor Yellow -NoNewline
}

function Export-Visualization {
    param(
        [string]$mermaidContent,
        [string]$viewName,
        [string]$outputPath = ""
    )
    
    if (-not $outputPath) {
        $exportsPath = Get-ProjectPath -pathKey "exports"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $exportsPath "${viewName}_view_$timestamp.mmd"
    }
    
    try {
        $mermaidContent | Set-Content $outputPath
        Write-Host "Visualization exported to: $outputPath" -ForegroundColor Green
        
        # Use the same working Pako method as the base script
        $nodeScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "src\node\generate_url.js"
        
        # Check if Node.js tool exists
        if (Test-Path $nodeScriptPath) {
            # Use the working Node.js tool for proper pako compression
            $mermaidLiveUrl = $mermaidContent | node $nodeScriptPath
            
            Write-Host "🌐 Opening in Mermaid.live: $mermaidLiveUrl" -ForegroundColor Cyan
            
            # Non-blocking browser launch to prevent hanging
            try {
                Start-Job -ScriptBlock { param($url) Start-Process $url -WindowStyle Hidden } -ArgumentList $mermaidLiveUrl | Out-Null
                Write-Host "✅ Opened Mermaid.live with Pako compression" -ForegroundColor Green
            } catch {
                Write-Host "⚠️ Could not open browser automatically. Please copy this URL:" -ForegroundColor Yellow
                Write-Host $mermaidLiveUrl -ForegroundColor Cyan
            }
        } else {
            Write-Host "⚠️ Node.js tool not found, falling back to URL encoding" -ForegroundColor Yellow
            # Fallback to URL encoding
            $encodedContent = [Uri]::EscapeDataString($mermaidContent)
            $mermaidUrl = "https://mermaid.live/edit#$encodedContent"
            Start-Process $mermaidUrl
        }
        
        return $outputPath
    } catch {
        Write-Error "Failed to export visualization: $($_.Exception.Message)"
        return $null
    }
}

# Initialize relationship visualizer when module is loaded
Initialize-RelationshipVisualizer

# Test relationship visualizer if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Relationship Visualizer..." -ForegroundColor Cyan
    
    # Create test relationships
    $testRelationships = @{
        directFK = @(
            @{ source = "partner"; target = "member" },
            @{ source = "member"; target = "programme" },
            @{ source = "programme"; target = "activity" },
            @{ source = "activity"; target = "partner" },
            @{ source = "member"; target = "center" },
            @{ source = "center"; target = "media" }
        )
        joinTables = @()
    }
    
    $testEntities = @("partner", "member", "programme", "activity", "center", "media")
    
    # Generate all views
    Write-Host "`n🔗 Generating all relationship views..." -ForegroundColor Yellow
    
    $views = @{
        "Dependency" = Generate-DependencyView -relationships $testRelationships -entities $testEntities
        "Influence" = Generate-InfluenceView -relationships $testRelationships -entities $testEntities
        "Hierarchy" = Generate-HierarchyView -relationships $testRelationships -entities $testEntities
        "Network" = Generate-NetworkView -relationships $testRelationships -entities $testEntities
        "Timeline" = Generate-TimelineView -relationships $testRelationships -entities $testEntities
        "Comparison" = Generate-ComparisonView -relationships $testRelationships -entities $testEntities
    }
    
    foreach ($view in $views.GetEnumerator()) {
        Write-Host "`n📊 $($view.Key) View:" -ForegroundColor Cyan
        Write-Host $view.Value -ForegroundColor Gray
        Write-Host "---" -ForegroundColor DarkGray
    }
    
    Write-Host "`nRelationship Visualizer test completed!" -ForegroundColor Green
}