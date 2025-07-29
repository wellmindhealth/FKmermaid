# Test Domain Detection - Comprehensive 5-Tier System
# Tests the 5-tier semantic styling system with comprehensive analysis

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Domain Detection - Comprehensive 5-Tier System" -ForegroundColor Cyan
    Write-Host "=================================================" -ForegroundColor Cyan
    Write-Host "Tests the 5-tier semantic styling system with comprehensive analysis" -ForegroundColor White
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

Write-Host "🧪 Test Domain Detection - Comprehensive 5-Tier System" -ForegroundColor Cyan
Write-Host "=====================================================" -ForegroundColor Cyan

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

# Function to analyze Mermaid diagram comprehensively
function Analyze-MermaidDiagram {
    param([string]$content)
    
    $analysis = @{
        Entities = @()
        Relationships = @()
        Styling = @{}
        EntityCount = 0
        RelationshipCount = 0
        Tiers = @{
            Focus = @()
            GoldTier = @()
            BlueTier = @()
            BlueGreyTier = @()
            DarkGreyTier = @()
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

# Load current colors from styles file
$styleColors = Get-StyleColors -stylesPath $stylesPath

Write-Host "📋 Current style colors:" -ForegroundColor White
Write-Host "  Focus: $($styleColors['focus'])" -ForegroundColor Gray
Write-Host "  Domain Related (Gold): $($styleColors['domain_related'])" -ForegroundColor Gray
Write-Host "  Related (Blue): $($styleColors['related'])" -ForegroundColor Gray

# Define test cases for 5-tier system
$testCases = @(
    @{
        Name = "Partner+Member Focus - 5-Tier Test"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Test 5-tier semantic styling system"
        ExpectedTiers = @{
            Focus = @("pathway_partner", "pathway_member")
            GoldTier = @("pathway_activityDef", "pathway_center", "pathway_intake", "pathway_media", "pathway_memberGroup", "pathway_programme", "pathway_progRole", "pathway_referer", "zfarcrycore_dmProfile")
            BlueTier = @("pathway_ruleSelfRegistration", "pathway_dmImage", "pathway_guide", "pathway_memberType", "pathway_progMember", "pathway_report", "pathway_testimonial")
            BlueGreyTier = @("zfarcrycore_farGroup", "zfarcrycore_farPermission", "zfarcrycore_farRole", "zfarcrycore_farUser")
            DarkGreyTier = @()
        }
    }
)

Set-Location $scriptPath

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains)" -ForegroundColor White
    Write-Host "Description: $($testCase.Description)" -ForegroundColor Gray

    # Generate test diagram
    $testOutput = "domain_detection_test.mmd"
    $result = & ".\generate_erd_enhanced.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Diagram generated successfully" -ForegroundColor Green
        
        # Analyze the generated file - the main script now creates unique filenames
        $generatedFile = "$exportsPath\$testOutput"
        if (Test-Path $generatedFile) {
            $content = Get-Content $generatedFile -Raw
            
            # Comprehensive analysis
            $analysis = Analyze-MermaidDiagram -content $content
            
            Write-Host "`n📊 COMPREHENSIVE ANALYSIS:" -ForegroundColor White
            Write-Host "  Entity Count: $($analysis.EntityCount)" -ForegroundColor Gray
            Write-Host "  Relationship Count: $($analysis.RelationshipCount)" -ForegroundColor Gray
            Write-Host "  Entities: $($analysis.Entities -join ', ')" -ForegroundColor Gray
            
            # Categorize entities by tier based on styling
            foreach ($entity in $analysis.Entities) {
                if ($analysis.Styling.ContainsKey($entity)) {
                    $color = $analysis.Styling[$entity]
                    switch ($color) {
                        $styleColors["focus"] { $analysis.Tiers.Focus += $entity }
                        $styleColors["domain_related"] { $analysis.Tiers.GoldTier += $entity }
                        $styleColors["related"] { $analysis.Tiers.BlueTier += $entity }
                        $styleColors["domain_other"] { $analysis.Tiers.BlueGreyTier += $entity }
                        $styleColors["secondary"] { $analysis.Tiers.DarkGreyTier += $entity }
                    }
                }
            }
            
            # Report tier breakdown
            Write-Host "`n🎨 TIER BREAKDOWN:" -ForegroundColor White
            Write-Host "  Focus entities: $($analysis.Tiers.Focus.Count) - $($analysis.Tiers.Focus -join ', ')" -ForegroundColor Gray
            Write-Host "  Gold tier entities: $($analysis.Tiers.GoldTier.Count) - $($analysis.Tiers.GoldTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Blue tier entities: $($analysis.Tiers.BlueTier.Count) - $($analysis.Tiers.BlueTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Blue-grey tier entities: $($analysis.Tiers.BlueGreyTier.Count) - $($analysis.Tiers.BlueGreyTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Dark grey tier entities: $($analysis.Tiers.DarkGreyTier.Count) - $($analysis.Tiers.DarkGreyTier -join ', ')" -ForegroundColor Gray
            
            # Validate against expected tiers
            $testPassed = $true
            $validationIssues = @()
            
            Write-Host "`n🎯 VALIDATION AGAINST EXPECTED TIERS:" -ForegroundColor Yellow
            foreach ($tierName in @("Focus", "GoldTier", "BlueTier", "BlueGreyTier", "DarkGreyTier")) {
                $expected = $testCase.ExpectedTiers[$tierName]
                $actual = $analysis.Tiers[$tierName]
                
                $missing = $expected | Where-Object { $_ -notin $actual }
                $unexpected = $actual | Where-Object { $_ -notin $expected }
                
                if ($missing.Count -gt 0) {
                    Write-Host "  ❌ $tierName missing: $($missing -join ', ')" -ForegroundColor Red
                    $validationIssues += "Missing from $tierName`: $($missing -join ', ')"
                    $testPassed = $false
                }
                if ($unexpected.Count -gt 0) {
                    Write-Host "  ⚠️  $tierName unexpected: $($unexpected -join ', ')" -ForegroundColor Yellow
                    $validationIssues += "Unexpected in $tierName`: $($unexpected -join ', ')"
                }
                if ($missing.Count -eq 0 -and $unexpected.Count -eq 0) {
                    Write-Host "  ✅ $tierName matches expected" -ForegroundColor Green
                }
            }
            
            # Save comprehensive test result
            $testResult = @{
                TestName = $testCase.Name
                Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Focus = $testCase.Focus
                Domains = $testCase.Domains
                DiagramType = $testCase.DiagramType
                Description = $testCase.Description
                ExpectedTiers = $testCase.ExpectedTiers
                Analysis = $analysis
                GeneratedFile = $testOutput
                ValidationIssues = $validationIssues
                TestPassed = $testPassed
                Status = "COMPREHENSIVE 5-TIER TEST"
            }
            
            # Save test result
            $testResult | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\domain_detection_comprehensive.json"
            
            Write-Host "`n📁 Comprehensive test result saved to: $testResultsPath\domain_detection_comprehensive.json" -ForegroundColor Gray
            Write-Host "📁 Generated file: $generatedFile" -ForegroundColor Gray
            
            if ($testPassed) {
                Write-Host "`n🎉 Test PASSED - All tiers match expected!" -ForegroundColor Green
            } else {
                Write-Host "`n❌ Test FAILED - Tier validation issues found" -ForegroundColor Red
                Write-Host "Issues: $($validationIssues -join '; ')" -ForegroundColor Red
            }
            
        } else {
            Write-Host "❌ Generated file not found" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}