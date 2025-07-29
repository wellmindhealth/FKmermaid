# Generate Baseline Outputs
# Creates baseline outputs for regression testing

param(
    [switch]$Force,
    [switch]$Help
)

if ($Help) {
    Write-Host "Generate Baseline Outputs" -ForegroundColor Cyan
    Write-Host "========================" -ForegroundColor Cyan
    Write-Host "Creates baseline outputs for regression testing" -ForegroundColor White
    Write-Host ""
    Write-Host "Parameters:" -ForegroundColor Yellow
    Write-Host "  -Force      Overwrite existing baselines" -ForegroundColor White
    Write-Host "  -Help       Show this help" -ForegroundColor White
    exit
}

# Test Configuration
$scriptPath = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell"
$baselinePath = "D:\GIT\farcry\Cursor\FKmermaid\tests\baseline_tests\baselines"

# Create baseline directory if it doesn't exist
if (-not (Test-Path $baselinePath)) {
    New-Item -ItemType Directory -Path $baselinePath -Force | Out-Null
    Write-Host "✅ Created baseline directory" -ForegroundColor Green
}

Write-Host "🧪 Generating Baseline Outputs" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

# Define baseline test cases
$baselineTests = @(
    @{
        Name = "Perfect 4-Tier Test"
        Focus = "partner"
        Domains = "partner,participant,programme"
        DiagramType = "ER"
        Description = "Shows all 4 color tiers working together"
    },
    @{
        Name = "Member Focus Test"
        Focus = "member"
        Domains = "participant,programme"
        DiagramType = "ER"
        Description = "Tests member-focused diagram"
    },
    @{
        Name = "Programme Focus Test"
        Focus = "programme"
        Domains = "programme,site"
        DiagramType = "ER"
        Description = "Tests programme-focused diagram"
    },
    @{
        Name = "Class Diagram Test"
        Focus = "partner"
        Domains = "partner,participant"
        DiagramType = "Class"
        Description = "Tests Class diagram generation"
    },
    @{
        Name = "Single Domain Test"
        Focus = "member"
        Domains = "participant"
        DiagramType = "ER"
        Description = "Tests single domain filtering"
    },
    @{
        Name = "Multi Domain Test"
        Focus = "programme"
        Domains = "programme,participant,site"
        DiagramType = "ER"
        Description = "Tests multi-domain filtering"
    }
)

Set-Location $scriptPath

$baselineResults = @()

foreach ($test in $baselineTests) {
    Write-Host "`n📋 Generating Baseline: $($test.Name)" -ForegroundColor Yellow
    Write-Host "Description: $($test.Description)" -ForegroundColor White
    
    $baselineFile = "$baselinePath\$($test.Name -replace '\s+', '_').mmd"
    
    # Check if baseline already exists
    if (Test-Path $baselineFile -and -not $Force) {
        Write-Host "⚠️  Baseline already exists. Use -Force to overwrite." -ForegroundColor Yellow
        continue
    }
    
    # Generate baseline
    $result = & ".\generate_erd_enhanced.ps1" -lFocus $test.Focus -DiagramType $test.DiagramType -lDomains $test.Domains -OutputFile $baselineFile 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Baseline generated: $baselineFile" -ForegroundColor Green
        
        # Analyze the generated file
        $content = Get-Content $baselineFile -Raw
        
        # Count entities and styles
        $entityCount = ($content -split "`n" | Where-Object { $_ -match '^\s*"\w+"\s*{' }).Count
        $styleCount = ($content -split "`n" | Where-Object { $_ -match "style.*fill:#" }).Count
        
        # Extract color distribution
        $colorDistribution = @{
            Orange = ($content -split "`n" | Where-Object { $_ -match "fill:#ff6f00" }).Count
            Blue = ($content -split "`n" | Where-Object { $_ -match "fill:#1976d2" }).Count
            BlueGrey = ($content -split "`n" | Where-Object { $_ -match "fill:#546e7a" }).Count
            DarkGrey = ($content -split "`n" | Where-Object { $_ -match "fill:#1a1a1a" }).Count
        }
        
        $baselineResult = @{
            TestName = $test.Name
            Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            Focus = $test.Focus
            Domains = $test.Domains
            DiagramType = $test.DiagramType
            Description = $test.Description
            FilePath = $baselineFile
            EntityCount = $entityCount
            StyleCount = $styleCount
            ColorDistribution = $colorDistribution
            FileSize = (Get-Item $baselineFile).Length
        }
        
        $baselineResults += $baselineResult
        
        Write-Host "📊 Entity Count: $entityCount" -ForegroundColor White
        Write-Host "📊 Style Count: $styleCount" -ForegroundColor White
        Write-Host "📊 Color Distribution: Orange=$($colorDistribution.Orange), Blue=$($colorDistribution.Blue), BlueGrey=$($colorDistribution.BlueGrey), DarkGrey=$($colorDistribution.DarkGrey)" -ForegroundColor White
        
    } else {
        Write-Host "❌ Failed to generate baseline" -ForegroundColor Red
        Write-Host $result -ForegroundColor Red
    }
}

# Save baseline metadata
$baselineMetadata = @{
    GeneratedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    TotalBaselines = $baselineResults.Count
    BaselinePath = $baselinePath
    Baselines = $baselineResults
}

$baselineMetadata | ConvertTo-Json -Depth 10 | Out-File "$baselinePath\baseline_metadata.json"

Write-Host "`n🏁 Baseline Generation Complete" -ForegroundColor Cyan
Write-Host "📊 Generated $($baselineResults.Count) baselines" -ForegroundColor White
Write-Host "📁 Baselines stored in: $baselinePath" -ForegroundColor White