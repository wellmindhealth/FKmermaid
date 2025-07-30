<#
.SYNOPSIS
    Test JavaScript execution and Mermaid generation in Confluence
    
.DESCRIPTION
    Creates a Confluence page to test:
    1. Basic JavaScript execution
    2. Mermaid diagram generation
    3. Inline diagram display
    
.EXAMPLE
    .\test_js_capabilities.ps1
#>

Write-Host "🧪 Confluence JavaScript Test" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan

# Load environment variables
function Load-EnvironmentVariables {
    $envPath = Join-Path $PSScriptRoot "..\..\.env"
    
    if (-not (Test-Path $envPath)) {
        Write-Host "❌ Environment file not found: $envPath" -ForegroundColor Red
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
    
    Write-Host "✅ Loaded $($envVars.Count) environment variables" -ForegroundColor Green
    return $envVars
}

$envVars = Load-EnvironmentVariables

# Test 1: Basic JavaScript execution
$basicJsTest = @"
<h1>🧪 Confluence JavaScript Capability Test</h1>

<h2>Test 1: Basic JavaScript Execution</h2>
<div id="js-test-result">Testing...</div>

<script>
console.log('JavaScript is running in Confluence!');
document.getElementById('js-test-result').innerHTML = '✅ JavaScript execution: SUCCESS';
</script>

<h2>Test 2: JSON Parsing</h2>
<div id="json-test-result">Testing...</div>

<script>
try {
    const testData = {
        "test": "value",
        "numbers": [1, 2, 3, 4, 5],
        "nested": {
            "key": "value"
        }
    };
    
    const parsed = JSON.parse(JSON.stringify(testData));
    document.getElementById('json-test-result').innerHTML = '✅ JSON parsing: SUCCESS - ' + parsed.test;
} catch (error) {
    document.getElementById('json-test-result').innerHTML = '❌ JSON parsing: FAILED - ' + error.message;
}
</script>

<h2>Test 3: Array Operations</h2>
<div id="array-test-result">Testing...</div>

<script>
try {
    const cfcs = ['partner', 'member', 'programme', 'activityDef'];
    const domains = ['partner', 'participant', 'programme'];
    
    const combinations = cfcs.map(cfc => 
        domains.map(domain => `${cfc} in ${domain}`)
    ).flat();
    
    document.getElementById('array-test-result').innerHTML = 
        '✅ Array operations: SUCCESS - ' + combinations.length + ' combinations generated';
} catch (error) {
    document.getElementById('array-test-result').innerHTML = '❌ Array operations: FAILED - ' + error.message;
}
</script>
"@

# Test 2: Mermaid diagram generation
$mermaidTest = @"
<h2>Test 4: Mermaid Diagram Generation</h2>
<div id="mermaid-test-result">Testing...</div>

<script>
try {
    // Test Mermaid syntax generation
    const testDiagram = `
graph TD
    A[Partner] --> B[Member]
    B --> C[Programme]
    C --> D[ActivityDef]
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
`;
    
    document.getElementById('mermaid-test-result').innerHTML = 
        '✅ Mermaid generation: SUCCESS - ' + testDiagram.split('\n').length + ' lines generated';
} catch (error) {
    document.getElementById('mermaid-test-result').innerHTML = '❌ Mermaid generation: FAILED - ' + error.message;
}
</script>

<h2>Test 5: Inline Mermaid Display</h2>
<div class="mermaid" id="inline-diagram">
graph TD
    A[Partner] --> B[Member]
    B --> C[Programme]
    C --> D[ActivityDef]
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
</div>

<script>
// Try to initialize Mermaid if it's available
if (typeof mermaid !== 'undefined') {
    mermaid.initialize({ startOnLoad: true });
    console.log('Mermaid library detected');
} else {
    console.log('Mermaid library not available');
}
</script>

<h2>Test 6: Dynamic Content Generation</h2>
<div id="dynamic-test-result">Testing...</div>

<script>
try {
    // Simulate CFC cache structure
    const cfcCache = {
        entities: {
            partner: { domain: "partner", properties: ["name", "id"] },
            member: { domain: "participant", properties: ["name", "id"] },
            programme: { domain: "programme", properties: ["name", "id"] }
        },
        relationships: [
            { from: "partner", to: "member", type: "hasMany" },
            { from: "member", to: "programme", type: "belongsTo" }
        ]
    };
    
    // Generate diagram from cache
    let diagramLines = ['graph TD'];
    cfcCache.relationships.forEach(rel => {
        diagramLines.push(`    ${rel.from} --> ${rel.to}`);
    });
    
    const generatedDiagram = diagramLines.join('\n');
    document.getElementById('dynamic-test-result').innerHTML = 
        '✅ Dynamic generation: SUCCESS - ' + generatedDiagram.split('\n').length + ' lines';
} catch (error) {
    document.getElementById('dynamic-test-result').innerHTML = '❌ Dynamic generation: FAILED - ' + error.message;
}
</script>

<h2>📊 Test Summary</h2>
<p>This page tests Confluence's JavaScript capabilities for dynamic diagram generation.</p>
<p><strong>If all tests pass:</strong> We can build a dynamic CFC diagram generator!</p>
<p><strong>If tests fail:</strong> We'll stick with the proven popout approach.</p>
"@

$pageContent = $basicJsTest + $mermaidTest

# Function to create Confluence page
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
        Write-Host "✅ Created new Confluence page" -ForegroundColor Green
        return $response
    } catch {
        Write-Host "❌ Failed to create Confluence page: $($_.Exception.Message)" -ForegroundColor Red
        throw
    }
}

try {
    $pageTitle = "JavaScript Capability Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $response = New-ConfluencePage -Title $pageTitle -Content $pageContent -SpaceKey "SD" -ParentPageId $envVars.CONFLUENCE_PAGE_ID -EnvVars $envVars
    
    Write-Host "✅ JavaScript test page created successfully!" -ForegroundColor Green
    Write-Host "🔗 Page URL: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
    Write-Host "📋 Check the page to see which tests pass/fail" -ForegroundColor Yellow
    
    return $response
} catch {
    Write-Host "❌ Failed to create JavaScript test page: $($_.Exception.Message)" -ForegroundColor Red
    throw
} 