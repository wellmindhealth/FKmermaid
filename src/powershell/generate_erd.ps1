param(
    [string]$FocusEntity,
    [ValidateSet("ER", "Class")]
    [string]$DiagramType,
    [string[]]$lDomains,
    [bool]$BroadenSpread = $true
)

# Set up paths
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$outputFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).mmd"

# Create exports directory if it doesn't exist
$exportsDir = Join-Path $ProjectRoot "exports"
if (!(Test-Path $exportsDir)) {
    New-Item -Path $exportsDir -ItemType Directory -Force | Out-Null
}

# Overwrite output file
if (Test-Path $outputFile) { Remove-Item $outputFile -Force }
New-Item -Path $outputFile -ItemType File -Force | Out-Null

# Read the domain configuration
$domainConfigPath = Join-Path $ProjectRoot "config\domains.json"
$domainConfig = Get-Content $domainConfigPath | ConvertFrom-Json

# Filter domains based on input
$allEntities = @()
foreach ($domainName in $lDomains) {
    if ($domainConfig.domains.$domainName) {
        $domain = $domainConfig.domains.$domainName
        foreach ($entityGroup in $domain.entities.PSObject.Properties) {
            $allEntities += $entityGroup.Value
        }
    }
}

# Remove duplicates and sort
$allEntities = $allEntities | Sort-Object -Unique

# Find the focus entity and ensure it's first in the list
$focusEntity = $allEntities | Where-Object { $_ -eq $FocusEntity } | Select-Object -First 1
if (!$focusEntity) {
    $focusEntity = $allEntities[0]
}

# Reorder entities to put focus entity first
$orderedEntities = @($focusEntity)
$orderedEntities += $allEntities | Where-Object { $_ -ne $focusEntity }

# Generate Mermaid diagram content
$mermaidLines = @()

if ($DiagramType -eq "ER") {
    $mermaidLines += "erDiagram"
} else {
    $mermaidLines += "classDiagram"
}

# Add entities/classes
foreach ($entity in $orderedEntities) {
    if ($DiagramType -eq "ER") {
        $mermaidLines += "    $entity {"
        $mermaidLines += "        string id"
        $mermaidLines += "        string name"
        $mermaidLines += "    }"
    } else {
        $mermaidLines += "    class $entity {"
        $mermaidLines += "        +String id"
        $mermaidLines += "        +String name"
        $mermaidLines += "    }"
    }
}

# Add relationships (simplified for now)
$mermaidLines += ""
$mermaidLines += "    %% Relationships"
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity) {
        if ($DiagramType -eq "ER") {
            $mermaidLines += "    $focusEntity ||--o{ $entity : `"related to`""
        } else {
            $mermaidLines += "    $focusEntity --> $entity : `"related to`""
        }
    }
}

# Write to file
$mermaidLines | Set-Content -Path $outputFile

# Also create an HTML file with embedded diagram
$htmlFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).html"
$diagramTitle = if ($DiagramType -eq "ER") { "ER Diagram" } else { "Class Diagram" }
$mermaidContentForHtml = $mermaidLines -join "`n"

