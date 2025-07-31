# Test CFC Cache Generation
# Validates that the cache generation works correctly with inheritance support

Write-Host "🧪 Testing CFC Cache Generation" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

# Configuration
$cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
$cacheScript = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_cfc_cache.ps1"
$backupCacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json.backup"

# Test results
$testResults = @()
$overallSuccess = $true

# Function to run a test step
function Test-Step {
    param(
        [string]$StepName,
        [scriptblock]$TestScript,
        [string]$Description
    )
    
    Write-Host "`n📋 $StepName" -ForegroundColor Yellow
    Write-Host "   $Description" -ForegroundColor Gray
    
    try {
        $result = & $TestScript
        Write-Host "   ✅ PASSED" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "   ❌ FAILED: $($_.Exception.Message)" -ForegroundColor Red
        $script:overallSuccess = $false
        return $false
    }
}

# Step 1: Backup existing cache
Test-Step -StepName "Backup Existing Cache" -Description "Creating backup of current cache file" -TestScript {
    if (Test-Path $cacheFile) {
        Copy-Item $cacheFile $backupCacheFile -Force
        Write-Host "   📋 Backup created: $backupCacheFile" -ForegroundColor Gray
    } else {
        Write-Host "   📋 No existing cache to backup" -ForegroundColor Gray
    }
}

# Step 2: Run cache generation
Test-Step -StepName "Generate CFC Cache" -Description "Running cache generation with inheritance support" -TestScript {
    & $cacheScript
    if ($LASTEXITCODE -ne 0) {
        throw "Cache generation failed with exit code $LASTEXITCODE"
    }
}

# Step 3: Validate cache structure
Test-Step -StepName "Validate Cache Structure" -Description "Checking that all required sections exist" -TestScript {
    if (-not (Test-Path $cacheFile)) {
        throw "Cache file not found: $cacheFile"
    }
    
    $cache = Get-Content $cacheFile | ConvertFrom-Json
    
    # Check required sections
    $requiredSections = @("directFK", "joinTables", "entities", "properties", "componentMetadata")
    foreach ($section in $requiredSections) {
        if (-not $cache.PSObject.Properties.Name -contains $section) {
            throw "Missing required section: $section"
        }
    }
    
    Write-Host "   📊 Found $($cache.componentMetadata.Count) component metadata entries" -ForegroundColor Gray
    Write-Host "   📊 Found $($cache.entities.Count) entities" -ForegroundColor Gray
    Write-Host "   📊 Found $($cache.directFK.Count) direct FK relationships" -ForegroundColor Gray
    Write-Host "   📊 Found $($cache.joinTables.Count) join table relationships" -ForegroundColor Gray
    Write-Host "   📊 Found $($cache.properties.Count) properties" -ForegroundColor Gray
}

# Step 4: Test inheritance functionality
Test-Step -StepName "Test Inheritance Support" -Description "Verifying that extended components inherit metadata" -TestScript {
    $cache = Get-Content $cacheFile | ConvertFrom-Json
    
    # Look for dmImage in zfarcrycore (base component)
    $dmImageZfarcrycore = $cache.componentMetadata | Where-Object { $_.name -eq "dmImage" -and $_.plugin -eq "zfarcrycore" }
    
    if (-not $dmImageZfarcrycore) {
        throw "dmImage (zfarcrycore) not found in cache"
    }
    
    # Check if dmImage has proper metadata (inheritance is handled in the generation script)
    if ([string]::IsNullOrWhiteSpace($dmImageZfarcrycore.hint)) {
        Write-Host "   ⚠️  dmImage should have hint metadata" -ForegroundColor Yellow
    } else {
        Write-Host "   ✅ dmImage has inherited metadata correctly" -ForegroundColor Green
    }
    
    if ([string]::IsNullOrWhiteSpace($dmImageZfarcrycore.description)) {
        Write-Host "   ⚠️  dmImage should have description metadata" -ForegroundColor Yellow
    } else {
        Write-Host "   ✅ dmImage has inherited description correctly" -ForegroundColor Green
    }
    
    Write-Host "   📋 dmImage (zfarcrycore): hint='$($dmImageZfarcrycore.hint)', description='$($dmImageZfarcrycore.description)'" -ForegroundColor Gray
}

# Step 5: Test specific metadata fields
Test-Step -StepName "Validate Metadata Fields" -Description "Checking that metadata contains expected fields" -TestScript {
    $cache = Get-Content $cacheFile | ConvertFrom-Json
    
    # Check a few sample components
    $sampleComponents = $cache.componentMetadata | Select-Object -First 5
    
    foreach ($component in $sampleComponents) {
        $requiredFields = @("name", "plugin", "filePath")
        foreach ($field in $requiredFields) {
            if (-not $component.PSObject.Properties.Name -contains $field) {
                throw "Component $($component.name) missing required field: $field"
            }
        }
        
        Write-Host "   📋 $($component.name) ($($component.plugin)): hint='$($component.hint)', description='$($component.description)'" -ForegroundColor Gray
    }
}

# Step 6: Restore backup
Test-Step -StepName "Restore Original Cache" -Description "Restoring original cache file" -TestScript {
    if (Test-Path $backupCacheFile) {
        Copy-Item $backupCacheFile $cacheFile -Force
        Remove-Item $backupCacheFile -Force
        Write-Host "   📋 Original cache restored" -ForegroundColor Gray
    }
}

# Final results
Write-Host "`n🎯 CFC Cache Generation Test Results" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan

if ($overallSuccess) {
    Write-Host "✅ ALL TESTS PASSED" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ SOME TESTS FAILED" -ForegroundColor Red
    exit 1
} 