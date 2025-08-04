# Analyze Special Relationship Components
# This script analyzes the actual relationship data for components with universal reference capabilities

param(
    [string]$OutputFolder = "D:\GIT\farcry\Cursor\FKmermaid\exports\relationship_analysis"
)

Write-Host "🔍 Analyzing Special Relationship Components" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# Ensure output folder exists
if (-not (Test-Path $OutputFolder)) {
    New-Item -ItemType Directory -Path $OutputFolder -Force | Out-Null
    Write-Host "✅ Created output folder: $OutputFolder" -ForegroundColor Green
}

# Load CFC cache
$cfcCachePath = Join-Path $PSScriptRoot "..\..\config\cfc_cache.json"
$cfcCache = Get-Content $cfcCachePath | ConvertFrom-Json

# Load domains
$domainsPath = Join-Path $PSScriptRoot "..\..\config\domains.json"
$domains = Get-Content $domainsPath | ConvertFrom-Json

# Define special components and their relationship properties
# Updated to use component names that are actually in the CFC cache
$specialComponents = @{
    "JWTapp" = @{
        "relationshipProperty" = "tokens"
        "propertyType" = "complex"
        "description" = "JWT authentication - can reference any user/object"
        "domains" = @("pathway")
    }
    "apiAccessKey" = @{
        "relationshipProperty" = "apiAccess"
        "propertyType" = "complex"
        "description" = "API access control - can access any content type"
        "domains" = @("provider")
    }
    "nhs" = @{
        "relationshipProperty" = "nhsIntegration"
        "propertyType" = "complex"
        "description" = "NHS integration - can reference any healthcare-related content"
        "domains" = @("provider")
    }
    "farFeedback" = @{
        "relationshipProperty" = "feedbackTarget"
        "propertyType" = "complex"
        "description" = "Feedback system - can reference any content type"
        "domains" = @("pathway")
    }
    "dmEmail" = @{
        "relationshipProperty" = "emailRecipients"
        "propertyType" = "complex"
        "description" = "Email system - can reference any user/content type"
        "domains" = @("pathway")
    }
    "dmNavigation" = @{
        "relationshipProperty" = "navigationTarget"
        "propertyType" = "complex"
        "description" = "Navigation system - can reference any content type"
        "domains" = @("pathway")
    }
    "dmImage" = @{
        "relationshipProperty" = "imageOwner"
        "propertyType" = "complex"
        "description" = "Image system - can be owned by any content type"
        "domains" = @("pathway")
    }
    "dmNews" = @{
        "relationshipProperty" = "newsCategory"
        "propertyType" = "complex"
        "description" = "News system - can be categorized by any content type"
        "domains" = @("pathway")
    }
    "dmFacts" = @{
        "relationshipProperty" = "factsContext"
        "propertyType" = "complex"
        "description" = "Facts system - can be contextualized by any content type"
        "domains" = @("pathway")
    }
    "dmEvent" = @{
        "relationshipProperty" = "eventOrganizer"
        "propertyType" = "complex"
        "description" = "Event system - can be organized by any content type"
        "domains" = @("pathway")
    }
}

# Analyze each special component
$analysisResults = @()

foreach ($componentName in $specialComponents.Keys) {
    Write-Host "📊 Analyzing $componentName..." -ForegroundColor Yellow
    
    $componentInfo = $specialComponents[$componentName]
    
    # Find the component in CFC cache
    $componentData = $cfcCache | Where-Object { $_.name -eq $componentName }
    
    if ($componentData) {
        $properties = $componentData.properties
        $relationshipProperty = $properties | Where-Object { $_.name -eq $componentInfo.relationshipProperty }
        
        $analysis = @{
            "componentName" = $componentName
            "description" = $componentInfo.description
            "domains" = $componentInfo.domains
            "relationshipProperty" = $componentInfo.relationshipProperty
            "propertyType" = $componentInfo.propertyType
            "hasRelationshipProperty" = $relationshipProperty -ne $null
            "relationshipPropertyDetails" = $relationshipProperty
            "allProperties" = $properties
            "totalProperties" = $properties.Count
            "componentData" = $componentData
        }
        
        $analysisResults += $analysis
        
        Write-Host "  ✅ Found $($properties.Count) properties" -ForegroundColor Green
        if ($relationshipProperty) {
            Write-Host "  🔗 Relationship property: $($relationshipProperty.name) ($($relationshipProperty.type))" -ForegroundColor Cyan
        } else {
            Write-Host "  ⚠️  No explicit relationship property found" -ForegroundColor Yellow
            # Show all properties for debugging
            Write-Host "  📋 Available properties: $($properties.name -join ', ')" -ForegroundColor Gray
        }
    } else {
        Write-Host "  ❌ Component not found in CFC cache" -ForegroundColor Red
    }
}

# Generate relationship strategies for each component
$strategies = @()

