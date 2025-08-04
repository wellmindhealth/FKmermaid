# Comprehensive Mermaid Diagram Validation Script
# Validates all diagrams against domains.json and cfc_cache.json

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"
$VerbosePreference = "Continue"

# Get base path
$basePath = "D:\GIT\farcry\Cursor\FKmermaid"

# Load configuration files
$domainsConfig = Get-Content -Path "$basePath\config\domains.json" | ConvertFrom-Json
$cfcCache = Get-Content -Path "$basePath\config\cfc_cache.json" | ConvertFrom-Json

# Initialize results storage
$results = @{
    TotalDiagrams = 0
    DiagramsWithIssues = 0
    IssuesByType = @{
        EntityPresence = 0
        LayerRepresentation = 0
        RelationshipAccuracy = 0
        DomainBoundaries = 0
        StyleLogic = 0
    }
    DetailedResults = @{}
}

function Get-EntityLayer {
    param(
        [string]$entityName,
        [PSCustomObject]$domainsConfig
    )

    # Strip plugin prefix if present
    $baseEntityName = $entityName -replace '^[^_]+_', ''
    
    # Debug output
    Write-Debug "Checking entity: '$entityName' -> base name: '$baseEntityName'"

    # Check each domain
    foreach ($domain in $domainsConfig.domains.PSObject.Properties) {
        if ($domain.Name -ne "catchall") {
            foreach ($layer in $domain.Value.entities.PSObject.Properties) {
                if ($layer.Value -contains $baseEntityName) {
                    Write-Debug "Found '$baseEntityName' in domain '$($domain.Name)' layer '$($layer.Name)'"
                    return @{
                        Layer = $layer.Name
                        Domain = $domain.Name
                    }
                }
            }
        }
    }

    # Check catchall
    if ($domainsConfig.catchall) {
        foreach ($layer in $domainsConfig.catchall.entities.PSObject.Properties) {
            if ($layer.Value -contains $baseEntityName) {
                Write-Debug "Found '$baseEntityName' in catchall layer '$($layer.Name)'"
                return @{
                    Layer = $layer.Name
                    Domain = "catchall"
                }
            }
        }
    }

    Write-Debug "Entity '$baseEntityName' not found in any domain"
    return @{
        Layer = "unknown"
        Domain = "unknown"
    }
}

function Test-RelationshipCompleteness {
    param(
        [string]$diagramPath,
        [string]$focusEntity,
        [array]$relationships,
        [PSCustomObject]$cfcCache
    )

    $issues = @()
    
    # Get expected relationships from cache
    $expectedRels = @()
    
    # Direct FK relationships
    $directFKs = $cfcCache.directFK | Where-Object { $_.from -eq $focusEntity -or $_.to -eq $focusEntity }
    foreach ($fk in $directFKs) {
        $expectedRels += @{
            From = $fk.from
            To = $fk.to
            Type = "direct"
        }
    }

    # Join table relationships
    $joinTables = $cfcCache.joinTables | Where-Object { $_.from -eq $focusEntity -or $_.to -eq $focusEntity }
    foreach ($jt in $joinTables) {
        $expectedRels += @{
            From = $jt.from
            To = $jt.to
            Type = "join"
        }
    }

    # Compare expected vs actual
    foreach ($expected in $expectedRels) {
        $found = $false
        foreach ($actual in $relationships) {
            if (($actual.From -eq $expected.From -and $actual.To -eq $expected.To) -or
                ($actual.From -eq $expected.To -and $actual.To -eq $expected.From)) {
                $found = $true
                break
            }
        }
        if (-not $found) {
            $issues += "Missing relationship: $($expected.From) -> $($expected.To) ($($expected.Type))"
        }
    }

    return $issues
}

function Test-StyleLogic {
    param(
        [string]$diagramPath,
        [string]$focusEntity,
        [array]$entities,
        [array]$relationships
    )

    $issues = @()
    $directlyConnected = @()

    # Find directly connected entities
    foreach ($rel in $relationships) {
        if ($rel.From -eq $focusEntity) {
            $directlyConnected += $rel.To
        }
        elseif ($rel.To -eq $focusEntity) {
            $directlyConnected += $rel.From
        }
    }

    # Verify colors based on 5-tier styling logic
    foreach ($entity in $entities) {
        $expectedColor = if ($entity.Name -eq $focusEntity) {
            "#d76400" # Orange - Focus tier
        }
        elseif ($directlyConnected -contains $entity.Name) {
            # Check if directly connected entity is from same domain or different domain
            $entityDomain = (Get-EntityLayer -entityName $entity.Name -domainsConfig $domainsConfig).Domain
            $focusDomain = (Get-EntityLayer -entityName $focusEntity -domainsConfig $domainsConfig).Domain
            
            if ($entityDomain -eq $focusDomain) {
                "#9d3100" # Rust - Domain-related tier (same domain, direct connection)
            }
            else {
                "#883583" # Magenta - Related tier (different domain, direct connection)
            }
        }
        else {
            "#7e4f2b" # Dark grey - Domain-other tier (no direct connection)
        }

        if ($entity.Style -notmatch $expectedColor) {
            $issues += "Incorrect style for $($entity.Name): Expected $expectedColor, got $($entity.Style)"
        }
    }

    return $issues
}

# Main validation loop
$mmdFiles = Get-ChildItem -Path "$basePath\exports\pre_generated\*.mmd"
$results.TotalDiagrams = $mmdFiles.Count

