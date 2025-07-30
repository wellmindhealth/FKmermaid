<#
.SYNOPSIS
    Generate Confluence pages with real Mermaid diagram collections
    
.DESCRIPTION
    Creates Confluence pages with organized collections of Mermaid.live diagrams
    using the actual generated 165 diagrams data.
    
.PARAMETER PageTitle
    Title for the Confluence page
    
.PARAMETER Layout
    Layout style: 'domain-first', 'component-first', 'simple-list'
    
.PARAMETER IncludePngPreviews
    Whether to include PNG preview placeholders
    
.PARAMETER DryRun
    Show what would be created without actually creating the page
    
.EXAMPLE
    .\generate_confluence_page_with_real_data.ps1 -PageTitle "CFC Diagrams - Real Data" -Layout "domain-first"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$PageTitle,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet('domain-first', 'component-first', 'simple-list')]
    [string]$Layout = 'domain-first',
    
    [Parameter(Mandatory=$false)]
    [switch]$IncludePngPreviews = $false,
    
    [Parameter(Mandatory=$false)]
    [switch]$DryRun = $false
)

# Load environment variables
function Load-EnvironmentVariables {
    $envFile = Join-Path $PSScriptRoot "..\..\.env"
    if (Test-Path $envFile) {
        Get-Content $envFile | ForEach-Object {
            if ($_ -match '^([^#][^=]+)=(.*)$') {
                $name = $matches[1]
                $value = $matches[2]
                Set-Variable -Name $name -Value $value -Scope Global
            }
        }
        Write-Host "✅ Environment variables loaded" -ForegroundColor Green
    } else {
        Write-Host "❌ .env file not found at: $envFile" -ForegroundColor Red
        exit 1
    }
}

# Load environment variables
Load-EnvironmentVariables

# Load domain configuration
$domainsConfigPath = Join-Path $PSScriptRoot "..\..\config\domains.json"
$domainsConfig = Get-Content $domainsConfigPath | ConvertFrom-Json

# Load real diagram data
$diagramsDataPath = Join-Path $PSScriptRoot "..\..\exports\pre_generated\165_diagrams_results.json"
$diagramsData = Get-Content $diagramsDataPath | ConvertFrom-Json

# Domain definitions and descriptions
$domainInfo = @{
    'partner' = @{
        Name = 'Partner Domain'
        Description = 'Components related to partner organizations, their relationships, and partner-specific data.'
        Examples = 'partner organizations, partner contacts, partner agreements'
        Color = '#007bff'
        Primary = $true
    }
    'participant' = @{
        Name = 'Participant Domain'
        Description = 'Components related to participants/users, their profiles, and participant-specific data.'
        Examples = 'participant profiles, participant activities, participant progress'
        Color = '#28a745'
        Primary = $true
    }
    'programme' = @{
        Name = 'Programme Domain'
        Description = 'Components related to programmes, activities, and programme-specific data.'
        Examples = 'programme definitions, activities, programme roles'
        Color = '#ffc107'
        Primary = $true
    }
    'site' = @{
        Name = 'Site Domain'
        Description = 'Components related to sites, locations, and site-specific data.'
        Examples = 'site information, site configurations, site relationships'
        Color = '#dc3545'
        Primary = $true
    }
    'all' = @{
        Name = 'All Domains'
        Description = 'Components across all domains showing comprehensive relationships.'
        Examples = 'cross-domain relationships, system-wide views'
        Color = '#6c757d'
        Primary = $false
    }
}

# Strata definitions and colors
$strataInfo = @{
    'core' = @{
        Name = 'Core'
        Description = 'Core business entities and fundamental components'
        Color = '#495057'
        Icon = '🔧'
    }
    'tracking' = @{
        Name = 'Tracking'
        Description = 'Data collection and monitoring components'
        Color = '#e83e8c'
        Icon = '📊'
    }
    'programme' = @{
        Name = 'Programme'
        Description = 'Programme-specific components and activities'
        Color = '#fd7e14'
        Icon = '📋'
    }
    'content' = @{
        Name = 'Content'
        Description = 'Content management and media components'
        Color = '#20c997'
        Icon = '📄'
    }
    'flow' = @{
        Name = 'Flow'
        Description = 'Workflow and process flow components'
        Color = '#6f42c1'
        Icon = '🔄'
    }
    'admin' = @{
        Name = 'Admin'
        Description = 'Administrative and user management components'
        Color = '#dc3545'
        Icon = '⚙️'
    }
    'resources' = @{
        Name = 'Resources'
        Description = 'Resource management components'
        Color = '#17a2b8'
        Icon = '📁'
    }
}

