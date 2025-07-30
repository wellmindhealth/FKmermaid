# Test Vanilla JavaScript in Confluence
# Simple show/hide and popover functionality

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

# Create simple HTML with vanilla JavaScript
$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Vanilla JS Test</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .test-section { margin: 20px 0; padding: 15px; border: 1px solid #ccc; }
        .hidden { display: none; }
        .visible { display: block; }
        .btn { padding: 10px 15px; margin: 5px; cursor: pointer; }
        .popover { position: relative; display: inline-block; }
        .popover-content { 
            display: none; 
            position: absolute; 
            background: #333; 
            color: white; 
            padding: 10px; 
            border-radius: 5px; 
            z-index: 1000;
            top: 100%;
            left: 0;
        }
        .show { display: block; }
        .filter-item { padding: 10px; margin: 5px; border-radius: 5px; }
        .red { background: #ffcccc; }
        .blue { background: #cce5ff; }
    </style>
</head>
<body>
    <h1>Vanilla JavaScript Test in Confluence</h1>
    
    <div class="test-section">
        <h2>Test 1: Simple Show/Hide</h2>
        <button class="btn" onclick="toggleContent()">Toggle Content</button>
        <div id="toggleContent" class="hidden">
            <p>This content can be shown/hidden with vanilla JavaScript!</p>
            <p>If you can see this, JavaScript is working in Confluence.</p>
        </div>
    </div>
    
    <div class="test-section">
        <h2>Test 2: Popover</h2>
        <div class="popover">
            <button class="btn" onclick="togglePopover()">Hover for Info</button>
            <div id="popoverContent" class="popover-content">
                This is a popover created with vanilla JavaScript!
            </div>
        </div>
    </div>
    
    <div class="test-section">
        <h2>Test 3: Filter Buttons</h2>
        <button class="btn" onclick="filterContent('all')">Show All</button>
        <button class="btn" onclick="filterContent('red')">Show Red</button>
        <button class="btn" onclick="filterContent('blue')">Show Blue</button>
        
        <div id="filterContainer">
            <div class="filter-item red">Red Item 1</div>
            <div class="filter-item blue">Blue Item 1</div>
            <div class="filter-item red">Red Item 2</div>
            <div class="filter-item blue">Blue Item 2</div>
        </div>
    </div>
    
    <div class="test-section">
        <h2>Test 4: Console Log</h2>
        <button class="btn" onclick="logTest()">Log to Console</button>
        <p>Check browser console for JavaScript output.</p>
    </div>

    <script>
        // Test 1: Simple toggle
        function toggleContent() {
            const content = document.getElementById('toggleContent');
            if (content.classList.contains('hidden')) {
                content.classList.remove('hidden');
                content.classList.add('visible');
            } else {
                content.classList.remove('visible');
                content.classList.add('hidden');
            }
        }
        
        // Test 2: Popover
        function togglePopover() {
            const popover = document.getElementById('popoverContent');
            if (popover.classList.contains('show')) {
                popover.classList.remove('show');
            } else {
                popover.classList.add('show');
            }
        }
        
        // Test 3: Filter
        function filterContent(filter) {
            const items = document.querySelectorAll('.filter-item');
            items.forEach(item => {
                if (filter === 'all' || item.classList.contains(filter)) {
                    item.style.display = 'block';
                } else {
                    item.style.display = 'none';
                }
            });
        }
        
        // Test 4: Console log
        function logTest() {
            console.log('Vanilla JavaScript is working in Confluence!');
            alert('JavaScript is working! Check console for log message.');
        }
        
        // Auto-run test on page load
        window.onload = function() {
            console.log('Page loaded successfully with JavaScript');
        };
    </script>
</body>
</html>
"@

# Convert to Confluence storage format - direct HTML content
$storageContent = $htmlContent

$pageBody = @{
    type = "page"
    title = "Vanilla JavaScript Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
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
    
    Write-Host "✅ Page created successfully!"
    Write-Host "Page ID: $($response.id)"
    Write-Host "Page URL: $($response._links.webui)"
    Write-Host ""
    Write-Host "Test the JavaScript functionality:"
    Write-Host "1. Click 'Toggle Content' to show/hide text"
    Write-Host "2. Click 'Hover for Info' to show popover"
    Write-Host "3. Click filter buttons to show/hide colored items"
    Write-Host "4. Click 'Log to Console' and check browser console"
    
} catch {
    Write-Error "Failed to create page: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response: $responseBody"
    }
} 