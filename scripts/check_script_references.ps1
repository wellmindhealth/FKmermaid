# Check Script References
# Utility script to find which scripts still reference the old generate_erd_enhanced.ps1

Write-Host "🔍 Checking for scripts that still reference generate_erd_enhanced.ps1..." -ForegroundColor Cyan

# Search for references to the old script
$results = Get-ChildItem -Path "D:\GIT\farcry\Cursor\FKmermaid" -Recurse -Include "*.ps1" | 
    Where-Object { $_.FullName -notlike "*confluence*" -and $_.FullName -notlike "*History*" } |
    ForEach-Object {
        $content = Get-Content $_.FullName -Raw
        if ($content -match "generate_erd_enhanced\.ps1" -and $_.Name -ne "check_script_references.ps1") {
            $matches = [regex]::Matches($content, "generate_erd_enhanced\.ps1")
            [PSCustomObject]@{
                File = $_.FullName
                LineCount = $matches.Count
                Lines = $matches | ForEach-Object { $_.Index }
            }
        }
    }

if ($results) {
    Write-Host "`n❌ Found $($results.Count) files still referencing generate_erd_enhanced.ps1:" -ForegroundColor Red
    
    foreach ($result in $results) {
        $relativePath = $result.File.Replace("D:\GIT\farcry\Cursor\FKmermaid\", "")
        Write-Host "   📄 $relativePath ($($result.LineCount) references)" -ForegroundColor Yellow
        
        # Show the actual lines
        $content = Get-Content $result.File
        foreach ($lineNum in $result.Lines) {
            $lineIndex = $lineNum - 1
            if ($lineIndex -lt $content.Length) {
                $line = $content[$lineIndex].Trim()
                Write-Host "      Line $($lineIndex + 1): $line" -ForegroundColor Gray
            }
        }
        Write-Host ""
    }
    
    Write-Host "🚨 These scripts need to be updated to use generate_erd_domain_colors.ps1!" -ForegroundColor Red
} else {
    Write-Host "`n✅ All scripts have been updated to use generate_erd_domain_colors.ps1!" -ForegroundColor Green
}

Write-Host "`n📋 Summary:" -ForegroundColor Cyan
Write-Host "   Total files checked: $(Get-ChildItem -Path 'D:\GIT\farcry\Cursor\FKmermaid' -Recurse -Include '*.ps1' | Where-Object { $_.FullName -notlike '*confluence*' -and $_.FullName -notlike '*History*' } | Measure-Object | Select-Object -ExpandProperty Count)" -ForegroundColor White
Write-Host "   Files still referencing old script: $($results.Count)" -ForegroundColor $(if ($results) { 'Red' } else { 'Green' }) 