# Function to determine primary domain and strata for a component
function Get-ComponentMetadata {
    param([string]$ComponentName)
    
    $primaryDomain = $null
    $strata = $null
    $availableDomains = @()
    
    # Check each domain for the component
    foreach ($domain in $domainsConfig.domains.PSObject.Properties.Name) {
        $domainData = $domainsConfig.domains.$domain
        foreach ($stratum in $domainData.entities.PSObject.Properties.Name) {
            if ($domainData.entities.$stratum -contains $ComponentName) {
                $availableDomains += $domain
                
                # Determine primary domain (first occurrence, or based on business logic)
                if (-not $primaryDomain) {
                    $primaryDomain = $domain
                    $strata = $stratum
                }
            }
        }
    }
    
    return @{
        PrimaryDomain = $primaryDomain
        Strata = $strata
        AvailableDomains = $availableDomains
    }
}

# Convert real diagram data to the format expected by the page generation
$realDiagrams = @()

foreach ($diagramKey in $diagramsData.generated.PSObject.Properties.Name) {
    $diagram = $diagramsData.generated.$diagramKey
    
    if ($diagram.Status -eq "Success") {
        # Parse component and domain from the key (e.g., "activityDef-programme")
        $parts = $diagramKey -split '-'
        $component = $parts[0]
        $domain = $parts[1]
        
        # Get component metadata
        $metadata = Get-ComponentMetadata -ComponentName $component
        
        $realDiagrams += @{
            Name = "$component - $($domainInfo[$domain].Name)"
            Focus = $component
            Domains = $domain
            Description = $diagram.Description
            MermaidUrl = $diagram.MermaidUrl
            PrimaryDomain = $metadata.PrimaryDomain
            Strata = $metadata.Strata
            AvailableDomains = $metadata.AvailableDomains
        }
    }
}

Write-Host "📊 Loaded $($realDiagrams.Count) real diagrams from generated data" -ForegroundColor Green

# Generate page content based on layout
function Generate-PageContent {
    param(
        [string]$Layout,
        [array]$Diagrams,
        [bool]$IncludePngPreviews
    )
    
    $content = @"
<h1>$PageTitle</h1>
<p>This page contains Mermaid diagrams showing ColdFusion Component (CFC) relationships and structures.</p>
<p><strong>Total Diagrams:</strong> $($Diagrams.Count) diagrams generated from real CFC data</p>

"@

    switch ($Layout) {
        'domain-first' {
            $content += Generate-DomainFirstLayout -Diagrams $Diagrams -IncludePngPreviews $IncludePngPreviews
        }
        'component-first' {
            $content += Generate-ComponentFirstLayout -Diagrams $Diagrams -IncludePngPreviews $IncludePngPreviews
        }
        'simple-list' {
            $content += Generate-SimpleListLayout -Diagrams $Diagrams -IncludePngPreviews $IncludePngPreviews
        }
    }
    
    return $content
}

