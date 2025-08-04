# Generate diagrams to temp folder and count results
param(
    [string]$TempFolder = "D:\GIT\farcry\Cursor\FKmermaid\exports\temp_diagrams"
)

Write-Host "🚀 Generating Diagrams to Temp Folder" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Ensure temp folder exists
if (-not (Test-Path $TempFolder)) {
    New-Item -ItemType Directory -Path $TempFolder -Force | Out-Null
    Write-Host "✅ Created temp folder: $TempFolder" -ForegroundColor Green
}

# Load domains.json
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
Write-Host "Generating $totalDiagrams diagrams to temp folder" -ForegroundColor Green

# Path to the ER generation script
$erScriptPath = Join-Path $PSScriptRoot "generate_erd_domain_colors.ps1"

$successCount = 0
$failedCount = 0
$singleEntityDiagrams = @()

foreach ($diagram in $diagramsToGenerate) {
    $diagramName = $diagram.DiagramName
    $outputFile = Join-Path $TempFolder "$diagramName.mmd"
    
    Write-Host "🔄 Generating: $diagramName" -ForegroundColor Blue
    
    $params = @{
        lFocus = $diagram.Component
        lDomains = $diagram.Domain
        DiagramType = "ER"
        NoBrowser = $true
        OutputFile = $outputFile
    }
    
    try {
        # Run the ER generation script
        & $erScriptPath @params
        
        # Check if file was created
        if (Test-Path $outputFile) {
            $content = Get-Content $outputFile -Raw
            $entityCount = ($content -split "`n" | Where-Object { $_ -match "^\s*[A-Za-z]" -and $_ -notmatch "^\s*%%" }).Count
            
            Write-Host "✅ Success: $diagramName ($entityCount entities)" -ForegroundColor Green
            
            if ($entityCount -eq 1) {
                $singleEntityDiagrams += @{
                    Name = $diagramName
                    Component = $diagram.Component
                    Domain = $diagram.Domain
                    EntityCount = $entityCount
                    FilePath = $outputFile
                }
            }
            
            $successCount++
        } else {
            Write-Host "❌ Failed: $diagramName - File not created" -ForegroundColor Red
            $failedCount++
        }
    } catch {
        Write-Host "❌ Failed: $diagramName - $($_.Exception.Message)" -ForegroundColor Red
        $failedCount++
    }
    
    # Small delay
    Start-Sleep -Milliseconds 50
}

# Count total files generated
$generatedFiles = Get-ChildItem $TempFolder -Filter "*.mmd" | Measure-Object | Select-Object -ExpandProperty Count

Write-Host "`n📈 Generation Complete!" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "Total diagrams: $totalDiagrams" -ForegroundColor White
Write-Host "Successful: $successCount" -ForegroundColor Green
Write-Host "Failed: $failedCount" -ForegroundColor Red
Write-Host "Files in temp folder: $generatedFiles" -ForegroundColor Yellow

Write-Host "`n🔍 Single Entity Diagrams ($($singleEntityDiagrams.Count) found):" -ForegroundColor Yellow
foreach ($diagram in $singleEntityDiagrams) {
    Write-Host "  - $($diagram.Name) ($($diagram.Component) in $($diagram.Domain))" -ForegroundColor Gray
}

# Save results to JSON
$results = @{
    totalDiagrams = $totalDiagrams
    successful = $successCount
    failed = $failedCount
    filesGenerated = $generatedFiles
    singleEntityDiagrams = $singleEntityDiagrams
    generatedAt = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
}

$resultsFile = Join-Path $TempFolder "generation_results.json"
$results | ConvertTo-Json -Depth 10 | Set-Content $resultsFile

Write-Host "`n📁 Results saved to: $resultsFile" -ForegroundColor Green
Write-Host "📁 Diagrams saved to: $TempFolder" -ForegroundColor Green 