<#
.SYNOPSIS
    Generate Confluence pages with Mermaid diagram collections
    
.DESCRIPTION
    Creates Confluence pages with organized collections of Mermaid.live diagrams.
    Supports different layouts and filtering options for large diagram sets.
    
.PARAMETER PageTitle
    Title for the Confluence page
    
.PARAMETER Layout
    Layout style: 'domain-first', 'component-first', 'simple-list'
    
.PARAMETER IncludePngPreviews
    Whether to include PNG preview placeholders
    
.PARAMETER DryRun
    Show what would be created without actually creating the page
    
.EXAMPLE
    .\generate_confluence_page.ps1 -PageTitle "CFC Diagrams - All Domains" -Layout "domain-first"
    
.EXAMPLE
    .\generate_confluence_page.ps1 -PageTitle "Test Page" -Layout "simple-list" -DryRun
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

# Sample diagram data with enhanced metadata (replace with actual generated data)
$sampleDiagrams = @(
    @{
        Name = "Activity Definition"
        Focus = "activityDef"
        Domains = "programme"
        Description = "Shows activityDef component and its relationships in the programme domain"
        MermaidUrl = "https://mermaid.live/edit#pako:eNq1WNtuozAQ/RWLqm+JlCalVf22Kq2UvWirtH1DqlwYErfGRsZsN2ry72uKSSCBKCYsT8yYczwznouTTycQITjYAelRMpck9jnSz/k5eiBaAgUyxT7XMkL3IshSjEig6B+qlh5EZsETMaFcLyVS5BwxmIXbBZEKPS0TwOhuVlD7TkLU4oMsX8J4GpM5+A76LJby5/l56qHfr28QqKlXqNc+34WWNpyCze3vAJ9nNOxk85vIJCes47YxhJR0A8avILsgt6fZETwTrBNWQapoLDglrBNckuBdJ7RNoHW6elTqFXT/A82AEUUFTxc0SQ+k3mo1HK5WralVK5Vyx7aP97iq0a9UljXPtsowUkBSkIVsx1JmPUZfb528MemAkcxf7PBl+mMUQkQypn7lCmszajWIkRGtaWoZpsNaiKOLvojGfRFN+iK67IvI3Scqc+tg6iY0UJmEg031hHPqxDO25Tm6pst0t6/DVuTpe+/VcBPWDJvTWmM7zRE2VB09mFI/xVxYgXd9iKhM1bdDjljRMXIEm3G++/HWh2tDozWhx6h4tWawOulaZdk6pYf2HQ/bB/fmq8cEAm0t+i70NbWG3VnZIoBFwxlEIIEHlM/r1CgSsn4PrsIkRCmiPGBZqO+9gut9pt4AkdsMHvQ25RlTSLVyyvUVW1NdNGrHjdpJo/ayUetutZYNfPccU+3bS+5bPYCWgdqA84ijJ/LK4Lj7VmHGWrReDIi5EqSHinAPv5et94Ix8ZEltUq049wZF+SpkDc0JnTtEaiE6Y4rbQR6VEumo1uoUy0A2mlpuhsxhs8ubq4m4XiQKineQYvulRuMjDj8oKFa4Mvk7yAQTEh8FkVRE2UZlP/BqaNiaMNr1x2NNrSRex2MrGm/xqAhvLqZkAqhG47BnnA7wfv0/itN+zSzaM59mrhJ6T7NLEdWn5yV+dOn/9uq7c7qS587AycGGRMaOvjTUQuI8z9YzM8WZ73+Bwpc7VE="
        PrimaryDomain = "programme"
        Strata = "core"
        AvailableDomains = @("programme", "participant", "partner")
    },
    @{
        Name = "Member"
        Focus = "member"
        Domains = "all"
        Description = "Shows member component across all domains"
        MermaidUrl = "https://mermaid.live/edit#pako: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"
        PrimaryDomain = "participant"
        Strata = "core"
        AvailableDomains = @("participant", "partner")
    },
    @{
        Name = "Programme Role"
        Focus = "progRole"
        Domains = "participant"
        Description = "Shows progRole component in participant domain"
        MermaidUrl = "https://mermaid.live/edit#pako:eNq1mV9vmzAQwL+KRdW3RMrfZuWtatopm6ptTfsWqXLgSNwCRsasi5p89xkwISRAsUPzlDu4n33H+e5IPgyL2mCYBrApwSuGvYWPxOfyEv3GQgIOLDQXvpARuqdWFJooYHT1SF2Q2in1MPFjPWacWCTAPpeXbtdChZ42AZjo7jElL4wA8/U73rxgi5O/hG8WBvpIr8Wf5+fZFP1avoLFZ9NUvVv4VbZTcHTMVxGxQcfwlUbMx+4Zppo7dsmSYaYVKw9sgvUMvSUwfcvvjEaBjnmcYQ/ai8fWInU90DVOklvDdj7/8yISfs0IJ2Gvr4sIxHHStw45g1Bzdc6w9aYXdGmqlN2iRkwJE1fQ/U/0CC7mhPrhmgRhTanYbrvd7bYqWdLqlIrZes0wxYpiogO5GpTeXLqlLAPTHSWSMicrUyZKvmntQyaziVhSspXss8phIhscHLn8IVYob6NQ+UwkRWVMIcVMJMVevy3QoC3QsC3QqC3Q+BSUd7JzTlQNpfyplx6nGsrBkc3PZCXh7MzR4gxUOY3rQ971z3lINZSG4a0h5DXCKy8O2Q3q1a3SsnH8agmFylhmK4Nb4vLhdBM7vpdVMEodpxrTwJVCruhHsx7j5cnoVSRiPaCQi1bE2E1lPh5u+dO4OoSF/KYuuEo4FzegyQeiH+vTWfLLWQ2rSQNag1QoDLrnuVaPUfCqGtTQoYPZ+zyXPgMpOFWHauBW/kpwzkZqKOU9tfRg1VAa9rHCYqqPSLyu3Pl29SvL/q55ABbBLvpBiR8WbI+u5BbgOt1HcICBbxF/VUQjh7LD7lA0Y+CEiPiWG9lgIuqLdWbTDsK3EfwWy2S1ikAolDOfg4gB75dqB6XaYal2VKod51rFyfW4zIbCt5fYt2IAFQO1N44jjp7w0oVmb5rpNna0ctrB8l0orGsmJ/YnPf+eui59j4JCR1FjHp0g/JTKe4wMXXUEDsJ053OxCTTnG1dEN1WHQgB07IFoq65rXoxG4/7E6YgqQ9/AvBhORpNRJnbfic3X5iD417GoS5l5ARY4Tr8OK7yQ5KvrIe719uSxPYC9KMmjnOw4Thk2mSxb3qqc7b+GmvvfFljO7i1Tk4PQ5pNKG1D7xGQsb9n5vNV9ATg5523GIZtHJdOejMcHTGc8sdSZR0OgRH+DwQjjPfoK95fXuDIMNeh0Emubmo1CbXJl8W05D/KSfhZ4wRa+0TE8YB4mtmF+GHwNXvx3j/w9z9jt/gO349Rn"
        PrimaryDomain = "participant"
        Strata = "programme"
        AvailableDomains = @("participant", "programme", "partner")
    }
)

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

$pageContent = Generate-PageContent -Layout $Layout -Diagrams $sampleDiagrams -IncludePngPreviews $IncludePngPreviews

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
        Write-Host "3. Plan the interface for 165 diagrams" -ForegroundColor White
        Write-Host "4. Consider filtering and search options" -ForegroundColor White
    } else {
        Write-Host "❌ Failed to create Confluence page" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Error creating Confluence page: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "📋 Response: $($_.Exception.Response)" -ForegroundColor Red
} 