# Create HTML file that uses clipboard approach for Mermaid Live Editor
$mermaidLiveHtml = @"
<!DOCTYPE html>
<html>
<head>
    <title>$FocusEntity $diagramTitle - Mermaid Live Editor</title>
    <script>
        // Auto-open Mermaid Live Editor with clipboard content
        window.onload = function() {
            const mermaidContent = `$mermaidContentForHtml`;
            
            // Copy content to clipboard
            function copyToClipboard(text) {
                if (navigator.clipboard) {
                    navigator.clipboard.writeText(text).then(() => {
                        console.log('Content copied to clipboard');
                        // Open Mermaid Live Editor after copying
                        window.open('https://mermaid.live/edit', '_blank');
                        document.getElementById('clipboardMethod').style.display = 'block';
                    }).catch(err => {
                        console.error('Failed to copy to clipboard:', err);
                        // Fallback: show manual instructions
                        document.getElementById('manualMethod').style.display = 'block';
                    });
                } else {
                    // Fallback for older browsers
                    const textArea = document.createElement('textarea');
                    textArea.value = text;
                    document.body.appendChild(textArea);
                    textArea.select();
                    document.execCommand('copy');
                    document.body.removeChild(textArea);
                    
                    // Open Mermaid Live Editor
                    window.open('https://mermaid.live/edit', '_blank');
                    document.getElementById('clipboardMethod').style.display = 'block';
                }
            }
            
            // Copy content and open editor
            copyToClipboard(mermaidContent);
        };
    </script>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; }
        .success { color: #4CAF50; font-weight: bold; }
        .warning { color: #FF9800; font-weight: bold; }
        .info { background: #e3f2fd; padding: 15px; border-radius: 5px; margin: 20px 0; }
        .code { background: #f5f5f5; padding: 15px; border-radius: 5px; font-family: monospace; white-space: pre-wrap; }
        #clipboardMethod, #manualMethod { display: none; }
        .button { background: #2196F3; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>$FocusEntity $diagramTitle</h1>
        <p class="success">Copying content to clipboard and opening Mermaid Live Editor...</p>
        
        <div id="clipboardMethod" class="info">
            <h3>Successfully opened Mermaid Live Editor!</h3>
            <p>The Mermaid content has been copied to your clipboard.</p>
            <p>Simply paste (Ctrl+V) into the editor to see your diagram.</p>
        </div>
        
        <div id="manualMethod" class="info">
            <h3>Manual Copy-Paste Method</h3>
            <p>Automatic clipboard copy failed. Please:</p>
            <ol>
                <li>Copy the Mermaid content below</li>
                <li>Go to <a href="https://mermaid.live/edit" target="_blank" class="button">Mermaid Live Editor</a></li>
                <li>Paste the content into the editor</li>
            </ol>
        </div>
        
        <div class="info">
            <h3>Mermaid Content for Copy-Paste</h3>
            <div class="code">$mermaidContentForHtml</div>
        </div>
        
        <div class="info">
            <h3>Generated Files</h3>
            <ul>
                <li><strong>Mermaid Source:</strong> $outputFile</li>
                <li><strong>HTML Launcher:</strong> $htmlFile</li>
                <li><strong>Simple HTML Viewer:</strong> $simpleHtmlFile</li>
            </ul>
        </div>
    </div>
</body>
</html>
"@

$mermaidLiveHtml | Set-Content -Path $htmlFile

# Also create a simple HTML file with embedded diagram as fallback
$simpleHtmlFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower())_simple.html"
$simpleHtmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>$FocusEntity $diagramTitle</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</head>
<body>
    <h1>$FocusEntity $diagramTitle</h1>
    <div class="mermaid">
$mermaidContentForHtml
    </div>
</body>
</html>
"@

$simpleHtmlContent | Set-Content -Path $simpleHtmlFile

# Create HTML file that injects content into Mermaid Live Editor
$injectionHtml = @"
<!DOCTYPE html>
<html>
<head>
    <title>$FocusEntity $diagramTitle - Mermaid Live Editor</title>
    <style>
        body { margin: 0; padding: 0; font-family: Arial, sans-serif; }
        .container { display: flex; height: 100vh; }
        .sidebar { width: 300px; background: #f5f5f5; padding: 20px; overflow-y: auto; }
        .editor { flex: 1; }
        iframe { width: 100%; height: 100%; border: none; }
        .button { background: #2196F3; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 10px 5px; }
        .success { color: #4CAF50; font-weight: bold; }
        .code { background: #f0f0f0; padding: 10px; border-radius: 5px; font-family: monospace; white-space: pre-wrap; font-size: 12px; max-height: 200px; overflow-y: auto; }
    </style>
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>$FocusEntity $diagramTitle</h2>
            <p class="success">Loading Mermaid Live Editor...</p>
            
            <div id="status">
                <p>Attempting to inject content into Mermaid Live Editor...</p>
            </div>
            
            <div id="manual">
                <h3>Manual Method (if auto-injection fails)</h3>
                <p>1. Click the button below to copy the diagram code</p>
                <p>2. Paste into the editor (Ctrl+V)</p>
                <button id="copyButton" onclick="copyDiagramToClipboard()" style="background: #4CAF50; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; margin-bottom: 10px;">📋 Copy Diagram Code</button>
                <div id="copyStatus" style="margin-bottom: 10px;"></div>
                <div class="code">$mermaidContentForHtml</div>
            </div>
            
            <div style="margin-top: 20px;">
                <a href="https://mermaid.live/edit" target="_blank" class="button">Open Mermaid Live Editor</a>
                <a href="$simpleHtmlFile" target="_blank" class="button">View Simple HTML</a>
            </div>
        </div>
        
        <div class="editor">
            <iframe id="mermaidEditor" src="https://mermaid.live/edit"></iframe>
        </div>
    </div>
    
    <script>
        const mermaidContent = `$mermaidContentForHtml`;
        const iframe = document.getElementById('mermaidEditor');
        const status = document.getElementById('status');
        
        // Wait for iframe to load
        iframe.onload = function() {
            try {
                // Try to inject content into the iframe
                const iframeDoc = iframe.contentDocument || iframe.contentWindow.document;
                
                // Look for the code editor
                const codeEditor = iframeDoc.querySelector('textarea, .monaco-editor, #editor');
                if (codeEditor) {
                    codeEditor.value = mermaidContent;
                    codeEditor.dispatchEvent(new Event('input', { bubbles: true }));
                    status.innerHTML = '<p class="success">Content injected successfully!</p>';
                } else {
                    status.innerHTML = '<p>Could not find editor. Please use manual method.</p>';
                }
            } catch (error) {
                status.innerHTML = '<p>Cross-origin restriction. Please use manual method.</p>';
            }
        };
        
        // Copy to clipboard as backup
        if (navigator.clipboard) {
            navigator.clipboard.writeText(mermaidContent);
        }

        function copyDiagramToClipboard() {
            console.log('Copy button clicked');
            
            // Get the diagram code from the visible div instead of template string
            const diagramCodeDiv = document.querySelector('.code');
            const diagramCode = diagramCodeDiv ? diagramCodeDiv.textContent : '';
            
            console.log('Diagram code length:', diagramCode.length);
            console.log('First 100 chars:', diagramCode.substring(0, 100));
            
            const copyStatusDiv = document.getElementById('copyStatus');
            
            if (!diagramCode) {
                copyStatusDiv.textContent = '❌ No diagram code found!';
                copyStatusDiv.style.color = '#FF9800';
                copyStatusDiv.style.fontWeight = 'bold';
                return;
            }
            
            // Try modern clipboard API first
            if (navigator.clipboard && navigator.clipboard.writeText) {
                console.log('Using modern clipboard API');
                navigator.clipboard.writeText(diagramCode).then(() => {
                    console.log('Clipboard API success');
                    copyStatusDiv.textContent = '✅ Diagram code copied to clipboard!';
                    copyStatusDiv.style.color = '#4CAF50';
                    copyStatusDiv.style.fontWeight = 'bold';
                }).catch(err => {
                    console.error('Clipboard API failed:', err);
                    // Fallback to execCommand
                    fallbackCopy();
                });
            } else {
                console.log('Using fallback copy method');
                // Fallback for older browsers
                fallbackCopy();
            }
            
            function fallbackCopy() {
                try {
                    console.log('Using execCommand fallback');
                    const textArea = document.createElement('textarea');
                    textArea.value = diagramCode;
                    textArea.style.position = 'fixed';
                    textArea.style.left = '-999999px';
                    textArea.style.top = '-999999px';
                    document.body.appendChild(textArea);
                    textArea.focus();
                    textArea.select();
                    const successful = document.execCommand('copy');
                    document.body.removeChild(textArea);
                    
                    if (successful) {
                        console.log('execCommand success');
                        copyStatusDiv.textContent = '✅ Diagram code copied to clipboard!';
                        copyStatusDiv.style.color = '#4CAF50';
                        copyStatusDiv.style.fontWeight = 'bold';
                    } else {
                        console.log('execCommand failed');
                        copyStatusDiv.textContent = '❌ Failed to copy. Please select and copy manually.';
                        copyStatusDiv.style.color = '#FF9800';
                        copyStatusDiv.style.fontWeight = 'bold';
                    }
                } catch (err) {
                    console.error('execCommand error:', err);
                    copyStatusDiv.textContent = '❌ Failed to copy. Please select and copy manually.';
                    copyStatusDiv.style.color = '#FF9800';
                    copyStatusDiv.style.fontWeight = 'bold';
                }
            }
        }
    </script>
</body>
</html>
"@

$injectionHtmlFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower())_injection.html"
$injectionHtml | Set-Content -Path $injectionHtmlFile

# Open the local HTML file (most reliable method)
Write-Host "Generated diagram successfully!"
Write-Host ""
Write-Host "Files created:"
Write-Host "   - Mermaid source: $outputFile"
Write-Host "   - Mermaid Live Editor launcher: $htmlFile"
Write-Host "   - Simple HTML viewer: $simpleHtmlFile"
Write-Host "   - Mermaid Live Editor Injection: $injectionHtmlFile"
Write-Host ""

# Copy Mermaid content to clipboard and open Mermaid Live Editor
$mermaidContent = $mermaidLines -join "`n"

# Generate base64 Mermaid Live Editor URL
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($mermaidContentForHtml))
$mermaidUrl = "https://mermaid.live/edit#base64:$base64"

# Also try data URL approach
$dataUrl = "data:text/plain;base64,$base64"
$mermaidDataUrl = "https://mermaid.live/edit#data:$dataUrl"

# Function to shorten URL using v.gd (alternative to is.gd)
function Get-ShortUrl {
    param([string]$LongUrl)
    try {
        $encodedUrl = [System.Web.HttpUtility]::UrlEncode($LongUrl)
        $shortenerUrl = "https://v.gd/create.php?format=json&url=$encodedUrl"
        $response = Invoke-RestMethod -Uri $shortenerUrl -Method Get
        return $response.shorturl
    } catch {
        Write-Host "v.gd shortener failed, trying is.gd..."
        try {
            $encodedUrl = [System.Web.HttpUtility]::UrlEncode($LongUrl)
            $shortenerUrl = "https://is.gd/create.php?format=json&url=$encodedUrl"
            $response = Invoke-RestMethod -Uri $shortenerUrl -Method Get
            return $response.shorturl
        } catch {
            Write-Host "Both URL shorteners failed: $($_.Exception.Message)"
            return $null
        }
    }
}

# Try to open Mermaid Live Editor with different approaches
$opened = $false

# Skip URL methods entirely - they're unreliable due to interstitial pages
# Go straight to the injection HTML method
Write-Host "Using local injection HTML method (most reliable)..."
try {
    Start-Process "chrome.exe" -ArgumentList $injectionHtmlFile -ErrorAction Stop
    Write-Host "Opened Mermaid Live Editor with content injection: $injectionHtmlFile"
    Write-Host "This will attempt to automatically inject the content into Mermaid Live Editor."
    $opened = $true
} catch {
    Write-Host "Failed to open injection HTML. Falling back to clipboard method..."
    try {
        $mermaidContent | Set-Clipboard
        Write-Host "Copied Mermaid content to clipboard!"
        Start-Process "chrome.exe" -ArgumentList "https://mermaid.live/edit" -ErrorAction Stop
        Write-Host "Opened Mermaid Live Editor! Paste (Ctrl+V) your diagram."
    } catch {
        Write-Host "Failed to open browser. Please open manually: $injectionHtmlFile"
    }
} 