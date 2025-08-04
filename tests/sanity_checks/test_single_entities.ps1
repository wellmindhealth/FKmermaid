# Sanity Check: Single Entity Tests
# This test validates that single entities don't cause issues

Write-Host "🧪 Testing single entity sanity checks..." -ForegroundColor Cyan

# Test specific entities that might cause issues
$problematicEntities = @(
    "device",      # Has duplicate entries (pathway/types and zfarcrycore/lib)
    "guide",       # Recently excluded
    "manifest",    # Common name that might appear multiple times
    "dmImage",     # Core entity that should always work
    "farUser"      # Core entity that should always work
)

$testResults = @()

foreach ($entity in $problematicEntities) {
    Write-Host "`n🔍 Testing entity: $entity" -ForegroundColor Yellow
    
    try {
        # Generate a diagram for this single entity
        $outputFile = "test_single_${entity}.mmd"
        $command = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\generate_erd_domain_colors.ps1 -lFocus `"$entity`" -DiagramType `"ER`" -OutputFile `"$outputFile`""
        
        Write-Host "   Running: $command" -ForegroundColor Gray
        $result = Invoke-Expression $command
        
        if ($LASTEXITCODE -eq 0) {
            # Check if the generated file exists and has content
            if (Test-Path $outputFile) {
                $content = Get-Content $outputFile -Raw
                if ($content -and $content.Length -gt 100) {
                    Write-Host "   ✅ PASSED: $entity generated successfully" -ForegroundColor Green
                    $testResults += @{
                        Entity = $entity
                        Status = "PASSED"
                        Message = "Generated successfully"
                        FileSize = $content.Length
                    }
                } else {
                    Write-Host "   ❌ FAILED: $entity generated empty file" -ForegroundColor Red
                    $testResults += @{
                        Entity = $entity
                        Status = "FAILED"
                        Message = "Generated empty file"
                        FileSize = $content.Length
                    }
                }
            } else {
                Write-Host "   ❌ FAILED: $entity file not created" -ForegroundColor Red
                $testResults += @{
                    Entity = $entity
                    Status = "FAILED"
                    Message = "File not created"
                    FileSize = 0
                }
            }
        } else {
            Write-Host "   ❌ FAILED: $entity command failed with exit code $LASTEXITCODE" -ForegroundColor Red
            $testResults += @{
                Entity = $entity
                Status = "FAILED"
                Message = "Command failed with exit code $LASTEXITCODE"
                FileSize = 0
            }
        }
        
        # Clean up test file
        if (Test-Path $outputFile) {
            Remove-Item $outputFile -Force
        }
        
    } catch {
        Write-Host "   ❌ FAILED: $entity threw exception: $($_.Exception.Message)" -ForegroundColor Red
        $testResults += @{
            Entity = $entity
            Status = "FAILED"
            Message = "Exception: $($_.Exception.Message)"
            FileSize = 0
        }
    }
}

# Report results
Write-Host "`n📊 Single Entity Test Results:" -ForegroundColor Cyan
$passed = ($testResults | Where-Object { $_.Status -eq "PASSED" }).Count
$failed = ($testResults | Where-Object { $_.Status -eq "FAILED" }).Count

foreach ($result in $testResults) {
    if ($result.Status -eq "PASSED") {
        Write-Host "   ✅ $($result.Entity): $($result.Message) ($($result.FileSize) chars)" -ForegroundColor Green
    } else {
        Write-Host "   ❌ $($result.Entity): $($result.Message)" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Summary:" -ForegroundColor Yellow
Write-Host "   Passed: $passed" -ForegroundColor Green
Write-Host "   Failed: $failed" -ForegroundColor Red
Write-Host "   Total: $($testResults.Count)" -ForegroundColor White

if ($failed -eq 0) {
    Write-Host "`n✅ All single entity tests PASSED!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some single entity tests FAILED!" -ForegroundColor Red
    exit 1
} 