# FKmermaid Impact Analyzer
# Analyzes the impact of changes on entities and relationships

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-ImpactAnalyzer {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Impact Analyzer initialized:" -ForegroundColor Green
    Write-Host "  Change impact analysis enabled" -ForegroundColor Cyan
    Write-Host "  Dependency chain tracking active" -ForegroundColor Cyan
    Write-Host "  Risk assessment ready" -ForegroundColor Cyan
}

function Analyze-ChangeImpact {
    param(
        [string]$targetEntity,
        [object]$relationships,
        [array]$entities,
        [string]$changeType = "modification",
        [hashtable]$options = @{}
    )
    
    $impact = @{
        DirectImpact = @()
        IndirectImpact = @()
        DependencyChain = @()
        RiskLevel = "Low"
        AffectedEntities = @()
        Recommendations = @()
    }
    
    # Find direct relationships
    $directRelationships = $relationships.directFK | Where-Object { 
        $_.source -eq $targetEntity -or $_.target -eq $targetEntity 
    }
    
    foreach ($rel in $directRelationships) {
        $impact.DirectImpact += @{
            Relationship = $rel
            ImpactType = if ($rel.source -eq $targetEntity) { "Source" } else { "Target" }
            Severity = "High"
        }
        
        # Add affected entity
        $affectedEntity = if ($rel.source -eq $targetEntity) { $rel.target } else { $rel.source }
        if ($affectedEntity -notin $impact.AffectedEntities) {
            $impact.AffectedEntities += $affectedEntity
        }
    }
    
    # Find indirect relationships (2nd level)
    $indirectEntities = $impact.AffectedEntities | ForEach-Object {
        $relationships.directFK | Where-Object { 
            $_.source -eq $_ -or $_.target -eq $_ 
        } | ForEach-Object { 
            if ($_.source -eq $_) { $_.target } else { $_.source }
        }
    } | Where-Object { $_ -ne $targetEntity -and $_ -notin $impact.AffectedEntities }
    
    foreach ($entity in $indirectEntities) {
        $impact.IndirectImpact += @{
            Entity = $entity
            Distance = 2
            Severity = "Medium"
        }
        $impact.AffectedEntities += $entity
    }
    
    # Build dependency chain
    $impact.DependencyChain = Build-DependencyChain -targetEntity $targetEntity -relationships $relationships
    
    # Assess risk level
    $impact.RiskLevel = Assess-RiskLevel -impact $impact -changeType $changeType
    
    # Generate recommendations
    $impact.Recommendations = Generate-Recommendations -impact $impact -changeType $changeType
    
    return $impact
}

function Build-DependencyChain {
    param(
        [string]$targetEntity,
        [object]$relationships
    )
    
    $chain = @()
    $visited = @{}
    $queue = @($targetEntity)
    $visited[$targetEntity] = 0
    
    while ($queue.Count -gt 0) {
        $current = $queue[0]
        $queue = $queue[1..($queue.Count-1)]
        $depth = $visited[$current]
        
        # Find all relationships involving current entity
        $relatedEntities = $relationships.directFK | Where-Object { 
            $_.source -eq $current -or $_.target -eq $current 
        } | ForEach-Object { 
            if ($_.source -eq $current) { $_.target } else { $_.source }
        }
        
        foreach ($entity in $relatedEntities) {
            if (-not $visited.ContainsKey($entity)) {
                $visited[$entity] = $depth + 1
                $queue += $entity
                
                $chain += @{
                    Entity = $entity
                    Depth = $depth + 1
                    Path = "$targetEntity -> $entity"
                }
            }
        }
    }
    
    return $chain | Sort-Object Depth
}

function Assess-RiskLevel {
    param(
        [object]$impact,
        [string]$changeType
    )
    
    $riskScore = 0
    
    # Base risk based on change type
    switch ($changeType.ToLower()) {
        "deletion" { $riskScore += 50 }
        "modification" { $riskScore += 20 }
        "addition" { $riskScore += 10 }
        default { $riskScore += 15 }
    }
    
    # Risk based on number of affected entities
    $affectedCount = $impact.AffectedEntities.Count
    if ($affectedCount -gt 10) { $riskScore += 30 }
    elseif ($affectedCount -gt 5) { $riskScore += 20 }
    elseif ($affectedCount -gt 2) { $riskScore += 10 }
    
    # Risk based on dependency chain depth
    $maxDepth = ($impact.DependencyChain | Measure-Object -Maximum Depth).Maximum
    if ($maxDepth -gt 3) { $riskScore += 20 }
    elseif ($maxDepth -gt 2) { $riskScore += 10 }
    
    # Determine risk level
    if ($riskScore -gt 70) { return "Critical" }
    elseif ($riskScore -gt 50) { return "High" }
    elseif ($riskScore -gt 30) { return "Medium" }
    else { return "Low" }
}

