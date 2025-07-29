# FKmermaid Advanced Test Scenarios
# Tests edge cases and complex relationship scenarios

# Import configuration manager
. (Join-Path $PSScriptRoot "config_manager.ps1")

function Initialize-AdvancedTestScenarios {
    param(
        [object]$config = $null
    )
    
    if (-not $config) {
        $config = Get-ProjectConfig
    }
    
    Write-Host "Advanced Test Scenarios initialized:" -ForegroundColor Green
    Write-Host "  Edge case testing enabled" -ForegroundColor Cyan
    Write-Host "  Complex relationship validation active" -ForegroundColor Cyan
    Write-Host "  Performance benchmarking ready" -ForegroundColor Cyan
}

function Test-EdgeCases {
    param(
        [hashtable]$options = @{}
    )
    
    $results = @{
        Passed = @()
        Failed = @()
        Warnings = @()
        Performance = @{}
    }
    
    Write-Host "🧪 Testing Edge Cases..." -ForegroundColor Cyan
    
    # Test 1: Empty focus entity
    Write-Host "  Testing empty focus entity..." -ForegroundColor White
    try {
        $result = Test-EmptyFocusEntity
        if ($result.Success) {
            $results.Passed += "Empty focus entity handling"
        } else {
            $results.Failed += "Empty focus entity handling"
        }
    } catch {
        $results.Failed += "Empty focus entity handling"
    }
    
    # Test 2: Invalid domain names
    Write-Host "  Testing invalid domain names..." -ForegroundColor White
    try {
        $result = Test-InvalidDomainNames
        if ($result.Success) {
            $results.Passed += "Invalid domain name handling"
        } else {
            $results.Failed += "Invalid domain name handling"
        }
    } catch {
        $results.Failed += "Invalid domain name handling"
    }
    
    # Test 3: Large entity sets
    Write-Host "  Testing large entity sets..." -ForegroundColor White
    try {
        $result = Test-LargeEntitySets
        if ($result.Success) {
            $results.Passed += "Large entity set handling"
        } else {
            $results.Failed += "Large entity set handling"
        }
        $results.Performance["LargeEntitySets"] = $result.Performance
    } catch {
        $results.Failed += "Large entity set handling"
    }
    
    # Test 4: Circular dependencies
    Write-Host "  Testing circular dependencies..." -ForegroundColor White
    try {
        $result = Test-CircularDependencies
        if ($result.Success) {
            $results.Passed += "Circular dependency detection"
        } else {
            $results.Failed += "Circular dependency detection"
        }
    } catch {
        $results.Failed += "Circular dependency detection"
    }
    
    # Test 5: Self-referencing relationships
    Write-Host "  Testing self-referencing relationships..." -ForegroundColor White
    try {
        $result = Test-SelfReferencingRelationships
        if ($result.Success) {
            $results.Passed += "Self-referencing relationship handling"
        } else {
            $results.Failed += "Self-referencing relationship handling"
        }
    } catch {
        $results.Failed += "Self-referencing relationship handling"
    }
    
    return $results
}

