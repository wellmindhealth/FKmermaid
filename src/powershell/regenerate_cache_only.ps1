# Simplified CFC Cache Regeneration Script
# Extracted from generate_erd_enhanced.ps1 to focus only on cache generation

param(
    [string]$pluginsPath = "D:\GIT\farcry\plugins",
    [string]$cacheFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_cache.json"
)

# Import the relationship detection module
. ".\relationship_detection.ps1"

# Load configuration
$configFile = "D:\GIT\farcry\Cursor\FKmermaid\config\cfc_scan_config.json"
if (Test-Path $configFile) {
    $config = Get-Content $configFile -Raw | ConvertFrom-Json
    $knownTables = $config.entityConstraints.knownTables
    $excludeFiles = $config.scanSettings.excludeFiles
    $excludeFolders = $config.scanSettings.excludeFolders
    Write-Host "DEBUG: Loaded $($knownTables.Count) known tables" -ForegroundColor Cyan
    Write-Host "DEBUG: First 10 known tables: $($knownTables[0..9] -join ', ')" -ForegroundColor Cyan
} else {
    Write-Host "❌ Configuration file not found: $configFile" -ForegroundColor Red
    exit 1
}

# Function to scan CFCs and extract relationships
function Get-CFCRelationships {
    param([string]$basePath)
    
    $relationships = @{
        directFK = @()
        joinTables = @()
        entities = @()
        properties = @()
    }
    
    # Get scan directories from config
    $scanDirectories = $config.scanSettings.scanDirectories
    
    # First pass: count total files to process for progress bar
    $totalFiles = 0
    Write-Host "DEBUG: Starting scan of directories..." -ForegroundColor Yellow
    foreach ($scanDir in $scanDirectories) {
        Write-Host "DEBUG: Checking scan directory: $scanDir" -ForegroundColor Cyan
        if (Test-Path $scanDir) {
            Write-Host "DEBUG: Directory exists: $scanDir" -ForegroundColor Green
            if ($scanDir -like "*zfarcrycore*") {
                Write-Host "DEBUG: Processing zfarcrycore..." -ForegroundColor Yellow
                $packagesPath = Join-Path $scanDir "packages"
                Write-Host "DEBUG: Packages path: $packagesPath" -ForegroundColor Cyan
                if (Test-Path $packagesPath) {
                    Write-Host "DEBUG: Packages path exists" -ForegroundColor Green
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    Write-Host "DEBUG: Found $($cfcFiles.Count) CFC files in zfarcrycore" -ForegroundColor Cyan
                    $matchingFiles = $cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }
                    Write-Host "DEBUG: $($matchingFiles.Count) files match knownTables" -ForegroundColor Cyan
                    $totalFiles += $matchingFiles.Count
                } else {
                    Write-Host "DEBUG: Packages path does not exist" -ForegroundColor Red
                }
            } else {
                Write-Host "DEBUG: Processing plugin directory..." -ForegroundColor Yellow
                $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
                Write-Host "DEBUG: Found $($pluginFolders.Count) plugin folders (after exclusions)" -ForegroundColor Cyan
                foreach ($pluginFolder in $pluginFolders) {
                    Write-Host "DEBUG: Processing plugin: $($pluginFolder.Name)" -ForegroundColor Yellow
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    Write-Host "DEBUG: Packages path: $packagesPath" -ForegroundColor Cyan
                    if (Test-Path $packagesPath) {
                        Write-Host "DEBUG: Packages path exists" -ForegroundColor Green
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        Write-Host "DEBUG: Found $($cfcFiles.Count) CFC files in $($pluginFolder.Name)" -ForegroundColor Cyan
                        $matchingFiles = $cfcFiles | Where-Object { $knownTables -contains [System.IO.Path]::GetFileNameWithoutExtension($_.Name) }
                        Write-Host "DEBUG: $($matchingFiles.Count) files match knownTables" -ForegroundColor Cyan
                        $totalFiles += $matchingFiles.Count
                    } else {
                        Write-Host "DEBUG: Packages path does not exist" -ForegroundColor Red
                    }
                }
            }
        } else {
            Write-Host "DEBUG: Directory does not exist: $scanDir" -ForegroundColor Red
        }
    }
    
    Write-Host "Scanning CFC files for relationships... ($totalFiles files to process)" -ForegroundColor Cyan
    
    # Second pass: process files with progress bar
    $processedFiles = 0
    foreach ($scanDir in $scanDirectories) {
        if (Test-Path $scanDir) {
            # Handle zfarcrycore differently (it's not a plugin)
            if ($scanDir -like "*zfarcrycore*") {
                $pluginName = "zfarcrycore"
                
                # Scan for CFC files in packages subdirectories
                $packagesPath = Join-Path $scanDir "packages"
                if (Test-Path $packagesPath) {
                    $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                    
                    foreach ($cfcFile in $cfcFiles) {
                        # Extract entity name from filename first (before reading file)
                        $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                        
                        # Only process if entity is in known tables (skip reading file if not needed)
                        if ($knownTables -contains $entityName) {
                            $processedFiles++
                            $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                            Write-Host "`rProcessing: $entityName [$progress%]   " -NoNewline
                            
                            $content = Get-Content $cfcFile.FullName -Raw
                            # Extract entity info
                            $relationships.entities += @{
                                name = $entityName
                                plugin = $pluginName
                                file = $cfcFile.FullName
                            }
                            
                            # Use the optimized relationship detection from the module
                            $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                            
                            # Merge relationships
                            $relationships.directFK += $entityRelationships.directFK
                            $relationships.joinTables += $entityRelationships.joinTables
                            $relationships.properties += $entityRelationships.properties
                        }
                    }
                }
            } else {
                # Scan all plugin folders except excluded ones
                $pluginFolders = Get-ChildItem -Path $scanDir -Directory | Where-Object { $excludeFolders -notcontains $_.Name }
                
                foreach ($pluginFolder in $pluginFolders) {
                    $pluginName = $pluginFolder.Name
                    
                    # Scan for CFC files in all packages subdirectories
                    $packagesPath = Join-Path $pluginFolder.FullName "packages"
                    if (Test-Path $packagesPath) {
                        $cfcFiles = Get-ChildItem -Path $packagesPath -Filter "*.cfc" -Recurse | Where-Object { $excludeFiles -notcontains $_.Name }
                        
                        foreach ($cfcFile in $cfcFiles) {
                            # Extract entity name from filename first (before reading file)
                            $entityName = [System.IO.Path]::GetFileNameWithoutExtension($cfcFile.Name)
                            
                            # Only process if entity is in known tables (skip reading file if not needed)
                            if ($knownTables -contains $entityName) {
                                $processedFiles++
                                $progress = [math]::Round(($processedFiles / $totalFiles) * 100, 1)
                                Write-Host "`rProcessing: $entityName [$progress%]   " -NoNewline
                                
                                $content = Get-Content $cfcFile.FullName -Raw
                                # Extract entity info
                                $relationships.entities += @{
                                    name = $entityName
                                    plugin = $pluginName
                                    file = $cfcFile.FullName
                                }
                                
                                # Use the optimized relationship detection from the module
                                $entityRelationships = Get-RelationshipsFromContent -content $content -entityName $entityName -pluginName $pluginName -config $config
                                
                                # Merge relationships
                                $relationships.directFK += $entityRelationships.directFK
                                $relationships.joinTables += $entityRelationships.joinTables
                                $relationships.properties += $entityRelationships.properties
                            }
                        }
                    }
                }
            }
        }
    }
    
    Write-Host "`nCFC scanning complete!" -ForegroundColor Green
    
    return $relationships
}

