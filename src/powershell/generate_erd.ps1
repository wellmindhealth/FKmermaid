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

# Get comprehensive entity list from CFC scanning with domain emphasis
$allEntities = @()
$domainEntities = @()
$focusDomainEntities = @()

# Define exclude patterns for CFC scanning
$excludePatterns = '^(mud|microdsoft|microsoft|test|shop|order|xealth|ldap|module|participant|rule|dont|freshbooks)'

# Get plugins root path
function Get-PluginsRoot {
    param([string]$startDir)
    $dir = Get-Item $startDir
    while($dir -and -not (Test-Path (Join-Path $dir.FullName 'plugins'))){
        $dir = $dir.Parent
    }
    if($dir){ return (Join-Path $dir.FullName 'plugins') }
    throw "Cannot locate 'plugins' folder up from $startDir"
}

$pluginsRoot = Get-PluginsRoot -startDir $PSScriptRoot
$typesPath = Join-Path $pluginsRoot 'pathway\packages\types'

# Scan CFC files for entities (base entities)
if (Test-Path $typesPath) {
    Get-ChildItem -Path $typesPath -Filter *.cfc -Recurse | ForEach-Object { 
        if($_.BaseName -notmatch $excludePatterns){ 
            $allEntities += $_.BaseName 
        } 
    }
}

# Add entities from domain config with emphasis
if ($lDomains -and $lDomains.Count -gt 0) {
    $domainConfigPath = Join-Path $ProjectRoot "config\domains.json"
    if (Test-Path $domainConfigPath) {
        $domainConfig = Get-Content $domainConfigPath | ConvertFrom-Json
        
        foreach ($domainName in $lDomains) {
            if ($domainConfig.domains.$domainName) {
                $domain = $domainConfig.domains.$domainName
                foreach ($entityGroup in $domain.entities.PSObject.Properties) {
                    $domainEntities += $entityGroup.Value
                    # Add focus domain entities multiple times for emphasis
                    if ($domainName -eq $lDomains[0]) {
                        $focusDomainEntities += $entityGroup.Value
                        $focusDomainEntities += $entityGroup.Value  # Double emphasis
                    }
                }
            }
        }
    }
}

# Combine entities with emphasis: focus entity first, then focus domain, then other domains, then base entities
$orderedEntities = @()
$orderedEntities += $FocusEntity  # Focus entity gets highest priority
$orderedEntities += $focusDomainEntities | Sort-Object -Unique  # Focus domain entities
$orderedEntities += $domainEntities | Sort-Object -Unique  # Other domain entities  
$orderedEntities += $allEntities | Sort-Object -Unique  # Base entities from CFC scanning

# Remove duplicates while preserving order
$allEntities = $orderedEntities | Select-Object -Unique

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
    # Use erDiagram for proper ER layout with sophisticated relationships
    $mermaidLines += "erDiagram"
    $mermaidLines += "    %% ER diagram with hub-and-spoke layout and detailed relationships"
    $mermaidLines += "    %% Focus entity with proper cardinality and relationship labels"
} else {
    $mermaidLines += "classDiagram"
    $mermaidLines += "    %% Sophisticated class diagram with detailed properties and stereotypes"
    $mermaidLines += "    %% Focus entity with comprehensive relationship mapping"
}

