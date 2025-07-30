# Complete CFC Revert Script
# Restores original property names and removes all changes made by the update script

param(
    [string]$PathwayPath = "D:\GIT\farcry\plugins\pathway\packages\types",
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)

# Property name mappings to restore original names
$propertyNameMappings = @{
    # activityDef.cfc property name corrections
    "programmeID" = "pr"
    "title" = "ti"
    "teaserImage" = "te"
    "stepNum" = "sn"
    "bogusStepNum" = "bsn"
    "bActive" = "ba"
    "bOptional" = "bo"
    "bOnEndAdvance" = "boa"
    "type" = "ty"
    "cuePointClass" = "cpc"
    "cuePointTime" = "cpt"
    "catTopic" = "ct"
    "bGuide" = "bg"
    "guideID" = "gi"
    "role" = "ro"
    "onEndID" = "oei"
    "description" = "de"
    "context" = "co"
    "code" = "cd"
    "stepReqEmail" = "sre"
    "broadcastDay" = "bd"
    "nextStepEmail" = "nse"
    "emailSubject" = "es"
    "emailTXT" = "et"
    "emailTeaseSubject" = "ets"
    "emailTeaseTXT" = "ett"
    "emailSubjectNagYearly" = "esny"
    "emailSubjectNag6month" = "esn6m"
    "emailSubjectNag3month" = "esn3m"
    "emailSubjectNag28" = "esn28"
    "emailSubjectNag14" = "esn14"
    "emailSubjectNag7" = "esn7"
    "emailSubjectNag3" = "esn3"
    "emailHTMLNagYearly" = "ehnny"
    "emailHTMLNag6month" = "ehnn6m"
    "emailHTMLNag3month" = "ehnn3m"
    "emailHTMLNag28" = "ehnn28"
    "emailHTMLNag14" = "ehnn14"
    "emailHTMLNag7" = "ehnn7"
    "emailHTMLNag3" = "ehnn3"
    "stepReqMedia" = "srm"
    "nextStepMedia" = "nsm"
    "defaultMediaID" = "dmi"
    "aCuePointActivities" = "acpa"
    "aMediaIDs" = "ami"
    "releaseMedia" = "rm"
    "stepReqInteract1" = "sri1"
    "nextStepInteract1" = "nsi1"
    "aInteract1Activities" = "aia1"
    "includeFieldsInteract1" = "ifi1"
    "buttonDoTitleInteract1" = "bdti1"
    "interact1HTML" = "i1h"
    "interact1Script" = "i1s"
    "list11FtHelpSection" = "l11fhs"
    "list11FtLabel" = "l11fl"
    "list11FtHint" = "l11fh"
    "list11FtList" = "l11fl"
    "list11FtValidation" = "l11fv"
    "list11FtValidationAdd" = "l11fva"
    "list11FtRenderType" = "l11frt"
    "list11FtClass" = "l11fc"
    "list11FtDefault" = "l11fd"
    "list11FtType" = "l11ft"
    "list11FtIncludeDecimal" = "l11fid"
    "list12FtHelpSection" = "l12fhs"
    "list12FtLabel" = "l12fl"
    "list12FtHint" = "l12fh"
    "list12FtList" = "l12fl"
    "list12FtValidation" = "l12fv"
    "list12FtValidationAdd" = "l12fva"
    "list12FtRenderType" = "l12frt"
    "list12FtClass" = "l12fc"
    "list12FtDefault" = "l12fd"
    "list12FtType" = "l12ft"
    "list12FtIncludeDecimal" = "l12fid"
}

# Component descriptions that were incorrectly applied (to remove from hints)
$componentDescriptions = @(
    "Central participant record connecting individuals to digital therapeutic ecosystem with HCP hierarchy relationships",
    "Active enrollment tracking participant's journey through structured treatment programs with progress monitoring", 
    "Personalized treatment step instances derived from activityDef templates for participant interaction",
    "Healthcare organization managing participant access and program delivery across populations",
    "Participant cohorts for segmentation, analysis, and organizational structure",
    "Physical or virtual service delivery points connecting participants to local care teams",
    "Healthcare professionals responsible for participant referrals and ongoing care coordination",
    "Capacity management system controlling participant access to programs with entitlement tracking",
    "Master treatment template containing activity structure, pacing, and lifecycle management",
    "Treatment step templates defining interaction patterns, media requirements, and progression logic",
    "Therapeutic content delivery system for videos, audio, and educational materials",
    "Simple confidence touchpoint system for single-slider assessments with gradual improvement tracking",
    "Touchpoint template system for quick confidence and satisfaction check-ins throughout treatment",
    "Program-specific role definitions for participant access control and content delivery",
    "Private participant personal documentation system for therapeutic reflection and clinical insights",
    "Journal template definition system for structured reflection prompts and therapeutic guidance",
    "Content library system for therapeutic resources, educational materials, and supplementary content",
    "Healthcare professional profile system for content attribution and credibility establishment"
)

# Get all CFC files in the pathway directory
$cfcFiles = Get-ChildItem -Path $PathwayPath -Filter "*.cfc"

foreach ($file in $cfcFiles) {
    $filePath = $file.FullName
    $content = Get-Content $filePath -Raw
    $originalContent = $content
    $modified = $false
    
    Write-Host "Processing: $($file.Name)" -ForegroundColor Blue
    
    # 1. Remove component descriptions from property hints
    foreach ($description in $componentDescriptions) {
        $escapedDescription = [regex]::Escape($description)
        $pattern = "hint=`"$escapedDescription`""
        if ($content -match $pattern) {
            $content = $content -replace $pattern, 'hint=""'
            $modified = $true
            if ($Verbose) {
                Write-Host "  Reverted hint in $($file.Name)" -ForegroundColor Yellow
            }
        }
    }
    
    # 2. Restore original property names
    foreach ($newName in $propertyNameMappings.Keys) {
        $oldName = $propertyNameMappings[$newName]
        $pattern = "name=`"$newName`""
        if ($content -match $pattern) {
            $content = $content -replace $pattern, "name=`"$oldName`""
            $modified = $true
            if ($Verbose) {
                Write-Host "  Restored property name: $newName -> $oldName" -ForegroundColor Yellow
            }
        }
    }
    
    # 3. Remove @@Description comments
    if ($content -match '<!--- @@Description:.*?--->') {
        $content = $content -replace '<!--- @@Description:.*?--->', ""
        $modified = $true
        if ($Verbose) {
            Write-Host "  Removed @@Description comment" -ForegroundColor Yellow
        }
    }
    
    # 4. Remove component-level hint attributes that were added
    if ($content -match '<cfcomponent[^>]*hint\s*=\s*["''][^"'']*["''][^>]*>') {
        $content = $content -replace '<cfcomponent([^>]*hint\s*=\s*["''])[^"'']*([^>]*>)', "<cfcomponent`$2"
        $modified = $true
        if ($Verbose) {
            Write-Host "  Removed component hint attribute" -ForegroundColor Yellow
        }
    }
    
    if ($modified) {
        if ($DryRun) {
            Write-Host "DRY RUN - Would update $filePath" -ForegroundColor Cyan
        } else {
            Set-Content -Path $filePath -Value $content -NoNewline
            Write-Host "Reverted: $($file.Name)" -ForegroundColor Green
        }
    } else {
        Write-Host "No changes needed: $($file.Name)" -ForegroundColor Gray
    }
}

Write-Host "Complete CFC reversion completed!" -ForegroundColor Green 