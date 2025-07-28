# Debug script to test regex pattern
$content = Get-Content 'D:\GIT\farcry\plugins\pathway\packages\types\member.cfc' -Raw
$pattern = '<cfproperty[^>]*name="([^"]+)"[^>]*ftJoin="([^"]+)"[^>]*>'
$matches = [regex]::Matches($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

Write-Host "Found $($matches.Count) matches:"
foreach($match in $matches) {
    Write-Host "Property: $($match.Groups[1].Value), Target: $($match.Groups[2].Value)"
    Write-Host "Full match: $($match.Value)"
    Write-Host "---"
}

# Let's also check for the caseness property specifically
Write-Host "`nChecking for caseness property:"
$casenessPattern = '<cfproperty[^>]*name="caseness"[^>]*ftJoin'
$casenessMatch = [regex]::Match($content, $casenessPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($casenessMatch.Success) {
    Write-Host "CASENESS HAS FTJOIN: $($casenessMatch.Value)"
} else {
    Write-Host "caseness does NOT have ftJoin"
}

# Check for roleID property
Write-Host "`nChecking for roleID property:"
$roleIDPattern = '<cfproperty[^>]*name="roleID"[^>]*ftJoin'
$roleIDMatch = [regex]::Match($content, $roleIDPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
if ($roleIDMatch.Success) {
    Write-Host "roleID HAS FTJOIN: $($roleIDMatch.Value)"
} else {
    Write-Host "roleID does NOT have ftJoin"
} 