# Function to save relationships to cache
function Save-RelationshipsToCache {
    param(
        [object]$relationships,
        [string]$cacheFile
    )
    
    Write-Host "Saving relationships to cache: $cacheFile"
    
    # Ensure directory exists
    $cacheDir = Split-Path $cacheFile -Parent
    if (!(Test-Path $cacheDir)) {
        New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
    }
    
    # Convert to JSON and save
    $jsonContent = $relationships | ConvertTo-Json -Depth 10
    $jsonContent | Set-Content $cacheFile -Encoding UTF8
    
    Write-Host "Cache saved successfully!" -ForegroundColor Green
}

# Main execution
Write-Host "Regenerating CFC Cache..." -ForegroundColor Yellow
Write-Host "Scanning plugins path: $pluginsPath" -ForegroundColor Cyan

# Scan CFC files for relationships
Write-Host "Scanning CFC files for relationships..."
$relationships = Get-CFCRelationships -basePath $pluginsPath

# Save to cache
Save-RelationshipsToCache -relationships $relationships -cacheFile $cacheFile

Write-Host "Cache regeneration complete!" -ForegroundColor Green
Write-Host "Found $($relationships.entities.Count) entities" -ForegroundColor Cyan
Write-Host "Found $($relationships.directFK.Count) direct FK relationships" -ForegroundColor Cyan
Write-Host "Found $($relationships.joinTables.Count) join table relationships" -ForegroundColor Cyan 