# Add entities with proper ER/Class diagram syntax
if ($DiagramType -eq "ER") {
    # Add all entities in ER diagram format
    foreach ($entity in $orderedEntities) {
        $mermaidLines += "    $entity"
    }
} else {
    # Add all entities in class diagram format with stereotypes and detailed properties
    foreach ($entity in $orderedEntities) {
        $mermaidLines += "    class $entity"
        
        # Add stereotypes for all entities based on gold standard patterns
        if ($entity -eq $focusEntity) {
            $mermaidLines += "    $entity : <<Focus Entity>>"
        } elseif ($entity -match "activityDef") {
            $mermaidLines += "    $entity : <<Farcry Activity Definition>>"
        } elseif ($entity -match "activity") {
            $mermaidLines += "    $entity : <<Activity Instance>>"
        } elseif ($entity -match "member") {
            $mermaidLines += "    $entity : <<Member>>"
        } elseif ($entity -match "progMember") {
            $mermaidLines += "    $entity : <<Program Member>>"
        } elseif ($entity -match "programme") {
            $mermaidLines += "    $entity : <<Programme>>"
        } elseif ($entity -match "trackerDef") {
            $mermaidLines += "    $entity : <<Tracker Definition>>"
        } elseif ($entity -match "journalDef") {
            $mermaidLines += "    $entity : <<Journal Definition>>"
        } elseif ($entity -match "media") {
            $mermaidLines += "    $entity : <<Media>>"
        } elseif ($entity -match "guide") {
            $mermaidLines += "    $entity : <<Guide>>"
        } elseif ($entity -match "partner") {
            $mermaidLines += "    $entity : <<Partner>>"
        } elseif ($entity -match "memberGroup") {
            $mermaidLines += "    $entity : <<Member Group>>"
        } elseif ($entity -match "referer") {
            $mermaidLines += "    $entity : <<Referrer>>"
        } elseif ($entity -match "testimonial") {
            $mermaidLines += "    $entity : <<Testimonial Instance>>"
        } elseif ($entity -match "ruleSelfRegistration") {
            $mermaidLines += "    $entity : <<Self-Registration Form>>"
        } elseif ($entity -match "aInteract") {
            $mermaidLines += "    $entity : <<Interact Activities>>"
        } elseif ($entity -match "SSQ_HUB") {
            $mermaidLines += "    $entity : <<SSQ Hub>>"
        } elseif ($entity -match "SSQ_") {
            $mermaidLines += "    $entity : <<$entity>>"
        }
    }
    
    # Add detailed class definition for focus entity if it's activityDef
    if ($focusEntity -match "activityDef") {
        $mermaidLines += "    class activityDef {"
        $mermaidLines += "        <<Farcry Activity Definition>>"
        $mermaidLines += "        %% Core Properties %%"
        $mermaidLines += "        +programmeID"
        $mermaidLines += "        +teaserImage"
        $mermaidLines += "        +guideID"
        $mermaidLines += "        +role"
        $mermaidLines += "        +onEndID"
        $mermaidLines += "        +defaultMediaID"
        $mermaidLines += "        +aCuePointActivities"
        $mermaidLines += "        +aMediaIDs"
        $mermaidLines += "        +journalID"
        $mermaidLines += "        %% Tracker IDs %%"
        $mermaidLines += "        +tracker01ID"
        $mermaidLines += "        +tracker02ID"
        $mermaidLines += "        +tracker03ID"
        $mermaidLines += "        +tracker04ID"
        $mermaidLines += "        +tracker05ID"
        $mermaidLines += "        %% Interact Activities %%"
        $mermaidLines += "        +aInteract1Activities"
        $mermaidLines += "        +aInteract2Activities"
        $mermaidLines += "        +aInteract3Activities"
        $mermaidLines += "        +aInteract4Activities"
        $mermaidLines += "        +aInteract5Activities"
        $mermaidLines += "    }"
    }
}

# Add relationships with sophisticated mapping based on gold standard patterns
$mermaidLines += ""
$mermaidLines += "    %% Sophisticated relationships with proper labels and cardinality"

