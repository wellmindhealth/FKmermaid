# Test Template-Based Mermaid Page Creation
Write-Host "🎯 Testing template-based Mermaid page creation..." -ForegroundColor Yellow

try {
    # Load environment variables
    $envPath = Join-Path $PSScriptRoot "..\..\.env"
    $envContent = Get-Content $envPath
    $envVars = @{}
    
    foreach ($line in $envContent) {
        if ($line -match '^([^=]+)=(.*)$') {
            $key = $matches[1]
            $value = $matches[2]
            $envVars[$key] = $value
        }
    }
    
    # Test content
    $testContent = @"
graph TD
    A[Start] --> B[Process]
    B --> C[Decision]
    C -->|Yes| D[Action]
    C -->|No| E[End]
    D --> E
    
    style A fill:#e1f5fe
    style B fill:#f3e5f5
    style C fill:#fff3e0
    style D fill:#e8f5e8
    style E fill:#ffebee
"@
    
    $pageTitle = "Template Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $filename = "graph-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
    
    Write-Host "📝 Title: $pageTitle" -ForegroundColor White
    Write-Host "🎨 Type: graph" -ForegroundColor White
    
    # Create the .mmd file content
    $mermaidFile = @"
$testContent
"@
    
    # Ensure test-diagrams directory exists
    $testDiagramsPath = Join-Path $PSScriptRoot "..\..\test-diagrams"
    if (-not (Test-Path $testDiagramsPath)) {
        New-Item -ItemType Directory -Path $testDiagramsPath -Force | Out-Null
        Write-Host "📁 Created test-diagrams directory" -ForegroundColor Green
    }
    
    # Write the .mmd file
    $mmdFilePath = Join-Path $testDiagramsPath "$filename.mmd"
    $mermaidFile | Out-File -FilePath $mmdFilePath -Encoding UTF8
    Write-Host "📄 Created Mermaid file: $filename.mmd" -ForegroundColor Green
    
    # Git operations for automatic upload
    $gitPath = Join-Path $PSScriptRoot "..\.."
    Push-Location $gitPath
    
    try {
        # Add the new file
        git add "test-diagrams/$filename.mmd"
        Write-Host "📝 Added file to git" -ForegroundColor Green
        
        # Commit with descriptive message
        $commitMessage = "Add template-based Mermaid diagram: $pageTitle (graph)"
        git commit -m $commitMessage
        Write-Host "💾 Committed to git" -ForegroundColor Green
        
        # Push to GitHub
        git push
        Write-Host "🚀 Pushed to GitHub successfully!" -ForegroundColor Green
        
    } catch {
        Write-Host "❌ Git operations failed: $($_.Exception.Message)" -ForegroundColor Red
        throw
    } finally {
        Pop-Location
    }
    
    # Create Confluence page using the working template structure
    $pageContent = @"
<h2>🎯 $pageTitle</h2>
<p>This page contains an embedded Mermaid diagram generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss').</p>

<h3>📊 Diagram Details:</h3>
<ul>
<li><strong>Type:</strong> graph</li>
<li><strong>Filename:</strong> $filename.mmd</li>
<li><strong>Repository:</strong> GitHub (wellmindhealth/FKmermaid)</li>
<li><strong>Path:</strong> test-diagrams/$filename.mmd</li>
<li><strong>GitHub URL:</strong> <a href="https://github.com/wellmindhealth/FKmermaid/blob/master/test-diagrams/$filename.mmd" target="_blank" rel="noopener noreferrer">View on GitHub</a></li>
</ul>

<h3>🎨 Embedded Diagram:</h3>
<p><em>To view this diagram, please:</em></p>
<ol>
<li>Install the <strong>Stratus Add-ons for Confluence</strong> from the Atlassian Marketplace</li>
<li>In the Stratus add-on configuration, connect your GitHub account via OAuth</li>
<li>Use the GitHub Repository Explorer (GRE) to navigate to: <code>wellmindhealth/FKmermaid/test-diagrams/</code></li>
<li>Select the file: <code>$filename.mmd</code></li>
</ol>

<h3>📋 Diagram Source:</h3>
<pre><code>$testContent</code></pre>

<hr>
<p><em>Generated automatically on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>
<p><em>Template-based approach to avoid CSP restrictions</em></p>
"@
    
    # Create the Confluence page with parent page ID
    $parentPageId = $envVars.CONFLUENCE_PAGE_ID
    
    # Basic auth for Confluence API
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($envVars.CONFLUENCE_USER):$($envVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $body = @{
        type = "page"
        title = $pageTitle
        space = @{
            key = "SD"
        }
        body = @{
            storage = @{
                value = $pageContent
                representation = "storage"
            }
        }
    }
    
    if ($parentPageId) {
        $body.ancestors = @(@{
            id = $parentPageId
        })
    }
    
    $url = "$($envVars.CONFLUENCE_BASE_URL)/rest/api/content"
    
    Write-Host "📄 Creating Confluence page..." -ForegroundColor Cyan
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
    
    Write-Host "🎉 Template-based Mermaid Page Created!" -ForegroundColor Green
    Write-Host "📄 Page ID: $($response.id)" -ForegroundColor Cyan
    Write-Host "🔗 URL: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
    Write-Host "📁 GitHub: https://github.com/wellmindhealth/FKmermaid/blob/master/test-diagrams/$filename.mmd" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Template-based Mermaid page creation failed: $($_.Exception.Message)" -ForegroundColor Red
} 