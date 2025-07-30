# Create CSS-Only Interface in Confluence
# Fully functional interface with no JavaScript required

param(
    [switch]$DryRun
)

# Load environment variables
$envPath = Join-Path $PSScriptRoot "..\..\..\.env"
if (Test-Path $envPath) {
    Get-Content $envPath | ForEach-Object {
        if ($_ -match '^([^=]+)=(.*)$') {
            [Environment]::SetEnvironmentVariable($matches[1], $matches[2])
        }
    }
}

$confluenceBaseUrl = $env:CONFLUENCE_BASE_URL
$confluenceUser = $env:CONFLUENCE_USER
$confluenceApiToken = $env:CONFLUENCE_API_TOKEN
$pageId = $env:CONFLUENCE_PAGE_ID

if (-not $confluenceBaseUrl -or -not $confluenceUser -or -not $confluenceApiToken) {
    Write-Error "Missing environment variables. Check .env file."
    exit 1
}

# Read the CSS-only HTML content
$htmlPath = Join-Path $PSScriptRoot "..\..\..\interface_css_only_working.html"
if (-not (Test-Path $htmlPath)) {
    Write-Error "HTML file not found: $htmlPath"
    exit 1
}

$htmlContent = Get-Content $htmlPath -Raw

# Convert to Confluence storage format - direct HTML content
$storageContent = $htmlContent

$pageBody = @{
    type = "page"
    title = "CFC Diagrams - CSS Only Interface - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    space = @{
        key = "wmhse"
    }
    ancestors = @(@{
        id = $pageId
    })
    body = @{
        storage = @{
            value = $storageContent
            representation = "storage"
        }
    }
}

if ($DryRun) {
    Write-Host "DRY RUN - Would create page with content:"
    Write-Host ($pageBody | ConvertTo-Json -Depth 10)
    exit 0
}

# Create the page using the working method
$basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$confluenceUser`:$confluenceApiToken"))
$headers = @{
    "Authorization" = "Basic $basicAuth"
    "Content-Type" = "application/json"
    "Accept" = "application/json"
}

try {
    $response = Invoke-RestMethod -Uri "$confluenceBaseUrl/rest/api/content" -Method Post -Headers $headers -Body ($pageBody | ConvertTo-Json -Depth 10)
    
    Write-Host "✅ CSS-Only Interface created successfully!"
    Write-Host "Page ID: $($response.id)"
    Write-Host "Page URL: $($response._links.webui)"
    Write-Host ""
    Write-Host "🎯 CSS-Only Features:"
    Write-Host "1. Domain Filtering - Click domain buttons to filter sections"
    Write-Host "2. Layer Filtering - Click layer buttons to filter cards"
    Write-Host "3. Domain Collapse - Click domain headers to expand/collapse"
    Write-Host "4. Popover Tooltips - Hover over badges for descriptions"
    Write-Host "5. Modal Details - Click 'View Details' for component info"
    Write-Host "6. Active States - Buttons change color when selected"
    Write-Host ""
    Write-Host "🚀 NO JAVASCRIPT REQUIRED - Pure CSS functionality!"
    
} catch {
    Write-Error "Failed to create page: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody"
    }
} 