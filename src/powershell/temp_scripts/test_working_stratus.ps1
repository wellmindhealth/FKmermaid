# Test Working Stratus Macro Generation
Write-Host "🎯 Testing working Stratus macro generation..." -ForegroundColor Yellow

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
    
    $pageTitle = "Working Stratus Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
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
        $commitMessage = "Add working Stratus test: $pageTitle (graph)"
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
    
    # Generate the EXACT same HTML structure as the working manual page
    $iframeId = "com.stratusaddons.confluence.plugins.mermaid__mermaid-cloud__$(Get-Random)"
    $macroId = "b2a41f59-26dc-4bbf-9f23-081eafc82a00"
    $localId = "8e72b43d-e500-4b99-b25c-037b11cd8711"
    
    # This is the EXACT structure from your working manual page
    $stratusMacro = @"
<div class="ak-renderer-extension  " data-layout="default" style="width: 100%;">
    <div class="ak-renderer-extension-overflow-container">
        <div style="display: none;"></div>
        <span></span>
        <div class="_o5724jg8 _11rm1hrf _5xln4jg8 _1v0sze3t _tmbuze3t _og5autpp _oxx4utpp" 
             data-fabric-macro="$macroId" 
             data-macro-body="" 
             data-macro-parameters="{&quot;toolbar&quot;:&quot;bottom&quot;,&quot;filename&quot;:&quot;$filename&quot;,&quot;zoom&quot;:&quot;fit&quot;,&quot;revision&quot;:&quot;1&quot;}" 
             data-testid="legacy-macro-element" 
             data-vc="legacy-macro-element_mermaid-cloud" 
             data-vc-ignore-if-no-layout-shift="true" 
             data-ssr-placeholder-replace="$macroId">
            <div class="ap-container conf-macro output-block" 
                 id="ap-com.stratusaddons.confluence.plugins.mermaid__mermaid-cloud2850482869319606122" 
                 data-hasbody="false" 
                 data-macro-name="mermaid-cloud" 
                 data-macro-id="$macroId" 
                 data-layout="default" 
                 data-local-id="$localId">
                <div class="ap-content " id="embedded-com.stratusaddons.confluence.plugins.mermaid__mermaid-cloud2850482869319606122"> 
                    <div class="ap-iframe-container iframe-init" id="embedded-com.stratusaddons.confluence.plugins.mermaid__mermaid-cloud__3a5ee747">
                        <iframe id="$iframeId" 
                                name="{&quot;extension_id&quot;:&quot;$iframeId&quot;,&quot;api&quot;:{&quot;_globals&quot;:{&quot;request&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;messages&quot;:{&quot;clear&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;onClose&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;generic&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}},&quot;error&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}},&quot;warning&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}},&quot;success&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}},&quot;info&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}},&quot;hint&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;n&quot;,&quot;r&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false}}},&quot;flag&quot;:{&quot;create&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;close&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false}}},&quot;dialog&quot;:{&quot;create&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;close&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;getCustomData&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;getButton&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;enable&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;disable&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;toggle&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;isEnabled&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;trigger&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;hide&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;show&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;isHidden&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false}},&quot;createButton&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}}},&quot;inlineDialog&quot;:{&quot;hide&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false}},&quot;env&quot;:{&quot;getLocation&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;resize&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;,&quot;n&quot;],&quot;returnsPromise&quot;:false},&quot;sizeToParent&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;hideFooter&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false}},&quot;events&quot;:{&quot;emit&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;emitPublic&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;emitToDataProvider&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false}},&quot;_analytics&quot;:{&quot;trackDeprecatedMethodUsed&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;trackIframePerformanceMetrics&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;trackWebVitals&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;scrollPosition&quot;:{&quot;getPosition&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;setVerticalPosition&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;dropdown&quot;:{&quot;create&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;showAt&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;,&quot;n&quot;,&quot;r&quot;],&quot;returnsPromise&quot;:false},&quot;hide&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;itemDisable&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;itemEnable&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;host&quot;:{&quot;focus&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;getSelectedText&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false}},&quot;theming&quot;:{&quot;initializeTheming&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;_finishedInitTheming&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false}},&quot;page&quot;:{&quot;setTitle&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;cookie&quot;:{&quot;erase&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;...n&quot;],&quot;returnsPromise&quot;:false},&quot;read&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;n&quot;],&quot;returnsPromise&quot;:false},&quot;save&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;n&quot;,&quot;t&quot;,&quot;...o&quot;],&quot;returnsPromise&quot;:false}},&quot;history&quot;:{&quot;_registerWindowListeners&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;back&quot;:{&quot;args&quot;:[&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;forward&quot;:{&quot;args&quot;:[&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;go&quot;:{&quot;args&quot;:[&quot;t&quot;],&quot;returnsPromise&quot;:false},&quot;getState&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;pushState&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;replaceState&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;],&quot;returnsPromise&quot;:false}},&quot;navigator&quot;:{&quot;getLocation&quot;:{&quot;args&quot;:[&quot;o&quot;],&quot;returnsPromise&quot;:false},&quot;go&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;n&quot;,&quot;a&quot;],&quot;returnsPromise&quot;:false},&quot;_shouldThrottle&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;o&quot;],&quot;returnsPromise&quot;:false},&quot;reload&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false}},&quot;user&quot;:{&quot;getUser&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;getCurrentUser&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;getTimeZone&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;getLocale&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false}},&quot;context&quot;:{&quot;getToken&quot;:{&quot;args&quot;:[&quot;t&quot;],&quot;returnsPromise&quot;:true},&quot;getContext&quot;:{&quot;args&quot;:[&quot;t&quot;],&quot;returnsPromise&quot;:true}},&quot;confluence&quot;:{&quot;saveMacro&quot;:{&quot;args&quot;:[&quot;a&quot;,&quot;i&quot;],&quot;returnsPromise&quot;:false},&quot;closeMacroEditor&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;getMacroData&quot;:{&quot;args&quot;:[&quot;o&quot;],&quot;returnsPromise&quot;:false},&quot;getMacroBody&quot;:{&quot;args&quot;:[&quot;o&quot;],&quot;returnsPromise&quot;:false},&quot;onMacroPropertyPanelEvent&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;closeMacroPropertyPanel&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;getContentProperty&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;setContentProperty&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;r&quot;],&quot;returnsPromise&quot;:false},&quot;syncPropertyFromServer&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;getContentPropertyV2&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;syncPropertyFromServerV2&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;postPropertyToServerV2&quot;:{&quot;args&quot;:[&quot;t&quot;,&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;updatePropertyToServerV2&quot;:{&quot;args&quot;:[&quot;e&quot;,&quot;t&quot;,&quot;o&quot;],&quot;returnsPromise&quot;:false}},&quot;custom-content&quot;:{&quot;getEditComponent&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;intercept&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;submitCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;submitErrorCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;submitSuccessCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;cancelCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false}}},&quot;customContent&quot;:{&quot;getEditComponent&quot;:{&quot;constructor&quot;:{&quot;args&quot;:[],&quot;returnsPromise&quot;:false},&quot;intercept&quot;:{&quot;args&quot;:[&quot;e&quot;],&quot;returnsPromise&quot;:false},&quot;submitCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;submitErrorCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;submitSuccessCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false},&quot;cancelCallback&quot;:{&quot;args&quot;:[&quot;o&quot;,&quot;c&quot;],&quot;returnsPromise&quot;:false}}},&quot;dataProvider&quot;:{&quot;emitToDataProvider&quot;:false}}"
                                width="100%"
                                height="1px"
                                src="about:blank"
                                sandbox="allow-downloads allow-forms allow-modals allow-popups allow-popups-to-escape-sandbox allow-scripts allow-same-origin allow-top-navigation-by-user-activation allow-storage-access-by-user-activation"
                                referrerpolicy="no-referrer"
                                class="ap-iframe"
                                style="width: 100%; height: 400px;">
                        </iframe>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
