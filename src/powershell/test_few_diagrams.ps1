<#
.SYNOPSIS
    Test script for generating a few diagrams with JSON output
    
.DESCRIPTION
    Tests the new JSON output functionality of generate_erd_enhanced.ps1
    to avoid console output capture issues.
    
.EXAMPLE
    .\test_few_diagrams.ps1
#>

Write-Host "🧪 Testing JSON Output Approach" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

# Path to the ER generation script
$erScriptPath = Join-Path $PSScriptRoot "generate_erd_enhanced.ps1"

# Test data - just a few diagrams
$testCases = @(
    @{ Focus = "activityDef"; Domains = "programme"; Description = "Activity Definition in Programme Domain" },
    @{ Focus = "progRole"; Domains = "participant"; Description = "Programme Role in Participant Domain" },
    @{ Focus = "member"; Domains = "all"; Description = "Member in All Domains" }
)

$diagramResults = @{
    generated = @{}
    failed = @{}
    total = $testCases.Count
    successCount = 0
    failedCount = 0
}

Write-Host "`n📊 Testing $($testCases.Count) diagrams..." -ForegroundColor Yellow

foreach ($testCase in $testCases) {
    $diagramName = "$($testCase.Focus)-$(($testCase.Domains -replace ',', '-') -replace ' ', '')"
    $jsonOutputFile = Join-Path $PSScriptRoot "..\..\exports\pre_generated\json_$diagramName.json"
    
    Write-Host "`n🔄 Generating: $diagramName" -ForegroundColor Blue
    
    $params = @{
        lFocus = $testCase.Focus
        lDomains = $testCase.Domains
        DiagramType = "ER"
        NoBrowser = $true
        JsonOutputFile = $jsonOutputFile
    }
    
    try {
        # Run the ER generation script with JSON output
        & $erScriptPath @params
        
        # Check if JSON file was created and read the URL
        if (Test-Path $jsonOutputFile) {
            $jsonContent = Get-Content $jsonOutputFile -Raw | ConvertFrom-Json
            
            if ($jsonContent.MermaidUrl) {
                $diagramResults.generated[$diagramName] = @{
                    Focus = $testCase.Focus
                    Domains = $testCase.Domains
                    Description = $testCase.Description
                    MermaidUrl = $jsonContent.MermaidUrl
                    Status = "Success"
                    GeneratedAt = $jsonContent.GeneratedAt
                }
                $diagramResults.successCount++
                Write-Host "✅ Success: $diagramName" -ForegroundColor Green
                Write-Host "   URL: $($jsonContent.MermaidUrl)" -ForegroundColor DarkGray
            } else {
                $diagramResults.failed[$diagramName] = "No Mermaid URL in JSON output"
                $diagramResults.failedCount++
                Write-Host "❌ Failed: $diagramName - No Mermaid URL in JSON" -ForegroundColor Red
            }
        } else {
            $diagramResults.failed[$diagramName] = "JSON output file not created"
            $diagramResults.failedCount++
            Write-Host "❌ Failed: $diagramName - JSON file not created" -ForegroundColor Red
        }
    } catch {
        $diagramResults.failed[$diagramName] = $_.Exception.Message
        $diagramResults.failedCount++
        Write-Host "❌ Failed: $diagramName - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Summary
Write-Host "`n📈 Test Results Summary" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "Total diagrams: $($diagramResults.total)" -ForegroundColor White
Write-Host "Successful: $($diagramResults.successCount)" -ForegroundColor Green
Write-Host "Failed: $($diagramResults.failedCount)" -ForegroundColor Red

if ($diagramResults.failedCount -gt 0) {
    Write-Host "`n❌ Failed diagrams:" -ForegroundColor Red
    foreach ($failed in $diagramResults.failed.GetEnumerator()) {
        Write-Host "  - $($failed.Key): $($failed.Value)" -ForegroundColor Red
    }
}

if ($diagramResults.successCount -gt 0) {
    Write-Host "`n✅ Successful diagrams:" -ForegroundColor Green
    foreach ($success in $diagramResults.generated.GetEnumerator()) {
        Write-Host "  - $($success.Key): $($success.Value.MermaidUrl)" -ForegroundColor Green
    }
}

Write-Host "`n🎯 JSON output approach test complete!" -ForegroundColor Cyan 