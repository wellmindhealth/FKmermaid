$domainsEntities = @(
    'partner','referer','center','memberGroup','intake','farWebtopDashboard','programme','progRole',
    'farUser','farGroup','farRole','farPermission','dmProfile','dmArchive','farLog',
    'member','progMember','activity','ssq_stress01','ssq_pain01','ssq_arthritis01','tracker','trackerDef',
    'journal','journalDef','library','activityDef','media','dmNavigation','dmHTML','dmFacts','dmNews','dmInclude','dmImage','dmFile'
)

$allEntities = Get-Content 'temp_entities.txt'
$notInDomains = $allEntities | Where-Object { $_ -notin $domainsEntities }

Write-Host "=== ENTITIES IN DOMAINS.JSON ===" -ForegroundColor Green
$domainsEntities | Sort-Object
Write-Host ""
Write-Host "=== ENTITIES NOT IN DOMAINS.JSON ===" -ForegroundColor Yellow
$notInDomains | Sort-Object
Write-Host ""
Write-Host "Total entities in domains.json: $($domainsEntities.Count)" -ForegroundColor Cyan
Write-Host "Total entities not in domains.json: $($notInDomains.Count)" -ForegroundColor Cyan 