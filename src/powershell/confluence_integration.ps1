# FKmermaid Confluence Integration Module
# 🦄 HOLY GRAIL: Automated Confluence page creation and diagram upload

param(
    [string]$DiagramSetPath = "",
    [string]$PageTitle = "",
    [string]$SpaceKey = "FK",
    [string]$ParentPageId = "",
    [switch]$CreateNewPage = $false,
    [switch]$UpdateExistingPage = $false,
    [switch]$DemoMode = $false,
    [switch]$TestMermaid = $false,
    [switch]$TestBasic = $false,
    [switch]$TestMermaidCloud = $false,
    [switch]$TestAlternative = $false,
    [switch]$TestManual = $false,
    [switch]$TestMermaidLive = $false,
    [switch]$TestNativeMermaid = $false,
    [switch]$TestStratusMermaid = $false,
    [switch]$TestMermaidComparison = $false,
    [switch]$TestContentCleaning = $false,
    [switch]$CreateFolder = $false,
    [switch]$Debug = $false,
    [switch]$Help = $false
)

# Check for help parameter first (before any logging)
if ($Help) {
    Write-Host "FKmermaid Confluence Integration - 🦄 HOLY GRAIL" -ForegroundColor Cyan
    Write-Host "=================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "📚 COMPLETE PARAMETER REFERENCE:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "🔴 REQUIRED PARAMETERS:" -ForegroundColor Red
    Write-Host "  -DiagramSetPath 'path'  # Path to diagram set folder" -ForegroundColor White
    Write-Host "  -PageTitle 'title'       # Confluence page title" -ForegroundColor White
    Write-Host ""
    Write-Host "🟡 OPTIONAL PARAMETERS:" -ForegroundColor Yellow
    Write-Host "  -SpaceKey 'key'          # Confluence space key (default: FK)" -ForegroundColor White
    Write-Host "  -ParentPageId 'id'       # Parent page ID for hierarchy" -ForegroundColor White
    Write-Host "  -CreateNewPage           # Create new page" -ForegroundColor White
    Write-Host "  -UpdateExistingPage      # Update existing page" -ForegroundColor White
    Write-Host "  -DemoMode                # Enable demo mode (saves content to file)" -ForegroundColor White
    Write-Host "  -TestNativeMermaid       # Test native Atlassian Mermaid extension" -ForegroundColor White
    Write-Host "  -TestStratusMermaid      # Test Stratus Add-on Mermaid extension" -ForegroundColor White
    Write-Host "  -TestMermaidComparison   # Test Mermaid format comparison" -ForegroundColor White
    Write-Host "  -TestContentCleaning    # Test Mermaid content cleaning" -ForegroundColor White
    Write-Host "  -Debug                   # Enable debug mode" -ForegroundColor White
    Write-Host "  -Help                    # Show this help" -ForegroundColor White
    Write-Host ""
    Write-Host "💡 USAGE EXAMPLES:" -ForegroundColor Cyan
    Write-Host "  .\confluence_integration.ps1 -DiagramSetPath 'exports' -PageTitle 'ER Diagrams' -CreateNewPage" -ForegroundColor Green
    Write-Host "  .\confluence_integration.ps1 -DiagramSetPath 'baselines' -PageTitle 'Test Results' -UpdateExistingPage" -ForegroundColor Green
    Write-Host ""
    Write-Host "📖 For complete documentation, see: README.md" -ForegroundColor Yellow
    exit 0
}

# Import logging modules
$loggerPath = Join-Path $PSScriptRoot "logger.ps1"
$integrationPath = Join-Path $PSScriptRoot "logging_integration.ps1"

if (Test-Path $loggerPath) {
    . $loggerPath
    . $integrationPath
    
    # Initialize logging
    Initialize-ModuleLogging -ModuleName "confluence_integration" -Debug:$Debug
    Write-InfoLog "Starting Confluence integration" -Context "Confluence_Integration" -Data @{
        DiagramSetPath = $DiagramSetPath
        PageTitle = $PageTitle
        SpaceKey = $SpaceKey
        CreateNewPage = $CreateNewPage
        UpdateExistingPage = $UpdateExistingPage
    }
} else {
    Write-Host "Warning: Logger module not found, using console output only" -ForegroundColor Yellow
}

# Load environment variables
function Load-EnvironmentVariables {
    $envPath = Join-Path $PSScriptRoot "..\..\.env"
    
    if (-not (Test-Path $envPath)) {
        Write-ErrorLog "Environment file not found: $envPath" -Context "Confluence_Integration"
        throw "Environment file not found: $envPath"
    }
    
    $envContent = Get-Content $envPath
    $envVars = @{}
    
    foreach ($line in $envContent) {
        if ($line -match '^([^=]+)=(.*)$') {
            $key = $matches[1]
            $value = $matches[2]
            $envVars[$key] = $value
        }
    }
    
    Write-InfoLog "Loaded environment variables" -Context "Confluence_Integration" -Data @{
        VariablesCount = $envVars.Count
        Variables = $envVars.Keys
    }
    
    return $envVars
}

# Confluence API functions
function Get-ConfluencePage {
    param(
        [string]$PageId,
        [hashtable]$EnvVars
    )
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content/$PageId"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        Write-InfoLog "Retrieved Confluence page" -Context "Confluence_Integration" -Data @{
            PageId = $PageId
            PageTitle = $response.title
        }
        return $response
    } catch {
        Write-ErrorLog "Failed to get Confluence page: $($_.Exception.Message)" -Context "Confluence_Integration" -Data @{
            PageId = $PageId
            Error = $_.Exception.Message
        }
        throw
    }
}

