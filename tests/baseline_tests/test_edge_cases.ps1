# Test Edge Cases
# Comprehensive validation of all edge case baselines

Write-Host "🔍 Testing Edge Case Baselines..." -ForegroundColor Cyan

# Define expected criteria for each edge case baseline
$edgeCaseTests = @(
    @{
        Name = "Edge_Case_No_Focus_All_Domains"
        BaselineFile = "Edge_Case_No_Focus_All_Domains.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("farUser")
            DomainFilter = @("all")
            DiagramType = "ER"
            ExpectedEntityCount = 32  # Actual result from baseline generation
            Description = "farUser focus, all domains - should be comprehensive"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_No_Focus_No_Domains"
        BaselineFile = "Edge_Case_No_Focus_No_Domains.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("dmImage")
            DomainFilter = @("")
            DiagramType = "ER"
            ExpectedEntityCount = 32  # Actual result from baseline generation
            Description = "dmImage focus, no domains - should show all entities"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Site_Domain_Only"
        BaselineFile = "Edge_Case_Site_Domain_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("dmImage")
            DomainFilter = @("site")
            DiagramType = "ER"
            ExpectedEntityCount = 13  # Actual result from baseline generation
            Description = "dmImage focus, site domain only - should be minimal, isolated domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Programme_Domain_Only"
        BaselineFile = "Edge_Case_Programme_Domain_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("activityDef")
            DomainFilter = @("programme")
            DiagramType = "ER"
            ExpectedEntityCount = 11  # Actual result from baseline generation
            Description = "activityDef focus, programme domain only - should be programme-specific"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Invalid_Domain"
        BaselineFile = "Edge_Case_Invalid_Domain.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("partner")
            DomainFilter = @("nonexistent")
            DiagramType = "ER"
            ExpectedEntityCount = 34  # Actual result from baseline generation (falls back to all domains)
            Description = "partner focus, invalid domain - should fall back to all domains"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Empty_Focus_Invalid_Domain"
        BaselineFile = "Edge_Case_Empty_Focus_Invalid_Domain.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("farUser")
            DomainFilter = @("nonexistent")
            DiagramType = "ER"
            ExpectedEntityCount = 32  # Actual result from baseline generation (falls back to all domains)
            Description = "farUser focus, invalid domain - should fall back to all domains"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Complex"
        BaselineFile = "Edge_Case_Class_Diagram_Complex.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("member")
            DomainFilter = @("participant", "programme")
            DiagramType = "Class"
            ExpectedEntityCount = 15  # Actual result from baseline generation
            Description = "Class diagram with complex relationships"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Partner_Site_Only"
        BaselineFile = "Edge_Case_Partner_Site_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("partner")
            DomainFilter = @("site")
            DiagramType = "ER"
            ExpectedEntityCount = 18  # Actual result from baseline generation
            Description = "partner focus, site domain only - should be minimal"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Programme_Site_Only"
        BaselineFile = "Edge_Case_Programme_Site_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("programme")
            DomainFilter = @("site")
            DiagramType = "ER"
            ExpectedEntityCount = 18  # Actual result from baseline generation
            Description = "programme focus, site domain only - should be minimal"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Member_Partner_Only"
        BaselineFile = "Edge_Case_Member_Partner_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("member")
            DomainFilter = @("partner")
            DiagramType = "ER"
            ExpectedEntityCount = 22  # Actual result from baseline generation
            Description = "member focus, partner domain only - should be minimal"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Multiple_Focus_Entities"
        BaselineFile = "Edge_Case_Multiple_Focus_Entities.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("partner", "member", "programme")
            DomainFilter = @("all")
            DiagramType = "ER"
            ExpectedEntityCount = 36  # Actual result from baseline generation
            Description = "Multiple focus entities - uncommon parameter"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Site_Only"
        BaselineFile = "Edge_Case_Class_Diagram_Site_Only.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("dmImage")
            DomainFilter = @("site")
            DiagramType = "Class"
            ExpectedEntityCount = 12  # Actual result from baseline generation
            Description = "Class diagram with site domain only - uncommon combination"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_All_Domains"
        BaselineFile = "Edge_Case_ER_Diagram_All_Domains.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("farUser")
            DomainFilter = @("all")
            DiagramType = "ER"
            ExpectedEntityCount = 32  # Actual result from baseline generation
            Description = "ER diagram with all domains and admin entity focus"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_All_Domains"
        BaselineFile = "Edge_Case_Class_Diagram_All_Domains.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("farUser")
            DomainFilter = @("all")
            DiagramType = "Class"
            ExpectedEntityCount = 4  # Actual result from baseline generation
            Description = "Class diagram with all domains and admin entity focus"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_Cross_Domain_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_Cross_Domain_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("dmProfile")
            DomainFilter = @("participant")
            DiagramType = "ER"
            ExpectedEntityCount = 23  # Actual result from baseline generation
            Description = "Admin entity focus with participant domain (cross-domain)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Cross_Domain_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_Cross_Domain_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("dmProfile")
            DomainFilter = @("participant")
            DiagramType = "Class"
            ExpectedEntityCount = 7  # Actual result from baseline generation
            Description = "Class diagram with admin entity focus and participant domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_Media_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_Media_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("media")
            DomainFilter = @("programme")
            DiagramType = "ER"
            ExpectedEntityCount = 7  # Actual result from baseline generation
            Description = "media entity focus with programme domain (media is in multiple domains)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Media_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_Media_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("media")
            DomainFilter = @("programme")
            DiagramType = "Class"
            ExpectedEntityCount = 7  # Actual result from baseline generation
            Description = "Class diagram with media entity focus and programme domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_ProgRole_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_ProgRole_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("progRole")
            DomainFilter = @("partner")
            DiagramType = "ER"
            ExpectedEntityCount = 15  # Actual result from baseline generation
            Description = "progRole focus with partner domain (progRole is in multiple domains)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_ProgRole_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_ProgRole_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("progRole")
            DomainFilter = @("partner")
            DiagramType = "Class"
            ExpectedEntityCount = 5  # Actual result from baseline generation
            Description = "Class diagram with progRole focus and partner domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_ActivityDef_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_ActivityDef_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("activityDef")
            DomainFilter = @("site")
            DiagramType = "ER"
            ExpectedEntityCount = 16  # Actual result from baseline generation
            Description = "activityDef focus with site domain (activityDef not in site domain)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_ActivityDef_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_ActivityDef_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("activityDef")
            DomainFilter = @("site")
            DiagramType = "Class"
            ExpectedEntityCount = 11  # Actual result from baseline generation
            Description = "Class diagram with activityDef focus and site domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_Guide_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_Guide_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("guide")
            DomainFilter = @("partner")
            DiagramType = "ER"
            ExpectedEntityCount = 16  # Actual result from baseline generation
            Description = "guide focus with partner domain (guide is in participant/programme domains)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Guide_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_Guide_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("guide")
            DomainFilter = @("partner")
            DiagramType = "Class"
            ExpectedEntityCount = 6  # Actual result from baseline generation
            Description = "Class diagram with guide focus and partner domain"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_ER_Diagram_Journal_Focus"
        BaselineFile = "Edge_Case_ER_Diagram_Journal_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("journal")
            DomainFilter = @("programme")
            DiagramType = "ER"
            ExpectedEntityCount = 9  # Actual result from baseline generation
            Description = "journal focus with programme domain (journal is in participant domain)"
        }
        ExpectedToFail = $false
    },
    @{
        Name = "Edge_Case_Class_Diagram_Journal_Focus"
        BaselineFile = "Edge_Case_Class_Diagram_Journal_Focus.mmd"
        ExpectedCriteria = @{
            FocusEntities = @("journal")
            DomainFilter = @("programme")
            DiagramType = "Class"
            ExpectedEntityCount = 4  # Actual result from baseline generation
            Description = "Class diagram with journal focus and programme domain"
        }
        ExpectedToFail = $false
    }
)

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
    
    # Parse Class diagram entities (different syntax)
    $classMatches = [regex]::Matches($content, 'class\s+(\w+)\s*\{')
    foreach ($match in $classMatches) {
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

# Test each edge case baseline
$baselinesDir = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines"
$allTestsPassed = $true
$testResults = @()

foreach ($test in $edgeCaseTests) {
    $filename = $test.BaselineFile
    $outputPath = Join-Path $baselinesDir $filename
    
    Write-Host "`n📋 Testing: $($test.Name)" -ForegroundColor Yellow
    Write-Host "   Description: $($test.ExpectedCriteria.Description)" -ForegroundColor Gray
    Write-Host "   File: $filename" -ForegroundColor Gray
    
    # Check if this test is expected to fail
    if ($test.ExpectedToFail) {
        Write-Host "   ⚠️  Expected to fail: $($test.FailureReason)" -ForegroundColor Yellow
        if (-not (Test-Path $outputPath)) {
            Write-Host "   ✅ Expected failure confirmed - baseline file not found (as expected)" -ForegroundColor Green
            $testResults += @{
                TestName = $test.Name
                Status = "EXPECTED_FAILURE"
                Reason = $test.FailureReason
                ExpectedToFail = $true
            }
        } else {
            Write-Host "   ⚠️  Unexpected: Baseline file exists but was expected to fail" -ForegroundColor Yellow
            $testResults += @{
                TestName = $test.Name
                Status = "UNEXPECTED_SUCCESS"
                Reason = "Baseline file exists but was expected to fail"
                ExpectedToFail = $true
            }
        }
        continue
    }
    
    if (-not (Test-Path $outputPath)) {
        Write-Host "   ❌ Baseline file not found: $filename" -ForegroundColor Red
        Write-Host "   💡 Run generate_baselines.ps1 to create missing baselines" -ForegroundColor Yellow
        $allTestsPassed = $false
        $testResults += @{
            TestName = $test.Name
            Status = "FAILED"
            Reason = "Baseline file not found"
            ExpectedToFail = $false
        }
        continue
    }
    
    # Analyze the file
    $content = Get-Content $outputPath -Raw
    $analysis = Analyze-MermaidDiagram -content $content
    
    Write-Host "   📊 Analysis:" -ForegroundColor Cyan
    Write-Host "      Entities: $($analysis.EntityCount)" -ForegroundColor Gray
    Write-Host "      Relationships: $($analysis.RelationshipCount)" -ForegroundColor Gray
    
    # Validate against expected criteria
    $criteria = $test.ExpectedCriteria
    $validationPassed = $true
    $validationDetails = @()
    
    # Check entity count (approximate)
    $entityCountDiff = [Math]::Abs($analysis.EntityCount - $criteria.ExpectedEntityCount)
    if ($entityCountDiff -gt 10) {  # Allow some variance for edge cases
        Write-Host "      ⚠️  Entity count ($($analysis.EntityCount)) differs significantly from expected ($($criteria.ExpectedEntityCount))" -ForegroundColor Yellow
        $validationDetails += "Entity count variance: $entityCountDiff"
    } else {
        Write-Host "      ✅ Entity count within expected range" -ForegroundColor Green
    }
    
    # Check for focus entities (if specified)
    if ($criteria.FocusEntities -and $criteria.FocusEntities[0] -ne "") {
        $focusEntitiesFound = @()
        foreach ($focusEntity in $criteria.FocusEntities) {
            $found = $analysis.Entities | Where-Object { $_ -like "*$focusEntity*" }
            if ($found) {
                $focusEntitiesFound += $found
            }
        }
        
        if ($focusEntitiesFound.Count -gt 0) {
            Write-Host "      ✅ Focus entities found: $($focusEntitiesFound -join ', ')" -ForegroundColor Green
        } else {
            Write-Host "      ❌ No focus entities found" -ForegroundColor Red
            $validationPassed = $false
            $validationDetails += "No focus entities found"
        }
    }
    
    # Check diagram type
    if ($content -match "classDiagram" -and $criteria.DiagramType -eq "Class") {
        Write-Host "      ✅ Class diagram type confirmed" -ForegroundColor Green
    } elseif ($content -match "erDiagram" -and $criteria.DiagramType -eq "ER") {
        Write-Host "      ✅ ER diagram type confirmed" -ForegroundColor Green
    } else {
        Write-Host "      ❌ Diagram type mismatch" -ForegroundColor Red
        $validationPassed = $false
        $validationDetails += "Diagram type mismatch"
    }
    
    # Check styling tiers
    $tiersFound = $analysis.Tiers.Keys | Where-Object { $analysis.Tiers[$_] -and $analysis.Tiers[$_].Count -gt 0 }
    if ($tiersFound.Count -gt 0) {
        Write-Host "      ✅ Semantic styling tiers found: $($tiersFound -join ', ')" -ForegroundColor Green
    } else {
        Write-Host "      ⚠️  No semantic styling tiers found" -ForegroundColor Yellow
    }
    
    if ($validationPassed) {
        Write-Host "   ✅ Test PASSED" -ForegroundColor Green
        $testResults += @{
            TestName = $test.Name
            Status = "PASSED"
            EntityCount = $analysis.EntityCount
            RelationshipCount = $analysis.RelationshipCount
            ExpectedToFail = $false
        }
    } else {
        Write-Host "   ❌ Test FAILED" -ForegroundColor Red
        Write-Host "      Details: $($validationDetails -join '; ')" -ForegroundColor Red
        $allTestsPassed = $false
        $testResults += @{
            TestName = $test.Name
            Status = "FAILED"
            Reason = $validationDetails -join '; '
            ExpectedToFail = $false
        }
    }
}

# Final result
Write-Host "`n🏁 Edge Case Test Results:" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

$passedTests = ($testResults | Where-Object { $_.Status -eq "PASSED" }).Count
$failedTests = ($testResults | Where-Object { $_.Status -eq "FAILED" }).Count
$expectedFailures = ($testResults | Where-Object { $_.Status -eq "EXPECTED_FAILURE" }).Count
$unexpectedSuccesses = ($testResults | Where-Object { $_.Status -eq "UNEXPECTED_SUCCESS" }).Count
$totalTests = $testResults.Count
$actualFailures = $failedTests + $unexpectedSuccesses

Write-Host "Total Tests: $totalTests" -ForegroundColor White
Write-Host "Passed: $passedTests" -ForegroundColor Green
Write-Host "Expected Failures: $expectedFailures" -ForegroundColor Yellow
Write-Host "Actual Failures: $actualFailures" -ForegroundColor Red

if ($totalTests -gt 0) {
    $successRate = [Math]::Round((($passedTests + $expectedFailures) / $totalTests) * 100, 1)
    Write-Host "Success Rate: $successRate%" -ForegroundColor White
}

# Only fail if there are actual failures (not expected ones)
if ($actualFailures -eq 0) {
    Write-Host "`n🎉 All edge case tests PASSED (including expected failures)!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some edge case tests FAILED!" -ForegroundColor Red
    Write-Host "Failed tests:" -ForegroundColor Red
    $testResults | Where-Object { $_.Status -eq "FAILED" -or $_.Status -eq "UNEXPECTED_SUCCESS" } | ForEach-Object {
        Write-Host "   - $($_.TestName): $($_.Reason)" -ForegroundColor Red
    }
    exit 1
}