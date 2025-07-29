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

# Define baseline test cases - EDGE CASES THAT PUSH LIMITS
$baselineTests = @(
    @{
        Name = "Edge_Case_No_Focus_All_Domains"
        Focus = ""
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests behavior with no focus but all domains (should be all entities)"
    },
    @{
        Name = "Edge_Case_No_Focus_No_Domains"
        Focus = ""
        Domains = ""
        DiagramType = "ER"
        Description = "Tests behavior with no focus and no domains (should be all entities)"
    },
    @{
        Name = "Edge_Case_Site_Domain_Only"
        Focus = ""
        Domains = "site"
        DiagramType = "ER"
        Description = "Tests site domain entities only (should be minimal, isolated domain)"
    },
    @{
        Name = "Edge_Case_Programme_Domain_Only"
        Focus = ""
        Domains = "programme"
        DiagramType = "ER"
        Description = "Tests programme domain entities only (should be programme-specific)"
    },
    @{
        Name = "Edge_Case_Invalid_Domain"
        Focus = "partner"
        Domains = "nonexistent"
        DiagramType = "ER"
        Description = "Tests behavior with non-existent domain (should be minimal)"
    },
    @{
        Name = "Edge_Case_Empty_Focus_Invalid_Domain"
        Focus = ""
        Domains = "nonexistent"
        DiagramType = "ER"
        Description = "Tests empty focus with invalid domain (should be empty)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Complex"
        Focus = "member"
        Domains = "participant,programme"
        DiagramType = "Class"
        Description = "Tests Class diagram with complex relationships (different diagram type)"
    },
    @{
        Name = "Edge_Case_Partner_Site_Only"
        Focus = "partner"
        Domains = "site"
        DiagramType = "ER"
        Description = "Tests partner focus with site domain only (should be minimal - partner not in site domain)"
    },
    @{
        Name = "Edge_Case_Programme_Site_Only"
        Focus = "programme"
        Domains = "site"
        DiagramType = "ER"
        Description = "Tests programme focus with site domain only (should be minimal - programme not in site domain)"
    },
    @{
        Name = "Edge_Case_Member_Partner_Only"
        Focus = "member"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Tests member focus with partner domain only (should be minimal - member not in partner domain)"
    },
    @{
        Name = "Edge_Case_Multiple_Focus_Entities"
        Focus = "partner,member,programme"
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests multiple focus entities (comma-separated) - uncommon parameter"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Site_Only"
        Focus = "dmImage"
        Domains = "site"
        DiagramType = "Class"
        Description = "Tests Class diagram with site domain only (uncommon combination)"
    },
    @{
        Name = "Edge_Case_ER_Diagram_All_Domains"
        Focus = "farUser"
        Domains = "all"
        DiagramType = "ER"
        Description = "Tests ER diagram with all domains and admin entity focus"
    },
    @{
        Name = "Edge_Case_Class_Diagram_All_Domains"
        Focus = "farUser"
        Domains = "all"
        DiagramType = "Class"
        Description = "Tests Class diagram with all domains and admin entity focus"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Cross_Domain_Focus"
        Focus = "dmProfile"
        Domains = "participant"
        DiagramType = "ER"
        Description = "Tests admin entity focus with participant domain (cross-domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Cross_Domain_Focus"
        Focus = "dmProfile"
        Domains = "participant"
        DiagramType = "Class"
        Description = "Tests Class diagram with admin entity focus and participant domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Media_Focus"
        Focus = "media"
        Domains = "programme"
        DiagramType = "ER"
        Description = "Tests media entity focus with programme domain (media is in multiple domains)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Media_Focus"
        Focus = "media"
        Domains = "programme"
        DiagramType = "Class"
        Description = "Tests Class diagram with media entity focus and programme domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_ProgRole_Focus"
        Focus = "progRole"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Tests progRole focus with partner domain (progRole is in multiple domains)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_ProgRole_Focus"
        Focus = "progRole"
        Domains = "partner"
        DiagramType = "Class"
        Description = "Tests Class diagram with progRole focus and partner domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_ActivityDef_Focus"
        Focus = "activityDef"
        Domains = "site"
        DiagramType = "ER"
        Description = "Tests activityDef focus with site domain (activityDef not in site domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_ActivityDef_Focus"
        Focus = "activityDef"
        Domains = "site"
        DiagramType = "Class"
        Description = "Tests Class diagram with activityDef focus and site domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Guide_Focus"
        Focus = "guide"
        Domains = "partner"
        DiagramType = "ER"
        Description = "Tests guide focus with partner domain (guide is in participant/programme domains)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Guide_Focus"
        Focus = "guide"
        Domains = "partner"
        DiagramType = "Class"
        Description = "Tests Class diagram with guide focus and partner domain"
    },
    @{
        Name = "Edge_Case_ER_Diagram_Journal_Focus"
        Focus = "journal"
        Domains = "programme"
        DiagramType = "ER"
        Description = "Tests journal focus with programme domain (journal is in participant domain)"
    },
    @{
        Name = "Edge_Case_Class_Diagram_Journal_Focus"
        Focus = "journal"
        Domains = "programme"
        DiagramType = "Class"
        Description = "Tests Class diagram with journal focus and programme domain"
    }
)

Set-Location $scriptPath

$baselineResults = @()

foreach ($test in $baselineTests) {
    Write-Host "`n📋 Generating Baseline: $($test.Name)" -ForegroundColor Yellow
    Write-Host "Description: $($test.Description)" -ForegroundColor White
    
    $baselineFile = "$baselinePath\$($test.Name -replace '\s+', '_').mmd"
    
    # Check if baseline already exists
    if ((Test-Path $baselineFile) -and (-not $Force)) {
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