"@
    
    # Create Confluence page with the working Stratus macro
    $pageContent = @"
<h2>🎯 $pageTitle</h2>
<p>This page contains a working embedded Mermaid diagram generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss').</p>

<h3>📊 Diagram Details:</h3>
<ul>
<li><strong>Type:</strong> graph</li>
<li><strong>Filename:</strong> $filename.mmd</li>
<li><strong>Repository:</strong> GitHub (wellmindhealth/FKmermaid)</li>
<li><strong>Path:</strong> test-diagrams/$filename.mmd</li>
<li><strong>GitHub URL:</strong> <a href="https://github.com/wellmindhealth/FKmermaid/blob/master/test-diagrams/$filename.mmd" target="_blank" rel="noopener noreferrer">View on GitHub</a></li>
</ul>

<h3>🎨 Embedded Diagram:</h3>
$stratusMacro

<h3>📋 Diagram Source:</h3>
<pre><code>$testContent</code></pre>

<hr>
<p><em>Generated automatically on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</em></p>
<p><em>Using exact working Stratus macro structure</em></p>
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
    
    Write-Host "📄 Creating Confluence page with working Stratus macro..." -ForegroundColor Cyan
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
    
    Write-Host "🎉 Working Stratus Mermaid Page Created!" -ForegroundColor Green
    Write-Host "📄 Page ID: $($response.id)" -ForegroundColor Cyan
    Write-Host "🔗 URL: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($response.id)" -ForegroundColor Cyan
    Write-Host "📁 GitHub: https://github.com/wellmindhealth/FKmermaid/blob/master/test-diagrams/$filename.mmd" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Working Stratus test failed: $($_.Exception.Message)" -ForegroundColor Red
} 