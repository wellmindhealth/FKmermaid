<#
.SYNOPSIS
    Update test expectations with actual entity counts from baseline files
    
.DESCRIPTION
    After regenerating baselines, this script analyzes the generated .mmd files
    and updates ExpectedEntityCount values in test files to match actual results.
    
.PARAMETER Force
    OPTIONAL: Force update even if differences are small
    
.EXAMPLE
    .\update_test_expectations.ps1
    
.EXAMPLE
    .\update_test_expectations.ps1 -Force
#>

param(
    [switch]$Force = $false
)

Write-Host "🔄 Updating Test Expectations" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan

# Paths
$baselinePath = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines"
$testFiles = @(
    "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\test_edge_cases.ps1",
    "D:\GIT\farcry\Cursor\FKmermaid\tests\main_script_tests\test_5_tier_system.ps1",
    "D:\GIT\farcry\Cursor\FKmermaid\tests\main_script_tests\test_manual_verification.ps1"
)

# Function to count entities in MMD file
function Get-EntityCountFromMMD {
    param([string]$mmdFile)
    
    if (-not (Test-Path $mmdFile)) {
        Write-Host "⚠️  Baseline file not found: $mmdFile" -ForegroundColor Yellow
        return 0
    }
    
    $content = Get-Content $mmdFile -Raw
    $entityMatches = [regex]::Matches($content, '^\s*(\w+)\s*\{', [System.Text.RegularExpressions.RegexOptions]::Multiline)
    
    return $entityMatches.Count
}

# Function to update ExpectedEntityCount in test file
function Update-TestFile {
    param(
        [string]$testFile,
        [hashtable]$baselineUpdates
    )
    
    if (-not (Test-Path $testFile)) {
        Write-Host "⚠️  Test file not found: $testFile" -ForegroundColor Yellow
        return
    }
    
    $content = Get-Content $testFile -Raw
    $updated = $false
    
    foreach ($baseline in $baselineUpdates.GetEnumerator()) {
        $baselineName = $baseline.Key
        $actualCount = $baseline.Value
        
        # Find ExpectedEntityCount line for this baseline
        $pattern = "(\s*ExpectedEntityCount\s*=\s*)\d+(\s*#.*$($baselineName).*)"
        if ($content -match $pattern) {
            $oldCount = [regex]::Match($content, $pattern).Groups[2].Value
            $newContent = $content -replace $pattern, "`$1$actualCount`$2"
            
            if ($newContent -ne $content) {
                $content = $newContent
                $updated = $true
                Write-Host "✅ Updated $($baselineName): $actualCount entities" -ForegroundColor Green
            }
        }
    }
    
    if ($updated) {
        $content | Set-Content $testFile
        Write-Host "📝 Updated test file: $testFile" -ForegroundColor Green
    } else {
        Write-Host "ℹ️  No updates needed for: $testFile" -ForegroundColor Gray
    }
}

# Get all baseline files and their entity counts
Write-Host "📊 Analyzing baseline files..." -ForegroundColor Yellow
$baselineUpdates = @{}

$baselineFiles = Get-ChildItem -Path $baselinePath -Filter "*.mmd"
foreach ($file in $baselineFiles) {
    $baselineName = $file.BaseName
    $entityCount = Get-EntityCountFromMMD $file.FullName
    
    if ($entityCount -gt 0) {
        $baselineUpdates[$baselineName] = $entityCount
        Write-Host "  $baselineName - $entityCount entities" -ForegroundColor White
    }
}

Write-Host "`n📝 Updating test files..." -ForegroundColor Yellow
foreach ($testFile in $testFiles) {
    Update-TestFile -testFile $testFile -baselineUpdates $baselineUpdates
}

Write-Host "`n✅ Test expectation update complete!" -ForegroundColor Green
Write-Host "📋 Updated $($baselineUpdates.Count) baseline expectations" -ForegroundColor Cyan 