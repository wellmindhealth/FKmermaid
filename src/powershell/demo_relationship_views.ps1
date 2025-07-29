# FKmermaid Relationship Views Demo
# Demonstrates different views of the same relationships

# Import modules
. (Join-Path $PSScriptRoot "config_manager.ps1")
. (Join-Path $PSScriptRoot "relationship_visualizer.ps1")

Write-Host "🎨 FKmermaid Relationship Views Demo" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "📋 What 'Different views of the same relationships' entails:" -ForegroundColor Yellow
Write-Host ""
Write-Host "Instead of just one ER diagram, we can create MULTIPLE perspectives" -ForegroundColor White
Write-Host "of the SAME relationship data to help developers and auditors" -ForegroundColor White
Write-Host "understand the codebase from different angles:" -ForegroundColor White
Write-Host ""

# Create sample relationships
$sampleRelationships = @{
    directFK = @(
        @{ source = "partner"; target = "member" },
        @{ source = "member"; target = "programme" },
        @{ source = "programme"; target = "activity" },
        @{ source = "activity"; target = "partner" },
        @{ source = "member"; target = "center" },
        @{ source = "center"; target = "media" },
        @{ source = "programme"; target = "guide" },
        @{ source = "guide"; target = "media" }
    )
    joinTables = @()
}

$sampleEntities = @("partner", "member", "programme", "activity", "center", "media", "guide")

# Define realistic parameters for demo
$focusEntity = "member"
$domains = @("participant", "programme")

Write-Host "🔗 Sample Relationships:" -ForegroundColor Yellow
foreach ($fk in $sampleRelationships.directFK) {
    Write-Host "  $($fk.source) -> $($fk.target)" -ForegroundColor White
}
Write-Host ""

Write-Host "📊 Demo Parameters:" -ForegroundColor Yellow
Write-Host "  Focus Entity: $focusEntity" -ForegroundColor White
Write-Host "  Domains: $($domains -join ', ')" -ForegroundColor White
Write-Host ""

Write-Host "📊 Now launching 6 DIFFERENT views in Mermaid.live:" -ForegroundColor Yellow
Write-Host ""

# 1. Dependency View
Write-Host "1️⃣ Launching DEPENDENCY VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Understand data dependencies and cascading effects" -ForegroundColor Gray
$dependencyView = Generate-DependencyView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $dependencyView -viewName "Dependency"
Write-Host ""

# 2. Influence View  
Write-Host "2️⃣ Launching INFLUENCE VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Understand control flow and data influence patterns" -ForegroundColor Gray
$influenceView = Generate-InfluenceView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $influenceView -viewName "Influence"
Write-Host ""

# 3. Hierarchy View
Write-Host "3️⃣ Launching HIERARCHY VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Understand organizational structure and inheritance" -ForegroundColor Gray
$hierarchyView = Generate-HierarchyView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $hierarchyView -viewName "Hierarchy"
Write-Host ""

# 4. Network View
Write-Host "4️⃣ Launching NETWORK VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Identify hubs, bottlenecks, and connection patterns" -ForegroundColor Gray
$networkView = Generate-NetworkView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $networkView -viewName "Network"
Write-Host ""

# 5. Timeline View
Write-Host "5️⃣ Launching TIMELINE VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Understand development complexity and evolution" -ForegroundColor Gray
$timelineView = Generate-TimelineView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $timelineView -viewName "Timeline"
Write-Host ""

# 6. Comparison View
Write-Host "6️⃣ Launching COMPARISON VIEW..." -ForegroundColor Cyan
Write-Host "   Purpose: Compare different domains and their relationships" -ForegroundColor Gray
$comparisonView = Generate-ComparisonView -relationships $sampleRelationships -entities $sampleEntities -focusEntity $focusEntity -domains $domains
Export-Visualization -mermaidContent $comparisonView -viewName "Comparison"
Write-Host ""

Write-Host "🎯 Benefits of Multiple Views:" -ForegroundColor Yellow
Write-Host "  • Developers: Understand code structure from different angles" -ForegroundColor White
Write-Host "  • Auditors: Verify relationships and data flows" -ForegroundColor White
Write-Host "  • Architects: Plan refactoring and optimization" -ForegroundColor White
Write-Host "  • Business: Understand data relationships and dependencies" -ForegroundColor White
Write-Host ""

Write-Host "🔗 Integration with diagramType:" -ForegroundColor Yellow
Write-Host "  • These views can be integrated as new diagramType options" -ForegroundColor White
Write-Host "  • Example: diagramType='dependency', 'influence', 'hierarchy', etc." -ForegroundColor White
Write-Host "  • Each view provides a different perspective of the same data" -ForegroundColor White
Write-Host ""

Write-Host "Demo completed! All 6 views should now be open in Mermaid.live tabs." -ForegroundColor Cyan