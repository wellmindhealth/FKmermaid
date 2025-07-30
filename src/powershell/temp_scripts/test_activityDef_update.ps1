# Test script to update only activityDef
param(
    [string]$ConfigPath = "D:\GIT\farcry\Cursor\FKmermaid\config\component_hints.json",
    [string]$CFCPath = "D:\GIT\farcry\plugins\pathway\packages\types",
    [switch]$DryRun = $true
)

# Load component hints
$hintsConfig = Get-Content $ConfigPath | ConvertFrom-Json

# Detailed descriptions for @@Description comments
$detailedDescriptions = @{
    "activityDef" = @"
Treatment Step Templates

Business Context: ActivityDefs (activity definitions) represent the definition of individual treatment steps within a program. These are the building blocks that define how participants interact with therapeutic content, complete exercises, or engage with educational materials. Each activityDef defines the structure, media requirements, interaction patterns, and progression logic for a specific treatment step.

Technical Role: ActivityDefs serve as templates that define the structure and requirements for individual treatment steps. They contain the logic for media integration, interaction patterns, progression rules, and content structure that will be instantiated for each participant.

Key Relationships: ActivityDefs belong to programmes and may reference multiple media resources, creating a template system that supports both consistency and flexibility in treatment delivery.
"@
}

function Update-CFCFile {
    param(
        [string]$FilePath,
        [string]$ComponentName,
        [string]$ShortHint,
        [string]$DetailedDescription
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return $false
    }
    
    $content = Get-Content $FilePath -Raw
    $originalContent = $content
    
    Write-Host "Current @@Description:" -ForegroundColor Cyan
    if ($content -match '<!--- @@Description:.*?--->') {
        Write-Host $matches[0] -ForegroundColor Gray
    } else {
        Write-Host "No @@Description found" -ForegroundColor Red
    }
    
    Write-Host "`nCurrent hint attribute:" -ForegroundColor Cyan
    if ($content -match 'hint="[^"]*"') {
        Write-Host $matches[0] -ForegroundColor Gray
    } else {
        Write-Host "No hint attribute found" -ForegroundColor Red
    }
    
    # Update the @@Description comment
    $descriptionPattern = '<!--- @@Description:.*?--->'
    $newDescriptionComment = "<!--- @@Description: $ComponentName - $DetailedDescription --->"
    
    if ($content -match $descriptionPattern) {
        $content = $content -replace $descriptionPattern, $newDescriptionComment
    } else {
        # Add description comment after copyright
        $content = $content -replace '(<!--- @@Copyright:.*?--->)', "`$1`n$newDescriptionComment"
    }
    
    # Update the hint attribute in cfcomponent tag
    $hintPattern = 'hint="[^"]*"'
    $newHint = "hint=`"$ShortHint`""
    
    if ($content -match $hintPattern) {
        $content = $content -replace $hintPattern, $newHint
    }
    
    Write-Host "`nNew @@Description:" -ForegroundColor Green
    Write-Host $newDescriptionComment -ForegroundColor Green
    
    Write-Host "`nNew hint attribute:" -ForegroundColor Green
    Write-Host $newHint -ForegroundColor Green
    
    if ($content -ne $originalContent) {
        if ($DryRun) {
            Write-Host "`nDRY RUN: Would update $FilePath" -ForegroundColor Yellow
        } else {
            Set-Content -Path $FilePath -Value $content -Encoding UTF8
            Write-Host "`nUpdated: $FilePath" -ForegroundColor Green
        }
        return $true
    } else {
        Write-Host "`nNo changes needed: $FilePath" -ForegroundColor Gray
        return $false
    }
}

# Main execution - only process activityDef
$componentName = "activityDef"
$cfcFile = Join-Path $CFCPath "$componentName.cfc"
$shortHint = $hintsConfig.componentHints.$componentName
$detailedDescription = $detailedDescriptions[$componentName]

Write-Host "Testing activityDef Update" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

$updated = Update-CFCFile -FilePath $cfcFile -ComponentName $componentName -ShortHint $shortHint -DetailedDescription $detailedDescription

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Component: $componentName"
Write-Host "  File: $cfcFile"
Write-Host "  Updated: $updated"
Write-Host "  Dry run mode: $DryRun" 