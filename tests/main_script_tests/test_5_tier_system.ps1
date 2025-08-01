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
    
    # Categorize entities into tiers based on colors
    foreach ($entity in $analysis.Entities) {
        if ($analysis.Styling.ContainsKey($entity)) {
            $color = $analysis.Styling[$entity]
            switch ($color) {
                "#d75500" { $analysis.Tiers["focus"] += $entity }  # Gold tier
                "#693a00" { $analysis.Tiers["domain_related"] += $entity }  # Bronze tier
                "#1963d2" { $analysis.Tiers["related"] += $entity }  # Blue tier
                "#44517f" { $analysis.Tiers["domain_other"] += $entity }  # Gray tier
                "#1a1a1a" { $analysis.Tiers["secondary"] += $entity }  # Black tier
                "#8e24aa" { $analysis.Tiers["secondary"] += $entity }  # Purple tier (SSQ entities)
                default { 
                    Write-Host "⚠️  Unknown color tier for $entity : $color" -ForegroundColor Yellow
                    $analysis.Tiers["secondary"] += $entity  # Default to secondary
                }
            }
        } else {
            Write-Host "⚠️  No styling found for $entity" -ForegroundColor Yellow
            $analysis.Tiers["secondary"] += $entity  # Default to secondary
        }
    }
    
    return $analysis
}

# Load the baseline file
$baselineFile = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines\Perfect_5-Tier_Test.mmd"

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

# Expected tiers for 5-tier system (partner,member,programme focus with partner,participant,programme domains)
$ExpectedTiers = @{
    "focus" = @("pathway_partner", "pathway_member", "pathway_programme")  # Orange tier (#d75500)
    "domain_related" = @("pathway_center", "pathway_intake", "pathway_memberGroup", "pathway_progRole", "pathway_referer", "pathway_ruleSelfRegistration", "pathway_report", "pathway_testimonial", "zfarcrycore_dmProfile", "zfarcrycore_farGroup")  # Gold tier (#693a00)
    "related" = @("pathway_activityDef", "pathway_media", "pathway_dmImage", "pathway_journalDef", "pathway_memberType", "pathway_progMember", "pathway_trackerDef", "zfarcrycore_dmFile", "farcrycms_farFeedback")  # Blue tier (#1963d2)
    "domain_other" = @("zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser", "zfarcrycore_farWebtopDashboard")  # Blue-grey tier (#44517f)
    "secondary" = @("pathway_activity", "pathway_journal", "pathway_library", "pathway_tracker", "pathway_dmNavigation", "pathway_dmNews", "farcrycms_dmEmail", "farcrycms_dmFacts", "zfarcrycore_dmHTML", "zfarcrycore_dmInclude", "zfarcrycore_farBarnacle")  # Dark grey tier (#1a1a1a) - excludes SSQ entities (purple)
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
            # For secondary tier, exclude SSQ entities since they have their own purple styling
            if ($tier -eq "secondary" -and $entity -like "*SSQ_*") {
                continue
            }
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