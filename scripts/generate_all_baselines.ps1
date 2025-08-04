# Generate All Baselines
# Creates all baseline files needed for the test suite

Write-Host "🎯 Generating All Baseline Files for Test Suite..." -ForegroundColor Cyan

# Create baselines directory if it doesn't exist
$baselinesDir = "D:\GIT\farcry\Cursor\FKmermaid\tests\baselines"
if (-not (Test-Path $baselinesDir)) {
    New-Item -ItemType Directory -Path $baselinesDir | Out-Null
    Write-Host "📁 Created baselines directory: $baselinesDir" -ForegroundColor Green
}

# Clear existing baseline files
Write-Host "🧹 Clearing existing baseline files..." -ForegroundColor Yellow
Remove-Item "$baselinesDir\baseline_*.mmd" -Force -ErrorAction SilentlyContinue
Remove-Item "$baselinesDir\manual_verification_*.mmd" -Force -ErrorAction SilentlyContinue

# Baseline definitions for all tests
$baselines = @(
    @{
        Name = "partner_member_focus_partner_domain_er"
        Description = "Partner+Member Focus - 5-Tier Test"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        UsedBy = @("test_5_tier_system.ps1")
    },
    @{
        Name = "programme_activity_focus_programme_domain_er"
        Description = "Programme+Activity Focus - 4-Tier Test"
        Focus = "programme,activityDef"
        Domains = "programme"
        DiagramType = "ER"
        UsedBy = @("test_4_tier_system.ps1")
    },
    @{
        Name = "partner_focus_partner_programme_domains_er"
        Description = "Single focus with multiple domains"
        Focus = "partner"
        Domains = "partner,programme"
        DiagramType = "ER"
        UsedBy = @("test_domain_detection.ps1")
    },
    @{
        Name = "partner_focus_partner_domain_class"
        Description = "Class diagram test"
        Focus = "partner"
        Domains = "partner"
        DiagramType = "Class"
        UsedBy = @("test_manual_verification.ps1")
    },
    @{
        Name = "member_focus_all_domains_er"
        Description = "All domains test"
        Focus = "member"
        Domains = "all"
        DiagramType = "ER"
        UsedBy = @("test_manual_verification.ps1")
    },
    @{
        Name = "manual_verification_single_focus_single_domain"
        Description = "Single focus with single domain"
        Focus = "dmImage"
        Domains = "partner"
        DiagramType = "ER"
        UsedBy = @("test_manual_verification.ps1")
    },
    @{
        Name = "manual_verification_single_focus_multiple_domains"
        Description = "Single focus with multiple domains"
        Focus = "member"
        Domains = "participant,programme"
        DiagramType = "ER"
        UsedBy = @("test_manual_verification.ps1")
    },
    @{
        Name = "manual_verification_multiple_focus_single_domain"
        Description = "Multiple focus with single domain"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        UsedBy = @("test_manual_verification.ps1")
    },
    @{
        Name = "manual_verification_class_diagram_test"
        Description = "Class diagram test"
        Focus = "dmImage"
        Domains = "partner"
        DiagramType = "Class"
        UsedBy = @("test_manual_verification.ps1")
    }
)

# Generate each baseline
$successCount = 0
$totalCount = $baselines.Count

foreach ($baseline in $baselines) {
    $filename = "baseline_$($baseline.Name).mmd"
    $outputPath = Join-Path $baselinesDir $filename
    
    Write-Host "`n📊 Generating: $($baseline.Description)" -ForegroundColor Yellow
    Write-Host "   Focus: $($baseline.Focus) | Domains: $($baseline.Domains) | Type: $($baseline.DiagramType)" -ForegroundColor Gray
    Write-Host "   Used by: $($baseline.UsedBy -join ', ')" -ForegroundColor Gray
    
    # Build command string
            $command = "& 'D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_domain_colors.ps1' -lFocus '$($baseline.Focus)' -DiagramType '$($baseline.DiagramType)' -lDomains '$($baseline.Domains)' -OutputFile '$outputPath'"
    
    # Execute command
    $result = Invoke-Expression $command 2>&1
    
    if (Test-Path $outputPath) {
        $fileSize = (Get-Item $outputPath).Length
        $lineCount = (Get-Content $outputPath | Measure-Object -Line).Lines
        Write-Host "   ✅ Generated: $filename ($fileSize bytes, $lineCount lines)" -ForegroundColor Green
        $successCount++
    } else {
        Write-Host "   ❌ Failed to generate: $filename" -ForegroundColor Red
        Write-Host "   Error: $result" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n🏁 Baseline Generation Complete" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "Total baselines: $totalCount" -ForegroundColor White
Write-Host "Successfully generated: $successCount" -ForegroundColor Green
Write-Host "Failed: $($totalCount - $successCount)" -ForegroundColor Red

if ($successCount -eq $totalCount) {
    Write-Host "`n✅ All baselines generated successfully!" -ForegroundColor Green
    Write-Host "📁 Baseline files location: $baselinesDir" -ForegroundColor Cyan
    Write-Host "🧪 Ready to run tests!" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "`n❌ Some baselines failed to generate!" -ForegroundColor Red
    exit 1
}