function Generate-DomainFirstLayout {
    param([array]$Diagrams, [bool]$IncludePngPreviews)
    
    $content = @"
<h2>Domain-Based Organization</h2>
<p>Diagrams are organized by domain to show how components relate within specific business contexts.</p>

<div class="domain-filter" style="margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 8px;">
    <h3 style="margin: 0 0 10px 0;">Select Domain to View:</h3>
    <div class="radio-group" style="display: flex; flex-wrap: wrap; gap: 15px;">
"@

    # Create radio buttons for each domain
    foreach ($domain in $domainInfo.Keys) {
        $domainData = $domainInfo[$domain]
        $domainId = $domain -replace ' ', '-'
        
        $content += @"
        <label style="display: flex; align-items: center; cursor: pointer; padding: 8px 12px; border: 2px solid #ddd; border-radius: 6px; background: white;">
            <input type="radio" name="domainFilter" value="$domain" id="$domainId" style="margin-right: 8px;">
            <span style="font-weight: bold; color: $($domainData.Color);">$($domainData.Name)</span>
        </label>
"@
    }
    
    $content += @"
    </div>
    <p style="margin: 10px 0 0 0; font-size: 14px; color: #666;">
        <em>Note: Only one domain's diagrams are shown at a time to improve performance and readability.</em>
    </p>
</div>

"@

    # Group diagrams by domain
    $diagramsByDomain = $Diagrams | Group-Object -Property Domains
    
    foreach ($domainGroup in $diagramsByDomain) {
        $domain = $domainGroup.Name
        $domainData = $domainInfo[$domain]
        $domainId = $domain -replace ' ', '-'
        
        $content += @"
<div class="domain-section" id="domain-$domain" style="display: none; margin: 20px 0; padding: 15px; border-left: 4px solid $($domainData.Color); background: #f8f9fa;">
    <h3 style="margin: 0 0 15px 0; color: $($domainData.Color);">$($domainData.Name) ($($domainGroup.Count) diagrams)</h3>
    
    <details style="margin-bottom: 20px;">
        <summary style="cursor: pointer; font-weight: bold; color: #666;">📋 Domain Description</summary>
        <div style="margin: 10px 0; padding: 10px; background: white; border-radius: 4px;">
            <p><em>$($domainData.Description)</em></p>
            <p><strong>Examples:</strong> $($domainData.Examples)</p>
        </div>
    </details>
    
    <div class="diagram-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
"@

        foreach ($diagram in $domainGroup.Group) {
            $content += Generate-DiagramCard -Diagram $diagram -IncludePngPreviews $IncludePngPreviews
        }
        
        $content += @"
    </div>
</div>
"@
    }
    
    # Add JavaScript for radio button functionality
    $content += @"
<script>
document.addEventListener('DOMContentLoaded', function() {
    const radioButtons = document.querySelectorAll('input[name="domainFilter"]');
    const domainSections = document.querySelectorAll('.domain-section');
    
    // Show first domain by default
    if (radioButtons.length > 0) {
        radioButtons[0].checked = true;
        const firstDomain = radioButtons[0].value;
        const firstSection = document.getElementById('domain-' + firstDomain);
        if (firstSection) firstSection.style.display = 'block';
    }
    
    // Handle radio button changes
    radioButtons.forEach(radio => {
        radio.addEventListener('change', function() {
            // Hide all domain sections
            domainSections.forEach(section => {
                section.style.display = 'none';
            });
            
            // Show selected domain section
            const selectedDomain = this.value;
            const selectedSection = document.getElementById('domain-' + selectedDomain);
            if (selectedSection) {
                selectedSection.style.display = 'block';
            }
        });
    });
});
</script>
"@
    
    return $content
}

function Generate-ComponentFirstLayout {
    param([array]$Diagrams, [bool]$IncludePngPreviews)
    
    $content = @"
<h2>Component-Based Organization</h2>
<p>Diagrams are organized by component to show how each component appears across different domains.</p>

<div class="domain-filter" style="margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 8px;">
    <h3 style="margin: 0 0 10px 0;">Select Domain to View:</h3>
    <div class="radio-group" style="display: flex; flex-wrap: wrap; gap: 15px;">
"@

    # Create radio buttons for each domain
    foreach ($domain in $domainInfo.Keys) {
        $domainData = $domainInfo[$domain]
        $domainId = $domain -replace ' ', '-'
        
        $content += @"
        <label style="display: flex; align-items: center; cursor: pointer; padding: 8px 12px; border: 2px solid #ddd; border-radius: 6px; background: white;">
            <input type="radio" name="domainFilter" value="$domain" id="$domainId" style="margin-right: 8px;">
            <span style="font-weight: bold; color: $($domainData.Color);">$($domainData.Name)</span>
        </label>
"@
    }
    
    $content += @"
    </div>
    <p style="margin: 10px 0 0 0; font-size: 14px; color: #666;">
        <em>Note: Only one domain's diagrams are shown at a time to improve performance and readability.</em>
    </p>
</div>

"@

    # Group diagrams by component, but filter by domain
    $diagramsByComponent = $Diagrams | Group-Object -Property Focus
    
    foreach ($componentGroup in $diagramsByComponent) {
        $component = $componentGroup.Name
        
        $content += @"
<div class="component-section" id="component-$component" style="display: none; margin: 20px 0; padding: 15px; background: #f8f9fa; border-radius: 8px;">
    <h3 style="margin: 0 0 15px 0;">$component ($($componentGroup.Count) diagrams)</h3>
    
    <div class="diagram-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px;">
"@

        foreach ($diagram in $componentGroup.Group) {
            $content += Generate-DiagramCard -Diagram $diagram -IncludePngPreviews $IncludePngPreviews
        }
        
        $content += @"
    </div>
</div>
"@
    }
    
    # Add JavaScript for radio button functionality
    $content += @"
<script>
document.addEventListener('DOMContentLoaded', function() {
    const radioButtons = document.querySelectorAll('input[name="domainFilter"]');
    const componentSections = document.querySelectorAll('.component-section');
    
    // Show first domain by default
    if (radioButtons.length > 0) {
        radioButtons[0].checked = true;
        const firstDomain = radioButtons[0].value;
        showComponentsForDomain(firstDomain);
    }
    
    // Handle radio button changes
    radioButtons.forEach(radio => {
        radio.addEventListener('change', function() {
            const selectedDomain = this.value;
            showComponentsForDomain(selectedDomain);
        });
    });
    
    function showComponentsForDomain(domain) {
        // Hide all component sections
        componentSections.forEach(section => {
            section.style.display = 'none';
        });
        
        // Show only components that have diagrams in the selected domain
        componentSections.forEach(section => {
            const diagrams = section.querySelectorAll('.diagram-card');
            let hasDomainDiagram = false;
            
            diagrams.forEach(diagram => {
                const domainBadge = diagram.querySelector('.domain-badge');
                if (domainBadge && domainBadge.textContent.includes(domainInfo[domain].Name)) {
                    hasDomainDiagram = true;
                }
            });
            
            if (hasDomainDiagram) {
                section.style.display = 'block';
            }
        });
    }
    
    // Domain info for JavaScript
    const domainInfo = {
"@

    foreach ($domain in $domainInfo.Keys) {
        $domainData = $domainInfo[$domain]
        $content += @"
        '$domain': {
            name: '$($domainData.Name)',
            color: '$($domainData.Color)'
        },
"@
    }
    
    $content += @"
    };
});
</script>
"@
    
    return $content
}

