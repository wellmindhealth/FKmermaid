# Test script for manual verification of semantic styling
# Run these tests and manually verify the outputs are semantically correct

param(
    [string]$stylesPath = "..\..\styles\mermaid_styles.mmd",
    [string]$exportsPath = "..\..\exports"
)

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Clean exports first
Write-Host "🧹 Cleaning exports directory..." -ForegroundColor Yellow
if (Test-Path $exportsPath) {
    Remove-Item -Path "$exportsPath\*.mmd" -Force
}

# Test cases for manual verification
$testCases = @(
    @{
        Name = "Single Focus - Partner"
        Focus = "partner"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Single focus entity in partner domain"
    },
    @{
        Name = "Multi Focus - Partner,Member"
        Focus = "partner,member"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Two focus entities in partner domain"
    },
    @{
        Name = "Cross Domain - Partner Focus, Programme Domain"
        Focus = "partner"
        Domains = "programme"
        DiagramType = "ER"
        Description = "Partner focus but programme domain filter"
    },
    @{
        Name = "Programme Focus with Activity"
        Focus = "programme,activityDef"
        Domains = "programme"
        DiagramType = "ER"
        Description = "Programme and activity focus in programme domain"
    },
    @{
        Name = "Site Domain Test"
        Focus = "dmImage"
        Domains = "site"
        DiagramType = "ER"
        Description = "Site focus in site domain"
    },
    @{
        Name = "Participant Domain Test"
        Focus = "member"
        Domains = "participant"
        DiagramType = "ER"
        Description = "Participant focus in participant domain"
    },
    @{
        Name = "Multi Domain - Partner and Programme"
        Focus = "partner,programme"
        Domains = "partner,programme"
        DiagramType = "ER"
        Description = "Multi-domain focus and filter"
    },
    @{
        Name = "Class Diagram Test"
        Focus = "partner"
        Domains = "partner"
        DiagramType = "Class"
        Description = "Class diagram with partner focus"
    },
    @{
        Name = "Complex Multi Focus"
        Focus = "partner,member,programme"
        Domains = "partner,programme"
        DiagramType = "ER"
        Description = "Three focus entities across two domains"
    },
    @{
        Name = "Single Entity Deep Focus"
        Focus = "farUser"
        Domains = ""
        DiagramType = "ER"
        Description = "Single farUser focus with no domain filter"
    },
    @{
        Name = "All Domains Test"
        Focus = "partner"
        Domains = "all"
        DiagramType = "ER"
        Description = "Partner focus with all domains explicitly specified"
    }
)

Write-Host "`n🧪 MANUAL VERIFICATION TESTS" -ForegroundColor Cyan
Write-Host "Generating $($testCases.Count) test cases for manual verification..." -ForegroundColor White

foreach ($testCase in $testCases) {
    Write-Host "`n📋 Test: $($testCase.Name)" -ForegroundColor Yellow
    Write-Host "Focus: $($testCase.Focus)" -ForegroundColor White
    Write-Host "Domains: $($testCase.Domains)" -ForegroundColor White
    Write-Host "Type: $($testCase.DiagramType)" -ForegroundColor White
    Write-Host "Description: $($testCase.Description)" -ForegroundColor Gray
    
    # Generate unique filename
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $guid = [System.Guid]::NewGuid().ToString("N").Substring(0, 8)
    $testOutput = "manual_verification_$($testCase.Name -replace '[^a-zA-Z0-9]', '_')_${timestamp}_${guid}.mmd"
    
    # Generate diagram
    $scriptPath = "..\..\src\powershell\generate_erd_enhanced.ps1"
    $command = "& '$scriptPath' -lFocus '$($testCase.Focus)' -DiagramType '$($testCase.DiagramType)' -OutputFile '$testOutput'"
    if ($testCase.Domains) {
        $command += " -lDomains '$($testCase.Domains)'"
    }
    
    Write-Host "Running: $command" -ForegroundColor Gray
    $result = Invoke-Expression $command 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Generated: $testOutput" -ForegroundColor Green
        
        # Show file location
        $fullPath = "$exportsPath\$testOutput"
        if (Test-Path $fullPath) {
            Write-Host "📁 Location: $fullPath" -ForegroundColor Cyan
        }
    } else {
        Write-Host "❌ Failed to generate: $testOutput" -ForegroundColor Red
        Write-Host "Error: $result" -ForegroundColor Red
    }
}

Write-Host "`n🎯 MANUAL VERIFICATION CHECKLIST:" -ForegroundColor Cyan
Write-Host "For each generated diagram, verify:" -ForegroundColor White
Write-Host "1. Focus entities are ORANGE" -ForegroundColor Gray
Write-Host "2. Same domain AND directly related entities are GOLD" -ForegroundColor Gray
Write-Host "3. Directly related (other domains) are BLUE" -ForegroundColor Gray
Write-Host "4. Same domain but NOT directly related are BLUE-GREY" -ForegroundColor Gray
Write-Host "5. Other domains are DARK GREY" -ForegroundColor Gray
Write-Host "6. SSQ groups are PURPLE (if present)" -ForegroundColor Gray
Write-Host "`n📊 Total files generated: $($testCases.Count)" -ForegroundColor Yellow
Write-Host "📁 Check exports directory for all .mmd files" -ForegroundColor Yellow