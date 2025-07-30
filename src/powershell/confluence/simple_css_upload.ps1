# Simple CSS-Only Interface Upload to Confluence
# Bypasses logger issues and directly uploads the CSS-only interface

param(
    [string]$PageTitle = "CSS-Only Interface Test",
    [string]$SpaceKey = "SD",
    [switch]$CreateNewPage = $true,
    [switch]$Debug = $false
)

Write-Host "🚀 Simple CSS-Only Interface Upload to Confluence..." -ForegroundColor Green

# Load environment variables directly
$envPath = Join-Path $PSScriptRoot "..\..\..\.env"
if (-not (Test-Path $envPath)) {
    Write-Host "❌ .env file not found at: $envPath" -ForegroundColor Red
    exit 1
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

Write-Host "✅ Environment variables loaded successfully" -ForegroundColor Green

# Read the CSS-only interface HTML file
$interfaceFile = Join-Path $PSScriptRoot "..\..\..\interface_css_only_fixed.html"
if (-not (Test-Path $interfaceFile)) {
    Write-Host "❌ CSS-only interface file not found at: $interfaceFile" -ForegroundColor Red
    exit 1
}

Write-Host "📖 Reading CSS-only interface file..." -ForegroundColor Yellow
$interfaceContent = Get-Content $interfaceFile -Raw -Encoding UTF8

# Create Confluence page content
$confluenceContent = @"
<h1>🧪 CSS-Only Interface Test</h1>
<p><strong>Test Date:</strong> $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
<p><strong>Purpose:</strong> Testing CSS-only functionality in Confluence environment</p>

<hr>

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0;">
    <h2>📋 Test Instructions</h2>
    <ul>
        <li><strong>Domain Filters:</strong> Click domain buttons to filter content (should work as toggles)</li>
        <li><strong>Layer Filters:</strong> Click layer buttons to filter by type (should work as toggles)</li>
        <li><strong>Collapse Headers:</strong> Click domain headers to expand/collapse sections</li>
        <li><strong>Counters:</strong> Top bar should show dynamic counts</li>
        <li><strong>Status Text:</strong> Top-right should show current filter state</li>
        <li><strong>Popovers:</strong> Hover over badges to see tooltips</li>
        <li><strong>Modals:</strong> Click "View Details" to open modals</li>
    </ul>
</div>

<hr>

<div style="background: #fff3cd; padding: 15px; border-radius: 6px; margin: 20px 0; border-left: 4px solid #ffc107;">
    <h3>⚠️ Important Notes</h3>
    <ul>
        <li>This interface uses <strong>NO JavaScript</strong> - only HTML and CSS</li>
        <li>All interactivity is achieved through CSS selectors and pseudo-classes</li>
        <li>If functionality doesn't work, it may be due to Confluence's CSP restrictions</li>
        <li>This is a proof-of-concept for CSS-only interfaces in Confluence</li>
    </ul>
</div>

<hr>

<!-- CSS-Only Interface Content -->
$interfaceContent
"@

# Create the Confluence page using direct API calls
Write-Host "🚀 Creating Confluence page with CSS-only interface..." -ForegroundColor Green

try {
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($envVars.CONFLUENCE_USER):$($envVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = $PageTitle
        space = @{
            key = $SpaceKey
        }
        body = @{
            storage = @{
                value = $confluenceContent
                representation = "storage"
            }
        }
    }
    
    $jsonBody = $body | ConvertTo-Json -Depth 10
    $url = "$($envVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    if ($Debug) {
        Write-Host "🔍 Debug: URL = $url" -ForegroundColor Gray
        Write-Host "🔍 Debug: Headers = $($headers | ConvertTo-Json)" -ForegroundColor Gray
        Write-Host "🔍 Debug: Body length = $($jsonBody.Length) characters" -ForegroundColor Gray
    }
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body $jsonBody
    
    if ($response) {
        Write-Host "✅ CSS-only interface page created successfully!" -ForegroundColor Green
        Write-Host "🔗 Page URL: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
        Write-Host "📄 Page ID: $($response.id)" -ForegroundColor Gray
        Write-Host ""
        Write-Host "🧪 Test the following functionality:" -ForegroundColor Yellow
        Write-Host "   • Domain filter toggles" -ForegroundColor White
        Write-Host "   • Layer filter toggles" -ForegroundColor White
        Write-Host "   • Collapsible sections" -ForegroundColor White
        Write-Host "   • Dynamic counters" -ForegroundColor White
        Write-Host "   • Status text updates" -ForegroundColor White
        Write-Host "   • CSS-only modals" -ForegroundColor White
        Write-Host "   • Hover tooltips" -ForegroundColor White
    } else {
        Write-Host "❌ Failed to create Confluence page" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Exception occurred: $($_.Exception.Message)" -ForegroundColor Red
    if ($Debug) {
        Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Open the created page in Confluence" -ForegroundColor White
Write-Host "   2. Test all interactive elements" -ForegroundColor White
Write-Host "   3. Check browser console for any CSP violations" -ForegroundColor White
Write-Host "   4. Report back on what works/doesn't work" -ForegroundColor White 