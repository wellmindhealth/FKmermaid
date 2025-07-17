# Debug script to test URL generation with actual generated content
$actualContent = Get-Content "..\..\exports\progRole_focus_er.mmd" -Raw

Write-Host "Actual Mermaid Content:"
Write-Host $actualContent
Write-Host "`nLength: $($actualContent.Length)"

# Test base64 encoding
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($actualContent))
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
    Write-Host "`nWARNING: URL is very long ($($url.Length) characters) - this might cause issues!"
}

# Test alternative URL format
$url2 = "https://mermaid.live/edit#pako:$base64"
Write-Host "`nAlternative URL (pako):"
Write-Host $url2

# Test with URL encoding
$urlEncoded = [System.Web.HttpUtility]::UrlEncode($base64)
$url3 = "https://mermaid.live/edit#base64:$urlEncoded"
Write-Host "`nURL with encoding:"
Write-Host $url3 