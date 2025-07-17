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
$timestamp = Get-Date -Format "yyyyMMddHHmmss"
$outputFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).mmd"
$htmlFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower())_$timestamp.html"

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
$diagramTitle = if ($DiagramType -eq "ER") { "ER Diagram" } else { "Class Diagram" }
$mermaidContentForHtml = $mermaidLines -join "`n"

# Create HTML file that uses clipboard approach for Mermaid Live Editor
$mermaidLiveHtml = @"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>$FocusEntity $diagramTitle - Mermaid Live Editor</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 0;
            padding: 0;
            height: 100vh;
            background: #f5f5f5;
        }
        .left-panel {
            width: 15%;
            min-width: 250px;
            padding: 12px;
            background: white;
            font-size: 12px;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            bottom: 0;
            overflow-y: auto;
        }
        .code-block {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-family: monospace;
            white-space: pre-wrap;
            margin: 8px 0;
            font-size: 12px;
            max-height: 60vh;
            overflow-y: auto;
            width: 100%;
            box-sizing: border-box;
            cursor: text;
            user-select: text;
        }
        .code-block:hover {
            border-color: #2196F3;
        }
        .button {
            background: #2196F3;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
            margin: 4px 0;
            white-space: nowrap;
            width: 100%;
            text-align: center;
            text-decoration: none;
            display: block;
            box-sizing: border-box;
        }
        .button:hover {
            background: #1976D2;
        }
        .success-message {
            display: none;
            color: #4CAF50;
            margin: 4px 0;
            font-size: 12px;
            padding: 4px;
            background: #E8F5E9;
            border-radius: 4px;
            text-align: center;
        }
        .error-message {
            display: none;
            color: #FF9800;
            margin: 4px 0;
            font-size: 12px;
            padding: 4px;
            background: #FFF3E0;
            border-radius: 4px;
            text-align: center;
        }
        h1 { 
            margin: 0 0 8px 0; 
            font-size: 1.2em;
        }
        h3 {
            margin: 8px 0;
            font-size: 1em;
        }
        .instructions {
            background: #e3f2fd;
            padding: 8px;
            border-radius: 4px;
            margin: 8px 0;
            font-size: 12px;
        }
        #paste-reminder {
            display: none;
            position: fixed;
            top: 20px;
            right: 20px;
            background: #E3F2FD;
            padding: 12px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
            z-index: 1000;
            font-size: 14px;
            animation: fadeInOut 5s forwards;
        }
        @keyframes fadeInOut {
            0% { opacity: 0; }
            10% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>
</head>
<body>
    <div class="left-panel">
        <h1>$FocusEntity $diagramTitle</h1>
        <div class="instructions">
            <h3>Quick Steps</h3>
            <ol>
                <li>Click "Open Editor & Copy"</li>
                <li>Wait for editor to load</li>
                <li>Press Ctrl+V to paste</li>
            </ol>
        </div>
        <button class="button" onclick="openEditorAndCopy()">Open Editor & Copy</button>
        <div id="copySuccess" class="success-message">✓ Code copied! Press Ctrl+V to paste</div>
        <div id="copyError" class="error-message">Failed to copy code. Please select and copy manually.</div>
        <button class="button" onclick="manualCopy()" style="background: #FF9800; margin-top: 8px;">📋 Manual Copy Only</button>
        <button class="button" onclick="showDebugInfo()" style="background: #9C27B0; margin-top: 4px;">🐛 Debug Info</button>
        <div class="code-block" id="mermaidSource">$mermaidContentForHtml</div>
    </div>

    <div id="paste-reminder">
        Press Ctrl+V to paste your diagram code!
    </div>

    <script>
    function showPasteReminder() {
        const reminder = document.getElementById('paste-reminder');
        reminder.style.display = 'block';
        setTimeout(() => {
            reminder.style.display = 'none';
        }, 5000);
    }

    function openEditorAndCopy() {
        // Get the code from the div instead of using a template string
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        
        console.log('Attempting to copy:', mermaidContent.substring(0, 100) + '...');
        console.log('Full content length:', mermaidContent.length);
        
        // Try modern clipboard API first
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(mermaidContent).then(() => {
                console.log('Clipboard API success');
                // Show success message
                const msg = document.getElementById('copySuccess');
                msg.style.display = 'block';
                setTimeout(() => msg.style.display = 'none', 3000);
                
                // Calculate window position and size
                const leftPanel = document.querySelector('.left-panel');
                const leftWidth = Math.max(leftPanel.offsetWidth, 250);
                const windowWidth = window.innerWidth - leftWidth;
                const windowHeight = window.innerHeight;
                
                // Open editor in new window
                const editorUrl = 'https://mermaid.live/edit';
                const windowFeatures = 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + leftWidth + ',top=0,menubar=no,toolbar=no,location=no,status=no,scrollbars=yes,resizable=yes';
                
                console.log('Opening editor with features:', windowFeatures);
                const editorWindow = window.open(editorUrl, '_blank', windowFeatures);
                
                if (editorWindow) {
                    console.log('Editor window opened successfully');
                    // Show paste reminder
                    showPasteReminder();
                } else {
                    console.error('Failed to open editor window');
                    alert('Failed to open editor window. Please check popup blocker settings.');
                }
            }).catch(err => {
                console.error('Clipboard API failed:', err);
                showCopyError();
            });
        } else {
            console.log('Using fallback copy method');
            fallbackCopy();
        }
        
        function fallbackCopy() {
            try {
                const textArea = document.createElement('textarea');
                textArea.value = mermaidContent;
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
                    const msg = document.getElementById('copySuccess');
                    msg.style.display = 'block';
                    msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                    setTimeout(() => msg.style.display = 'none', 3000);
                    
                    // Open editor with URL parameters
                    const editorUrl = 'https://mermaid.live/edit';
                    
                    const leftPanel = document.querySelector('.left-panel');
                    const leftWidth = Math.max(leftPanel.offsetWidth, 250);
                    const windowWidth = window.innerWidth - leftWidth;
                    const windowHeight = window.innerHeight;
                    
                    const editorWindow = window.open(editorUrl, '_blank', 'width=' + windowWidth + ',height=' + windowHeight + ',left=' + leftWidth + ',top=0,menubar=no,toolbar=no,location=no,status=no,scrollbars=yes,resizable=yes');
                    
                    setTimeout(showPasteReminder, 1000);
                } else {
                    console.log('execCommand failed');
                    showCopyError();
                }
            } catch (err) {
                console.error('execCommand error:', err);
                showCopyError();
            }
        }

        function showCopyError() {
            const msg = document.getElementById('copyError');
            msg.style.display = 'block';
            setTimeout(() => msg.style.display = 'none', 5000);
        }
    }

    function manualCopy() {
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        if (navigator.clipboard && navigator.clipboard.writeText) {
            navigator.clipboard.writeText(mermaidContent).then(() => {
                const msg = document.getElementById('copySuccess');
                msg.style.display = 'block';
                msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                setTimeout(() => msg.style.display = 'none', 3000);
                console.log('Manual copy successful via Clipboard API');
            }).catch(err => {
                const msg = document.getElementById('copyError');
                msg.style.display = 'block';
                msg.textContent = 'Failed to copy code. Please select and copy manually.';
                setTimeout(() => msg.style.display = 'none', 5000);
                console.error('Manual copy failed via Clipboard API:', err);
            });
        } else {
            try {
                const textArea = document.createElement('textarea');
                textArea.value = mermaidContent;
                textArea.style.position = 'fixed';
                textArea.style.left = '-999999px';
                textArea.style.top = '-999999px';
                document.body.appendChild(textArea);
                textArea.focus();
                textArea.select();
                const successful = document.execCommand('copy');
                document.body.removeChild(textArea);
                if (successful) {
                    const msg = document.getElementById('copySuccess');
                    msg.style.display = 'block';
                    msg.textContent = '✓ Code copied! Press Ctrl+V to paste';
                    setTimeout(() => msg.style.display = 'none', 3000);
                    console.log('Manual copy successful via execCommand');
                } else {
                    const msg = document.getElementById('copyError');
                    msg.style.display = 'block';
                    msg.textContent = 'Failed to copy code. Please select and copy manually.';
                    setTimeout(() => msg.style.display = 'none', 5000);
                    console.log('Manual copy failed via execCommand');
                }
            } catch (err) {
                const msg = document.getElementById('copyError');
                msg.style.display = 'block';
                msg.textContent = 'Failed to copy code. Please select and copy manually.';
                setTimeout(() => msg.style.display = 'none', 5000);
                console.error('Manual copy failed via execCommand:', err);
            }
        }
    }

    function showDebugInfo() {
        const mermaidContent = document.getElementById('mermaidSource').textContent;
        console.log('=== DEBUG INFO ===');
        console.log('Content length:', mermaidContent.length);
        console.log('First 200 chars:', mermaidContent.substring(0, 200));
        console.log('Last 100 chars:', mermaidContent.substring(mermaidContent.length - 100));
        console.log('Contains "erDiagram":', mermaidContent.includes('erDiagram'));
        console.log('Contains "classDiagram":', mermaidContent.includes('classDiagram'));
        console.log('Full content:');
        console.log(mermaidContent);
        
        // Show in an alert for easy viewing
        alert('Content length: ' + mermaidContent.length + '\n\nFirst 200 chars:\n' + mermaidContent.substring(0, 200) + '\n\nContains erDiagram: ' + mermaidContent.includes('erDiagram'));
    }

    // Handle window resize
    window.addEventListener('resize', () => {
        const editorWindow = window.open('', 'mermaidEditor');
        if (editorWindow && !editorWindow.closed) {
            const leftPanel = document.querySelector('.left-panel');
            const leftWidth = Math.max(leftPanel.offsetWidth, 250);
            editorWindow.resizeTo(window.innerWidth - leftWidth, window.innerHeight);
            editorWindow.moveTo(leftWidth, 0);
        }
    });
    </script>
