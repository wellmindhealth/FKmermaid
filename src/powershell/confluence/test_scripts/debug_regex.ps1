Write-Host "🔍 Debugging Regex Pattern" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan

# Test the exact output we're getting
$testOutput = @"
2025-07-30 08:42:30 [INFO] Logger Initialize-Logger Logger initialized
2025-07-30 08:42:30 [INFO] Logger Initialize-Logger Log level: INFO
2025-07-30 08:42:30 [INFO] Logger Initialize-Logger Log file: D:\GIT\farcry\Cursor\FKmermaid\logs\fkmermaid_20250730_084230.log

2025-07-30 08:42:30 [INFO] Logging Write-InfoLog Module logging initialized: diagram_generation
2025-07-30 08:42:30 [INFO] Diagram_Generation Write-InfoLog Starting ER diagram generation | Data: {"RefreshCFCs":{"IsPresent":false},"Focus":"partner","ConfigFile":"D:\\GIT\\farcry\\Cursor\\FKmermaid\\config\\cfc_scan_config.json","DiagramType":"ER","Domains":"partner"}
✅ Loaded relationship detection module
FarCry ERD Generator (Enhanced)
===============================
📋 Loaded 8 styles from Mermaid styles file
📋 Loaded 8 styles from Mermaid styles file
🎯 Focus: partner | 📊 Type: ER | 🌍 Domains: partner
Loading cached relationships from: D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json
Found 83 entities
Found 106 direct FK relationships
Found 38 join table relationships
📊 Filtered to 19 entities based on parameters:
   Focus: partner
   Domains: partner
ER diagram saved to: D:\GIT\farcry\Cursor\FKmermaid\exports\partner_20250730_084230_5b06bbe4.mmd
🗑️  Cleaned up: programme_20250730_084056_41ce94ae.mmd
🧹 Kept last 3 files in exports folder
🚀 Spawning Mermaid.live directly with content...
✅ Generated compressed Mermaid.live URL
🚫 Browser opening suppressed (NoBrowser parameter)
🔗 Mermaid.live URL: https://mermaid.live/edit#pako:eNq1Wdtu2zgQ/RVCRd8SIBc7RvW2iJOFu7fAad4MBIw0stlKokBSm/Um+fdS94tFmaRVP5G0z9HMcOYMKb85HvXBcR1gS4K3DEebGMnP58/oAcsZCGDc3cRyjtA99VLuogQzEQMrF5c0wiQ+WL7dySn6tk/ARXfrgnTjJFjsXvH+maUhPEIYrGFLuGBYEBpvHPRW/C77PD2tluifl+/gidWyWP7YxH0eP1pFeAs2UOwJ8i8R+yUENnAPYhkaG+Q2Jb6VxSQW+IcVMgKfYDtg9GLnZYH8ndE0sYFXyWQDZTTL4whswWsaWmEZBMDsbGaQUCZMkP8HmHls71EGsgoeGA2ImdVtAjk03qke/gFYRDg3rOMeiWnke/AnbhJ9KVNLwuQ36P4PtIYwFyG+IwnXVKv39/Pz93dlzruoNa+ebk7aVEItsfZktWq5qBjaUzXZ7qJyfEjWFdlD31qlKr2rZsY8TRtwkQAs06CYm7FUwuyifGTlTZnBMiTZwAxfqbSLfAhwGoq/soVDM+pNHI3Dn3RLjyNVMiJtqGYmBmglqxpuVEDVdo1GISGeSBloY7UcUKI1yqtu4qc5r6bRsKFKNPMKUCK14qZG6+rAKEOn9oaw5VnmtMiraTRjoIJrbZwKrKXGanhXmVzUmhtFQHcXqlifEkMlxzEVbJ4xBdRKQY14OMSEssc0yc6IA1yt4rGL5yjD0ZCMgft5FRDGxW9jyWVEF2INtjIh7UWnqS2bVjOAtkqZESv0johqvNm5Vc2jc7qsLjqnbIeSQi8OKnita1UEGrBqx+xCeZRNcTeTCZ8Puc4dTEVW6zPORnz8KmVokbxS3cW++lpV/+oxAY/gEH2lJLYxoVs1aXbgXz4L+pyN/sYR5IPCDMr2HeN6j25Mknee83We3LFH4m3XdhRQ1u6KXZisCY5I7IWpDy6isXzOanmG8G0KD/IxlUYR4HJxlVWGpLocXL0aXL0eXJ0Nrs6bVcMLSF9eufQtq/fu7poGyiTC3SQeiTHOseCLfQInlUPnRye43LO8hmdphr7hlxDG3zF0Y/9BlXdDXN4KufJaVYPVFYOz4tJgGDpe4iIQh/D6TjJgfa2s0vxszMfPdIMuNJogae7z9UE3mjZwYEirQ+HbfGyC1opCu48dMBycs+9pGNLXNOmcYriyZyki28hxGV7NhqMKc4tvtOGUveQX0/RKFDfzI63D0K6y2NUV2yrru1jI3UKPYh9KPSiWuZwAGnuPJs+/Yeh+uvxyc+1fnclV+gPkdH4z9y7K6fkr8cXOnSX/nXk0pMz9FATBEH959JySspWdJe1sNr9cBDXt9WK2mAVd2quGFjwIgssh5qLuStKbL9f44qImnftXcGFsa/6CYkrnC/Wa2O9ctqd0u6j3Kf1uKciUhpYyWlL6i/m8RRnMF54FZaWsk9pZ3hAn3viyVUxpadEEptj6wXYwhalDOjtRYJU94dfwT5gSA73pJOYN28TOmRPJCGDiO+6bI3YQZf/hl38bOB8fPwEhpOgI
✅ Enhanced ERD generation complete!
📁 MMD file: D:\GIT\farcry\Cursor\FKmermaid\exports\partner_20250730_084230_5b06bbe4.mmd
🔗 Browser should have opened automatically
✅ No errors found in log file
2025-07-30 08:42:30 [INFO] Diagram_Generation Write-InfoLog ER diagram generation completed successfully | Data: {"RelationshipCount":0,"EntityCount":0,"DiagramType":"ER","OutputFile":"D:\\GIT\\farcry\\Cursor\\FKmermaid\\exports\\partner_20250730_084230_5b06bbe4.mmd"}
"@

