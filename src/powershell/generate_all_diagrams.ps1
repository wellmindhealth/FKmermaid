<#
.SYNOPSIS
    Generate all pre-generated diagrams for Confluence integration
    
.DESCRIPTION
    Generates all single-entity and multi-entity diagrams based on domains.json
    Saves Mermaid.live URLs to a JSON file for Confluence integration
    
.PARAMETER NoBrowser
    Suppress browser opening during generation
    
.EXAMPLE
    .\generate_all_diagrams.ps1 -NoBrowser
#>

param(
    [switch]$NoBrowser = $true
)

# Import logging modules
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
    Initialize-ModuleLogging -ModuleName "diagram_generation" -Debug:$false
}

Write-Host "🎯 FarCry Pre-Generated Diagram Generator" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Load domain configuration
$domainsPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "config\domains.json"
$domains = Get-Content $domainsPath | ConvertFrom-Json

# Create output directory
$outputDir = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "exports\pre_generated"
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

# Initialize results collection
$diagramResults = @{
    generated = @()
    failed = @()
    timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    total = 0
    success = 0
    failedCount = 0
    version = "1.0"
    changeDetection = @{
        enabled = $true
        lastGenerated = $null
        changedDiagrams = @()
    }
}

# Load previous results for change detection
$previousResultsFile = Join-Path $outputDir "diagram_results.json"
$previousResults = $null
if (Test-Path $previousResultsFile) {
    try {
        $previousResults = Get-Content $previousResultsFile | ConvertFrom-Json
        $diagramResults.changeDetection.lastGenerated = $previousResults.timestamp
        Write-Host "📋 Loaded previous results from: $($previousResults.timestamp)" -ForegroundColor Cyan
    } catch {
        Write-Host "⚠️  Could not load previous results, starting fresh" -ForegroundColor Yellow
    }
}

# Function to generate a single diagram
function Generate-Diagram {
    param(
        [string]$Focus,
        [string]$Domains,
        [string]$Description = ""
    )
    
    try {
        Write-Host "📊 Generating: $Focus in $Domains" -ForegroundColor Yellow
        
        $erScriptPath = Join-Path $PSScriptRoot "generate_erd_enhanced.ps1"
        $tempFile = Join-Path $outputDir "temp_$Focus`_$($Domains -replace ',', '_').mmd"
        
        # Generate ER diagram with NoBrowser (all relationship types included)
        $params = @{
            lFocus = $Focus
            lDomains = $Domains
            DiagramType = "ER"
            NoBrowser = $true
            OutputFile = $tempFile
        }
        
        $result = & $erScriptPath @params 2>&1
        
        if (Test-Path $tempFile) {
            $content = Get-Content $tempFile -Raw
            $nodeScriptPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "src\node\generate_url.js"
            $mermaidUrl = $content | node $nodeScriptPath "view"
            
            # Calculate content hash for change detection
            $contentHash = [System.Security.Cryptography.SHA256]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($content))
            $contentHashString = [System.Convert]::ToBase64String($contentHash)
            
            # Check if diagram has changed
            $hasChanged = $false
            $previousUrl = $null
            if ($previousResults -and $previousResults.generated) {
                $previousDiagram = $previousResults.generated | Where-Object { $_.focus -eq $Focus -and $_.domains -eq $Domains }
                if ($previousDiagram) {
                    $previousUrl = $previousDiagram.mermaidUrl
                    $hasChanged = $previousDiagram.contentHash -ne $contentHashString
                    if ($hasChanged) {
                        $diagramResults.changeDetection.changedDiagrams += @{
                            focus = $Focus
                            domains = $Domains
                            oldUrl = $previousUrl
                            newUrl = $mermaidUrl
                            changed = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                        }
                        Write-Host "🔄 Content changed for: $Focus in $Domains" -ForegroundColor Yellow
                    }
                }
            }
            
            $diagramInfo = @{
                focus = $Focus
                domains = $Domains
                diagramType = "ER"
                description = $Description
                mermaidUrl = $mermaidUrl
                contentHash = $contentHashString
                generated = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                version = $diagramResults.version
                hasChanged = $hasChanged
                previousUrl = $previousUrl
            }
            
            $diagramResults.generated += $diagramInfo
            $diagramResults.success++
            
            Write-Host "✅ Success: $Focus in $Domains" -ForegroundColor Green
            return $diagramInfo
        } else {
            throw "No output file generated"
        }
    } catch {
        $errorInfo = @{
            focus = $Focus
            domains = $Domains
            error = $_.Exception.Message
            timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        }
        $diagramResults.failed += $errorInfo
        $diagramResults.failedCount++
        Write-Host "❌ Failed: $Focus in $Domains - $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Single entity diagrams based on domain assignments
Write-Host "`n🎯 Generating Single Entity Diagrams..." -ForegroundColor Cyan

# Dynamically read all CFCs from domains.json
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
                    Description = "$cfc entity in $domainName domain"
                }
            }
        }
    }
}

