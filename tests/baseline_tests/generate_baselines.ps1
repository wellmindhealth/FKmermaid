# Generate Baseline Outputs
# Creates baseline outputs for regression testing

param(
    [switch]$Force,
    [switch]$Help
)

if ($Help) {
    Write-Host "Generate Baseline Outputs" -ForegroundColor Cyan
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "Creates baseline outputs for regression testing" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Force      Overwrite existing baselines" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$baselinePath = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines"

# Create baseline directory if it doesn't exist
if (-not (Test-Path $baselinePath)) {
    New-Item -ItemType Directory -Path $baselinePath -Force | Out-Null
    Write-Host "✅ Created baseline directory" -ForegroundColor Green
}

Write-Host "🧪 Generating Baseline Outputs" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

# Define baseline test cases - EDGE CASES THAT PUSH LIMITS
$baselineTests = @(
    @{
        Name = "Edge_Case_No_Focus_All_Domains"
        Focus = "farUser"
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests behavior with farUser focus and all domains (should be comprehensive)"
    },
    @{
        Name = "Edge_Case_No_Focus_No_Domains"
        Focus = "dmImage"
        Domains = ""
        DiagramType = "ER"
        Description = "Tests behavior with dmImage focus and no domains (should be all entities)"
    },
    @{
        Name = "Edge_Case_Pathway_Domain_Only"
        Focus = "activityDef"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests pathway domain entities only (should be pathway-specific)"
    },
    @{
        Name = "Edge_Case_Partner_Pathway_Only"
        Focus = "partner"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests partner focus with pathway domain only (should be minimal - partner not in pathway domain)"
    },
    @{
        Name = "Edge_Case_Programme_Pathway_Only"
        Focus = "programme"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests programme focus with pathway domain only (should be pathway-specific - programme is in pathway domain)"
    },
    @{
        Name = "Edge_Case_Invalid_Domain"
        Focus = "partner"
        Domains = "nonexistent"
        DiagramType = "ER"
        Description = "Tests behavior with non-existent domain (should be minimal)"
    },
    @{
        Name = "Edge_Case_Empty_Focus_Invalid_Domain"
        Focus = "farUser"
        Domains = "nonexistent"
        DiagramType = "ER"
        Description = "Tests farUser focus with invalid domain (should be minimal)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Complex"
        Focus = "member"
        Domains = "participant,pathway"
        DiagramType = "Class"
        Description = "Tests Class diagram with complex relationships (different diagram type)"
    },
    @{
        Name = "Edge_Case_Provider_Pathway_Only"
        Focus = "partner"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests partner focus with pathway domain only (should be minimal - partner not in pathway domain)"
    },
    @{
        Name = "Edge_Case_Pathway_Pathway_Only"
        Focus = "programme"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests programme focus with pathway domain only (should be pathway-specific - programme is in pathway domain)"
    },
    @{
        Name = "Edge_Case_Member_Partner_Only"
        Focus = "member"
        Domains = "provider"
        DiagramType = "ER"
        Description = "Tests member focus with provider domain only (should be minimal - member not in provider domain)"
    },
    @{
        Name = "Edge_Case_Multiple_Focus_Entities"
        Focus = "partner,member,programme"
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests multiple focus entities (comma-separated) - uncommon parameter"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Pathway_Only"
        Focus = "dmImage"
        Domains = "pathway"
        DiagramType = "Class"
        Description = "Tests Class diagram with pathway domain only (uncommon combination)"
    },
    @{
        Name = "Edge_Case_ER_Diagram_All_Domains"
        Focus = "farUser"
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests ER diagram with all domains and admin entity focus"
    },
    @{
        Name = "Edge_Case_Class_Diagram_All_Domains"
        Focus = "farUser"
        Domains = "all"
        DiagramType = "Class"
        Description = "Tests Class diagram with all domains and admin entity focus"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Cross_Domain_Focus"
        Focus = "dmProfile"
        Domains = "participant"
        DiagramType = "ER"
        Description = "Tests admin entity focus with participant domain (cross-domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Cross_Domain_Focus"
        Focus = "dmProfile"
        Domains = "participant"
        DiagramType = "Class"
        Description = "Tests Class diagram with admin entity focus and participant domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Media_Focus"
        Focus = "media"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests media entity focus with pathway domain (media is in multiple domains)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Media_Focus"
        Focus = "media"
        Domains = "pathway"
        DiagramType = "Class"
        Description = "Tests Class diagram with media entity focus and pathway domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_ProgRole_Focus"
        Focus = "progRole"
        Domains = "provider"
        DiagramType = "ER"
        Description = "Tests progRole focus with provider domain (progRole is in multiple domains)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_ProgRole_Focus"
        Focus = "progRole"
        Domains = "provider"
        DiagramType = "Class"
        Description = "Tests Class diagram with progRole focus and provider domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_ActivityDef_Focus"
        Focus = "activityDef"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests activityDef focus with pathway domain (activityDef is in pathway domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_ActivityDef_Focus"
        Focus = "activityDef"
        Domains = "pathway"
        DiagramType = "Class"
        Description = "Tests Class diagram with activityDef focus and pathway domain"
    },

    @{
        Name = "Edge_Case_ER_Diagram_Journal_Focus"
        Focus = "journal"
        Domains = "pathway"
        DiagramType = "ER"
        Description = "Tests journal focus with pathway domain (journal is in participant domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Journal_Focus"
        Focus = "journal"
        Domains = "pathway"
        DiagramType = "Class"
        Description = "Tests Class diagram with journal focus and pathway domain"
    },
    @{
        Name = "Single_Domain_Test"
        Focus = "member"
        Domains = "participant"
        DiagramType = "ER"
        Description = "Single focus with single domain - member focus, participant domain"
    },
    @{
        Name = "Multi_Domain_Test"
        Focus = "member"
        Domains = "participant,pathway"
        DiagramType = "ER"
        Description = "Single focus with multiple domains - member focus, multiple domains"
    },
    @{
        Name = "Programme_Focus_Test"
        Focus = "programme"
        Domains = "all"
        DiagramType = "ER"
        Description = "Programme focus test - programme focus, all domains"
    },
    @{
        Name = "Class_Diagram_Test"
        Focus = "dmImage"
        Domains = "provider"
        DiagramType = "Class"
        Description = "Class diagram test - dmImage focus, provider domain, Class type"
    },
    @{
        Name = "Perfect_5-Tier_Test"
        Focus = "partner,member,programme"
        Domains = "provider,participant,pathway"
        DiagramType = "ER"
        Description = "Perfect 5-tier semantic styling test - multiple focus entities across domains"
    }
)

Set-Location $scriptPath

$baselineResults = @()

foreach ($test in $baselineTests) {
    Write-Host "`n📋 Generating Baseline: $($test.Name)" -ForegroundColor Yellow
    Write-Host "Description: $($test.Description)" -ForegroundColor White
    
    $baselineFile = "$baselinePath\$($test.Name -replace '\s+', '_').mmd"
    
    # Check if baseline already exists
    if ((Test-Path $baselineFile) -and (-not $Force)) {
        Write-Host "⚠️  Baseline already exists. Use -Force to overwrite." -ForegroundColor Yellow
        continue
    }
    
    # Generate baseline
                $result = & ".\generate_erd_domain_colors.ps1" -lFocus $test.Focus -DiagramType $test.DiagramType -lDomains $test.Domains -OutputFile $baselineFile -NoBrowser 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Baseline generated: $baselineFile" -ForegroundColor Green
        
        # Analyze the generated file
        $content = Get-Content $baselineFile -Raw
        
        # Count entities and styles (handle both ER and Class diagrams)
        $entityCount = 0
        if ($test.DiagramType -eq "Class") {
            # Class diagram syntax: class entityName {
            $entityCount = ($content -split "`n" | Where-Object { $_ -match '^\s*class\s+\w+' }).Count
        } else {
            # ER diagram syntax: "entity" {
            $entityCount = ($content -split "`n" | Where-Object { $_ -match '^\s*"\w+"\s*{' }).Count
        }
        
        $styleCount = ($content -split "`n" | Where-Object { $_ -match "style.*fill:#" }).Count
        
        # Extract color distribution
        $colorDistribution = @{
            Orange = ($content -split "`n" | Where-Object { $_ -match "fill:#ff6f00" }).Count
            Blue = ($content -split "`n" | Where-Object { $_ -match "fill:#1976d2" }).Count
            BlueGrey = ($content -split "`n" | Where-Object { $_ -match "fill:#546e7a" }).Count
            DarkGrey = ($content -split "`n" | Where-Object { $_ -match "fill:#1a1a1a" }).Count
        }
        
        $baselineResult = @{
            TestName = $test.Name
            Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Focus = $test.Focus
            Domains = $test.Domains
            DiagramType = $test.DiagramType
            Description = $test.Description
            FilePath = $baselineFile
            EntityCount = $entityCount
            StyleCount = $styleCount
            ColorDistribution = $colorDistribution
            FileSize = (Get-Item $baselineFile).Length
        }
        
        $baselineResults += $baselineResult
        
        Write-Host "📊 Entity Count: $entityCount" -ForegroundColor White
        Write-Host "📊 Style Count: $styleCount" -ForegroundColor White
        Write-Host "📊 Color Distribution: Orange=$($colorDistribution.Orange), Blue=$($colorDistribution.Blue), BlueGrey=$($colorDistribution.BlueGrey), DarkGrey=$($colorDistribution.DarkGrey)" -ForegroundColor White
        
    } else {
        Write-Host "❌ Failed to generate baseline" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}

# Save baseline metadata
$baselineMetadata = @{
    GeneratedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    TotalBaselines = $baselineResults.Count
    BaselinePath = $baselinePath
    Baselines = $baselineResults
}

$baselineMetadata | ConvertTo-Json -Depth 10 | Out-File "$baselinePath\baseline_metadata.json"

Write-Host "`n🏁 Baseline Generation Complete" -ForegroundColor Cyan
Write-Host "📊 Generated $($baselineResults.Count) baselines" -ForegroundColor White
Write-Host "📁 Baselines stored in: $baselinePath" -ForegroundColor White

# Update test expectations with new entity counts
Write-Host "`n🔄 Updating test expectations..." -ForegroundColor Yellow
$updateScriptPath = Join-Path $PSScriptRoot "..\update_test_expectations.ps1"
if (Test-Path $updateScriptPath) {
    & $updateScriptPath
    Write-Host "✅ Test expectations updated" -ForegroundColor Green
} else {
    Write-Host "⚠️  Update script not found: $updateScriptPath" -ForegroundColor Yellow
}

# Cross-check baselines against generated diagrams
Write-Host "`n🔍 Cross-checking baselines against generated diagrams..." -ForegroundColor Cyan
& {
    # Function to analyze Mermaid diagram
    function Analyze-MermaidDiagram {
        param([string]$content, [string]$diagramType)
        
        $analysis = @{
            EntityCount = 0
            RelationshipCount = 0
            StyleCount = 0
            ColorDistribution = @{}
            SyntaxValid = $true
            Errors = @()
        }
        
        # Count entities based on diagram type
        if ($diagramType -eq "Class") {
            $analysis.EntityCount = ($content -split "`n" | Where-Object { $_ -match '^\s*class\s+\w+' }).Count
        } else {
            $analysis.EntityCount = ($content -split "`n" | Where-Object { $_ -match '^\s*"\w+"\s*{' }).Count
        }
        
        # Count relationships
        if ($diagramType -eq "Class") {
            # Class diagram syntax: entity --> entity : relationship
            $analysis.RelationshipCount = ($content -split "`n" | Where-Object { $_ -match '\w+\s+-->\s+\w+' }).Count
        } else {
            # ER diagram syntax: ||--||
            $analysis.RelationshipCount = ($content -split "`n" | Where-Object { $_ -match '\|\|--\|\|' }).Count
        }
        
        # Count styles
        $analysis.StyleCount = ($content -split "`n" | Where-Object { $_ -match "style.*fill:#" }).Count
        
        # Analyze color distribution
        $colorMatches = [regex]::Matches($content, 'fill:(#[0-9a-fA-F]{6})')
        foreach ($match in $colorMatches) {
            $color = $match.Groups[1].Value
            if ($analysis.ColorDistribution.ContainsKey($color)) {
                $analysis.ColorDistribution[$color]++
            } else {
                $analysis.ColorDistribution[$color] = 1
            }
        }
        
        # Basic syntax validation
        if (-not ($content -match 'erDiagram|classDiagram')) {
            $analysis.SyntaxValid = $false
            $analysis.Errors += "Missing diagram declaration"
        }
        
        if ($analysis.EntityCount -eq 0) {
            $analysis.SyntaxValid = $false
            $analysis.Errors += "No entities found"
        }
        
        return $analysis
    }
    
    # Cross-check function
    function Cross-CheckBaselines {
        param([array]$baselineResults)
        
        Write-Host "🔍 Cross-checking $($baselineResults.Count) baselines..." -ForegroundColor Yellow
        
        $crossCheckResults = @()
        $totalIssues = 0
        
        foreach ($baseline in $baselineResults) {
            $baselineFile = $baseline.FilePath
            if (-not (Test-Path $baselineFile)) {
                Write-Host "❌ Baseline file not found: $baselineFile" -ForegroundColor Red
                continue
            }
            
            $content = Get-Content $baselineFile -Raw
            $analysis = Analyze-MermaidDiagram -content $content -diagramType $baseline.DiagramType
            
            # Compare with expected values
            $issues = @()
            
            if ($analysis.EntityCount -ne $baseline.EntityCount) {
                $issues += "Entity count mismatch: Expected $($baseline.EntityCount), Got $($analysis.EntityCount)"
            }
            
            if ($analysis.StyleCount -ne $baseline.StyleCount) {
                $issues += "Style count mismatch: Expected $($baseline.StyleCount), Got $($analysis.StyleCount)"
            }
            
            if (-not $analysis.SyntaxValid) {
                $issues += "Syntax errors: $($analysis.Errors -join ', ')"
            }
            
            if ($analysis.EntityCount -eq 0) {
                $issues += "No entities found - possible empty diagram"
            }
            
            if ($analysis.RelationshipCount -eq 0 -and $analysis.EntityCount -gt 1) {
                $issues += "Multiple entities but no relationships - possible disconnected diagram"
            }
            
            $crossCheckResult = @{
                TestName = $baseline.TestName
                FilePath = $baselineFile
                Analysis = $analysis
                Issues = $issues
                HasIssues = $issues.Count -gt 0
            }
            
            $crossCheckResults += $crossCheckResult
            $totalIssues += $issues.Count
            
            # Report results
            if ($issues.Count -eq 0) {
                Write-Host "✅ $($baseline.TestName): Valid" -ForegroundColor Green
            } else {
                Write-Host "❌ $($baseline.TestName): $($issues.Count) issues" -ForegroundColor Red
                foreach ($issue in $issues) {
                    Write-Host "   ⚠️  $issue" -ForegroundColor Yellow
                }
            }
        }
        
        # Summary
        Write-Host "`n📊 Cross-check Summary:" -ForegroundColor Cyan
        Write-Host "   Total Baselines: $($crossCheckResults.Count)" -ForegroundColor White
        Write-Host "   Valid: $($crossCheckResults | Where-Object { -not $_.HasIssues } | Measure-Object).Count" -ForegroundColor Green
        Write-Host "   Issues Found: $totalIssues" -ForegroundColor $(if ($totalIssues -eq 0) { "Green" } else { "Red" })
        
        # Save cross-check results
        $crossCheckMetadata = @{
            CrossCheckedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            TotalBaselines = $crossCheckResults.Count
            ValidBaselines = ($crossCheckResults | Where-Object { -not $_.HasIssues }).Count
            TotalIssues = $totalIssues
            Results = $crossCheckResults
        }
        
        $crossCheckMetadata | ConvertTo-Json -Depth 10 | Out-File "$baselinePath\cross_check_results.json"
        
        if ($totalIssues -eq 0) {
            Write-Host "🎉 All baselines validated successfully!" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Cross-check completed with $totalIssues issues found" -ForegroundColor Yellow
        }
        
        return $crossCheckResults
    }
    
    # Run cross-check
    $crossCheckResults = Cross-CheckBaselines -baselineResults $baselineResults
}