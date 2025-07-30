# Revert CFC Hints Script
# Removes incorrectly applied component descriptions from property hints

param(
    [string]$PathwayPath = "D:\GIT\farcry\plugins\pathway\packages\types",
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)

# Component descriptions that were incorrectly applied
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
    
    # Remove component descriptions from property hints
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

Write-Host "CFC hint reversion completed!" -ForegroundColor Green 