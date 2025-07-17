param(
    [string]$lDomains = "",
    [string]$lFocus = "",
    [switch]$RefreshCFCs = $false,
    [string]$CacheFile = "D:\GIT\farcry\Cursor\FKmermaid\src\powershell\cfc_cache.json"
)

# Configuration
$pluginsPath = "D:\GIT\farcry\plugins"
$outputPath = "D:\GIT\farcry"
$excludeFolders = @("farcrycms")
$excludeFiles = @("participant.cfc")

# Function to scan CFCs and extract relationships
function Get-CFCRelationships {
    param([string]$pluginsPath)
    
    $relationships = @{
        directFK = @()
        joinTables = @()
        entities = @()
    }
    
    # Scan all plugin folders except excluded ones
    $pluginFolders = Get-ChildItem -Path $pluginsPath -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
    
    foreach ($pluginFolder in $pluginFolders) {
        $typesPath = Join-Path $pluginFolder.FullName "packages\types"
        if (Test-Path $typesPath) {
            $cfcFiles = Get-ChildItem -Path $typesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
            
            foreach ($cfcFile in $cfcFiles) {
                $content = Get-Content $cfcFile.FullName -Raw
                $entityName = $cfcFile.BaseName
                $pluginName = $pluginFolder.Name
                
                # Extract entity info
                $relationships.entities += @{
                    name = $entityName
                    plugin = $pluginName
                    file = $cfcFile.FullName
                }
                
                # Extract direct FK relationships (ftJoin with type="UUID")
                $directFKMatches = [regex]::Matches($content, 'ftJoin="([^"]+)".*?type="UUID"', [System.Text.RegularExpressions.RegexOptions]::Singleline)
                foreach ($match in $directFKMatches) {
                    $targetEntity = $match.Groups[1].Value
                    $relationships.directFK += @{
                        source = $entityName
                        sourcePlugin = $pluginName
                        target = $targetEntity
                        property = "Unknown" # Would need more complex parsing to get property name
                    }
                }
                
                # Extract array/join table relationships (ftType="array" with ftJoin)
                $arrayMatches = [regex]::Matches($content, 'ftType="array".*?ftJoin="([^"]+)"', [System.Text.RegularExpressions.RegexOptions]::Singleline)
                foreach ($match in $arrayMatches) {
                    $targetEntity = $match.Groups[1].Value
                    $relationships.joinTables += @{
                        source = $entityName
                        sourcePlugin = $pluginName
                        target = $targetEntity
                        joinTable = "${entityName}_a${targetEntity}"
                    }
                }
            }
        }
    }
    
    return $relationships
}

# Function to load cached relationships
function Load-CachedRelationships {
    param([string]$cacheFile)
    
    if (Test-Path $cacheFile) {
        $cachedData = Get-Content $cacheFile -Raw | ConvertFrom-Json
        return $cachedData
    }
    return $null
}

# Function to save relationships to cache
function Save-RelationshipsToCache {
    param($relationships, [string]$cacheFile)
    
    $cacheDir = Split-Path $cacheFile -Parent
    if (!(Test-Path $cacheDir)) {
        New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
    }
    
    $relationships | ConvertTo-Json -Depth 10 | Set-Content $cacheFile
    Write-Host "Cached relationships saved to: $cacheFile"
}

# Main execution
Write-Host "FarCry ERD Generator"
Write-Host "===================="

# Determine whether to use fresh scan or cached data
if ($RefreshCFCs -or !(Test-Path $CacheFile)) {
    Write-Host "Scanning CFC files for relationships..."
    $relationships = Get-CFCRelationships -pluginsPath $pluginsPath
    Save-RelationshipsToCache -relationships $relationships -cacheFile $CacheFile
} else {
    Write-Host "Loading cached relationships from: $CacheFile"
    $relationships = Load-CachedRelationships -cacheFile $CacheFile
    if ($null -eq $relationships) {
        Write-Host "Cache file corrupted or empty, scanning CFC files..."
        $relationships = Get-CFCRelationships -pluginsPath $pluginsPath
        Save-RelationshipsToCache -relationships $relationships -cacheFile $CacheFile
    }
}

Write-Host "Found $($relationships.entities.Count) entities"
Write-Host "Found $($relationships.directFK.Count) direct FK relationships"
Write-Host "Found $($relationships.joinTables.Count) join table relationships"

# Generate Mermaid ERD
$mermaidContent = @"
erDiagram
"@

# Add entities
foreach ($entity in $relationships.entities) {
    $mermaidContent += "`n    `"$($entity.plugin) - $($entity.name)`" {`n"
    $mermaidContent += "        UUID ObjectID`n"
    $mermaidContent += "        string name`n"
    $mermaidContent += "    }`n"
}

# Add relationships
foreach ($fk in $relationships.directFK) {
    $mermaidContent += "`n    `"$($fk.sourcePlugin) - $($fk.source)`" }o--|| `"$($fk.target)`" : $($fk.property)"
}

foreach ($join in $relationships.joinTables) {
    $mermaidContent += "`n    `"$($join.sourcePlugin) - $($join.source)`" }o--|| `"$($join.target)`" : $($join.joinTable)"
}

# Save to file
$outputFile = Join-Path $outputPath "plugins_erd.mmd"
$mermaidContent | Set-Content $outputFile
Write-Host "ERD saved to: $outputFile"

Write-Host "`nUsage:"
Write-Host "  .\generate_erd.ps1                    # Use cached data (default)"
Write-Host "  .\generate_erd.ps1 -RefreshCFCs      # Scan CFCs fresh"
Write-Host "  .\generate_erd.ps1 -CacheFile 'path' # Use different cache file" 