Write-Host "`n🔍 Testing Regex Patterns:" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

# Test different patterns
$patterns = @(
    "🔗 Mermaid\.live URL:",
    "https://mermaid\.live",
    "Mermaid\.live URL:",
    "🔗"
)

foreach ($pattern in $patterns) {
    $matches = $testOutput -split "`n" | Where-Object { $_ -match $pattern }
    if ($matches) {
        Write-Host "✅ Pattern '$pattern' found:" -ForegroundColor Green
        $matches | ForEach-Object { Write-Host "   $_" -ForegroundColor Gray }
    } else {
        Write-Host "❌ Pattern '$pattern' NOT found" -ForegroundColor Red
    }
}

Write-Host "`n🎯 Testing URL extraction:" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green

$mermaidUrl = $testOutput -split "`n" | Where-Object { $_ -match "🔗 Mermaid\.live URL:" } | Select-Object -First 1

if ($mermaidUrl) {
    Write-Host "✅ Found URL line: $mermaidUrl" -ForegroundColor Green
    $cleanUrl = $mermaidUrl -replace "🔗 Mermaid\.live URL: ", ""
    Write-Host "✅ Clean URL: $cleanUrl" -ForegroundColor Green
} else {
    Write-Host "❌ No URL found with current pattern" -ForegroundColor Red
}

Write-Host "`n🔍 Testing with different approach:" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# Try with -split approach
$lines = $testOutput -split "`n"
$urlLine = $lines | Where-Object { $_ -match "🔗 Mermaid\.live URL:" } | Select-Object -First 1

if ($urlLine) {
    Write-Host "✅ Found URL line with -split: $urlLine" -ForegroundColor Green
    $cleanUrl = $urlLine -replace "🔗 Mermaid\.live URL: ", ""
    Write-Host "✅ Clean URL: $cleanUrl" -ForegroundColor Green
} else {
    Write-Host "❌ No URL found with -split approach" -ForegroundColor Red
} 