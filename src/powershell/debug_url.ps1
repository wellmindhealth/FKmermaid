# Debug script to test URL generation
$mermaidContent = @"
erDiagram
    progRole {
        +
    }
    activityDef {
        +
    }
    programme {
        +
    }

    %% Relationships
    progRole ||--o{ activityDef : related
    progRole ||--o{ programme : related
"@

Write-Host "Original Mermaid Content:"
Write-Host $mermaidContent
Write-Host "`nLength: $($mermaidContent.Length)"

# Test base64 encoding
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($mermaidContent))
Write-Host "`nBase64 encoded content:"
Write-Host $base64
Write-Host "`nBase64 length: $($base64.Length)"

# Generate URL
$url = "https://mermaid.live/edit#base64:$base64"
Write-Host "`nGenerated URL:"
Write-Host $url
Write-Host "`nURL length: $($url.Length)"

# Test if URL is too long
if ($url.Length -gt 2048) {
    Write-Host "`nWARNING: URL is very long ($($url.Length) characters)"
}

# Test alternative URL format
$url2 = "https://mermaid.live/edit#pako:$base64"
Write-Host "`nAlternative URL (pako):"
Write-Host $url2 