function Generate-SimpleListLayout {
    param([array]$Diagrams, [bool]$IncludePngPreviews)
    
    $content = @"
<h2>All Diagrams</h2>
<p>Complete list of all available diagrams.</p>

<div class="diagram-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; margin: 20px 0;">
"@

    foreach ($diagram in $Diagrams) {
        $content += Generate-DiagramCard -Diagram $diagram -IncludePngPreviews $IncludePngPreviews
    }
    
    $content += @"
</div>
"@

    return $content
}

function Generate-DiagramCard {
    param([hashtable]$Diagram, [bool]$IncludePngPreviews)
    
    $domainData = $domainInfo[$Diagram.Domains]
    $strataData = $strataInfo[$Diagram.Strata]
    $primaryDomainData = $domainInfo[$Diagram.PrimaryDomain]
    
    $card = @"
<div class="diagram-card" style="border: 1px solid #ddd; border-radius: 8px; padding: 15px; background: #f9f9f9;">
    <div class="badges-container" style="display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 10px;">
        <!-- Domain Badge -->
        <div class="domain-badge" style="display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; color: white; background: $($domainData.Color);">
            $($domainData.Name)
        </div>
        
        <!-- Strata Badge -->
        <div class="strata-badge" style="display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 12px; font-weight: bold; color: white; background: $($strataData.Color);">
            $($strataData.Icon) $($strataData.Name)
        </div>
        
        <!-- Primary Domain Indicator (if different from current domain) -->
"@

    if ($Diagram.PrimaryDomain -ne $Diagram.Domains -and $Diagram.PrimaryDomain -ne "all") {
        $card += @"
        <div class="primary-domain-indicator" style="display: inline-block; padding: 2px 8px; border-radius: 12px; font-size: 11px; font-weight: bold; color: $($primaryDomainData.Color); background: rgba(0,0,0,0.1); border: 1px solid $($primaryDomainData.Color);">
            🏠 Primary: $($primaryDomainData.Name)
        </div>
"@
    }
    
    $card += @"
    </div>
    
    <h4 style="margin: 0 0 10px 0;">$($Diagram.Name)</h4>
    <p style="margin: 0 0 10px 0; font-size: 14px;">$($Diagram.Description)</p>
    
    <!-- Component Metadata -->
    <div class="component-metadata" style="margin: 10px 0; padding: 8px; background: #f0f0f0; border-radius: 4px; font-size: 12px;">
        <div style="margin-bottom: 5px;">
            <strong>Primary Domain:</strong> $($primaryDomainData.Name)
        </div>
        <div style="margin-bottom: 5px;">
            <strong>Strata:</strong> $($strataData.Name) - $($strataData.Description)
        </div>
        <div>
            <strong>Available in:</strong> $($Diagram.AvailableDomains -join ', ')
        </div>
    </div>
    
"@

    if ($IncludePngPreviews) {
        $card += @"
    <div class="preview-placeholder" style="border: 1px dashed #ccc; padding: 20px; text-align: center; margin: 10px 0; background: #f0f0f0;">
        <p style="margin: 0; color: #666;">PNG Preview Placeholder</p>
        <p style="margin: 5px 0 0 0; font-size: 12px; color: #999;">(Upload PNG file to Confluence)</p>
    </div>
"@
    }
    
    $card += @"
    <div class="mermaid-link" style="margin-top: 10px;">
        <a href="$($Diagram.MermaidUrl)" target="_blank" class="external-link" style="display: inline-block; padding: 8px 16px; background: #007bff; color: white; text-decoration: none; border-radius: 4px; font-size: 14px;">
            🔗 Open in Mermaid.live
        </a>
    </div>
</div>
"@

    return $card
}