foreach ($analysis in $analysisResults) {
    $strategy = @{
        "componentName" = $analysis.componentName
        "description" = $analysis.description
        "domains" = $analysis.domains
        "relationshipStrategy" = @()
        "implementationSteps" = @()
    }
    
    switch ($analysis.componentName) {
        "JWTapp" {
            $strategy.relationshipStrategy += "JWT token relationships to authentication components"
            $strategy.relationshipStrategy += "Show relationships to user management components"
            $strategy.relationshipStrategy += "Use dotted lines to indicate JWT relationships"
            $strategy.implementationSteps += "Analyze JWT token usage patterns"
            $strategy.implementationSteps += "Create JWT relationship matrix"
            $strategy.implementationSteps += "Add JWT relationship visualization"
        }
        "apiAccessKey" {
            $strategy.relationshipStrategy += "API access relationships to service components"
            $strategy.relationshipStrategy += "Show relationships to API-accessible content types"
            $strategy.relationshipStrategy += "Use dashed lines to indicate API relationships"
            $strategy.implementationSteps += "Analyze API access patterns"
            $strategy.implementationSteps += "Create API relationship matrix"
            $strategy.implementationSteps += "Add API relationship visualization"
        }
        "nhs" {
            $strategy.relationshipStrategy += "NHS integration relationships to healthcare components"
            $strategy.relationshipStrategy += "Show relationships to patient/participant components"
            $strategy.relationshipStrategy += "Use special lines to indicate NHS relationships"
            $strategy.implementationSteps += "Analyze NHS integration patterns"
            $strategy.implementationSteps += "Create NHS relationship matrix"
            $strategy.implementationSteps += "Add NHS relationship visualization"
        }
        default {
            $strategy.relationshipStrategy += "Analyze actual usage patterns from database"
            $strategy.relationshipStrategy += "Create relationships based on common usage scenarios"
            $strategy.relationshipStrategy += "Use appropriate line styles for relationship type"
            $strategy.implementationSteps += "Analyze component usage patterns"
            $strategy.implementationSteps += "Create relationship frequency analysis"
            $strategy.implementationSteps += "Add relationship visualization"
        }
    }
    
    $strategies += $strategy
}

# Save analysis results
$analysisOutput = @{
    "timestamp" = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "totalSpecialComponents" = $analysisResults.Count
    "components" = $analysisResults
    "strategies" = $strategies
}

$analysisOutput | ConvertTo-Json -Depth 10 | Set-Content (Join-Path $OutputFolder "special_relationships_analysis.json")

# Generate summary report
$summaryReport = @"
# Special Relationship Components Analysis Report

Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

## Summary
- **Total Special Components Analyzed**: $($analysisResults.Count)
- **Components with Explicit Relationship Properties**: $(($analysisResults | Where-Object { $_.hasRelationshipProperty }).Count)
- **Components Needing Analysis**: $(($analysisResults | Where-Object { -not $_.hasRelationshipProperty }).Count)

## Components by Domain

### Provider Domain
$(($analysisResults | Where-Object { $_.domains -contains "provider" } | ForEach-Object { "- $($_.componentName): $($_.description)" }) -join "`n")

### Participant Domain  
$(($analysisResults | Where-Object { $_.domains -contains "participant" } | ForEach-Object { "- $($_.componentName): $($_.description)" }) -join "`n")

### Pathway Domain
$(($analysisResults | Where-Object { $_.domains -contains "pathway" } | ForEach-Object { "- $($_.componentName): $($_.description)" }) -join "`n")

## Implementation Priority

### High Priority (Explicit Relationship Properties)
$(($analysisResults | Where-Object { $_.hasRelationshipProperty } | ForEach-Object { "- $($_.componentName): $($_.relationshipProperty)" }) -join "`n")

### Medium Priority (Complex Relationship Analysis Needed)
$(($analysisResults | Where-Object { -not $_.hasRelationshipProperty } | ForEach-Object { "- $($_.componentName): $($_.description)" }) -join "`n")

## Next Steps
1. Implement data analysis scripts for high-priority components
2. Create relationship frequency matrices
3. Modify diagram generation to include special relationships
4. Add relationship filtering and visualization features
"@

$summaryReport | Set-Content (Join-Path $OutputFolder "analysis_summary.md")

Write-Host "`n📊 Analysis Complete!" -ForegroundColor Green
Write-Host "📁 Results saved to: $OutputFolder" -ForegroundColor Cyan
Write-Host "📄 Summary report: analysis_summary.md" -ForegroundColor Cyan
Write-Host "📊 Detailed analysis: special_relationships_analysis.json" -ForegroundColor Cyan

Write-Host "`n🎯 Key Findings:" -ForegroundColor Yellow
Write-Host "- Found $($analysisResults.Count) special relationship components" -ForegroundColor White
Write-Host "- $($analysisResults | Where-Object { $_.hasRelationshipProperty } | Measure-Object | Select-Object -ExpandProperty Count) components have explicit relationship properties" -ForegroundColor White
Write-Host "- $($analysisResults | Where-Object { -not $_.hasRelationshipProperty } | Measure-Object | Select-Object -ExpandProperty Count) components need complex relationship analysis" -ForegroundColor White

Write-Host "`n🚀 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Analyze actual usage patterns for identified components" -ForegroundColor White
Write-Host "2. Create relationship frequency matrices" -ForegroundColor White
Write-Host "3. Modify diagram generation scripts" -ForegroundColor White
Write-Host "4. Add relationship visualization features" -ForegroundColor White 