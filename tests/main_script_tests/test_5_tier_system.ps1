# Test 5-Tier Semantic Styling System
# Tests the semantic styling system with known parameter combinations

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test 5-Tier Semantic Styling System" -ForegroundColor Cyan
    Write-Host "====================================" -ForegroundColor Cyan
    Write-Host "Tests the semantic styling system with known parameter combinations" -ForegroundColor White
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

Write-Host "🧪 Testing 5-Tier Semantic Styling System" -ForegroundColor Cyan
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

# Load current colors from styles file
$styleColors = Get-StyleColors -stylesPath $stylesPath
Write-Host "📋 Loaded colors from styles file:" -ForegroundColor White
foreach ($style in $styleColors.Keys) {
    Write-Host "  $style`: $($styleColors[$style])" -ForegroundColor Gray
}

# Define test cases with expected results
$testCases = @(
    @{
        Name = "Perfect 5-Tier Test"
        Focus = "partner"
        Domains = "partner,participant,programme"
        DiagramType = "ER"
        ExpectedTiers = @{
            Focus = @("pathway_partner")  # Orange tier
            DomainRelated = @("pathway_center", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_referer", "zfarcrycore_dmProfile")  # Dark burnt gold tier
            Related = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_member", "pathway_report")  # Blue tier
            DomainOther = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")  # Blue-grey tier
            Secondary = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")  # Dark grey tier
        }
    },
    @{
        Name = "Member Focus Test"
        Focus = "member"
        Domains = "participant,programme"
        DiagramType = "ER"
        ExpectedTiers = @{
            Focus = @("pathway_member")  # Orange tier
            DomainRelated = @()  # Will be populated based on actual relationships
            Related = @()  # Will be populated based on actual relationships
            DomainOther = @()  # Will be populated based on actual relationships
            Secondary = @()  # Will be populated based on actual relationships
        }
    }
)

Set-Location $scriptPath

$testResults = @()

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains), Type: $($testCase.DiagramType)" -ForegroundColor White
    
    # Generate test diagram
    $testOutput = "test_5tier_$($testCase.Focus).mmd"
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
                DomainRelated = @()
                Related = @()
                DomainOther = @()
                Secondary = @()
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
                        $styleColors["domain_related"] { $actualTiers.DomainRelated += $entity }
                        $styleColors["related"] { $actualTiers.Related += $entity }
                        $styleColors["domain_other"] { $actualTiers.DomainOther += $entity }
                        $styleColors["secondary"] { $actualTiers.Secondary += $entity }
                    }
                }
            }
            
            # Validate results
            $validationResults = @{}
            $overallSuccess = $true
            
            foreach ($tier in $actualTiers.Keys) {
                $expected = $testCase.ExpectedTiers[$tier]
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
                        $validationResults[$tier] = $true
                    } else {
                        Write-Host "❌ $tier tier: Missing $($missing -join ', ')" -ForegroundColor Red
                        $validationResults[$tier] = $false
                        $overallSuccess = $false
                    }
                } else {
                    # For cases where we don't have specific expectations, just report what we found
                    Write-Host "📊 $tier tier: $($actual.Count) found" -ForegroundColor White
                    $validationResults[$tier] = $true
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
                ValidationResults = $validationResults
                Success = $overallSuccess
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
$testResults | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\5tier_system_test_results.json"

Write-Host "`n🏁 5-Tier System Test Complete" -ForegroundColor Cyan
Write-Host "📊 Test Results: $($testResults.Count) tests completed" -ForegroundColor White