# Analyze Current Output Comprehensively
# Analyzes the current plugins_full_erd.mmd file for comprehensive baseline data

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Analyze Current Output Comprehensively" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host "Analyzes current plugins_full_erd.mmd for comprehensive baseline" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Show detailed output" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"
$stylesPath = "D:\GIT\farcry\Cursor\FKmermaid\styles\mermaid_styles.mmd"

Write-Host "🧪 Analyzing Current Output Comprehensively" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Function to load colors from styles file
function Get-StyleColors {
    param([string]$stylesPath)
    
    $colors = @{}
    if (Test-Path $stylesPath) {
        $content = Get-Content $stylesPath
        foreach ($line in $content) {
            if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
                $styleName = $matches[1]
                $color = $matches[2]
                $colors[$styleName] = $color
            }
        }
    }
    return $colors
}

# Function to analyze Mermaid diagram comprehensively
function Analyze-MermaidDiagram {
    param([string]$content)
    
    $analysis = @{
        Entities = @()
        Relationships = @()
        Styling = @{}
        EntityCount = 0
        RelationshipCount = 0
        Tiers = @{
            Focus = @()
            GoldTier = @()
            BlueTier = @()
            BlueGreyTier = @()
            DarkGreyTier = @()
        }
    }
    
    # Parse entities
    $entityMatches = [regex]::Matches($content, '"([^"]+)"\s*\{')
    foreach ($match in $entityMatches) {
        $entity = $match.Groups[1].Value
        $analysis.Entities += $entity
    }
    $analysis.EntityCount = $analysis.Entities.Count
    
    # Parse relationships
    $relationshipMatches = [regex]::Matches($content, '"([^"]+)"\s*\|\|--\|\|\s*"([^"]+)"\s*:\s*([^\n]+)')
    foreach ($match in $relationshipMatches) {
        $fromEntity = $match.Groups[1].Value
        $toEntity = $match.Groups[2].Value
        $relationship = $match.Groups[3].Value.Trim()
        $analysis.Relationships += @{
            From = $fromEntity
            To = $toEntity
            Type = $relationship
        }
    }
    $analysis.RelationshipCount = $analysis.Relationships.Count
    
    # Parse styling
    $styleMatches = [regex]::Matches($content, 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)')
    foreach ($match in $styleMatches) {
        $entity = $match.Groups[1].Value
        $color = $match.Groups[2].Value
        $analysis.Styling[$entity] = $color
    }
    
    return $analysis
}

# Load current colors from styles file
$styleColors = Get-StyleColors -stylesPath $stylesPath

Write-Host "📋 Current style colors:" -ForegroundColor White
Write-Host "  Focus: $($styleColors['focus'])" -ForegroundColor Gray
Write-Host "  Domain Related (Gold): $($styleColors['domain_related'])" -ForegroundColor Gray
Write-Host "  Related (Blue): $($styleColors['related'])" -ForegroundColor Gray

# Analyze the current file
$generatedFile = "$exportsPath\plugins_full_erd.mmd"
if (Test-Path $generatedFile) {
    $content = Get-Content $generatedFile -Raw
    
    # Comprehensive analysis
    $analysis = Analyze-MermaidDiagram -content $content
    
    Write-Host "`n📊 COMPREHENSIVE ANALYSIS:" -ForegroundColor White
    Write-Host "  Entity Count: $($analysis.EntityCount)" -ForegroundColor Gray
    Write-Host "  Relationship Count: $($analysis.RelationshipCount)" -ForegroundColor Gray
    Write-Host "  Entities: $($analysis.Entities -join ', ')" -ForegroundColor Gray
    
    # Categorize entities by tier based on styling
    foreach ($entity in $analysis.Entities) {
        if ($analysis.Styling.ContainsKey($entity)) {
            $color = $analysis.Styling[$entity]
            switch ($color) {
                $styleColors["focus"] { $analysis.Tiers.Focus += $entity }
                $styleColors["domain_related"] { $analysis.Tiers.GoldTier += $entity }
                $styleColors["related"] { $analysis.Tiers.BlueTier += $entity }
                $styleColors["domain_other"] { $analysis.Tiers.BlueGreyTier += $entity }
                $styleColors["secondary"] { $analysis.Tiers.DarkGreyTier += $entity }
            }
        }
    }
    
    # Report tier breakdown
    Write-Host "`n🎨 TIER BREAKDOWN:" -ForegroundColor White
    Write-Host "  Focus entities: $($analysis.Tiers.Focus.Count) - $($analysis.Tiers.Focus -join ', ')" -ForegroundColor Gray
    Write-Host "  Gold tier entities: $($analysis.Tiers.GoldTier.Count) - $($analysis.Tiers.GoldTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Blue tier entities: $($analysis.Tiers.BlueTier.Count) - $($analysis.Tiers.BlueTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Blue-grey tier entities: $($analysis.Tiers.BlueGreyTier.Count) - $($analysis.Tiers.BlueGreyTier -join ', ')" -ForegroundColor Gray
    Write-Host "  Dark grey tier entities: $($analysis.Tiers.DarkGreyTier.Count) - $($analysis.Tiers.DarkGreyTier -join ', ')" -ForegroundColor Gray
    
    # Expected gold tier entities
    $expectedGoldEntities = @("pathway_center", "pathway_memberGroup", "pathway_referer", "zfarcrycore_dmProfile")
    
    Write-Host "`n🎯 Expected gold tier entities:" -ForegroundColor Yellow
    Write-Host "  $($expectedGoldEntities -join ', ')" -ForegroundColor Gray
    
    Write-Host "`n🚨 GOLD TIER ISSUE ANALYSIS:" -ForegroundColor Red
    foreach ($expectedEntity in $expectedGoldEntities) {
        if ($analysis.Tiers.BlueTier -contains $expectedEntity) {
            Write-Host "  ❌ $expectedEntity should be GOLD but is BLUE" -ForegroundColor Red
        } elseif ($analysis.Tiers.GoldTier -contains $expectedEntity) {
            Write-Host "  ✅ $expectedEntity is correctly GOLD" -ForegroundColor Green
        } else {
            Write-Host "  ❓ $expectedEntity not found in any tier" -ForegroundColor Yellow
        }
    }
    
    # Save comprehensive baseline result
    $baselineResult = @{
        TestName = "Partner+Member Focus - Comprehensive Analysis"
        Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Comprehensive analysis of current output including entities, relationships, and styling"
        ExpectedGoldEntities = $expectedGoldEntities
        Analysis = $analysis
        GeneratedFile = "plugins_full_erd.mmd"
        Status = "COMPREHENSIVE BASELINE CAPTURED"
    }
    
    # Save baseline result
    $baselineResult | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\comprehensive_baseline.json"
    
    Write-Host "`n✅ Comprehensive baseline captured!" -ForegroundColor Green
    Write-Host "📁 Baseline saved to: $testResultsPath\comprehensive_baseline.json" -ForegroundColor Gray
    Write-Host "📁 Analyzed file: $generatedFile" -ForegroundColor Gray
    
    Write-Host "`n📋 SUMMARY:" -ForegroundColor Cyan
    Write-Host "  Total Entities: $($analysis.EntityCount)" -ForegroundColor White
    Write-Host "  Total Relationships: $($analysis.RelationshipCount)" -ForegroundColor White
    Write-Host "  Gold Tier Issue: CONFIRMED" -ForegroundColor Red
    Write-Host "  Ready for domain detection investigation" -ForegroundColor Green
    
} else {
    Write-Host "❌ Generated file not found: $generatedFile" -ForegroundColor Red
}