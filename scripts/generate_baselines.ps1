# Generate baseline outputs for regression testing
# These are reference outputs that should be kept for future comparison

Write-Host "🎯 Generating baseline outputs for regression testing..." -ForegroundColor Cyan

# Create baselines directory if it doesn't exist
$baselinesDir = "D:\GIT\farcry\Cursor\FKmermaid\baselines"
if (-not (Test-Path $baselinesDir)) {
    New-Item -ItemType Directory -Path $baselinesDir | Out-Null
    Write-Host "📁 Created baselines directory: $baselinesDir" -ForegroundColor Green
}

# Test case 1: Partner+Member Focus - 5-Tier Test
Write-Host "📊 Generating baseline 1: Partner+Member Focus - 5-Tier Test" -ForegroundColor Yellow
& "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1" -lFocus "partner,member" -DiagramType "ER" -lDomains "provider" -OutputFile "baseline_partner_member_focus_provider_domain_er.mmd"

# Test case 2: Programme+Activity Focus - 4-Tier Test  
Write-Host "📊 Generating baseline 2: Programme+Activity Focus - 4-Tier Test" -ForegroundColor Yellow
& "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1" -lFocus "programme,activityDef" -DiagramType "ER" -lDomains "pathway" -OutputFile "baseline_programme_activity_focus_pathway_domain_er.mmd"

# Test case 3: Single focus with multiple domains
Write-Host "📊 Generating baseline 3: Single focus with multiple domains" -ForegroundColor Yellow
& "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "provider,pathway" -OutputFile "baseline_partner_focus_provider_pathway_domains_er.mmd"

# Test case 4: Class diagram test
Write-Host "📊 Generating baseline 4: Class diagram test" -ForegroundColor Yellow
& "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "Class" -lDomains "provider" -OutputFile "baseline_partner_focus_provider_domain_class.mmd"

# Test case 5: All domains test
Write-Host "📊 Generating baseline 5: All domains test" -ForegroundColor Yellow
& "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1" -lFocus "member" -DiagramType "ER" -lDomains "all" -OutputFile "baseline_member_focus_all_domains_er.mmd"

# Move baseline files to baselines directory
Write-Host "📁 Moving baseline files to baselines directory..." -ForegroundColor Cyan
Get-ChildItem "D:\GIT\farcry\Cursor\FKmermaid\exports\baseline_*.mmd" | ForEach-Object {
    Move-Item $_.FullName -Destination $baselinesDir -Force
    Write-Host "   Moved: $($_.Name)" -ForegroundColor Gray
}

Write-Host "✅ All baseline outputs generated and moved to baselines directory!" -ForegroundColor Green
Write-Host "📁 Baseline files location: $baselinesDir" -ForegroundColor Cyan
Write-Host "📋 These files are for regression testing and should not be cleaned up" -ForegroundColor Yellow