if ($DiagramType -eq "ER") {
    # ER diagram relationships with proper cardinality and detailed labels
    $relatedEntities = $orderedEntities | Where-Object { $_ -ne $focusEntity }
    foreach ($entity in $relatedEntities) {
        # Create sophisticated relationship labels based on gold standard patterns
        $relationshipLabel = "related to"
        $cardinality = "}o--||"
        
        # Focus entity specific relationships
        if ($focusEntity -match "activityDef") {
            if ($entity -match "trackerDef") {
                $relationshipLabel = "tracker01ID"
            } elseif ($entity -match "activityDef") {
                $relationshipLabel = "onEndID"
            } elseif ($entity -match "media") {
                $relationshipLabel = "defaultMediaID"
            } elseif ($entity -match "programme") {
                $relationshipLabel = "programmeID"
            } elseif ($entity -match "dmImage") {
                $relationshipLabel = "teaserImage"
            } elseif ($entity -match "guide") {
                $relationshipLabel = "guideID"
            } elseif ($entity -match "progRole") {
                $relationshipLabel = "role"
            } elseif ($entity -match "journalDef") {
                $relationshipLabel = "journalID"
            } elseif ($entity -match "aInteract") {
                $relationshipLabel = $entity
            }
        } elseif ($focusEntity -match "activity") {
            if ($entity -match "activityDef") {
                $relationshipLabel = "activityDefID"
            }
        } elseif ($focusEntity -match "programme") {
            if ($entity -match "partner") {
                $relationshipLabel = "partnerID"
            } elseif ($entity -match "activityDef") {
                $relationshipLabel = "firstActivityDefID"
            } elseif ($entity -match "trackerDef") {
                $relationshipLabel = "aTrackerIDs"
            } elseif ($entity -match "dmFile") {
                $relationshipLabel = "aObjectIDs"
            }
        }
        
        $mermaidLines += "    $focusEntity $cardinality $entity : `"$relationshipLabel`""
    }
} else {
    # Class diagram relationships with detailed labels
    $relatedEntities = $orderedEntities | Where-Object { $_ -ne $focusEntity }
    foreach ($entity in $relatedEntities) {
        # Create sophisticated relationship labels based on gold standard patterns
        $relationshipLabel = "related to"
        
        # Focus entity specific relationships
        if ($focusEntity -match "activityDef") {
            if ($entity -match "trackerDef") {
                $relationshipLabel = "tracker01ID"
            } elseif ($entity -match "activityDef") {
                $relationshipLabel = "onEndID"
            } elseif ($entity -match "media") {
                $relationshipLabel = "defaultMediaID"
            } elseif ($entity -match "programme") {
                $relationshipLabel = "programmeID"
            } elseif ($entity -match "dmImage") {
                $relationshipLabel = "teaserImage"
            } elseif ($entity -match "guide") {
                $relationshipLabel = "guideID"
            } elseif ($entity -match "progRole") {
                $relationshipLabel = "role"
            } elseif ($entity -match "journalDef") {
                $relationshipLabel = "journalID"
            } elseif ($entity -match "aInteract") {
                $relationshipLabel = $entity
            }
        } elseif ($focusEntity -match "activity") {
            if ($entity -match "activityDef") {
                $relationshipLabel = "activityDefID"
            }
        } elseif ($focusEntity -match "programme") {
            if ($entity -match "partner") {
                $relationshipLabel = "partnerID"
            } elseif ($entity -match "activityDef") {
                $relationshipLabel = "firstActivityDefID"
            } elseif ($entity -match "trackerDef") {
                $relationshipLabel = "aTrackerIDs"
            } elseif ($entity -match "dmFile") {
                $relationshipLabel = "aObjectIDs"
            }
        }
        
        $mermaidLines += "    $focusEntity -- $entity : $relationshipLabel"
    }
}

# Add sophisticated styling matching gold standard patterns
$mermaidLines += ""
$mermaidLines += "    %% Gold standard styling with proper color hierarchy"

# Core entities get high emphasis (blue, 4px border) - matching gold standard
$coreEntities = @("member", "progMember", "activity", "activityDef", "programme", "journal")
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity -and $coreEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff"
    }
}

# Tracker entities get special emphasis (green, 4px border)
$trackerEntities = @("tracker", "trackerDef")
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity -and $trackerEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#43a047,stroke:#fff,stroke-width:4px,color:#fff"
    }
}

# Report/Module entities get medium emphasis (green, 3px border)
$reportEntities = @("report", "moduleDef", "module")
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity -and $reportEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#388e3c,stroke:#fff,stroke-width:3px,color:#fff"
    }
}

# SSQ entities get special emphasis (purple, 2px border)
$ssqEntities = @("SSQ_arthritis01", "SSQ_pain01", "SSQ_stress01")
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity -and $ssqEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222"
    }
}

# SSQ_HUB gets special styling (grey, no border)
if ($orderedEntities -contains "SSQ_HUB") {
    $mermaidLines += "    style SSQ_HUB fill:#e0e0e0,stroke:#bdbdbd,stroke-width:0px,color:#333"
}

# Other domain entities get light emphasis (light blue, 2px border)
$otherDomainEntities = $domainEntities | Where-Object { $_ -notin $coreEntities -and $_ -notin $trackerEntities -and $_ -notin $reportEntities -and $_ -notin $ssqEntities -and $_ -ne "SSQ_HUB" } | Sort-Object -Unique
foreach ($entity in $orderedEntities) {
    if ($entity -ne $focusEntity -and $otherDomainEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#42a5f5,stroke:#fff,stroke-width:2px,color:#fff"
    }
}

# Base entities from CFC scanning get default styling (grey, 1px border)
$baseEntities = $allEntities | Where-Object { $_ -notin $domainEntities -and $_ -notin $coreEntities -and $_ -notin $trackerEntities -and $_ -notin $reportEntities -and $_ -notin $ssqEntities -and $_ -ne "SSQ_HUB" -and $_ -ne $focusEntity }
foreach ($entity in $orderedEntities) {
    if ($baseEntities -contains $entity) {
        $mermaidLines += "    style $entity fill:#9e9e9e,stroke:#fff,stroke-width:1px,color:#fff"
    }
}

# Write to file
$mermaidLines | Set-Content -Path $outputFile

# Also create an HTML file with embedded diagram as fallback
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
            font-size: 1.4em;
            font-weight: bold;
        }
        h2 {
            margin: 8px 0;
            font-size: 1.1em;
            font-weight: normal;
        }
        h3 {
            margin: 8px 0;
            font-size: 1em;
        }
        h4 {
            margin: 8px 0;
            font-size: 0.9em;
            font-weight: bold;
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
        <h1>$FocusEntity</h1>
        <h2>$FocusEntity | $($lDomains -join ', ') 'focus'</h2>
        <h3>$DiagramType Diagram</h3>
        <div class="instructions">
            <h4>Quick Steps</h4>
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
                
                // Open Mermaid Live Editor in new tab
                window.open('https://mermaid.live/edit', '_blank');
                
                // Show paste reminder
                showPasteReminder();
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
                    
                    // Open Mermaid Live Editor in new tab
                    window.open(editorUrl, '_blank');
                    
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
        mermaid.initialize({ 
            startOnLoad: true,
            er: {
                layoutDirection: 'LR',
                minEntityWidth: 80,
                minEntityHeight: 30,
                entitySpacing: 80,
                relationshipSpacing: 50,
                layoutPadding: 40,
                useMaxWidth: false
            },
            flowchart: {
                useMaxWidth: false,
                htmlLabels: true,
                direction: 'LR',
                nodeSpacing: 200,
                rankSpacing: 150,
                curve: 'basis'
            }
        });
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

# Open the local HTML file (most reliable method)
Write-Host "Generated diagram successfully!"
Write-Host "`nFiles created:"
Write-Host "   - Mermaid source: $outputFile"
Write-Host "`nOpening local HTML viewer..."

# Use Invoke-Item to open with system default browser
Invoke-Item $htmlFile

Write-Host "Opened diagram viewer: $htmlFile"
Write-Host "Use the copy button to copy the diagram code, then paste into Mermaid Live Editor." 