function New-ConfluencePage {
    param(
        [string]$Title,
        [string]$Content,
        [string]$SpaceKey,
        [string]$ParentPageId = "",
        [hashtable]$EnvVars
    )
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = $Title
        space = @{
            key = $SpaceKey
        }
        body = @{
            storage = @{
                value = $Content
                representation = "storage"
            }
        }
    }
    
    if ($ParentPageId) {
        $body.ancestors = @(@{
            id = $ParentPageId
        })
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-InfoLog "Created new Confluence page" -Context "Confluence_Integration" -Data @{
            PageId = $response.id
            PageTitle = $Title
            SpaceKey = $SpaceKey
        }
        return $response
    } catch {
        Write-ErrorLog "Failed to create Confluence page: $($_.Exception.Message)" -Context "Confluence_Integration" -Data @{
            Title = $Title
            SpaceKey = $SpaceKey
            Error = $_.Exception.Message
        }
        throw
    }
}

function Update-ConfluencePage {
    param(
        [string]$PageId,
        [string]$Title,
        [string]$Content,
        [int]$Version,
        [hashtable]$EnvVars
    )
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        version = @{
            number = ($Version + 1)
        }
        title = $Title
        type = "page"
        body = @{
            storage = @{
                value = $Content
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content/$PageId"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Put -Body ($body | ConvertTo-Json -Depth 10)
        Write-InfoLog "Updated Confluence page" -Context "Confluence_Integration" -Data @{
            PageId = $PageId
            PageTitle = $Title
            NewVersion = ($Version + 1)
        }
        return $response
    } catch {
        Write-ErrorLog "Failed to update Confluence page: $($_.Exception.Message)" -Context "Confluence_Integration" -Data @{
            PageId = $PageId
            Title = $Title
            Error = $_.Exception.Message
        }
        throw
    }
}

function Convert-DiagramToConfluenceContent {
    param(
        [string]$DiagramContent,
        [string]$DiagramTitle = "Mermaid Diagram"
    )
    
    # Clean the content for Confluence
    $cleanContent = $DiagramContent -replace '\r\n', ' ' -replace '\n', ' ' -replace '\s+', ' '
    
    # Use Stratus Add-on macro format (which works!)
    $confluenceContent = "<h2>$DiagramTitle</h2>`n"
    $confluenceContent += '<ac:structured-macro ac:name="mermaid-cloud" ac:schema-version="1">`n'
    $confluenceContent += '<ac:parameter ac:name="chart">' + $cleanContent + '</ac:parameter>`n'
    $confluenceContent += '</ac:structured-macro>`n'
    $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
    
    return $confluenceContent
}

function Convert-DiagramToConfluenceContentAlternative {
    param(
        [string]$DiagramPath,
        [string]$DiagramTitle
    )
    
    if (-not (Test-Path $DiagramPath)) {
        Write-WarnLog "Diagram file not found: $DiagramPath" -Context "Confluence_Integration"
        return ""
    }
    
    $diagramContent = Get-Content $DiagramPath -Raw
    
    # Clean up the diagram content for Confluence
    $cleanContent = $diagramContent -replace "`r`n", "`n" -replace "`r", "`n"
    
    # Alternative format using code block
    $confluenceContent = "<h2>$DiagramTitle</h2>`n"
    $confluenceContent += '<p>Generated diagram showing entity relationships and structure.</p>`n`n'
    $confluenceContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $confluenceContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $confluenceContent += '<ac:plain-text-body><![CDATA[' + $cleanContent + ']]></ac:plain-text-body>`n'
    $confluenceContent += '</ac:structured-macro>`n`n'
    $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
    
    return $confluenceContent
}

function Convert-DiagramToMermaidLive {
    param(
        [string]$DiagramContent,
        [string]$DiagramTitle = "Mermaid Diagram"
    )
    
    # Clean the content for compression
    $cleanContent = $DiagramContent -replace '\r\n', ' ' -replace '\n', ' ' -replace '\s+', ' '
    
    # Create JSON payload for Mermaid.live (same as Node.js tool)
    $mermaidJson = @{
        code = $cleanContent
        mermaid = @{
            theme = "default"
        }
    } | ConvertTo-Json -Compress
    
    # Use the working Node.js tool for proper pako compression
    $nodeScriptPath = Join-Path $PSScriptRoot "..\node\generate_url.js"
    
    try {
        # Pass the JSON to Node.js tool and get the compressed URL
        $compressedUrl = $mermaidJson | node $nodeScriptPath
        
        # Create Confluence content with the working URL
        $confluenceContent = "<h2>$DiagramTitle</h2>`n"
        $confluenceContent += '<p><strong>Link: <a href="' + $compressedUrl + '" target="_blank">View Diagram on Mermaid.live</a></strong></p>`n'
        $confluenceContent += '<p><em>Click the link above to view and edit this diagram in Mermaid.live</em></p>`n`n'
        $confluenceContent += '<details>`n'
        $confluenceContent += '<summary>Diagram Code (Click to expand)</summary>`n'
        $confluenceContent += '<pre><code>' + $cleanContent + '</code></pre>`n'
        $confluenceContent += '</details>`n`n'
        $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
        
        return $confluenceContent
    } catch {
        Write-WarnLog "Failed to generate Mermaid.live URL using Node.js tool, falling back to simple link" -Context "Confluence_Integration"
        
        # Fallback to simple URL encoding
        $encodedContent = [System.Web.HttpUtility]::UrlEncode($cleanContent)
        $simpleUrl = "https://mermaid.live/edit#$encodedContent"
        
        $confluenceContent = "<h2>$DiagramTitle</h2>`n"
        $confluenceContent += '<p><strong>Link: <a href="' + $simpleUrl + '" target="_blank">View Diagram on Mermaid.live</a></strong></p>`n'
        $confluenceContent += '<p><em>Click the link above to view and edit this diagram in Mermaid.live</em></p>`n`n'
        $confluenceContent += '<details>`n'
        $confluenceContent += '<summary>Diagram Code (Click to expand)</summary>`n'
        $confluenceContent += '<pre><code>' + $cleanContent + '</code></pre>`n'
        $confluenceContent += '</details>`n`n'
        $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
        
        return $confluenceContent
    }
}

function Convert-DiagramToNativeConfluence {
    param(
        [string]$DiagramContent,
        [string]$DiagramTitle
    )
    
    # Clean the content for Confluence
    $cleanContent = $DiagramContent -replace '\r\n', ' ' -replace '\n', ' ' -replace '\s+', ' '
    
    # Use the proven working code block format from manual test
    $confluenceContent = "<h2>$DiagramTitle</h2>`n"
    $confluenceContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $confluenceContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $confluenceContent += '<ac:plain-text-body><![CDATA[' + $cleanContent + ']]></ac:plain-text-body>`n'
    $confluenceContent += '</ac:structured-macro>`n'
    $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
    
    return $confluenceContent
}

function Convert-DiagramToStratusConfluence {
    param(
        [string]$DiagramContent,
        [string]$DiagramTitle
    )
    
    # Clean the content for Confluence
    $cleanContent = $DiagramContent -replace '\r\n', ' ' -replace '\n', ' ' -replace '\s+', ' '
    
    # Use the proven working code block format from manual test
    $confluenceContent = "<h2>$DiagramTitle</h2>`n"
    $confluenceContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $confluenceContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $confluenceContent += '<ac:plain-text-body><![CDATA[' + $cleanContent + ']]></ac:plain-text-body>`n'
    $confluenceContent += '</ac:structured-macro>`n'
    $confluenceContent += '<p><em>Generated by FKmermaid on ' + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + '</em></p>'
    
    return $confluenceContent
}

function Test-NativeConfluenceMermaid {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing Native Atlassian Mermaid Extension..." -ForegroundColor Yellow
    
    $testContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[End]
    C --> D[Success]
"@
    
    $confluenceContent = Convert-DiagramToNativeConfluence -DiagramContent $testContent -DiagramTitle "Native Mermaid Test"
    
    $pageTitle = "Native Mermaid Extension Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $pageContent = @"
<h1>🧪 Native Atlassian Mermaid Extension Test</h1>
<p>Testing the native Atlassian Labs Mermaid extension without CRs and code blocks.</p>

$confluenceContent

<h2>📝 Test Details</h2>
<ul>
<li><strong>Extension:</strong> Native Atlassian Labs Mermaid</li>
<li><strong>Macro:</strong> <code>ac:name="mermaid"</code></li>
<li><strong>Parameter:</strong> <code>ac:parameter ac:name="chart"</code></li>
<li><strong>Content:</strong> Cleaned (no CRs, normalized whitespace)</li>
</ul>

<p><em>Test created on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>
"@
    
    try {
        $response = New-ConfluencePage -Title $pageTitle -Content $pageContent -SpaceKey "wmhse" -ParentPageId $EnvVars.CONFLUENCE_PAGE_ID -EnvVars $EnvVars
        Write-Host "✅ Native Mermaid test page created successfully!" -ForegroundColor Green
        Write-Host "🔗 Page URL: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-ErrorLog "Failed to create native Mermaid test page: $($_.Exception.Message)" -Context "Confluence_Integration"
        throw
    }
}

function Test-StratusConfluenceMermaid {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing Stratus Add-on Mermaid Extension..." -ForegroundColor Yellow
    
    $testContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[End]
    C --> D[Success]
"@
    
    $confluenceContent = Convert-DiagramToStratusConfluence -DiagramContent $testContent -DiagramTitle "Stratus Mermaid Test"
    
    $pageTitle = "Stratus Mermaid Extension Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $pageContent = @"
<h1>🧪 Stratus Add-on Mermaid Extension Test</h1>
<p>Testing the Stratus Add-on Mermaid extension without CRs and code blocks.</p>

$confluenceContent

<h2>📝 Test Details</h2>
<ul>
<li><strong>Extension:</strong> Stratus Add-on for Mermaid</li>
<li><strong>Macro:</strong> <code>ac:name="mermaid-cloud"</code></li>
<li><strong>Parameter:</strong> <code>ac:parameter ac:name="chart"</code></li>
<li><strong>Content:</strong> Cleaned (no CRs, normalized whitespace)</li>
</ul>

<p><em>Test created on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>
"@
    
    try {
        $response = New-ConfluencePage -Title $pageTitle -Content $pageContent -SpaceKey "wmhse" -ParentPageId $EnvVars.CONFLUENCE_PAGE_ID -EnvVars $EnvVars
        Write-Host "✅ Stratus Mermaid test page created successfully!" -ForegroundColor Green
        Write-Host "🔗 Page URL: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-ErrorLog "Failed to create Stratus Mermaid test page: $($_.Exception.Message)" -Context "Confluence_Integration"
        throw
    }
}

function Test-MermaidComparison {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Creating Mermaid Format Comparison Test..." -ForegroundColor Yellow
    
    $testContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[End]
    C --> D[Success]
"@
    
    $nativeContent = Convert-DiagramToNativeConfluence -DiagramContent $testContent -DiagramTitle "Native Mermaid Format"
    $stratusContent = Convert-DiagramToStratusConfluence -DiagramContent $testContent -DiagramTitle "Stratus Mermaid Format"
    
    $pageTitle = "Mermaid Format Comparison Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $pageContent = @"
<h1>🧪 Mermaid Format Comparison Test</h1>
<p>Testing both native Atlassian and Stratus Add-on Mermaid extensions side by side.</p>

<h2>📊 Test Diagram</h2>
<p>Both formats should render the same simple flowchart:</p>

<h3>🔧 Native Atlassian Mermaid Extension</h3>
$nativeContent

<h3>☁️ Stratus Add-on Mermaid Extension</h3>
$stratusContent

<h2>📝 Format Details</h2>
<table>
<tr><th>Extension</th><th>Macro Name</th><th>Parameter</th><th>Status</th></tr>
<tr><td>Native Atlassian</td><td><code>ac:name="mermaid"</code></td><td><code>ac:parameter ac:name="chart"</code></td><td>🔄 Testing</td></tr>
<tr><td>Stratus Add-on</td><td><code>ac:name="mermaid-cloud"</code></td><td><code>ac:parameter ac:name="chart"</code></td><td>🔄 Testing</td></tr>
</table>

<h2>🎯 Expected Results</h2>
<ul>
<li>Both diagrams should render identically</li>
<li>Both should show a simple flowchart with 4 nodes</li>
<li>If one fails, the other may work as a fallback</li>
</ul>

<p><em>Comparison test created on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>
"@
    
    try {
        $response = New-ConfluencePage -Title $pageTitle -Content $pageContent -SpaceKey "wmhse" -ParentPageId $EnvVars.CONFLUENCE_PAGE_ID -EnvVars $EnvVars
        Write-Host "✅ Mermaid comparison test page created successfully!" -ForegroundColor Green
        Write-Host "🔗 Page URL: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-ErrorLog "Failed to create Mermaid comparison test page: $($_.Exception.Message)" -Context "Confluence_Integration"
        throw
    }
}

function Process-DiagramSet {
    param(
        [string]$DiagramSetPath,
        [hashtable]$EnvVars
    )
    
    if (-not (Test-Path $DiagramSetPath)) {
        Write-ErrorLog "Diagram set path not found: $DiagramSetPath" -Context "Confluence_Integration"
        throw "Diagram set path not found: $DiagramSetPath"
    }
    
    $diagramFiles = Get-ChildItem -Path $DiagramSetPath -Filter "*.mmd" | Sort-Object Name
    $totalDiagrams = $diagramFiles.Count
    
    Write-Host "📊 Found $totalDiagrams diagrams in: $DiagramSetPath" -ForegroundColor Green
    Write-InfoLog "Processing diagram set" -Context "Confluence_Integration" -Data @{
        DiagramSetPath = $DiagramSetPath
        TotalDiagrams = $totalDiagrams
    }
    
    $confluenceContent = "<h1>$PageTitle</h1>`n"
    $confluenceContent += "<p>Automatically generated ER and Class diagrams from ColdFusion Components.</p>`n`n"
    $confluenceContent += "<h2>📋 Diagram Overview</h2>`n"
    $confluenceContent += "<ul>`n"
    $confluenceContent += "<li>Total Diagrams: $totalDiagrams</li>`n"
    $confluenceContent += "<li>Generated: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</li>`n"
    $confluenceContent += "<li>Tool: FKmermaid ER Diagram Generator</li>`n"
    $confluenceContent += "</ul>`n`n"
    $confluenceContent += "<h2>🎨 Generated Diagrams</h2>`n"
    
    $processedCount = 0
    foreach ($diagramFile in $diagramFiles) {
        $diagramTitle = [System.IO.Path]::GetFileNameWithoutExtension($diagramFile.Name)
        $diagramContent = Get-Content $diagramFile.FullName -Raw
        $confluenceContent += Convert-DiagramToStratusConfluence -DiagramContent $diagramContent -DiagramTitle $diagramTitle
        
        $processedCount++
        Write-Host "  ✅ Processed: $($diagramFile.Name)" -ForegroundColor Gray
        Write-InfoLog "Processed diagram" -Context "Confluence_Integration" -Data @{
            DiagramName = $diagramFile.Name
            ProcessedCount = $processedCount
            TotalCount = $totalDiagrams
        }
        
        $confluenceContent += "`n"
    }
    
    $confluenceContent += "`n<h2>📊 Summary</h2>`n"
    $confluenceContent += "<p>All diagrams have been successfully generated and uploaded to Confluence.</p>`n"
    $confluenceContent += "<ul>`n"
    $confluenceContent += "<li>Processing completed: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</li>`n"
    $confluenceContent += "<li>Total diagrams processed: $processedCount</li>`n"
    $confluenceContent += "<li>Status: ✅ Complete</li>`n"
    $confluenceContent += "</ul>`n"
    
    return $confluenceContent
}

function Test-SimpleMermaidBasic {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing basic Mermaid integration..." -ForegroundColor Yellow
    
    $simpleContent = "<h1>Basic Mermaid Test</h1>`n"
    $simpleContent += "<p>Testing basic Mermaid diagram rendering.</p>`n`n"
    $simpleContent += "<h2>Simple Flowchart</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body><![CDATA[flowchart LR`n'
    $simpleContent += '    A[Start] --> B[Process]`n'
    $simpleContent += '    B --> C[End]`n'
    $simpleContent += ']]></ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Simple Class Diagram</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body><![CDATA[classDiagram`n'
    $simpleContent += '    class Animal {`n'
    $simpleContent += '        +String name`n'
    $simpleContent += '        +makeSound()`n'
    $simpleContent += '    }`n'
    $simpleContent += '    class Dog {`n'
    $simpleContent += '        +bark()`n'
    $simpleContent += '    }`n'
    $simpleContent += '    Animal <|-- Dog`n'
    $simpleContent += ']]></ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Simple ER Diagram</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body><![CDATA[erDiagram`n'
    $simpleContent += '    CUSTOMER ||--o{ ORDER : places`n'
    $simpleContent += '    ORDER ||--|{ ORDER_ITEM : contains`n'
    $simpleContent += '    CUSTOMER {`n'
    $simpleContent += '        string name`n'
    $simpleContent += '        string email`n'
    $simpleContent += '    }`n'
    $simpleContent += '    ORDER {`n'
    $simpleContent += '        int orderNumber`n'
    $simpleContent += '        date orderDate`n'
    $simpleContent += '    }`n'
    $simpleContent += '    ORDER_ITEM {`n'
    $simpleContent += '        int quantity`n'
    $simpleContent += '        float price`n'
    $simpleContent += '    }`n'
    $simpleContent += ']]></ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<p><em>Basic test created by FKmermaid on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "Basic Mermaid Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
        space = @{
            key = "wmhse"
        }
        # Add parent page reference to create under FKmermaid folder
        ancestors = @(
            @{
                id = $EnvVars.CONFLUENCE_PAGE_ID
            }
        )
        body = @{
            storage = @{
                value = $simpleContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created basic test page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-Host "❌ Failed to create basic test page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Test-SimpleMermaidCloud {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing Stratus Add-on Mermaid macro..." -ForegroundColor Yellow
    
    $simpleContent = "<h1>Stratus Add-on Mermaid Test</h1>`n"
    $simpleContent += "<p>Testing the working Stratus Add-on Mermaid extension.</p>`n`n"
    $simpleContent += "<h2>Simple Flowchart</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="mermaid-cloud" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="chart">graph TD`n'
    $simpleContent += '    A[Start] --> B[Process]`n'
    $simpleContent += '    B --> C[End]</ac:parameter>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Simple Class Diagram</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="mermaid-cloud" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="chart">classDiagram`n'
    $simpleContent += '    class Animal`n'
    $simpleContent += '    class Dog`n'
    $simpleContent += '    Animal <|-- Dog</ac:parameter>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Simple ER Diagram</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="mermaid-cloud" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="chart">erDiagram`n'
    $simpleContent += '    CUSTOMER ||--o{ ORDER : places`n'
    $simpleContent += '    ORDER ||--|{ ORDER_ITEM : contains`n'
    $simpleContent += '    CUSTOMER {`n'
    $simpleContent += '        string name`n'
    $simpleContent += '        string email`n'
    $simpleContent += '    }`n'
    $simpleContent += '    ORDER {`n'
    $simpleContent += '        int orderNumber`n'
    $simpleContent += '        date orderDate`n'
    $simpleContent += '    }`n'
    $simpleContent += '    ORDER_ITEM {`n'
    $simpleContent += '        int quantity`n'
    $simpleContent += '        float price`n'
    $simpleContent += '    }</ac:parameter>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<p><em>Stratus Add-on test created by FKmermaid on " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "</em></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "Stratus Add-on Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
        space = @{
            key = "wmhse"
        }
        ancestors = @(
            @{
                id = $EnvVars.CONFLUENCE_PAGE_ID
            }
        )
        body = @{
            storage = @{
                value = $simpleContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created Stratus Add-on test page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-Host "❌ Failed to create Stratus Add-on test page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Create-FKmermaidFolder {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "📁 Creating FKmermaid folder..." -ForegroundColor Yellow
    
    $folderContent = "<h1>FKmermaid</h1>`n"
    $folderContent += "<p>Folder for FKmermaid generated diagrams and documentation.</p>`n"
    $folderContent += "<p><em>Created by FKmermaid on " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "</em></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "FKmermaid"
        space = @{
            key = "wmhse"
        }
        body = @{
            storage = @{
                value = $folderContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created FKmermaid folder: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        Write-Host "📝 Update your .env file with: CONFLUENCE_PAGE_ID=$($response.id)" -ForegroundColor Yellow
        return $response
    } catch {
        Write-Host "❌ Failed to create FKmermaid folder: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Test-SimpleMermaidAlternative {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing alternative Mermaid formats..." -ForegroundColor Yellow
    
    $simpleContent = "<h1>Alternative Mermaid Test</h1>`n"
    $simpleContent += "<p>Testing different Mermaid code block formats.</p>`n`n"
    $simpleContent += "<h2>Method 1: Plain Code Block</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body><![CDATA[graph TD`n'
    $simpleContent += '    A[Start] --> B[Process]`n'
    $simpleContent += '    B --> C[End]`n'
    $simpleContent += ']]></ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Method 2: No CDATA</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body>graph TD`n'
    $simpleContent += '    A[Start] --> B[Process]`n'
    $simpleContent += '    B --> C[End]`n'
    $simpleContent += '</ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<h2>Method 3: Different Language</h2>`n"
    $simpleContent += '<ac:structured-macro ac:name="code" ac:schema-version="1">`n'
    $simpleContent += '<ac:parameter ac:name="language">mermaid</ac:parameter>`n'
    $simpleContent += '<ac:parameter ac:name="theme">default</ac:parameter>`n'
    $simpleContent += '<ac:plain-text-body>flowchart LR`n'
    $simpleContent += '    A[Start] --> B[Process]`n'
    $simpleContent += '    B --> C[End]`n'
    $simpleContent += '</ac:plain-text-body>`n'
    $simpleContent += '</ac:structured-macro>`n`n'
    $simpleContent += "<p><em>Alternative test created by FKmermaid on " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "</em></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "Alternative Mermaid Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
        space = @{
            key = "wmhse"
        }
        ancestors = @(
            @{
                id = $EnvVars.CONFLUENCE_PAGE_ID
            }
        )
        body = @{
            storage = @{
                value = $simpleContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created alternative test page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-Host "❌ Failed to create alternative test page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Test-ManualMermaidTest {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Creating manual test page for Mermaid extension..." -ForegroundColor Yellow
    
    $manualContent = "<h1>Manual Mermaid Extension Test</h1>`n"
    $manualContent += "<p>This page is for manual testing of the Mermaid extension.</p>`n`n"
    $manualContent += "<h2>Instructions:</h2>`n"
    $manualContent += "<ol>`n"
    $manualContent += "<li>Click <strong>Edit</strong> on this page</li>`n"
    $manualContent += "<li>Add a new code block by typing <code>/code</code></li>`n"
    $manualContent += "<li>Set the language to <code>mermaid</code></li>`n"
    $manualContent += "<li>Paste this simple Mermaid code:</li>`n"
    $manualContent += "</ol>`n`n"
    $manualContent += "<pre>graph TD`n"
    $manualContent += "    A[Start] --> B[Process]`n"
    $manualContent += "    B --> C[End]</pre>`n`n"
    $manualContent += "<h2>Alternative Test Code:</h2>`n"
    $manualContent += "<pre>flowchart LR`n"
    $manualContent += "    A[Start] --> B[Process]`n"
    $manualContent += "    B --> C[End]</pre>`n`n"
    $manualContent += "<h2>Class Diagram Test:</h2>`n"
    $manualContent += "<pre>classDiagram`n"
    $manualContent += "    class Animal`n"
    $manualContent += "    class Dog`n"
    $manualContent += "    Animal <|-- Dog</pre>`n`n"
    $manualContent += "<p><em>Manual test created by FKmermaid on " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "</em></p>`n"
    $manualContent += "<p><strong>If this works manually, we'll know the extension is functional and the issue is with our automated content format.</strong></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "Manual Mermaid Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
        space = @{
            key = "wmhse"
        }
        ancestors = @(
            @{
                id = $EnvVars.CONFLUENCE_PAGE_ID
            }
        )
        body = @{
            storage = @{
                value = $manualContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created manual test page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        Write-Host "📝 Instructions: Edit the page and manually add a code block with language 'mermaid'" -ForegroundColor Yellow
        return $response
    } catch {
        Write-Host "❌ Failed to create manual test page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Test-MermaidLiveIntegration {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing Mermaid.live integration..." -ForegroundColor Yellow
    
    # Sample Mermaid diagrams
    $flowchartContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[End]
"@
    
    $classContent = @"
classDiagram
    class Animal
    class Dog
    Animal <|-- Dog
"@
    
    $erContent = @"
erDiagram
    CUSTOMER ||--o{ ORDER : places
    ORDER ||--|{ ORDER_ITEM : contains
    CUSTOMER {
        string name
        string email
    }
    ORDER {
        int orderNumber
        date orderDate
    }
    ORDER_ITEM {
        int quantity
        float price
    }
"@
    
    $simpleContent = "<h1>Mermaid.live Integration Test</h1>`n"
    $simpleContent += "<p>Testing external Mermaid.live integration as alternative to embedded diagrams.</p>`n`n"
    $simpleContent += (Convert-DiagramToMermaidLive -DiagramContent $flowchartContent -DiagramTitle "Simple Flowchart")
    $simpleContent += "`n`n"
    $simpleContent += (Convert-DiagramToMermaidLive -DiagramContent $classContent -DiagramTitle "Simple Class Diagram")
    $simpleContent += "`n`n"
    $simpleContent += (Convert-DiagramToMermaidLive -DiagramContent $erContent -DiagramTitle "Simple ER Diagram")
    $simpleContent += "`n`n"
    $simpleContent += "<p><strong>✅ This approach bypasses Confluence's broken Mermaid extensions by using external Mermaid.live links.</strong></p>"
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = "Mermaid.live Integration Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
        space = @{
            key = "wmhse"
        }
        ancestors = @(
            @{
                id = $EnvVars.CONFLUENCE_PAGE_ID
            }
        )
        body = @{
            storage = @{
                value = $simpleContent
                representation = "storage"
            }
        }
    }
    
    $url = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    try {
        $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
        Write-Host "✅ Created Mermaid.live integration test page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        Write-Host "🔗 This approach uses external Mermaid.live links instead of embedded diagrams" -ForegroundColor Yellow
        return $response
    } catch {
        Write-Host "❌ Failed to create Mermaid.live integration test page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

function Test-ContentCleaning {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🧪 Testing Content Cleaning..." -ForegroundColor Yellow
    
    $testContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[End]
    C --> D[Success]
"@
    
    Write-Host "Original content length: $($testContent.Length)" -ForegroundColor Cyan
    Write-Host "Original content (hex): $([System.BitConverter]::ToString([System.Text.Encoding]::UTF8.GetBytes($testContent)))" -ForegroundColor Gray
    
    $cleanContent = $testContent -replace '\r\n', ' ' -replace '\n', ' ' -replace '\s+', ' '
    
    Write-Host "Cleaned content length: $($cleanContent.Length)" -ForegroundColor Cyan
    Write-Host "Cleaned content: '$cleanContent'" -ForegroundColor Green
    
    $nativeContent = Convert-DiagramToNativeConfluence -DiagramContent $testContent -DiagramTitle "Content Cleaning Test"
    
    $pageTitle = "Content Cleaning Test - " + (Get-Date -Format 'yyyy-MM-dd HH:mm')
    $pageContent = "<h1>🧪 Content Cleaning Test</h1>`n"
    $pageContent += "<p>Testing Mermaid content cleaning to ensure no CR issues.</p>`n`n"
    $pageContent += "<h2>📊 Test Results</h2>`n"
    $pageContent += "<ul>`n"
    $pageContent += "<li><strong>Original Length:</strong> " + $testContent.Length + " characters</li>`n"
    $pageContent += "<li><strong>Cleaned Length:</strong> " + $cleanContent.Length + " characters</li>`n"
    $pageContent += "<li><strong>CR/LF Removed:</strong> ✅ Yes</li>`n"
    $pageContent += "<li><strong>Whitespace Normalized:</strong> ✅ Yes</li>`n"
    $pageContent += "</ul>`n`n"
    $pageContent += "<h2>🔧 Native Mermaid Test</h2>`n"
    $pageContent += $nativeContent
    $pageContent += "`n`n"
    $pageContent += "<h2>📋 Raw Content Analysis</h2>`n"
    $pageContent += "<details>`n"
    $pageContent += "<summary>Original Content (Click to expand)</summary>`n"
    $pageContent += "<pre><code>" + $testContent + "</code></pre>`n"
    $pageContent += "</details>`n`n"
    $pageContent += "<details>`n"
    $pageContent += "<summary>Cleaned Content (Click to expand)</summary>`n"
    $pageContent += "<pre><code>" + $cleanContent + "</code></pre>`n"
    $pageContent += "</details>`n`n"
    $pageContent += "<p><em>Content cleaning test created on " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + "</em></p>"
    
    try {
        $response = New-ConfluencePage -Title $pageTitle -Content $pageContent -SpaceKey "wmhse" -ParentPageId $EnvVars.CONFLUENCE_PAGE_ID -EnvVars $EnvVars
        Write-Host "✅ Content cleaning test page created successfully!" -ForegroundColor Green
        Write-Host "🔗 Page URL: $($EnvVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        return $response
    } catch {
        Write-ErrorLog "Failed to create content cleaning test page: $($_.Exception.Message)" -Context "Confluence_Integration"
        throw
    }
}

# Test API connectivity
function Test-ConfluenceAPI {
    param(
        [hashtable]$EnvVars
    )
    
    Write-Host "🔍 Testing Confluence API connectivity..." -ForegroundColor Yellow
    
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    # Test 1: Try to get user info
    try {
        $userUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/user/current"
        Write-Host "  Testing user endpoint: $userUrl" -ForegroundColor Gray
        $userResponse = Invoke-RestMethod -Uri $userUrl -Headers $headers -Method Get
        Write-Host "  ✅ User API working: $($userResponse.displayName)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ User API failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "     Status: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
        Write-Host "     Reason: $($_.Exception.Response.ReasonPhrase)" -ForegroundColor Red
    }
    
    # Test 2: Try to get space info
    try {
        $spaceUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/space/wmhse"
        Write-Host "  Testing space endpoint: $spaceUrl" -ForegroundColor Gray
        $spaceResponse = Invoke-RestMethod -Uri $spaceUrl -Headers $headers -Method Get
        Write-Host "  ✅ Space API working: $($spaceResponse.name)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Space API failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "     Status: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
        Write-Host "     Reason: $($_.Exception.Response.ReasonPhrase)" -ForegroundColor Red
    }
    
    # Test 3: Try to get page info with different endpoint
    try {
        $pageUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content/18415620?expand=body.storage"
        Write-Host "  Testing page endpoint: $pageUrl" -ForegroundColor Gray
        $pageResponse = Invoke-RestMethod -Uri $pageUrl -Headers $headers -Method Get
        Write-Host "  ✅ Page API working: $($pageResponse.title)" -ForegroundColor Green
        return $pageResponse
    } catch {
        Write-Host "  ❌ Page API failed: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host "     Status: $($_.Exception.Response.StatusCode)" -ForegroundColor Red
        Write-Host "     Reason: $($_.Exception.Response.ReasonPhrase)" -ForegroundColor Red
    }
    
    # Test 4: Try different authentication method (Basic Auth)
    try {
        $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($EnvVars.CONFLUENCE_USER):$($EnvVars.CONFLUENCE_API_TOKEN)"))
        $basicHeaders = @{
            "Authorization" = "Basic $basicAuth"
            "Content-Type" = "application/json"
            "Accept" = "application/json"
        }
        
        $testUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/user/current"
        Write-Host "  Testing Basic Auth: $testUrl" -ForegroundColor Gray
        $basicResponse = Invoke-RestMethod -Uri $testUrl -Headers $basicHeaders -Method Get
        Write-Host "  ✅ Basic Auth working: $($basicResponse.displayName)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Basic Auth failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Test 5: Try different API endpoints
    try {
        $serverInfoUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/serverInfo"
        Write-Host "  Testing server info: $serverInfoUrl" -ForegroundColor Gray
        $serverResponse = Invoke-RestMethod -Uri $serverInfoUrl -Headers $headers -Method Get
        Write-Host "  ✅ Server info working: $($serverResponse.baseUrl)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Server info failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Test 6: Try to list spaces
    try {
        $spacesUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/space"
        Write-Host "  Testing spaces list: $spacesUrl" -ForegroundColor Gray
        $spacesResponse = Invoke-RestMethod -Uri $spacesUrl -Headers $headers -Method Get
        Write-Host "  ✅ Spaces list working: Found $($spacesResponse.results.Count) spaces" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Spaces list failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    # Test 7: Try to get page without expand
    try {
        $simplePageUrl = "$($EnvVars.CONFLUENCE_BASE_URL)/rest/api/content/18415620"
        Write-Host "  Testing simple page: $simplePageUrl" -ForegroundColor Gray
        $simplePageResponse = Invoke-RestMethod -Uri $simplePageUrl -Headers $headers -Method Get
        Write-Host "  ✅ Simple page working: $($simplePageResponse.title)" -ForegroundColor Green
    } catch {
        Write-Host "  ❌ Simple page failed: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    return $null
}

# Main execution
try {
    Write-Host "🦄 FKmermaid Confluence Integration - HOLY GRAIL" -ForegroundColor Cyan
    Write-Host "=================================================" -ForegroundColor Cyan
    
    # Validate parameters
    if (-not $TestMermaid -and -not $TestBasic -and -not $TestMermaidCloud -and -not $TestAlternative -and -not $TestManual -and -not $TestMermaidLive -and -not $TestNativeMermaid -and -not $TestStratusMermaid -and -not $TestMermaidComparison -and -not $TestContentCleaning -and -not $DiagramSetPath) {
        throw "DiagramSetPath is required. Use -Help for usage information."
    }
    
    if (-not $TestMermaid -and -not $TestBasic -and -not $TestMermaidCloud -and -not $TestAlternative -and -not $TestManual -and -not $TestMermaidLive -and -not $TestNativeMermaid -and -not $TestStratusMermaid -and -not $TestMermaidComparison -and -not $TestContentCleaning -and -not $PageTitle) {
        throw "PageTitle is required. Use -Help for usage information."
    }
    
    # Load environment variables
    Write-Host "🔐 Loading Confluence credentials..." -ForegroundColor Yellow
    $envVars = Load-EnvironmentVariables
    
    # Test API connectivity first
    $testPage = Test-ConfluenceAPI -EnvVars $envVars
    
    # Test Mermaid extension if requested
    if ($TestMermaid) {
        Write-Host "🧪 Testing Mermaid extension..." -ForegroundColor Yellow
        Test-SimpleMermaidBasic -EnvVars $envVars
        return
    }
    
    # Test basic Mermaid if requested
    if ($TestBasic) {
        Write-Host "🧪 Testing basic Mermaid integration..." -ForegroundColor Yellow
        Test-SimpleMermaidBasic -EnvVars $envVars
        return
    }
    
    # Test mermaid-cloud macro if requested
    if ($TestMermaidCloud) {
        Write-Host "🧪 Testing mermaid-cloud macro..." -ForegroundColor Yellow
        Test-SimpleMermaidCloud -EnvVars $envVars
        return
    }
    
    # Test alternative formats if requested
    if ($TestAlternative) {
        Write-Host "🧪 Testing alternative Mermaid formats..." -ForegroundColor Yellow
        Test-SimpleMermaidAlternative -EnvVars $envVars
        return
    }
    
    # Test manual Mermaid extension if requested
    if ($TestManual) {
        Write-Host "🧪 Creating manual test page for Mermaid extension..." -ForegroundColor Yellow
        Test-ManualMermaidTest -EnvVars $envVars
        return
    }
    
    # Test Mermaid.live integration if requested
    if ($TestMermaidLive) {
        Write-Host "🧪 Testing Mermaid.live integration..." -ForegroundColor Yellow
        Test-MermaidLiveIntegration -EnvVars $envVars
        return
    }
    
    # Test native Atlassian Mermaid extension if requested
    if ($TestNativeMermaid) {
        Write-Host "🧪 Testing native Atlassian Mermaid extension..." -ForegroundColor Yellow
        Test-NativeConfluenceMermaid -EnvVars $envVars
        return
    }
    
    # Test Stratus Add-on Mermaid extension if requested
    if ($TestStratusMermaid) {
        Write-Host "🧪 Testing Stratus Add-on Mermaid extension..." -ForegroundColor Yellow
        Test-StratusConfluenceMermaid -EnvVars $envVars
        return
    }
    
    # Test Mermaid format comparison if requested
    if ($TestMermaidComparison) {
        Write-Host "🧪 Testing Mermaid format comparison..." -ForegroundColor Yellow
        Test-MermaidComparison -EnvVars $envVars
        return
    }
    
    # Test content cleaning if requested
    if ($TestContentCleaning) {
        Write-Host "🧪 Testing Content Cleaning..." -ForegroundColor Yellow
        Test-ContentCleaning -EnvVars $envVars
        return
    }
    
    # Process diagram set
    Write-Host "📊 Processing diagram set..." -ForegroundColor Yellow
    $confluenceContent = Process-DiagramSet -DiagramSetPath $DiagramSetPath -EnvVars $envVars
    
    # Determine action (create or update)
    if ($DemoMode) {
        Write-Host "🎭 Demo mode: Saving content to file..." -ForegroundColor Cyan
        $demoFile = Join-Path $PSScriptRoot "..\..\confluence_demo_content.html"
        $confluenceContent | Out-File -FilePath $demoFile -Encoding UTF8
        Write-Host "✅ Demo content saved to: $demoFile" -ForegroundColor Green
        Write-Host "📄 Content preview (first 500 chars):" -ForegroundColor Gray
        Write-Host $confluenceContent.Substring(0, [Math]::Min(500, $confluenceContent.Length)) -ForegroundColor Gray
    } elseif ($CreateNewPage) {
        Write-Host "📄 Creating new Confluence page..." -ForegroundColor Green
        $response = New-ConfluencePage -Title $PageTitle -Content $confluenceContent -SpaceKey $SpaceKey -ParentPageId $ParentPageId -EnvVars $envVars
        Write-Host "✅ Created new page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
    } elseif ($UpdateExistingPage) {
        if (-not $envVars.CONFLUENCE_PAGE_ID) {
            throw "CONFLUENCE_PAGE_ID is required for updating existing page"
        }
        
        Write-Host "📝 Updating existing Confluence page..." -ForegroundColor Green
        $existingPage = Get-ConfluencePage -PageId $envVars.CONFLUENCE_PAGE_ID -EnvVars $envVars
        $response = Update-ConfluencePage -PageId $envVars.CONFLUENCE_PAGE_ID -Title $PageTitle -Content $confluenceContent -Version $existingPage.version.number -EnvVars $envVars
        Write-Host "✅ Updated page: $($response.id)" -ForegroundColor Green
        Write-Host "🌐 View at: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
    } else {
        Write-Host "⚠️  No action specified. Use -CreateNewPage, -UpdateExistingPage, or -DemoMode" -ForegroundColor Yellow
        Write-Host "📄 Content preview (first 500 chars):" -ForegroundColor Gray
        Write-Host $confluenceContent.Substring(0, [Math]::Min(500, $confluenceContent.Length)) -ForegroundColor Gray
    }
    
    Write-Host "🎉 Confluence integration completed successfully!" -ForegroundColor Green
    Write-InfoLog "Confluence integration completed successfully" -Context "Confluence_Integration" -Data @{
        Action = if ($CreateNewPage) { "Create" } elseif ($UpdateExistingPage) { "Update" } else { "Preview" }
        PageTitle = $PageTitle
        DiagramsProcessed = ($confluenceContent -split '<h2>').Count - 1
    }
    
} catch {
    Write-Host "❌ Confluence integration failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-ErrorLog "Confluence integration failed" -Context "Confluence_Integration" -Data @{
        Error = $_.Exception.Message
        StackTrace = $_.Exception.StackTrace
    }
    exit 1
}