foreach ($mmdFile in $mmdFiles) {
    Write-Verbose "Processing $($mmdFile.Name)..."
    
    $content = Get-Content $mmdFile.FullName -Raw
    $diagramIssues = @()

    # Extract focus entity and domains
    if ($content -match '%%\s+Focus:\s+(\w+)') {
        $focusEntity = $matches[1]
    }
    if ($content -match '%%\s+Domains:\s+(.+)') {
        $domains = $matches[1].Split(',').Trim()
    }

    # Parse entities and relationships
    $entities = @()
    $relationships = @()

    # Extract entities
    $entityMatches = [regex]::Matches($content, '"([^"]+)"\s*\{([^}]+)\}')
    foreach ($match in $entityMatches) {
        $entityName = $match.Groups[1].Value
        $entityContent = $match.Groups[2].Value

        # Extract style from the separate styling section
        $style = "unknown"
        if ($content -match "style\s+$([regex]::Escape($entityName))\s+fill:(#[0-9a-f]{6})") {
            $style = $matches[1]
        }

        # Debug: Log style extraction for first few entities
        if ($entities.Count -lt 3) {
            Write-Debug "Entity: $entityName, Style: $style"
        }

        $entities += @{
            Name = $entityName
            Content = $entityContent
            Style = $style
        }
    }

    # Extract relationships
    $relMatches = [regex]::Matches($content, '"([^"]+)"\s+(\|\|--\|\||}o--\|\|)\s+"([^"]+)"\s*:\s*([^\r\n]+)')
    foreach ($match in $relMatches) {
        $relationships += @{
            From = $match.Groups[1].Value
            To = $match.Groups[3].Value
            Type = $match.Groups[2].Value
            Label = $match.Groups[4].Value
        }
    }

    # Run validations
    # 1. Entity Layer Representation
    foreach ($entity in $entities) {
        $expectedLayer = (Get-EntityLayer -entityName $entity.Name -domainsConfig $domainsConfig).Layer
        if ($entity.Content -notmatch $expectedLayer) {
            $diagramIssues += "Layer mismatch for $($entity.Name): Expected $expectedLayer"
            $results.IssuesByType.LayerRepresentation++
        }
    }

    # 2. Relationship Accuracy
    $relationshipIssues = Test-RelationshipCompleteness -diagramPath $mmdFile.FullName `
                                                       -focusEntity $focusEntity `
                                                       -relationships $relationships `
                                                       -cfcCache $cfcCache
    $diagramIssues += $relationshipIssues
    $results.IssuesByType.RelationshipAccuracy += $relationshipIssues.Count

    # 3. Domain Boundaries
    foreach ($entity in $entities) {
        $entityDomain = (Get-EntityLayer -entityName $entity.Name -domainsConfig $domainsConfig).Domain
        if ($entityDomain -ne "catchall" -and $domains -notcontains $entityDomain) {
            # Skip validation for directly connected entities (cross-domain relationships are intentional)
            $isDirectlyConnected = $relationships | Where-Object {
                ($_.From -eq $entity.Name -and $_.To -eq $focusEntity) -or
                ($_.To -eq $entity.Name -and $_.From -eq $focusEntity)
            }
            
            # Skip validation for entities that are part of the same business context
            # (e.g., auth entities, utility entities that are commonly shared)
            $isCommonEntity = $entity.Name -match "farUser|dmProfile|farGroup|farRole|farPermission|dmFile|dmHTML|dmInclude"
            
            if (-not $isDirectlyConnected -and -not $isCommonEntity) {
                $diagramIssues += "Domain boundary violation: $($entity.Name) from $entityDomain (not directly connected and not common entity)"
                $results.IssuesByType.DomainBoundaries++
            }
        }
    }

    # 4. Style Logic
    $styleIssues = Test-StyleLogic -diagramPath $mmdFile.FullName `
                                  -focusEntity $focusEntity `
                                  -entities $entities `
                                  -relationships $relationships
    $diagramIssues += $styleIssues
    $results.IssuesByType.StyleLogic += $styleIssues.Count

    # Store results
    if ($diagramIssues.Count -gt 0) {
        $results.DiagramsWithIssues++
        $results.DetailedResults[$mmdFile.Name] = @{
            FocusEntity = $focusEntity
            Domains = $domains
            Issues = $diagramIssues
        }
    }
}

# Generate report
$reportPath = "validation_report.md"
$report = @"
# Mermaid Diagram Validation Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary

- **Total Diagrams**: $($results.TotalDiagrams)
- **Diagrams With Issues**: $($results.DiagramsWithIssues)

### Issues by Type

| Issue Type | Count |
|------------|-------|
| Layer Representation | $($results.IssuesByType.LayerRepresentation) |
| Relationship Accuracy | $($results.IssuesByType.RelationshipAccuracy) |
| Domain Boundaries | $($results.IssuesByType.DomainBoundaries) |
| Style Logic | $($results.IssuesByType.StyleLogic) |

## Detailed Results

"@

foreach ($diagram in $results.DetailedResults.Keys | Sort-Object) {
    $detail = $results.DetailedResults[$diagram]
    $report += @"

### $diagram

- **Focus Entity**: $($detail.FocusEntity)
- **Domains**: $($detail.Domains -join ', ')

#### Issues:
$(($detail.Issues | ForEach-Object { "- $_" }) -join "`n")

"@
}

# Save report
$report | Out-File $reportPath -Encoding utf8

Write-Host "Validation complete. Report saved to: $reportPath"