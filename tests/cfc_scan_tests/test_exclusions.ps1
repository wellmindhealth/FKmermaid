# Test Entity Exclusions
# Tests that excluded entities don't appear in diagrams

param(
    [switch]$Verbose,
    [switch]$Help
)

if ($Help) {
    Write-Host "Test Entity Exclusions" -ForegroundColor Cyan
    Write-Host "=====================" -ForegroundColor Cyan
    Write-Host "Tests that excluded entities don't appear in diagrams" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Verbose    Show detailed output" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$configPath = "D:\GIT\farcry\Cursor\FKmermaid\config"
$exportsPath = "D:\GIT\farcry\Cursor\FKmermaid\exports"
$testResultsPath = "D:\GIT\farcry\Cursor\FKmermaid\tests\results"

# Create results directory if it doesn't exist
if (-not (Test-Path $testResultsPath)) {
    New-Item -ItemType Directory -Path $testResultsPath -Force | Out-Null
}

Write-Host "🧪 Testing Entity Exclusions" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan

# Expected excluded entities
$expectedExclusions = @("farFilter.cfc", "farTask.cfc", "address.cfc")

# Expected excluded entity names (without .cfc extension)
$expectedExcludedEntities = @("farFilter", "farTask", "address")

# Test 1: Verify Exclusions in Config
Write-Host "`n📋 Test 1: Verify Exclusions in Config" -ForegroundColor Yellow

$config = Get-Content "$configPath\cfc_scan_config.json" | ConvertFrom-Json
$missingExclusions = @()

foreach ($exclusion in $expectedExclusions) {
    if ($config.scanSettings.excludeFiles -notcontains $exclusion) {
        $missingExclusions += $exclusion
    }
}

if ($missingExclusions.Count -eq 0) {
    Write-Host "✅ All expected exclusions present in config" -ForegroundColor Green
} else {
    Write-Host "❌ Missing exclusions: $($missingExclusions -join ', ')" -ForegroundColor Red
}

# Test 2: Verify Exclusions in knownTables
Write-Host "`n📋 Test 2: Verify Exclusions in knownTables" -ForegroundColor Yellow

$excludedInKnownTables = @()
foreach ($exclusion in $expectedExclusions) {
    if ($config.knownTables -contains $exclusion) {
        $excludedInKnownTables += $exclusion
    }
}

if ($excludedInKnownTables.Count -eq 0) {
    Write-Host "✅ No excluded entities in knownTables" -ForegroundColor Green
} else {
    Write-Host "❌ Excluded entities found in knownTables: $($excludedInKnownTables -join ', ')" -ForegroundColor Red
}

# Test 3: Generate Diagram and Check for Exclusions
Write-Host "`n📋 Test 3: Generate Diagram and Check for Exclusions" -ForegroundColor Yellow

Set-Location $scriptPath

# Generate a test diagram
$testOutput = "test_exclusions.mmd"
        $result = & ".\generate_erd_domain_colors.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "provider,participant" -OutputFile $testOutput 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Test diagram generated successfully" -ForegroundColor Green
    
    # Check the generated file for excluded entities
    $generatedFile = "$scriptPath\$testOutput"
    if (Test-Path $generatedFile) {
        $content = Get-Content $generatedFile -Raw
        
        $foundExclusions = @()
        foreach ($exclusion in $expectedExcludedEntities) {
            if ($content -match $exclusion) {
                $foundExclusions += $exclusion
            }
        }
        
        if ($foundExclusions.Count -eq 0) {
            Write-Host "✅ No excluded entities found in generated diagram" -ForegroundColor Green
        } else {
            Write-Host "❌ Excluded entities found in diagram: $($foundExclusions -join ', ')" -ForegroundColor Red
        }
        
        # Clean up test file
        Remove-Item $generatedFile -Force
        Write-Host "✅ Cleaned up test file" -ForegroundColor Green
        
    } else {
        Write-Host "❌ Generated file not found" -ForegroundColor Red
    }
} else {
    Write-Host "❌ Failed to generate test diagram" -ForegroundColor Red
    Write-Host $result -ForegroundColor Red
}

# Test 4: Check CFC Cache for Exclusions
Write-Host "`n📋 Test 4: Check CFC Cache for Exclusions" -ForegroundColor Yellow

$cacheFile = "$configPath\cfc_cache.json"
if (Test-Path $cacheFile) {
    $cache = Get-Content $cacheFile | ConvertFrom-Json
    
    $excludedInCache = @()
    foreach ($exclusion in $expectedExcludedEntities) {
        if ($cache.entities -contains $exclusion) {
            $excludedInCache += $exclusion
        }
    }
    
    if ($excludedInCache.Count -eq 0) {
        Write-Host "✅ No excluded entities in CFC cache" -ForegroundColor Green
    } else {
        Write-Host "❌ Excluded entities found in CFC cache: $($excludedInCache -join ', ')" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️  CFC cache file not found" -ForegroundColor Yellow
}

# Save test results
$testResult = @{
    TestName = "Entity Exclusions"
    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    ExpectedExclusions = $expectedExclusions
    ExpectedExcludedEntities = $expectedExcludedEntities
    MissingExclusionsInConfig = $missingExclusions
    ExcludedInKnownTables = $excludedInKnownTables
    ExcludedInCache = $excludedInCache
    ConfigExclusionsValid = ($missingExclusions.Count -eq 0)
    KnownTablesValid = ($excludedInKnownTables.Count -eq 0)
    CacheValid = ($excludedInCache.Count -eq 0)
    Success = ($missingExclusions.Count -eq 0 -and $excludedInKnownTables.Count -eq 0 -and $excludedInCache.Count -eq 0)
}

$testResult | ConvertTo-Json | Out-File "$testResultsPath\exclusions_test_result.json"

Write-Host "`n🏁 Entity Exclusions Test Complete" -ForegroundColor Cyan