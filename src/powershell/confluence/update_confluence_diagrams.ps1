<#
.SYNOPSIS
    Update Confluence pages when diagram URLs change
    
.DESCRIPTION
    Reads diagram_results.json and updates Confluence pages with new URLs
    when diagram content has changed. This ensures Confluence pages stay
    synchronized with the latest diagram versions.
    
.PARAMETER DryRun
    Show what would be updated without making changes
    
.EXAMPLE
    .\update_confluence_diagrams.ps1 -DryRun
#>

param(
    [switch]$DryRun = $false
)

# Import required modules
$confluencePath = Join-Path $PSScriptRoot "confluence_integration.ps1"
if (Test-Path $confluencePath) {
    . $confluencePath
}

Write-Host "🔄 Confluence Diagram URL Updater" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Load diagram results
$resultsFile = Join-Path (Split-Path (Split-Path $PSScriptRoot)) "exports\pre_generated\diagram_results.json"
if (-not (Test-Path $resultsFile)) {
    Write-Host "❌ No diagram results found at: $resultsFile" -ForegroundColor Red
    Write-Host "Run generate_all_diagrams.ps1 first" -ForegroundColor Yellow
    exit 1
}

$results = Get-Content $resultsFile | ConvertFrom-Json

# Check for changed diagrams
$changedDiagrams = $results.changeDetection.changedDiagrams
if ($changedDiagrams.Count -eq 0) {
    Write-Host "✅ No diagram changes detected - no updates needed" -ForegroundColor Green
    exit 0
}

Write-Host "🔄 Found $($changedDiagrams.Count) diagrams with URL changes:" -ForegroundColor Yellow
foreach ($change in $changedDiagrams) {
    Write-Host "  - $($change.focus) in $($change.domains)" -ForegroundColor Yellow
    Write-Host "    Old: $($change.oldUrl)" -ForegroundColor Gray
    Write-Host "    New: $($change.newUrl)" -ForegroundColor Gray
}

if ($DryRun) {
    Write-Host "`n🔍 DRY RUN - No changes will be made" -ForegroundColor Cyan
    Write-Host "To apply changes, run without -DryRun parameter" -ForegroundColor Yellow
    exit 0
}

# Load environment variables
$envPath = Join-Path (Split-Path (Split-Path $PSScriptRoot)) ".env"
$envVars = @{}
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match "^([^=]+)=(.*)$") {
            $envVars[$matches[1]] = $matches[2]
        }
    }
}

# Function to update Confluence page with new URLs
function Update-ConfluencePageContent {
    param(
        [string]$PageId,
        [string]$OldUrl,
        [string]$NewUrl,
        [string]$DiagramName
    )
    
    try {
        Write-Host "📝 Updating Confluence page $PageId for $DiagramName..." -ForegroundColor Cyan
        
        # Get current page content
        $page = Get-ConfluencePage -PageId $PageId -EnvVars $envVars
        
        # Replace old URL with new URL
        $updatedContent = $page.body.storage.value -replace [regex]::Escape($OldUrl), $NewUrl
        
        # Update the page
        $updateParams = @{
            PageId = $PageId
            Content = $updatedContent
            Version = ($page.version.number + 1)
            Title = $page.title
            EnvVars = $envVars
        }
        
        $result = Update-ConfluencePage @updateParams
        Write-Host "✅ Successfully updated page for $DiagramName" -ForegroundColor Green
        return $result
        
    } catch {
        Write-Host "❌ Failed to update page for $DiagramName: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# Update each changed diagram
$successCount = 0
$failureCount = 0

foreach ($change in $changedDiagrams) {
    # For now, we'll update a single test page
    # In production, you'd have a mapping of diagrams to Confluence pages
    $pageId = $envVars.CONFLUENCE_PAGE_ID
    
    $result = Update-ConfluencePageContent -PageId $pageId -OldUrl $change.oldUrl -NewUrl $change.newUrl -DiagramName $change.focus
    
    if ($result) {
        $successCount++
    } else {
        $failureCount++
    }
}

Write-Host "`n📊 Update Summary:" -ForegroundColor Cyan
Write-Host "=================" -ForegroundColor Cyan
Write-Host "Successfully updated: $successCount" -ForegroundColor Green
Write-Host "Failed updates: $failureCount" -ForegroundColor Red

if ($failureCount -gt 0) {
    Write-Host "`n⚠️  Some updates failed. Check the logs above." -ForegroundColor Yellow
    exit 1
} else {
    Write-Host "`n✅ All Confluence pages updated successfully!" -ForegroundColor Green
} 