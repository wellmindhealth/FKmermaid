# Simple Confluence API Test - Bypasses all validation
Write-Host "🚀 Testing Confluence API directly..." -ForegroundColor Yellow

try {
    # Load environment variables directly
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
    
    Write-Host "📋 Loaded environment variables:" -ForegroundColor Cyan
    foreach ($key in $envVars.Keys) {
        Write-Host "  $key = $($envVars[$key])" -ForegroundColor Gray
    }
    
    # Test basic API call
    $basicAuth = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($envVars.CONFLUENCE_USER):$($envVars.CONFLUENCE_API_TOKEN)"))
    $headers = @{
        "Authorization" = "Basic $basicAuth"
        "Content-Type" = "application/json"
        "Accept" = "application/json"
    }
    
    $url = "$($envVars.CONFLUENCE_BASE_URL)/rest/api/user/current"
    Write-Host "🔍 Testing URL: $url" -ForegroundColor Cyan
    
    $response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
    Write-Host "✅ API Test Successful!" -ForegroundColor Green
    Write-Host "👤 User: $($response.displayName)" -ForegroundColor Green
    
    # List available spaces
    Write-Host "📋 Listing available spaces..." -ForegroundColor Cyan
    $spacesUrl = "$($envVars.CONFLUENCE_BASE_URL)/rest/api/space"
    $spacesResponse = Invoke-RestMethod -Uri $spacesUrl -Headers $headers -Method Get
    Write-Host "✅ Found $($spacesResponse.results.Count) spaces:" -ForegroundColor Green
    foreach ($space in $spacesResponse.results) {
        Write-Host "  📁 $($space.key) - $($space.name)" -ForegroundColor Gray
    }
    
    # Now try to create a simple page in the first available space
    $firstSpace = $spacesResponse.results[0]
    Write-Host "🎯 Using space: $($firstSpace.key) - $($firstSpace.name)" -ForegroundColor Yellow
    
    $pageTitle = "Direct API Test - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
    $pageContent = @"
<h2>🎯 Direct API Test</h2>
<p>This page was created by bypassing all validation and going straight to the Confluence API.</p>
<p><strong>Timestamp:</strong> $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')</p>
<p><strong>Status:</strong> ✅ Success!</p>
<p><strong>Space:</strong> $($firstSpace.key) - $($firstSpace.name)</p>
"@
    
    $body = @{
        type = "page"
        title = $pageTitle
        space = @{
            key = $firstSpace.key
        }
        body = @{
            storage = @{
                value = $pageContent
                representation = "storage"
            }
        }
    }
    
    $createUrl = "$($envVars.CONFLUENCE_BASE_URL)/rest/api/content"
    Write-Host "📄 Creating page: $pageTitle" -ForegroundColor Cyan
    
    $pageResponse = Invoke-RestMethod -Uri $createUrl -Headers $headers -Method Post -Body ($body | ConvertTo-Json -Depth 10)
    
    Write-Host "🎉 Page created successfully!" -ForegroundColor Green
    Write-Host "📄 Page ID: $($pageResponse.id)" -ForegroundColor Cyan
    Write-Host "🔗 URL: $($envVars.CONFLUENCE_BASE_URL)/pages/viewpage.action?pageId=$($pageResponse.id)" -ForegroundColor Cyan
    
} catch {
    Write-Host "❌ Direct API test failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "🔍 Full error: $($_.Exception)" -ForegroundColor Red
} 