# Remove duplicates and generate single entity diagrams
$uniqueCfcs = $allCfcs | Sort-Object Name, Domain | Get-Unique -AsString | ForEach-Object { 
    $parts = $_ -split ', '
    @{
        Name = $parts[0]
        Domain = $parts[1]
        Description = "$($parts[0]) entity in $($parts[1]) domain"
    }
}

foreach ($cfc in $uniqueCfcs) {
    Generate-Diagram -Focus $cfc.Name -Domains $cfc.Domain -Description $cfc.Description
}

# Multi-domain CFCs (CFCs that appear in multiple domains)
Write-Host "`n🎯 Generating Multi-Domain Diagrams..." -ForegroundColor Cyan

# Find CFCs that appear in multiple domains
$cfcDomainMap = @{}
foreach ($cfc in $allCfcs) {
    if ($cfcDomainMap.ContainsKey($cfc.Name)) {
        $cfcDomainMap[$cfc.Name] += ",$($cfc.Domain)"
    } else {
        $cfcDomainMap[$cfc.Name] = $cfc.Domain
    }
}

# Generate multi-domain diagrams for CFCs that appear in multiple domains
foreach ($cfcName in $cfcDomainMap.Keys) {
    $domains = $cfcDomainMap[$cfcName]
    if ($domains -like "*,*") {
        $domainList = $domains -split ","
        $domainString = $domainList -join ","
        Generate-Diagram -Focus $cfcName -Domains $domainString -Description "$cfcName across $domainString domains"
    }
}

# Multi-entity logical groupings
Write-Host "`n🎯 Generating Multi-Entity Diagrams..." -ForegroundColor Cyan

# Partner admin group
Generate-Diagram -Focus "farUser,farGroup,farRole,farPermission" -Domains "partner" -Description "Partner admin entities (FarUser, FarGroup, FarRole, FarPermission)"

# Programme core group
Generate-Diagram -Focus "programme,progRole,activityDef" -Domains "programme" -Description "Programme core entities (Programme, ProgRole, ActivityDef)"

# Participant core group
Generate-Diagram -Focus "member,memberGroup,progMember" -Domains "participant" -Description "Participant core entities (Member, MemberGroup, ProgMember)"

# Site content group
Generate-Diagram -Focus "dmNavigation,dmHTML,dmFacts,dmNews" -Domains "site" -Description "Site content entities (DmNavigation, DmHTML, DmFacts, DmNews)"

# Media/Content group
Generate-Diagram -Focus "media,guide,library" -Domains "participant" -Description "Media and content entities (Media, Guide, Library)"

# Journal group (new)
Generate-Diagram -Focus "journal,journalDef" -Domains "participant" -Description "Journal entities (Journal, JournalDef)"

# Save results
$resultsFile = Join-Path $outputDir "diagram_results.json"
$diagramResults | ConvertTo-Json -Depth 10 | Out-File -FilePath $resultsFile -Encoding UTF8

# Generate summary
Write-Host "`n📊 Generation Summary:" -ForegroundColor Cyan
Write-Host "=====================" -ForegroundColor Cyan
Write-Host "Total diagrams attempted: $($diagramResults.success + $diagramResults.failedCount)" -ForegroundColor White
Write-Host "Successful: $($diagramResults.success)" -ForegroundColor Green
Write-Host "Failed: $($diagramResults.failedCount)" -ForegroundColor Red
Write-Host "Version: $($diagramResults.version)" -ForegroundColor Cyan

# Change detection summary
if ($diagramResults.changeDetection.changedDiagrams.Count -gt 0) {
    Write-Host "`n🔄 Change Detection Summary:" -ForegroundColor Yellow
    Write-Host "===========================" -ForegroundColor Yellow
    Write-Host "Diagrams with content changes: $($diagramResults.changeDetection.changedDiagrams.Count)" -ForegroundColor Yellow
    foreach ($change in $diagramResults.changeDetection.changedDiagrams) {
        Write-Host "  - $($change.focus) in $($change.domains)" -ForegroundColor Yellow
    }
    Write-Host "`n⚠️  IMPORTANT: URLs have changed! Confluence pages need updating." -ForegroundColor Red
} else {
    Write-Host "`n✅ No content changes detected - URLs remain valid" -ForegroundColor Green
}

Write-Host "Results saved to: $resultsFile" -ForegroundColor Cyan

# Clean up temp files
Get-ChildItem -Path $outputDir -Filter "temp_*.mmd" | Remove-Item -Force

Write-Host "`n✅ Pre-generated diagram generation complete!" -ForegroundColor Green 