function Generate-Recommendations {
    param(
        [object]$impact,
        [string]$changeType
    )
    
    $recommendations = @()
    
    # Recommendations based on risk level
    switch ($impact.RiskLevel) {
        "Critical" {
            $recommendations += "Perform comprehensive testing before deployment"
            $recommendations += "Consider breaking change into smaller increments"
            $recommendations += "Review all affected entities thoroughly"
        }
        "High" {
            $recommendations += "Test all direct relationships"
            $recommendations += "Monitor for unexpected side effects"
            $recommendations += "Update documentation for affected entities"
        }
        "Medium" {
            $recommendations += "Test primary relationships"
            $recommendations += "Review indirect impacts"
        }
        "Low" {
            $recommendations += "Standard testing procedures"
        }
    }
    
    # Specific recommendations based on change type
    switch ($changeType.ToLower()) {
        "deletion" {
            $recommendations += "Ensure no critical dependencies exist"
            $recommendations += "Plan data migration if needed"
        }
        "modification" {
            $recommendations += "Maintain backward compatibility where possible"
            $recommendations += "Update any hardcoded references"
        }
        "addition" {
            $recommendations += "Validate new relationships"
            $recommendations += "Update existing queries if needed"
        }
    }
    
    return $recommendations
}

function Show-ImpactDashboard {
    param(
        [object]$impact,
        [string]$targetEntity,
        [string]$changeType
    )
    
    Write-Host "🎯 FKmermaid Impact Analysis Dashboard" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "📋 Change Analysis:" -ForegroundColor Yellow
    Write-Host "  Target Entity: $targetEntity" -ForegroundColor White
    Write-Host "  Change Type: $changeType" -ForegroundColor White
    Write-Host "  Risk Level: $($impact.RiskLevel)" -ForegroundColor $(if ($impact.RiskLevel -eq "Critical" -or $impact.RiskLevel -eq "High") { "Red" } else { "Green" })
    Write-Host ""
    
    Write-Host "📊 Impact Summary:" -ForegroundColor Yellow
    Write-Host "  Direct Impacts: $($impact.DirectImpact.Count)" -ForegroundColor White
    Write-Host "  Indirect Impacts: $($impact.IndirectImpact.Count)" -ForegroundColor White
    Write-Host "  Total Affected: $($impact.AffectedEntities.Count)" -ForegroundColor White
    Write-Host "  Dependency Depth: $($impact.DependencyChain.Count)" -ForegroundColor White
    Write-Host ""
    
    if ($impact.DirectImpact.Count -gt 0) {
        Write-Host "🔗 Direct Relationships:" -ForegroundColor Yellow
        foreach ($direct in $impact.DirectImpact | Select-Object -First 5) {
            $rel = $direct.Relationship
            Write-Host "  $($rel.source) -> $($rel.target) ($($direct.ImpactType))" -ForegroundColor White
        }
        Write-Host ""
    }
    
    if ($impact.IndirectImpact.Count -gt 0) {
        Write-Host "🔗 Indirect Relationships:" -ForegroundColor Yellow
        foreach ($indirect in $impact.IndirectImpact | Select-Object -First 5) {
            Write-Host "  $($indirect.Entity) (Distance: $($indirect.Distance))" -ForegroundColor White
        }
        Write-Host ""
    }
    
    if ($impact.Recommendations.Count -gt 0) {
        Write-Host "💡 Recommendations:" -ForegroundColor Yellow
        foreach ($rec in $impact.Recommendations) {
            Write-Host "  • $rec" -ForegroundColor White
        }
        Write-Host ""
    }
}

function Generate-ImpactReport {
    param(
        [object]$impact,
        [string]$targetEntity,
        [string]$changeType,
        [string]$outputPath = ""
    )
    
    if (-not $outputPath) {
        $resultsPath = Get-ProjectPath -pathKey "results"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $resultsPath "impact_analysis_${targetEntity}_$timestamp.json"
    }
    
    $report = @{
        GeneratedAt = Get-Date
        TargetEntity = $targetEntity
        ChangeType = $changeType
        Impact = $impact
        Summary = @{
            RiskLevel = $impact.RiskLevel
            TotalAffected = $impact.AffectedEntities.Count
            DirectImpacts = $impact.DirectImpact.Count
            IndirectImpacts = $impact.IndirectImpact.Count
            DependencyDepth = $impact.DependencyChain.Count
        }
    }
    
    try {
        $report | ConvertTo-Json -Depth 10 | Set-Content $outputPath
        Write-Host "Impact analysis report exported to: $outputPath" -ForegroundColor Green
        return $outputPath
    } catch {
        Write-Error "Failed to export impact report: $($_.Exception.Message)"
        return $null
    }
}

# Initialize impact analyzer when module is loaded
Initialize-ImpactAnalyzer

# Test impact analyzer if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Impact Analyzer..." -ForegroundColor Cyan
    
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
    
    # Analyze impact of changing "member"
    $impact = Analyze-ChangeImpact -targetEntity "member" -relationships $testRelationships -entities $testEntities -changeType "modification"
    
    # Show dashboard
    Show-ImpactDashboard -impact $impact -targetEntity "member" -changeType "modification"
    
    # Generate report
    $reportPath = Generate-ImpactReport -impact $impact -targetEntity "member" -changeType "modification"
    if ($reportPath) {
        Write-Host "Impact analysis report exported to: $reportPath" -ForegroundColor Green
    }
    
    Write-Host "Impact Analyzer test completed!" -ForegroundColor Green
}