</body>
</html>
"@

$mermaidLiveHtml | Set-Content -Path $htmlFile

# Clean up old HTML files
Get-ChildItem -Path (Join-Path $ProjectRoot "exports") -Filter "*_focus_*_*.html" | 
    Where-Object { $_.Name -ne (Split-Path $htmlFile -Leaf) } |
    Where-Object { $_.LastWriteTime -lt (Get-Date).AddHours(-1) } |
    Remove-Item -Force

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
            <div style="background: #f0f0f0; padding: 20px; text-align: center; border-radius: 5px;">
                <h3>Mermaid Live Editor</h3>
                <p>Click the button below to copy the diagram code, then:</p>
                <ol style="text-align: left; display: inline-block;">
                    <li>Click "Open Mermaid Live Editor" (opens in new tab)</li>
                    <li>Paste the copied code (Ctrl+V)</li>
                    <li>Your diagram will appear!</li>
                </ol>
                <br>
                <a href="https://mermaid.live/edit" target="_blank" class="button" style="font-size: 16px; padding: 15px 25px;">🚀 Open Mermaid Live Editor</a>
            </div>
        </div>
    </div>
    
    <script>
        // Get the code from the visible div instead of template string
        const diagramCodeDiv = document.querySelector('.code');
        const mermaidContent = diagramCodeDiv ? diagramCodeDiv.textContent : '';
        
        // Copy to clipboard as backup
        if (navigator.clipboard) {
            navigator.clipboard.writeText(mermaidContent);
        }

        function copyDiagramToClipboard() {
            console.log('Copy button clicked');
            
            // Get the diagram code from the visible div
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
                    copyStatusDiv.textContent = '✓ Diagram code copied to clipboard!';
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
Write-Host "`nFiles created:"
Write-Host "   - Mermaid source: $outputFile"
Write-Host "`nOpening local HTML viewer..."

# Use Invoke-Item to open with system default browser
Invoke-Item $htmlFile

Write-Host "Opened diagram viewer: $htmlFile"
Write-Host "Use the copy button to copy the diagram code, then paste into Mermaid Live Editor." 