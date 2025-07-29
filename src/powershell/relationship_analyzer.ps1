# FKmermaid Relationship Analyzer
# Provides deeper entity mapping and relationship pattern analysis

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-RelationshipAnalyzer {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Relationship Analyzer initialized:" -ForegroundColor Green
    Write-Host "  Deep analysis enabled" -ForegroundColor Cyan
    Write-Host "  Pattern recognition active" -ForegroundColor Cyan
    Write-Host "  Cross-domain analysis ready" -ForegroundColor Cyan
}

function Analyze-RelationshipPatterns {
    param(
        [object]$relationships,
        [array]$entities,
        [hashtable]$options = @{}
    )
    
    $patterns = @{
        DirectFK = @()
        JoinTables = @()
        SelfReferences = @()
        CircularDependencies = @()
        CrossDomainRelationships = @()
        StrongRelationships = @()
        WeakRelationships = @()
        Patterns = @{}
    }
    
    # Analyze direct FK relationships
    foreach ($fk in $relationships.directFK) {
        $patterns.DirectFK += @{
            Source = $fk.source
            Target = $fk.target
            Strength = "Strong"
            Type = "Direct FK"
        }
    }
    
    # Analyze join table relationships
    foreach ($join in $relationships.joinTables) {
        $patterns.JoinTables += @{
            Table = $join.table
            Source = $join.source
            Target = $join.target
            Strength = "Medium"
            Type = "Join Table"
        }
    }
    
    # Detect self-referencing relationships
    foreach ($fk in $relationships.directFK) {
        if ($fk.source -eq $fk.target) {
            $patterns.SelfReferences += @{
                Entity = $fk.source
                Type = "Self-Reference"
            }
        }
    }
    
    # Detect circular dependencies
    $circularDeps = Find-CircularDependencies -relationships $relationships
    $patterns.CircularDependencies = $circularDeps
    
    # Analyze cross-domain relationships
    $crossDomain = Analyze-CrossDomainRelationships -relationships $relationships -entities $entities
    $patterns.CrossDomainRelationships = $crossDomain
    
    # Score relationship strength
    $patterns.StrongRelationships = $patterns.DirectFK | Where-Object { $_.Strength -eq "Strong" }
    $patterns.WeakRelationships = $patterns.JoinTables | Where-Object { $_.Strength -eq "Medium" }
    
    return $patterns
}

function Find-CircularDependencies {
    param(
        [object]$relationships
    )
    
    $circularDeps = @()
    $visited = @{}
    $recStack = @{}
    
    # Create adjacency list
    $graph = @{}
    foreach ($fk in $relationships.directFK) {
        if (-not $graph.ContainsKey($fk.source)) {
            $graph[$fk.source] = @()
        }
        $graph[$fk.source] += $fk.target
    }
    
    # DFS to find cycles
    foreach ($entity in $graph.Keys) {
        if (-not $visited.ContainsKey($entity)) {
            $cycle = Find-Cycle -graph $graph -entity $entity -visited $visited -recStack $recStack
            if ($cycle) {
                $circularDeps += $cycle
            }
        }
    }
    
    return $circularDeps
}

function Find-Cycle {
    param(
        [hashtable]$graph,
        [string]$entity,
        [hashtable]$visited,
        [hashtable]$recStack
    )
    
    $visited[$entity] = $true
    $recStack[$entity] = $true
    
    if ($graph.ContainsKey($entity)) {
        foreach ($neighbor in $graph[$entity]) {
            if (-not $visited.ContainsKey($neighbor)) {
                $cycle = Find-Cycle -graph $graph -entity $neighbor -visited $visited -recStack $recStack
                if ($cycle) {
                    return $cycle
                }
            } elseif ($recStack[$neighbor]) {
                # Found a cycle
                return @{
                    Cycle = @($entity, $neighbor)
                    Type = "Circular Dependency"
                }
            }
        }
    }
    
    $recStack[$entity] = $false
    return $null
}

function Analyze-CrossDomainRelationships {
    param(
        [object]$relationships,
        [array]$entities
    )
    
    $crossDomain = @()
    $domains = @{
        "partner" = @()
        "participant" = @()
        "programme" = @()
        "site" = @()
    }
    
    # Categorize entities by domain
    foreach ($entity in $entities) {
        foreach ($domain in $domains.Keys) {
            if ($entity -like "*$domain*") {
                $domains[$domain] += $entity
                break
            }
        }
    }
    
    # Find relationships between different domains
    foreach ($fk in $relationships.directFK) {
        $sourceDomain = Get-EntityDomain -entity $fk.source -domains $domains
        $targetDomain = Get-EntityDomain -entity $fk.target -domains $domains
        
        if ($sourceDomain -and $targetDomain -and $sourceDomain -ne $targetDomain) {
            $crossDomain += @{
                Source = $fk.source
                Target = $fk.target
                SourceDomain = $sourceDomain
                TargetDomain = $targetDomain
                Type = "Cross-Domain"
            }
        }
    }
    
    return $crossDomain
}

function Get-EntityDomain {
    param(
        [string]$entity,
        [hashtable]$domains
    )
    
    foreach ($domain in $domains.Keys) {
        if ($domains[$domain] -contains $entity) {
            return $domain
        }
    }
    return $null
}

