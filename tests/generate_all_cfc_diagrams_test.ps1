<#
.SYNOPSIS
    QUICK TEST: Generate a subset of diagrams for testing (3 CFCs × 2 domains = 6 diagrams)
    
.DESCRIPTION
    Generates 6 test diagrams instead of 165:
    - 3 test CFCs × 2 domain options (provider, participant)
    - Uses JSON output to avoid console capture issues
    - Saves results to all_diagrams_results_test.json
    - Perfect for quick testing of the workflow
    
.PARAMETER RefreshCFCs
    OPTIONAL: Force fresh CFC cache generation before diagram generation
    
.EXAMPLE
    .\generate_all_cfc_diagrams_test.ps1
    
.EXAMPLE
    .\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs
#>

param(
    [switch]$RefreshCFCs = $false
)

# Import the ER generation script
$erScriptPath = Join-Path $PSScriptRoot "..\src\powershell\generate_erd_enhanced.ps1"

# Test CFCs (just 3 for quick testing - these exist in the test domains)
$testCfcNames = @("member", "activityDef", "progRole")

# Test domains (just 2 for quick testing)
$testDomainOptions = @("provider", "participant")

# Initialize results tracking
$diagramResults = @{
    generated = @{}
    failed = @{}
    total = ($testCfcNames.Count * $testDomainOptions.Count)
    successCount = 0
    failedCount = 0
    generatedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

Write-Host "`n🧪 QUICK TEST: Generating $($diagramResults.total) test diagrams..." -ForegroundColor Yellow

$progress = 0

foreach ($cfcName in $testCfcNames) {
    foreach ($domainOption in $testDomainOptions) {
        $progress++
        $percent = [math]::Round(($progress / $diagramResults.total) * 100, 1)
        
        $diagramName = "$cfcName-$domainOption"
        $jsonOutputFile = Join-Path $PSScriptRoot "..\exports\pre_generated\json_$diagramName.json"
        
        Write-Host "`n📊 Progress: $progress/$($diagramResults.total) ($percent%)" -ForegroundColor Magenta
        Write-Host "🔄 Generating: $diagramName" -ForegroundColor Blue
        
        $params = @{
            lFocus = $cfcName
            lDomains = $domainOption
            DiagramType = "ER"
            NoBrowser = $true
            JsonOutputFile = $jsonOutputFile
        }
        
        # Add RefreshCFCs parameter if specified
        if ($RefreshCFCs) {
            $params.RefreshCFCs = $true
        }
        
        try {
            # Run the ER generation script with JSON output
            & $erScriptPath @params
            
            # Check if JSON file was created and read the URL
            if (Test-Path $jsonOutputFile) {
                $jsonContent = Get-Content $jsonOutputFile -Raw | ConvertFrom-Json
                
                if ($jsonContent.MermaidUrl) {
                    $diagramResults.generated[$diagramName] = @{
                        Focus = $cfcName
                        Domains = $domainOption
                        Description = "$cfcName entity in $domainOption domain"
                        MermaidUrl = $jsonContent.MermaidUrl
                        Status = "Success"
                        GeneratedAt = $jsonContent.GeneratedAt
                    }
                    $diagramResults.successCount++
                    Write-Host "✅ Success: $diagramName" -ForegroundColor Green
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
        
        # Small delay to prevent overwhelming the system
        Start-Sleep -Milliseconds 100
    }
}

# Save results to JSON file
$resultsFile = Join-Path $PSScriptRoot "..\config\all_diagrams_results_test.json"
$diagramResults | ConvertTo-Json -Depth 10 | Set-Content -Path $resultsFile

# Summary
Write-Host "`n📈 Test Generation Complete!" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "Total diagrams: $($diagramResults.total)" -ForegroundColor White
Write-Host "Successful: $($diagramResults.successCount)" -ForegroundColor Green
Write-Host "Failed: $($diagramResults.failedCount)" -ForegroundColor Red
Write-Host "Results saved to: $resultsFile" -ForegroundColor Green

if ($diagramResults.failedCount -gt 0) {
    Write-Host "`n❌ Failed diagrams:" -ForegroundColor Red
    foreach ($failed in $diagramResults.failed.GetEnumerator()) {
        Write-Host "  - $($failed.Key): $($failed.Value)" -ForegroundColor Red
    }
}

if ($diagramResults.successCount -gt 0) {
    Write-Host "`n✅ Successfully generated $($diagramResults.successCount) test diagrams!" -ForegroundColor Green
    Write-Host "🎯 Ready for testing!" -ForegroundColor Green
}

# Cleanup temporary JSON files
Write-Host "`n🧹 Cleaning up temporary files..." -ForegroundColor Yellow
$tempFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot "..\exports\pre_generated") -Filter "json_*.json"
$tempFiles | Remove-Item -Force
Write-Host "✅ Cleaned up $($tempFiles.Count) temporary files" -ForegroundColor Green

Write-Host "`n🎯 Test diagrams generation complete!" -ForegroundColor Cyan 