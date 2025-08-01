# Sanity Check: Low Entity Count Tests
# This test validates that low entity count scenarios work correctly

Write-Host "🧪 Testing low entity count sanity checks..." -ForegroundColor Cyan

# Test scenarios with low entity counts
$testScenarios = @(
    @{
        Name = "Single Device Entity"
        Focus = "device"
        Domains = ""
        ExpectedMinEntities = 1
        ExpectedMaxEntities = 5
        Description = "Tests single device entity (should pick pathway_device, not zfarcrycore device)"
    },
    @{
        Name = "API Access Key in Provider"
        Focus = "apiAccessKey"
        Domains = "provider"
        ExpectedMinEntities = 1
        ExpectedMaxEntities = 10
        Description = "Tests apiAccessKey in provider domain"
    },
    @{
        Name = "Guide Entity (Excluded)"
        Focus = "guide"
        Domains = ""
        ExpectedMinEntities = 0
        ExpectedMaxEntities = 0
        Description = "Tests guide entity (should be excluded)"
    },
    @{
        Name = "Manifest Entity"
        Focus = "manifest"
        Domains = ""
        ExpectedMinEntities = 1
        ExpectedMaxEntities = 5
        Description = "Tests manifest entity (common name)"
    },
    @{
        Name = "SSQ Entity"
        Focus = "SSQ_arthritis01"
        Domains = ""
        ExpectedMinEntities = 1
        ExpectedMaxEntities = 5
        Description = "Tests SSQ entity with special naming"
    }
)

$testResults = @()

foreach ($scenario in $testScenarios) {
    Write-Host "`n🔍 Testing: $($scenario.Name)" -ForegroundColor Yellow
    Write-Host "   Description: $($scenario.Description)" -ForegroundColor Gray
    
    try {
        # Generate diagram for this scenario
        $outputFile = "test_low_entity_$($scenario.Name -replace '\s+', '_').mmd"
        $focusParam = $scenario.Focus
        $domainsParam = if ($scenario.Domains) { "-lDomains `"$($scenario.Domains)`"" } else { "" }
        
        $command = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_enhanced.ps1 -lFocus `"$focusParam`" -DiagramType `"ER`" $domainsParam -OutputFile `"$outputFile`""
        
        Write-Host "   Running: $command" -ForegroundColor Gray
        $result = Invoke-Expression $command
        
        if ($LASTEXITCODE -eq 0) {
            # Check if the generated file exists and has content
            if (Test-Path $outputFile) {
                $content = Get-Content $outputFile -Raw
                if ($content) {
                    # Count entities in the diagram
                    $entityMatches = [regex]::Matches($content, '"([^"]+)"\s*\{')
                    $entityCount = $entityMatches.Count
                    
                    Write-Host "   📊 Found $entityCount entities" -ForegroundColor Cyan
                    
                    # Check if entity count is within expected range
                    if ($entityCount -ge $scenario.ExpectedMinEntities -and $entityCount -le $scenario.ExpectedMaxEntities) {
                        Write-Host "   ✅ PASSED: Entity count $entityCount is within expected range ($($scenario.ExpectedMinEntities)-$($scenario.ExpectedMaxEntities))" -ForegroundColor Green
                        $testResults += @{
                            Scenario = $scenario.Name
                            Status = "PASSED"
                            Message = "Entity count $entityCount is within expected range"
                            EntityCount = $entityCount
                            ExpectedMin = $scenario.ExpectedMinEntities
                            ExpectedMax = $scenario.ExpectedMaxEntities
                            FileSize = $content.Length
                        }
                    } else {
                        Write-Host "   ❌ FAILED: Entity count $entityCount is outside expected range ($($scenario.ExpectedMinEntities)-$($scenario.ExpectedMaxEntities))" -ForegroundColor Red
                        $testResults += @{
                            Scenario = $scenario.Name
                            Status = "FAILED"
                            Message = "Entity count $entityCount is outside expected range"
                            EntityCount = $entityCount
                            ExpectedMin = $scenario.ExpectedMinEntities
                            ExpectedMax = $scenario.ExpectedMaxEntities
                            FileSize = $content.Length
                        }
                    }
                    
                    # Show the entities found
                    Write-Host "   📋 Entities found:" -ForegroundColor Gray
                    foreach ($match in $entityMatches) {
                        $entityName = $match.Groups[1].Value
                        Write-Host "      - $entityName" -ForegroundColor Gray
                    }
                    
                } else {
                    Write-Host "   ❌ FAILED: Generated empty file" -ForegroundColor Red
                    $testResults += @{
                        Scenario = $scenario.Name
                        Status = "FAILED"
                        Message = "Generated empty file"
                        EntityCount = 0
                        ExpectedMin = $scenario.ExpectedMinEntities
                        ExpectedMax = $scenario.ExpectedMaxEntities
                        FileSize = 0
                    }
                }
            } else {
                Write-Host "   ❌ FAILED: File not created" -ForegroundColor Red
                $testResults += @{
                    Scenario = $scenario.Name
                    Status = "FAILED"
                    Message = "File not created"
                    EntityCount = 0
                    ExpectedMin = $scenario.ExpectedMinEntities
                    ExpectedMax = $scenario.ExpectedMaxEntities
                    FileSize = 0
                }
            }
        } else {
            Write-Host "   ❌ FAILED: Command failed with exit code $LASTEXITCODE" -ForegroundColor Red
            $testResults += @{
                Scenario = $scenario.Name
                Status = "FAILED"
                Message = "Command failed with exit code $LASTEXITCODE"
                EntityCount = 0
                ExpectedMin = $scenario.ExpectedMinEntities
                ExpectedMax = $scenario.ExpectedMaxEntities
                FileSize = 0
            }
        }
        
        # Clean up test file
        if (Test-Path $outputFile) {
            Remove-Item $outputFile -Force
        }
        
    } catch {
        Write-Host "   ❌ FAILED: Threw exception: $($_.Exception.Message)" -ForegroundColor Red
        $testResults += @{
            Scenario = $scenario.Name
            Status = "FAILED"
            Message = "Exception: $($_.Exception.Message)"
            EntityCount = 0
            ExpectedMin = $scenario.ExpectedMinEntities
            ExpectedMax = $scenario.ExpectedMaxEntities
            FileSize = 0
        }
    }
}

# Report results
Write-Host "`n📊 Low Entity Count Test Results:" -ForegroundColor Cyan
$passed = ($testResults | Where-Object { $_.Status -eq "PASSED" }).Count
$failed = ($testResults | Where-Object { $_.Status -eq "FAILED" }).Count

foreach ($result in $testResults) {
    if ($result.Status -eq "PASSED") {
        Write-Host "   ✅ $($result.Scenario): $($result.Message) ($($result.EntityCount) entities, $($result.FileSize) chars)" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $($result.Scenario): $($result.Message)" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Summary:" -ForegroundColor Yellow
Write-Host "   Passed: $passed" -ForegroundColor Green
Write-Host "   Failed: $failed" -ForegroundColor Red
Write-Host "   Total: $($testResults.Count)" -ForegroundColor White

if ($failed -eq 0) {
    Write-Host "`n✅ All low entity count tests PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some low entity count tests FAILED!" -ForegroundColor Red
    exit 1
} 