function Calculate-RelationshipStrength {
    param(
        [object]$relationships,
        [array]$entities
    )
    
    $strengthScores = @{}
    
    # Calculate frequency-based strength
    foreach ($fk in $relationships.directFK) {
        $key = "$($fk.source)->$($fk.target)"
        if (-not $strengthScores.ContainsKey($key)) {
            $strengthScores[$key] = 0
        }
        $strengthScores[$key]++
    }
    
    # Normalize scores
    $maxScore = ($strengthScores.Values | Measure-Object -Maximum).Maximum
    foreach ($key in $strengthScores.Keys) {
        $strengthScores[$key] = [math]::Round(($strengthScores[$key] / $maxScore) * 100, 2)
    }
    
    return $strengthScores
}

function Generate-RelationshipReport {
    param(
        [object]$patterns,
        [hashtable]$strengthScores,
        [string]$outputPath = ""
    )
    
    if (-not $outputPath) {
        $resultsPath = Get-ProjectPath -pathKey "results"
        $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
        $outputPath = Join-Path $resultsPath "relationship_analysis_$timestamp.json"
    }
    
    $report = @{
        GeneratedAt = Get-Date
        Patterns = $patterns
        StrengthScores = $strengthScores
        Summary = @{
            TotalRelationships = $patterns.DirectFK.Count + $patterns.JoinTables.Count
            StrongRelationships = $patterns.StrongRelationships.Count
            WeakRelationships = $patterns.WeakRelationships.Count
            SelfReferences = $patterns.SelfReferences.Count
            CircularDependencies = $patterns.CircularDependencies.Count
            CrossDomainRelationships = $patterns.CrossDomainRelationships.Count
        }
    }
    
    try {
        $report | ConvertTo-Json -Depth 10 | Set-Content $outputPath
        Write-Host "Relationship analysis report exported to: $outputPath" -ForegroundColor Green
        return $outputPath
    } catch {
        Write-Error "Failed to export relationship report: $($_.Exception.Message)"
        return $null
    }
}

function Show-RelationshipDashboard {
    param(
        [object]$patterns,
        [hashtable]$strengthScores
    )
    
    Write-Host "🔍 FKmermaid Relationship Analysis Dashboard" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Summary statistics
    Write-Host "📊 Relationship Summary:" -ForegroundColor Yellow
    Write-Host "  Total Direct FK: $($patterns.DirectFK.Count)" -ForegroundColor White
    Write-Host "  Join Tables: $($patterns.JoinTables.Count)" -ForegroundColor White
    Write-Host "  Self References: $($patterns.SelfReferences.Count)" -ForegroundColor White
    Write-Host "  Circular Dependencies: $($patterns.CircularDependencies.Count)" -ForegroundColor $(if ($patterns.CircularDependencies.Count -eq 0) { "Green" } else { "Red" })
    Write-Host "  Cross-Domain: $($patterns.CrossDomainRelationships.Count)" -ForegroundColor White
    Write-Host ""
    
    # Strongest relationships
    if ($strengthScores.Count -gt 0) {
        Write-Host "💪 Strongest Relationships:" -ForegroundColor Yellow
        $topRelationships = $strengthScores.GetEnumerator() | Sort-Object Value -Descending | Select-Object -First 5
        foreach ($rel in $topRelationships) {
            Write-Host "  $($rel.Key): $($rel.Value)%" -ForegroundColor White
        }
        Write-Host ""
    }
    
    # Circular dependencies warning
    if ($patterns.CircularDependencies.Count -gt 0) {
        Write-Host "⚠️  Circular Dependencies Found:" -ForegroundColor Red
        foreach ($circular in $patterns.CircularDependencies) {
            Write-Host "  $($circular.Cycle -join ' -> ')" -ForegroundColor Red
        }
        Write-Host ""
    }
    
    # Cross-domain analysis
    if ($patterns.CrossDomainRelationships.Count -gt 0) {
        Write-Host "🌐 Cross-Domain Relationships:" -ForegroundColor Yellow
        foreach ($cross in $patterns.CrossDomainRelationships | Select-Object -First 5) {
            Write-Host "  $($cross.Source) ($($cross.SourceDomain)) -> $($cross.Target) ($($cross.TargetDomain))" -ForegroundColor White
        }
        Write-Host ""
    }
}

# Initialize relationship analyzer when module is loaded
Initialize-RelationshipAnalyzer

# Test relationship analyzer if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Relationship Analyzer..." -ForegroundColor Cyan
    
    # Create test relationships
    $testRelationships = @{
        directFK = @(
            @{ source = "partner"; target = "member" },
            @{ source = "member"; target = "programme" },
            @{ source = "programme"; target = "activity" },
            @{ source = "activity"; target = "partner" },  # Circular dependency
            @{ source = "partner"; target = "partner" }    # Self reference
        )
        joinTables = @(
            @{ table = "partner_member"; source = "partner"; target = "member" }
        )
    }
    
    $testEntities = @("partner", "member", "programme", "activity")
    
    # Analyze patterns
    $patterns = Analyze-RelationshipPatterns -relationships $testRelationships -entities $testEntities
    
    # Calculate strength scores
    $strengthScores = Calculate-RelationshipStrength -relationships $testRelationships -entities $testEntities
    
    # Show dashboard
    Show-RelationshipDashboard -patterns $patterns -strengthScores $strengthScores
    
    # Generate report
    $reportPath = Generate-RelationshipReport -patterns $patterns -strengthScores $strengthScores
    if ($reportPath) {
        Write-Host "Relationship analysis report exported to: $reportPath" -ForegroundColor Green
    }
    
    Write-Host "Relationship Analyzer test completed!" -ForegroundColor Green
}