# Generate the page content
Write-Host "📄 Generating page content with layout: $Layout" -ForegroundColor Cyan
Write-Host "📊 Using $($realDiagrams.Count) real diagrams from generated data" -ForegroundColor Green

$pageContent = Generate-PageContent -Layout $Layout -Diagrams $realDiagrams -IncludePngPreviews $IncludePngPreviews

if ($DryRun) {
    Write-Host "🔍 DRY RUN - Page content preview:" -ForegroundColor Yellow
    Write-Host "Title: $PageTitle" -ForegroundColor Cyan
    Write-Host "Layout: $Layout" -ForegroundColor Cyan
    Write-Host "Include PNG Previews: $IncludePngPreviews" -ForegroundColor Cyan
    Write-Host "Content length: $($pageContent.Length) characters" -ForegroundColor Cyan
    Write-Host "`n📋 Content preview (first 500 chars):" -ForegroundColor Yellow
    Write-Host $pageContent.Substring(0, [Math]::Min(500, $pageContent.Length)) -ForegroundColor Gray
    Write-Host "`n✅ Dry run completed - no page created" -ForegroundColor Green
    exit 0
}

# Create Confluence page
Write-Host "🌐 Creating Confluence page..." -ForegroundColor Cyan

try {
    $credentials = "$CONFLUENCE_USER`:$CONFLUENCE_API_TOKEN"
    $encodedCredentials = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($credentials))
    
    $headers = @{
        'Authorization' = "Basic $encodedCredentials"
        'Content-Type' = 'application/json'
        'Accept' = 'application/json'
    }
    
    $body = @{
        type = 'page'
        title = $PageTitle
        space = @{
            key = 'SD'
        }
        ancestors = @(
            @{
                id = '22020146'  # Parent page ID for Mermaid page
            }
        )
        body = @{
            storage = @{
                value = $pageContent
                representation = 'storage'
            }
        }
    } | ConvertTo-Json -Depth 10
    
    $uri = "$CONFLUENCE_BASE_URL/rest/api/content"
    
    Write-Host "📡 Making API call to: $uri" -ForegroundColor Blue
    
    $response = Invoke-RestMethod -Uri $uri -Method Post -Headers $headers -Body $body
    
    if ($response.id) {
        Write-Host "✅ Confluence page created successfully!" -ForegroundColor Green
        Write-Host "📄 Page ID: $($response.id)" -ForegroundColor Cyan
        Write-Host "🔗 View page: $CONFLUENCE_BASE_URL/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Yellow
        
        Write-Host "`n🎯 Page ready! Check the interface and navigation." -ForegroundColor Green
        Write-Host "💡 Next steps:" -ForegroundColor Yellow
        Write-Host "1. Review the page layout and navigation" -ForegroundColor White
        Write-Host "2. Test the Mermaid.live links" -ForegroundColor White
        Write-Host "3. Verify all 165 diagrams are working" -ForegroundColor White
        Write-Host "4. Check domain filtering functionality" -ForegroundColor White
    } else {
        Write-Host "❌ Failed to create Confluence page" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Error creating Confluence page: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "📋 Response: $($_.Exception.Response)" -ForegroundColor Red
} 