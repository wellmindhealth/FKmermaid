<#
.SYNOPSIS
    Generate all 165 diagrams (33 CFCs × 5 domain options)
    
.DESCRIPTION
    Generates 165 ER diagrams:
    - 33 unique CFCs × 5 domain options (provider, participant, pathway, site, all)
    - Uses JSON output to avoid console capture issues
    - Saves results to 165_diagrams_results.json
    
.EXAMPLE
    .\generate_165_diagrams.ps1
#>

Write-Host "🚀 Generating 165 Diagrams" -ForegroundColor Cyan
Write-Host "========================" -ForegroundColor Cyan

# Load environment variables
function Load-EnvironmentVariables {
    $envPath = Join-Path $PSScriptRoot "..\..\.env"
    
    if (-not (Test-Path $envPath)) {
        Write-Host "❌ Environment file not found: $envPath" -ForegroundColor Red
        throw "Environment file not found: $envPath"
    }
    
    $envContent = Get-Content $envPath
    $envVars = @{}
    
    foreach ($line in $envContent) {
        if ($line -match '^([^=]+)=(.*)$') {
            $key = $matches[1]
            $value = $matches[2]
            $envVars[$key] = $value
        }
    }
    
    Write-Host "✅ Loaded $($envVars.Count) environment variables from $envPath" -ForegroundColor Green
    return $envVars
}

$envVars = Load-EnvironmentVariables

# Path to the ER generation script
$erScriptPath = Join-Path $PSScriptRoot "generate_erd_enhanced.ps1"

# Load domains.json to get all CFCs
$domainsPath = Join-Path $PSScriptRoot "..\..\config\domains.json"
$domains = Get-Content $domainsPath | ConvertFrom-Json

# Collect all unique CFCs
$allCfcs = @()

foreach ($domainName in $domains.domains.PSObject.Properties.Name) {
    $domain = $domains.domains.$domainName
    foreach ($categoryName in $domain.entities.PSObject.Properties.Name) {
        $cfcs = $domain.entities.$categoryName
        foreach ($cfc in $cfcs) {
            # Skip non-CFC properties
            $skipCfcs = @(
                "defaultMediaID", "aCuePointActivities", "aMediaIDs", "onEndID", 
                "aInteract1Activities", "aInteract2Activities", "aInteract3Activities", 
                "aInteract4Activities", "aInteract5Activities"
            )
            if ($cfc -notin $skipCfcs) {
                $allCfcs += @{
                    Name = $cfc
                    Domain = $domainName
                }
            }
        }
    }
}

# Get unique CFC names
$uniqueCfcNames = ($allCfcs | Select-Object -ExpandProperty Name | Sort-Object -Unique)

Write-Host "Found $($uniqueCfcNames.Count) unique CFCs after filtering." -ForegroundColor Green

# Domain options
$domainOptions = @("provider", "participant", "pathway", "site", "all")

$diagramResults = @{
    generated = @{}
    failed = @{}
    total = ($uniqueCfcNames.Count * $domainOptions.Count)
    successCount = 0
    failedCount = 0
    generatedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

Write-Host "`n📊 Generating $($diagramResults.total) diagrams..." -ForegroundColor Yellow

$progress = 0

foreach ($cfcName in $uniqueCfcNames) {
    foreach ($domainOption in $domainOptions) {
        $progress++
        $percent = [math]::Round(($progress / $diagramResults.total) * 100, 1)
        
        $diagramName = "$cfcName-$domainOption"
        $jsonOutputFile = Join-Path $PSScriptRoot "..\..\exports\pre_generated\json_$diagramName.json"
        
        Write-Host "`n📊 Progress: $progress/$($diagramResults.total) ($percent%)" -ForegroundColor Magenta
        Write-Host "🔄 Generating: $diagramName" -ForegroundColor Blue
        
        $params = @{
            lFocus = $cfcName
            lDomains = $domainOption
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
$resultsFile = Join-Path $PSScriptRoot "..\..\config\165_diagrams_results.json"
$diagramResults | ConvertTo-Json -Depth 10 | Set-Content -Path $resultsFile

# Summary
Write-Host "`n📈 Generation Complete!" -ForegroundColor Cyan
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
    Write-Host "`n✅ Successfully generated $($diagramResults.successCount) diagrams!" -ForegroundColor Green
    Write-Host "🎯 Ready for Confluence integration!" -ForegroundColor Green
}

Write-Host "`n🎯 165 diagrams generation complete!" -ForegroundColor Cyan 