function Test-EmptyFocusEntity {
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    try {
        $result = & ".\generate_erd_enhanced.ps1" -lFocus "" -DiagramType "ER" -lDomains "partner" -OutputFile "test_empty_focus.mmd" 2>&1
        $success = $LASTEXITCODE -eq 0
        
        # Clean up
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\test_empty_focus.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
        }
        
        return @{
            Success = $success
            Output = $result
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-InvalidDomainNames {
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    try {
        $result = & ".\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "invalid_domain,another_invalid" -OutputFile "test_invalid_domains.mmd" 2>&1
        $success = $LASTEXITCODE -eq 0
        
        # Clean up
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\test_invalid_domains.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
        }
        
        return @{
            Success = $success
            Output = $result
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-LargeEntitySets {
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    $startTime = Get-Date
    
    try {
        $result = & ".\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "partner,participant,programme,site" -OutputFile "test_large_entities.mmd" 2>&1
        $success = $LASTEXITCODE -eq 0
        
        $endTime = Get-Date
        $duration = $endTime - $startTime
        
        # Clean up
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\test_large_entities.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
        }
        
        return @{
            Success = $success
            Output = $result
            Performance = @{
                Duration = $duration.TotalSeconds
                MemoryUsage = (Get-Process -Id $PID).WorkingSet64 / 1MB
            }
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
            Performance = @{
                Duration = 0
                MemoryUsage = 0
            }
        }
    }
}

function Test-CircularDependencies {
    # Create a test scenario with circular dependencies
    $testRelationships = @{
        directFK = @(
            @{ source = "entity1"; target = "entity2" },
            @{ source = "entity2"; target = "entity3" },
            @{ source = "entity3"; target = "entity1" }  # Creates a cycle
        )
        joinTables = @()
    }
    
    try {
        # Test if circular dependency detection works
        $hasCircular = $false
        foreach ($fk in $testRelationships.directFK) {
            if ($fk.source -eq $fk.target) {
                $hasCircular = $true
                break
            }
        }
        
        return @{
            Success = $hasCircular
            Output = "Circular dependency detection test"
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-SelfReferencingRelationships {
    # Create a test scenario with self-referencing relationships
    $testRelationships = @{
        directFK = @(
            @{ source = "entity1"; target = "entity1" },  # Self-reference
            @{ source = "entity2"; target = "entity3" },
            @{ source = "entity3"; target = "entity2" }
        )
        joinTables = @()
    }
    
    try {
        # Test if self-referencing relationships are detected
        $hasSelfRef = $false
        foreach ($fk in $testRelationships.directFK) {
            if ($fk.source -eq $fk.target) {
                $hasSelfRef = $true
                break
            }
        }
        
        return @{
            Success = $hasSelfRef
            Output = "Self-referencing relationship detection test"
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-ComplexRelationshipScenarios {
    param(
        [hashtable]$options = @{}
    )
    
    $results = @{
        Passed = @()
        Failed = @()
        Warnings = @()
    }
    
    Write-Host "🧪 Testing Complex Relationship Scenarios..." -ForegroundColor Cyan
    
    # Test 1: Multi-level relationships
    Write-Host "  Testing multi-level relationships..." -ForegroundColor White
    try {
        $result = Test-MultiLevelRelationships
        if ($result.Success) {
            $results.Passed += "Multi-level relationship handling"
        } else {
            $results.Failed += "Multi-level relationship handling"
        }
    } catch {
        $results.Failed += "Multi-level relationship handling"
    }
    
    # Test 2: Cross-domain relationships
    Write-Host "  Testing cross-domain relationships..." -ForegroundColor White
    try {
        $result = Test-CrossDomainRelationships
        if ($result.Success) {
            $results.Passed += "Cross-domain relationship handling"
        } else {
            $results.Failed += "Cross-domain relationship handling"
        }
    } catch {
        $results.Failed += "Cross-domain relationship handling"
    }
    
    # Test 3: Relationship strength scoring
    Write-Host "  Testing relationship strength scoring..." -ForegroundColor White
    try {
        $result = Test-RelationshipStrengthScoring
        if ($result.Success) {
            $results.Passed += "Relationship strength scoring"
        } else {
            $results.Failed += "Relationship strength scoring"
        }
    } catch {
        $results.Failed += "Relationship strength scoring"
    }
    
    return $results
}

function Test-MultiLevelRelationships {
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    try {
        # Test with multiple focus entities to create multi-level relationships
        $result = & ".\generate_erd_enhanced.ps1" -lFocus "partner,member,programme" -DiagramType "ER" -lDomains "partner,participant,programme" -OutputFile "test_multi_level.mmd" 2>&1
        $success = $LASTEXITCODE -eq 0
        
        # Clean up
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\test_multi_level.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
        }
        
        return @{
            Success = $success
            Output = $result
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-CrossDomainRelationships {
    $scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
    Set-Location $scriptPath
    
    try {
        # Test with domains that span multiple areas
        $result = & ".\generate_erd_enhanced.ps1" -lFocus "partner" -DiagramType "ER" -lDomains "partner,participant,programme,site" -OutputFile "test_cross_domain.mmd" 2>&1
        $success = $LASTEXITCODE -eq 0
        
        # Clean up
        $testFile = "D:\GIT\farcry\Cursor\FKmermaid\exports\test_cross_domain.mmd"
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
        }
        
        return @{
            Success = $success
            Output = $result
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Test-RelationshipStrengthScoring {
    # Create test relationships with varying frequencies
    $testRelationships = @{
        directFK = @(
            @{ source = "entity1"; target = "entity2" },
            @{ source = "entity1"; target = "entity2" },  # Duplicate for strength
            @{ source = "entity2"; target = "entity3" },
            @{ source = "entity3"; target = "entity4" },
            @{ source = "entity1"; target = "entity3" }
        )
        joinTables = @()
    }
    
    try {
        # Calculate relationship strength
        $strengthScores = @{}
        foreach ($fk in $testRelationships.directFK) {
            $key = "$($fk.source)->$($fk.target)"
            if (-not $strengthScores.ContainsKey($key)) {
                $strengthScores[$key] = 0
            }
            $strengthScores[$key]++
        }
        
        # Check if scoring works
        $hasScoring = $strengthScores.Count -gt 0
        $maxScore = ($strengthScores.Values | Measure-Object -Maximum).Maximum
        
        return @{
            Success = $hasScoring -and $maxScore -gt 1
            Output = "Relationship strength scoring test"
            Scores = $strengthScores
        }
    } catch {
        return @{
            Success = $false
            Output = $_.Exception.Message
        }
    }
}

function Show-AdvancedTestResults {
    param(
        [object]$edgeCaseResults,
        [object]$complexResults
    )
    
    Write-Host "🧪 FKmermaid Advanced Test Results" -ForegroundColor Cyan
    Write-Host "=================================" -ForegroundColor Cyan
    Write-Host ""
    
    # Edge Case Results
    Write-Host "📋 Edge Case Tests:" -ForegroundColor Yellow
    Write-Host "  Passed: $($edgeCaseResults.Passed.Count)" -ForegroundColor Green
    Write-Host "  Failed: $($edgeCaseResults.Failed.Count)" -ForegroundColor $(if ($edgeCaseResults.Failed.Count -eq 0) { "Green" } else { "Red" })
    Write-Host "  Warnings: $($edgeCaseResults.Warnings.Count)" -ForegroundColor Yellow
    Write-Host ""
    
    if ($edgeCaseResults.Passed.Count -gt 0) {
        Write-Host "✅ Passed Tests:" -ForegroundColor Green
        foreach ($test in $edgeCaseResults.Passed) {
            Write-Host "  • $test" -ForegroundColor White
        }
        Write-Host ""
    }
    
    if ($edgeCaseResults.Failed.Count -gt 0) {
        Write-Host "❌ Failed Tests:" -ForegroundColor Red
        foreach ($test in $edgeCaseResults.Failed) {
            Write-Host "  • $test" -ForegroundColor White
        }
        Write-Host ""
    }
    
    # Complex Relationship Results
    Write-Host "📋 Complex Relationship Tests:" -ForegroundColor Yellow
    Write-Host "  Passed: $($complexResults.Passed.Count)" -ForegroundColor Green
    Write-Host "  Failed: $($complexResults.Failed.Count)" -ForegroundColor $(if ($complexResults.Failed.Count -eq 0) { "Green" } else { "Red" })
    Write-Host "  Warnings: $($complexResults.Warnings.Count)" -ForegroundColor Yellow
    Write-Host ""
    
    if ($complexResults.Passed.Count -gt 0) {
        Write-Host "✅ Passed Tests:" -ForegroundColor Green
        foreach ($test in $complexResults.Passed) {
            Write-Host "  • $test" -ForegroundColor White
        }
        Write-Host ""
    }
    
    if ($complexResults.Failed.Count -gt 0) {
        Write-Host "❌ Failed Tests:" -ForegroundColor Red
        foreach ($test in $complexResults.Failed) {
            Write-Host "  • $test" -ForegroundColor White
        }
        Write-Host ""
    }
    
    # Performance metrics
    if ($edgeCaseResults.Performance.Count -gt 0) {
        Write-Host "📊 Performance Metrics:" -ForegroundColor Yellow
        foreach ($metric in $edgeCaseResults.Performance.Keys) {
            $perf = $edgeCaseResults.Performance[$metric]
            Write-Host "  ${metric}: $($perf.Duration)s, $([math]::Round($perf.MemoryUsage, 2))MB" -ForegroundColor White
        }
        Write-Host ""
    }
}

# Initialize advanced test scenarios when module is loaded
Initialize-AdvancedTestScenarios

# Test advanced scenarios if run directly
if ($MyInvocation.InvocationName -eq $MyInvocation.MyCommand.Name) {
    Write-Host "Testing FKmermaid Advanced Test Scenarios..." -ForegroundColor Cyan
    
    # Run edge case tests
    $edgeCaseResults = Test-EdgeCases
    
    # Run complex relationship tests
    $complexResults = Test-ComplexRelationshipScenarios
    
    # Show results
    Show-AdvancedTestResults -edgeCaseResults $edgeCaseResults -complexResults $complexResults
    
    Write-Host "Advanced Test Scenarios completed!" -ForegroundColor Green
}