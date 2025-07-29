# Test 5-tier semantic styling system
# This test validates that the 5-tier system works correctly with known baseline

Write-Host "🎨 Testing 5-tier semantic styling system..." -ForegroundColor Cyan

# Function to analyze Mermaid diagram
function Analyze-MermaidDiagram {
    param([string]$content)
    
    $analysis = @{
        Entities = @()
        Relationships = @()
        Styling = @{}
        EntityCount = 0
        RelationshipCount = 0
        Tiers = @{
            "focus" = @()
            "domain_related" = @()
            "related" = @()
            "domain_other" = @()
            "secondary" = @()
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

# Load the baseline file
$baselineFile = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines\Edge_Case_Multiple_Focus_Entities.mmd"

if (-not (Test-Path $baselineFile)) {
    Write-Host "❌ Baseline file not found: $baselineFile" -ForegroundColor Red
    Write-Host "   Run generate_baselines.ps1 first to create baseline files" -ForegroundColor Yellow
    exit 1
}

Write-Host "📁 Using baseline: $baselineFile" -ForegroundColor Green

# Analyze the baseline
$baselineContent = Get-Content $baselineFile -Raw
$analysis = Analyze-MermaidDiagram -content $baselineContent

Write-Host "📊 Baseline Analysis:" -ForegroundColor Yellow
Write-Host "   Entities: $($analysis.EntityCount)" -ForegroundColor Gray
Write-Host "   Relationships: $($analysis.RelationshipCount)" -ForegroundColor Gray
Write-Host "   Tiers found: $($analysis.Tiers.Count)" -ForegroundColor Gray

# Expected tiers for 5-tier system (partner domain with partner,member focus)
$ExpectedTiers = @{
    "focus" = @("pathway_partner", "pathway_member", "pathway_programme")  # Orange tier
    "domain_related" = @("pathway_partner", "pathway_memberGroup", "pathway_memberType")  # Gold tier (same domain + related)
    "related" = @("pathway_progMember", "pathway_center", "pathway_guide")  # Blue tier (related but different domain)
    "domain_other" = @("pathway_activity", "pathway_activityDef", "pathway_media")  # Blue-grey tier (same domain, not related)
    "secondary" = @("pathway_journal", "pathway_library", "pathway_testimonial")  # Dark grey tier (other domains)
}

# Validate tiers
$tierValidation = @{}
foreach ($tier in $ExpectedTiers.Keys) {
    $expectedEntities = $ExpectedTiers[$tier]
    $actualEntities = $analysis.Tiers[$tier]
    
    if ($actualEntities) {
        $missing = @()
        $extra = @()
        
        foreach ($entity in $expectedEntities) {
            if ($entity -notin $actualEntities) {
                $missing += $entity
            }
        }
        
        foreach ($entity in $actualEntities) {
            if ($entity -notin $expectedEntities) {
                $extra += $entity
            }
        }
        
        $tierValidation[$tier] = @{
            Valid = ($missing.Count -eq 0 -and $extra.Count -eq 0)
            Missing = $missing
            Extra = $extra
        }
    } else {
        $tierValidation[$tier] = @{
            Valid = $false
            Missing = $expectedEntities
            Extra = @()
        }
    }
}

# Report results
$allValid = $true
Write-Host "`n🎯 Tier Validation Results:" -ForegroundColor Cyan

foreach ($tier in $tierValidation.Keys) {
    $validation = $tierValidation[$tier]
    if ($validation.Valid) {
        Write-Host "   ✅ $tier tier: Valid" -ForegroundColor Green
    } else {
        $allValid = $false
        Write-Host "   ❌ $tier tier: Invalid" -ForegroundColor Red
        if ($validation.Missing.Count -gt 0) {
            Write-Host "      Missing: $($validation.Missing -join ', ')" -ForegroundColor Yellow
        }
        if ($validation.Extra.Count -gt 0) {
            Write-Host "      Extra: $($validation.Extra -join ', ')" -ForegroundColor Yellow
        }
    }
}

if ($allValid) {
    Write-Host "`n✅ 5-tier system test PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ 5-tier system test FAILED!" -ForegroundColor Red
    exit 1
}