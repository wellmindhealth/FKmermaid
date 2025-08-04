# Test Baseline Capture
# Captures actual current behavior as baseline for regression testing

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Baseline Capture" -ForegroundColor Cyan
    Write-Host "====================" -ForegroundColor Cyan
    Write-Host "Captures actual current behavior as baseline" -ForegroundColor White
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

Write-Host "🧪 Capturing Current Behavior as Baseline" -ForegroundColor Cyan
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

Write-Host "📋 Current style colors:" -ForegroundColor White
Write-Host "  Focus: $($styleColors['focus'])" -ForegroundColor Gray
Write-Host "  Domain Related (Gold): $($styleColors['domain_related'])" -ForegroundColor Gray
Write-Host "  Related (Blue): $($styleColors['related'])" -ForegroundColor Gray
Write-Host "  Domain Other (Blue-Grey): $($styleColors['domain_other'])" -ForegroundColor Gray
        Write-Host "  Other (Dark Grey): $($styleColors['other'])" -ForegroundColor Gray

# Define test cases to capture baseline
$testCases = @(
    @{
        Name = "Partner Focus - Single Domain"
        Focus = "partner"
        Domains = "provider"
        DiagramType = "ER"
    },
    @{
        Name = "Partner+Member Focus - Single Domain"
        Focus = "partner,member"
        Domains = "provider"
        DiagramType = "ER"
    },
    @{
        Name = "Partner Focus - Multi Domain"
        Focus = "partner"
        Domains = "provider,participant"
        DiagramType = "ER"
    },
    @{
        Name = "Member Focus - Pathway Domain"
        Focus = "member"
        Domains = "pathway"
        DiagramType = "ER"
    },
    @{
        Name = "Center Focus - Provider Domain"
        Focus = "center"
        Domains = "provider"
        DiagramType = "ER"
    }
)

Set-Location $scriptPath

$baselineResults = @()

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Capturing: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus), Domains: $($testCase.Domains)" -ForegroundColor White
    
    # Generate test diagram
    $testOutput = "baseline_$($testCase.Name -replace '\s+', '_').mmd"
            $result = & ".\generate_erd_domain_colors.ps1" -lFocus $testCase.Focus -DiagramType $testCase.DiagramType -lDomains $testCase.Domains -OutputFile $testOutput 2>&1
    
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
                        $styleColors["other"] { $actualTiers.DarkGreyTier += $entity }
                    }
                }
            }
            
            # Report what we actually found
            Write-Host "📊 Actual Results:" -ForegroundColor White
            Write-Host "  Focus entities: $($actualTiers.Focus.Count) - $($actualTiers.Focus -join ', ')" -ForegroundColor Gray
            Write-Host "  Gold tier entities: $($actualTiers.GoldTier.Count) - $($actualTiers.GoldTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Blue tier entities: $($actualTiers.BlueTier.Count) - $($actualTiers.BlueTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Blue-grey tier entities: $($actualTiers.BlueGreyTier.Count) - $($actualTiers.BlueGreyTier -join ', ')" -ForegroundColor Gray
            Write-Host "  Dark grey tier entities: $($actualTiers.DarkGreyTier.Count) - $($actualTiers.DarkGreyTier -join ', ')" -ForegroundColor Gray
            
            # Save baseline result
            $baselineResult = @{
                TestName = $testCase.Name
                Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                Focus = $testCase.Focus
                Domains = $testCase.Domains
                DiagramType = $testCase.DiagramType
                ActualTiers = $actualTiers
                GeneratedFile = $testOutput
            }
            
            $baselineResults += $baselineResult
            
            # Keep the generated file for manual inspection
            Write-Host "✅ Baseline captured - file kept for inspection" -ForegroundColor Green
            
        } else {
            Write-Host "❌ Generated file not found" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Failed to generate diagram" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}

# Save all baseline results
$baselineResults | ConvertTo-Json -Depth 10 | Out-File "$testResultsPath\baseline_capture_results.json"

Write-Host "`n🏁 Baseline Capture Complete" -ForegroundColor Cyan
Write-Host "📊 Baseline Results: $($baselineResults.Count) tests captured" -ForegroundColor White

Write-Host "`n📋 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Review the generated .mmd files in exports/" -ForegroundColor White
Write-Host "2. Manually verify the tier assignments are correct" -ForegroundColor White
Write-Host "3. If correct, use these as regression test baselines" -ForegroundColor White
Write-Host "4. If incorrect, investigate domain detection logic" -ForegroundColor White

Write-Host "`n📁 Generated files:" -ForegroundColor Yellow
foreach ($result in $baselineResults) {
    Write-Host "  $($result.GeneratedFile)" -ForegroundColor Gray
}