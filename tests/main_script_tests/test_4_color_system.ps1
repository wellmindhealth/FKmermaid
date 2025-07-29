# Test 4-Color Semantic Styling System
# Tests the semantic styling system with known parameter combinations

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test 4-Color Semantic Styling System" -ForegroundColor Cyan
    Write-Host "=====================================" -ForegroundColor Cyan
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

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Testing 4-Color Semantic Styling System" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# Define test cases with expected results
$testCases = @(
    @{
        Name = "Perfect 4-Tier Test"
        Focus = "partner"
        Domains = "partner,participant,programme"
        DiagramType = "ER"
        ExpectedColors = @{
            Orange = @("pathway_partner")  # Focus
            Blue = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_center", "pathway_guide", "pathway_media", "pathway_member", "pathway_memberGroup", "pathway_programme", "pathway_promotion", "pathway_referer", "pathway_report", "zfarcrycore_dmProfile")  # Related
            BlueGrey = @("pathway_activityDef", "pathway_intake", "pathway_progRole", "zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")  # Same domain, not directly related
            DarkGrey = @("pathway_activity", "pathway_journal", "pathway_journalDef", "pathway_library", "pathway_progMember", "pathway_tracker", "pathway_trackerDef")  # Other domains
        }
    },
    @{
        Name = "Member Focus Test"
        Focus = "member"
        Domains = "participant,programme"
        DiagramType = "ER"
        ExpectedColors = @{
            Orange = @("pathway_member")  # Focus
            Blue = @()  # Will be populated based on actual relationships
            BlueGrey = @()  # Will be populated based on actual relationships
            DarkGrey = @()  # Will be populated based on actual relationships
        }
    },
    @{
        Name = "Programme Focus Test"
        Focus = "programme"
        Domains = "programme,site"
        DiagramType = "ER"
        ExpectedColors = @{
            Orange = @("pathway_programme")  # Focus
            Blue = @()  # Will be populated based on actual relationships
            BlueGrey = @()  # Will be populated based on actual relationships
            DarkGrey = @()  # Will be populated based on actual relationships
        }
    }
)

Set-Location $scriptPath

$testResults = @()

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains), Type: $($testCase.DiagramType)" -ForegroundColor White
    
    # Generate test diagram
    $testOutput = "test_4color_$($testCase.Focus).mmd"
    $result = & ".\generate_erd_enhanced.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Diagram generated successfully" -ForegroundColor Green
        
        # Analyze the generated file
        $generatedFile = "$exportsPath\$testOutput"
        if (Test-Path $generatedFile) {
            $content = Get-Content $generatedFile -Raw
            
            # Extract styling information
            $actualColors = @{
                Orange = @()
                Blue = @()
                BlueGrey = @()
                DarkGrey = @()
            }
            
            # Parse style lines to extract entity-color mappings
            $styleLines = $content -split "`n" | Where-Object { $_ -match "style.*fill:#" }
            
            foreach ($line in $styleLines) {
                if ($line -match 'style\s+(\w+)\s+fill:(#[0-9a-fA-F]+)') {
                    $entity = $matches[1]
                    $color = $matches[2]
                    
                    switch ($color) {
                        "#ff6f00" { $actualColors.Orange += $entity }
                        "#1976d2" { $actualColors.Blue += $entity }
                        "#546e7a" { $actualColors.BlueGrey += $entity }
                        "#1a1a1a" { $actualColors.DarkGrey += $entity }
                    }
                }
            }
            
            # Validate results
            $validationResults = @{}
            $overallSuccess = $true
            
            foreach ($color in $actualColors.Keys) {
                $expected = $testCase.ExpectedColors[$color]
                $actual = $actualColors[$color]
                
                if ($expected.Count -gt 0) {
                    # Check if expected entities are present
                    $missing = @()
                    foreach ($expectedEntity in $expected) {
                        if ($actual -notcontains $expectedEntity) {
                            $missing += $expectedEntity
                        }
                    }
                    
                    if ($missing.Count -eq 0) {
                        Write-Host "✅ $color entities: All expected entities present" -ForegroundColor Green
                        $validationResults[$color] = $true
                    } else {
                        Write-Host "❌ $color entities: Missing $($missing -join ', ')" -ForegroundColor Red
                        $validationResults[$color] = $false
                        $overallSuccess = $false
                    }
                } else {
                    # For cases where we don't have specific expectations, just report what we found
                    Write-Host "📊 $color entities: $($actual.Count) found" -ForegroundColor White
                    $validationResults[$color] = $true
                }
            }
            
            # Save test result
            $testResult = @{
                TestName = $testCase.Name
                Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Focus = $testCase.Focus
                Domains = $testCase.Domains
                DiagramType = $testCase.DiagramType
                ActualColors = $actualColors
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
$testResults | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\4color_system_test_results.json"

Write-Host "`n🏁 4-Color System Test Complete" -ForegroundColor Cyan
Write-Host "📊 Test Results: $($testResults.Count) tests completed" -ForegroundColor White