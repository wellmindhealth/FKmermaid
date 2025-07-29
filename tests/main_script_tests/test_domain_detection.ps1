# Test Domain Detection and Styling Consistency
# Tests the domain detection logic and styling consistency across different scenarios

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Domain Detection and Styling Consistency" -ForegroundColor Cyan
    Write-Host "=============================================" -ForegroundColor Cyan
    Write-Host "Tests domain detection logic and styling consistency" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Show detailed output" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"
$stylesPath = "D:\GIT\farcry\Cursor\FKmermaid\styles\mermaid_styles.mmd"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Testing Domain Detection and Styling Consistency" -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

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

# Load current colors from styles file
$styleColors = Get-StyleColors -stylesPath $stylesPath

# Define comprehensive test cases
$testCases = @(
    @{
        Name = "Single Focus - Single Domain"
        Focus = "partner"
        Domains = "partner"
        DiagramType = "ER"
        ExpectedConsistency = @{
            FocusEntities = @("pathway_partner")
            GoldTierEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
            BlueTierEntities = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_member", "pathway_promotion", "pathway_report")
            BlueGreyTierEntities = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")
            DarkGreyTierEntities = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")
        }
    },
    @{
        Name = "Multi Focus - Single Domain"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        ExpectedConsistency = @{
            FocusEntities = @("pathway_partner", "pathway_member")
            GoldTierEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
            BlueTierEntities = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_promotion", "pathway_report")
            BlueGreyTierEntities = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")
            DarkGreyTierEntities = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")
        }
    },
    @{
        Name = "Single Focus - Multi Domain"
        Focus = "partner"
        Domains = "partner,participant"
        DiagramType = "ER"
        ExpectedConsistency = @{
            FocusEntities = @("pathway_partner")
            GoldTierEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
            BlueTierEntities = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_member", "pathway_promotion", "pathway_report")
            BlueGreyTierEntities = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")
            DarkGreyTierEntities = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")
        }
    },
    @{
        Name = "Multi Focus - Multi Domain"
        Focus = "partner,member"
        Domains = "partner,participant"
        DiagramType = "ER"
        ExpectedConsistency = @{
            FocusEntities = @("pathway_partner", "pathway_member")
            GoldTierEntities = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")
            BlueTierEntities = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_promotion", "pathway_report")
            BlueGreyTierEntities = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")
            DarkGreyTierEntities = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")
        }
    },
    @{
        Name = "Cross Domain Focus"
        Focus = "member"
        Domains = "programme"
        DiagramType = "ER"
        ExpectedConsistency = @{
            FocusEntities = @("pathway_member")
            GoldTierEntities = @()  # Member is not in programme domain
            BlueTierEntities = @()  # Will be populated based on actual relationships
            BlueGreyTierEntities = @()  # Will be populated based on actual relationships
            DarkGreyTierEntities = @()  # Will be populated based on actual relationships
        }
    }
)

Set-Location $scriptPath

$testResults = @()

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains), Type: $($testCase.DiagramType)" -ForegroundColor White
    
    # Generate test diagram
    $testOutput = "test_domain_$($testCase.Name -replace '\s+', '_').mmd"
    $result = & ".\generate_erd_enhanced.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Diagram generated successfully" -ForegroundColor Green
        
        # Analyze the generated file
        $generatedFile = "$exportsPath\$testOutput"
        if (Test-Path $generatedFile) {
            $content = Get-Content $generatedFile -Raw
            
            # Extract styling information
            $actualTiers = @{
                Focus = @()
                GoldTier = @()
                BlueTier = @()
                BlueGreyTier = @()
                DarkGreyTier = @()
            }
            
            # Parse style lines to extract entity-tier mappings
            $styleLines = $content -split "`n" | Where-Object { $_ -match "style.*fill:#" }
            
            foreach ($line in $styleLines) {
                if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
                    $entity = $matches[1]
                    $color = $matches[2]
                    
                    # Map colors to tiers based on current styles
                    switch ($color) {
                        $styleColors["focus"] { $actualTiers.Focus += $entity }
                        $styleColors["domain_related"] { $actualTiers.GoldTier += $entity }
                        $styleColors["related"] { $actualTiers.BlueTier += $entity }
                        $styleColors["domain_other"] { $actualTiers.BlueGreyTier += $entity }
                        $styleColors["secondary"] { $actualTiers.DarkGreyTier += $entity }
                    }
                }
            }
            
            # Check consistency
            $consistencyResults = @{}
            $overallConsistency = $true
            
            foreach ($tier in $actualTiers.Keys) {
                $expected = $testCase.ExpectedConsistency["$($tier)Entities"]
                $actual = $actualTiers[$tier]
                
                if ($expected.Count -gt 0) {
                    # Check if expected entities are present
                    $missing = @()
                    foreach ($expectedEntity in $expected) {
                        if ($actual -notcontains $expectedEntity) {
                            $missing += $expectedEntity
                        }
                    }
                    
                    if ($missing.Count -eq 0) {
                        Write-Host "✅ $tier tier: All expected entities present" -ForegroundColor Green
                        $consistencyResults[$tier] = $true
                    } else {
                        Write-Host "❌ $tier tier: Missing $($missing -join ', ')" -ForegroundColor Red
                        $consistencyResults[$tier] = $false
                        $overallConsistency = $false
                    }
                } else {
                    # For cases where we don't have specific expectations, just report what we found
                    Write-Host "📊 $tier tier: $($actual.Count) found" -ForegroundColor White
                    $consistencyResults[$tier] = $true
                }
            }
            
            # Save test result
            $testResult = @{
                TestName = $testCase.Name
                Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Focus = $testCase.Focus
                Domains = $testCase.Domains
                DiagramType = $testCase.DiagramType
                ActualTiers = $actualTiers
                ConsistencyResults = $consistencyResults
                Consistent = $overallConsistency
            }
            
            $testResults += $testResult
            
            # Clean up test file
            Remove-Item $generatedFile -Force
            Write-Host "✅ Cleaned up test file" -ForegroundColor Green
            
        } else {
            Write-Host "❌ Generated file not found" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}

# Save all test results
$testResults | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\domain_detection_test_results.json"

Write-Host "`n🏁 Domain Detection Test Complete" -ForegroundColor Cyan
Write-Host "📊 Test Results: $($testResults.Count) tests completed" -ForegroundColor White

# Summary
$consistentTests = ($testResults | Where-Object { $_.Consistent }).Count
$totalTests = $testResults.Count

Write-Host "📈 Consistency Summary:" -ForegroundColor Cyan
Write-Host "  Consistent: $consistentTests/$totalTests" -ForegroundColor $(if ($consistentTests -eq $totalTests) { "Green" } else { "Red" })

if ($consistentTests -lt $totalTests) {
    Write-Host "⚠️  Domain detection inconsistencies detected!" -ForegroundColor Yellow
    Write-Host "   Review results before making changes to domain detection logic." -ForegroundColor Yellow
}