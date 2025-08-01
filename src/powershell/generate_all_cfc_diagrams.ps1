<#
.SYNOPSIS
    Generate diagrams dynamically based on domains.json configuration
    
.DESCRIPTION
    Generates ER diagrams for each component in each domain where it exists:
    - Reads domains.json to determine which components exist in which domains
    - Only generates diagrams for valid component-domain combinations
    - Uses JSON output to avoid console capture issues
    - Saves results to all_diagrams_results.json
    
.PARAMETER RefreshCFCs
    OPTIONAL: Force fresh CFC cache generation before diagram generation
    
.EXAMPLE
    .\generate_all_cfc_diagrams.ps1
    
.EXAMPLE
    .\generate_all_cfc_diagrams.ps1 -RefreshCFCs
#>

param(
    [switch]$RefreshCFCs = $false
)

Write-Host "🚀 Generating Diagrams Dynamically" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

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

# Load domains.json to get all CFCs and their domain mappings
$domainsPath = Join-Path $PSScriptRoot "..\..\config\domains.json"
$domains = Get-Content $domainsPath | ConvertFrom-Json

# Build component-domain mapping
$componentDomainMapping = @{}

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
                if (-not $componentDomainMapping.ContainsKey($cfc)) {
                    $componentDomainMapping[$cfc] = @()
                }
                $componentDomainMapping[$cfc] += $domainName
            }
        }
    }
}

# Create list of diagrams to generate
$diagramsToGenerate = @()

foreach ($component in $componentDomainMapping.Keys) {
    $domainsForComponent = $componentDomainMapping[$component]
    foreach ($domain in $domainsForComponent) {
        $diagramsToGenerate += @{
            Component = $component
            Domain = $domain
            DiagramName = "$component-$domain"
        }
    }
}

$totalDiagrams = $diagramsToGenerate.Count

Write-Host "Found $($componentDomainMapping.Keys.Count) unique components" -ForegroundColor Green
Write-Host "Generating $totalDiagrams diagrams (only valid component-domain combinations)" -ForegroundColor Green

$diagramResults = @{
    generated = @{}
    failed = @{}
    total = $totalDiagrams
    successCount = 0
    failedCount = 0
    generatedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

# Regenerate cache once at the beginning if RefreshCFCs is specified
if ($RefreshCFCs) {
    Write-Host "`n🔄 Regenerating CFC cache once at the beginning..." -ForegroundColor Yellow
    $cacheScriptPath = Join-Path $PSScriptRoot "generate_cfc_cache.ps1"
    if (Test-Path $cacheScriptPath) {
        & $cacheScriptPath
        Write-Host "✅ Cache regeneration completed" -ForegroundColor Green
    } else {
        Write-Host "❌ Cache generation script not found: $cacheScriptPath" -ForegroundColor Red
        exit 1
    }
}

Write-Host "`n📊 Generating $totalDiagrams diagrams..." -ForegroundColor Yellow

$progress = 0

foreach ($diagram in $diagramsToGenerate) {
    $progress++
    $percent = [math]::Round(($progress / $totalDiagrams) * 100, 1)
    
    $diagramName = $diagram.DiagramName
    $jsonOutputFile = Join-Path $PSScriptRoot "..\..\exports\pre_generated\json_$diagramName.json"
    
    Write-Host "`n📊 Progress: $progress/$totalDiagrams ($percent%)" -ForegroundColor Magenta
    Write-Host "🔄 Generating: $diagramName" -ForegroundColor Blue
    
    $params = @{
        lFocus = $diagram.Component
        lDomains = $diagram.Domain
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
                    Focus = $diagram.Component
                    Domains = $diagram.Domain
                    Description = "$($diagram.Component) entity in $($diagram.Domain) domain"
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

# Save results to JSON file
$resultsFile = Join-Path $PSScriptRoot "..\..\config\all_diagrams_results.json"
$diagramResults | ConvertTo-Json -Depth 10 | Set-Content -Path $resultsFile

# Summary
Write-Host "`n📈 Generation Complete!" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "Total diagrams: $totalDiagrams" -ForegroundColor White
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

# Cleanup temporary JSON files
Write-Host "`n🧹 Cleaning up temporary files..." -ForegroundColor Yellow
$tempFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot "..\..\exports\pre_generated") -Filter "json_*.json"
$tempFiles | Remove-Item -Force
Write-Host "✅ Cleaned up $($tempFiles.Count) temporary files" -ForegroundColor Green

Write-Host "`n🎯 All diagrams generation complete!" -ForegroundColor Cyan 