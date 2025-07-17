# Test script to verify HTML approach works
$testContent = @"
erDiagram
    progRole {
        string id
        string name
        string description
    }
    activityDef {
        string id
        string name
        string type
    }
    programme {
        string id
        string name
        string status
    }

    %% Relationships
    progRole ||--o{ activityDef : "has activities"
    progRole ||--o{ programme : "belongs to"
"@

$htmlContent = @"
<!DOCTYPE html>
<html>
<head>
    <title>Test ER Diagram</title>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>
        mermaid.initialize({ startOnLoad: true });
    </script>
</head>
<body>
    <h1>Test ER Diagram</h1>
    <div class="mermaid">
$testContent
    </div>
</body>
</html>
"@

$testFile = "..\..\exports\test_diagram.html"
$htmlContent | Set-Content -Path $testFile

Write-Host "Created test HTML file: $testFile"
Write-Host "Opening in browser..."

Start-Process "chrome.exe" -ArgumentList (Resolve-Path $testFile).Path

Write-Host "Test completed. The HTML file should display the diagram correctly." 