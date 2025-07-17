param(
    [string]$FocusEntity = "progRole",
    [int]$TopN = 20,
    [ValidateSet("ER", "Class")]
    [string]$DiagramType = "Class",
    [string[]]$lDomains = @("programme", "partner"),
    [bool]$BroadenSpread = $true
)

Write-Host "Generating $DiagramType diagram for focus entity: $FocusEntity"
Write-Host "Domains: $($lDomains -join ', ')"

# Get the directory of the currently running script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$FarcryRoot = Resolve-Path (Join-Path $ProjectRoot "..\..") 

# Define the paths for the output files
$outputFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).mmd"
$outputMDFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus_$($DiagramType.ToLower()).md"

# Overwrite the output file and the markdown file
if (Test-Path $outputFile) { Remove-Item $outputFile -Force }
if (Test-Path $outputMDFile) { Remove-Item $outputMDFile -Force }
New-Item -Path $outputFile -ItemType File -Force | Out-Null
New-Item -Path $outputMDFile -ItemType File -Force | Out-Null

# Set the search directory for CFCs
$searchPath = Join-Path $FarcryRoot "plugins"

# Excluded directories
$excludePatterns = '^(farcrycms|testmxunit|mud|microdsoft|microsoft|test|shop|order|xealth|ldap|module|participant|rule|dont|freshbooks|report|promotion|token|device|oAuth2service|JWTapp)'

# Find all CFC files, excluding specified directories
Write-Host "Searching for CFC files in: $searchPath ..."
$cfcFiles = Get-ChildItem -Path $searchPath -Filter *.cfc -Recurse -ErrorAction SilentlyContinue | Where-Object {
    $_.FullName -notmatch ($excludePatterns -join '|')
}

$relationships = @()
$entityDisplayNames = @{}
$i = 0
foreach ($file in $cfcFiles) {
    $i++
    Write-Progress -Activity "Processing CFC files" -Status "Processing $($file.Name) ($i of $($cfcFiles.Count))" -PercentComplete ($i / $($cfcFiles.Count) * 100)
    
    $content = Get-Content $file.FullName -Raw

    # Extract displayName from CFC
    $displayNameMatch = [regex]::Match($content, 'displayname\s*=\s*"([^"]*)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    if ($displayNameMatch.Success) {
        $entityDisplayNames[$file.BaseName] = $displayNameMatch.Groups[1].Value
    } else {
        $entityDisplayNames[$file.BaseName] = $file.BaseName
    }

    # Find all property tags first to avoid catastrophic backtracking
    $propertyTagRegex = '(?im)<cfproperty\s+.*?/?>'
    $propertyTags = [regex]::Matches($content, $propertyTagRegex)

    foreach ($tagMatch in $propertyTags) {
        $tag = $tagMatch.Value
        # Check if the tag has both required attributes
        if ($tag -match 'ftJoin\s*=' -and $tag -match 'name\s*=') {
            # Extract the values using simpler, non-hanging regexes
            $nameMatch = [regex]::Match($tag, 'name\s*=\s*"([^"]*)"')
            $joinMatch = [regex]::Match($tag, 'ftJoin\s*=\s*"([^"]*)"')
            
            if ($nameMatch.Success -and $joinMatch.Success) {
                $relationships += [pscustomobject]@{
                    SourceTable = $file.BaseName
                    TargetTable = $joinMatch.Groups[1].Value
                    ForeignKey  = $nameMatch.Groups[1].Value
                }
            }
        }
    }
}

Write-Progress -Activity "Processing CFC files" -Completed

# Add "loose" relationships that aren't defined with ftJoin
$relationships += [pscustomobject]@{ SourceTable = 'dmProfile'; TargetTable = 'farUser'; ForeignKey = 'userid' }
$relationships += [pscustomobject]@{ SourceTable = 'farUser'; TargetTable = 'farGroup'; ForeignKey = 'aGroups' }
$relationships += [pscustomobject]@{ SourceTable = 'farRole'; TargetTable = 'farGroup'; ForeignKey = 'aGroups' }
$relationships += [pscustomobject]@{ SourceTable = 'farRole'; TargetTable = 'farPermission'; ForeignKey = 'aPermissions' }
$relationships += [pscustomobject]@{ SourceTable = 'member'; TargetTable = 'progMember'; ForeignKey = 'memberID' }

# Load domain configuration
$domainConfig = Get-Content "$PSScriptRoot/../../config/domains.json" | ConvertFrom-Json

# Get all entities from specified domains
$allDomainEntities = @()
foreach ($domain in $lDomains) {
    Write-Host "Processing domain: $domain"
    foreach ($cat in $domainConfig.domains.$domain.entities.PSObject.Properties.Name) {
        Write-Host "  Adding category: $cat"
        $allDomainEntities += $domainConfig.domains.$domain.entities.$cat
    }
}

# Filter relationships to include only those involving domain entities or the focus entity
$filteredRelationships = @()
foreach ($rel in $relationships) {
    $sourceInDomain = $allDomainEntities -contains $rel.SourceTable
    $targetInDomain = $allDomainEntities -contains $rel.TargetTable
    $involvesFocus = $rel.SourceTable -eq $FocusEntity -or $rel.TargetTable -eq $FocusEntity
    
    if ($sourceInDomain -or $targetInDomain -or $involvesFocus) {
        $filteredRelationships += $rel
    }
}
$relationships = $filteredRelationships

Write-Host "Filtered to $($relationships.Count) relationships"

# Focus on the specified entity and its relationships
Write-Host "Focusing on entity: $FocusEntity"

# Find relationships involving the focus entity
$focusedRels = $relationships | Where-Object {
    $_.SourceTable -eq $FocusEntity -or $_.TargetTable -eq $FocusEntity
}

Write-Host "Found $($focusedRels.Count) direct relationships for $FocusEntity"

# Get entities directly related to the focus entity
$directlyRelated = $focusedRels | ForEach-Object { 
    if ($_.SourceTable -eq $FocusEntity) { $_.TargetTable } else { $_.SourceTable }
} | Select-Object -Unique

Write-Host "Directly related entities: $($directlyRelated -join ', ')"

# Include focus entity and directly related entities
$focusEntities = @($FocusEntity) + $directlyRelated

# If broaden spread is enabled, include entities related to the directly related entities
if ($BroadenSpread) {
    $secondaryRels = $relationships | Where-Object {
        $directlyRelated -contains $_.SourceTable -or $directlyRelated -contains $_.TargetTable
    }
    
    $secondaryEntities = $secondaryRels | ForEach-Object { 
        if ($directlyRelated -contains $_.SourceTable) { $_.TargetTable } else { $_.SourceTable }
    } | Select-Object -Unique | Where-Object { $allDomainEntities -contains $_ }
    
    $focusEntities += $secondaryEntities
    Write-Host "Including secondary entities: $($secondaryEntities -join ', ')"
}

# Get all relationships between included entities
$includedRels = $relationships | Where-Object {
    $focusEntities -contains $_.SourceTable -and $focusEntities -contains $_.TargetTable
}

$includedEntities = $includedRels | ForEach-Object { @($_.SourceTable, $_.TargetTable) } | Select-Object -Unique

# Load style variables
. "$PSScriptRoot/../../css/styles.ps1"

# Style map - focus entity gets focus style, others get domain-based styling
$entityStyles = @{}
foreach ($entity in $includedEntities) {
    if ($entity -eq $FocusEntity) {
        $entityStyles[$entity] = $focusStyle
    } elseif ($allDomainEntities -contains $entity) {
        $entityStyles[$entity] = $secondaryDomainStyle
    } else {
        $entityStyles[$entity] = $defaultStyle
    }
}

# Write the diagram header
if ($DiagramType -eq "ER") {
    Set-Content -Path $outputFile -Value 'erDiagram'
    Set-Content -Path $outputMDFile -Value '```mermaid'
    Add-Content -Path $outputMDFile -Value 'erDiagram'
} else {
    Set-Content -Path $outputFile -Value 'classDiagram'
    Set-Content -Path $outputMDFile -Value '```mermaid'
    Add-Content -Path $outputMDFile -Value 'classDiagram'
}

# Write the entities with proper focus styling
foreach ($entity in $includedEntities) {
    $displayName = if ($entityDisplayNames.ContainsKey($entity)) { $entityDisplayNames[$entity] } else { $entity }
    Write-Host "Entity: $entity, DisplayName: $displayName"
    
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    $entity"
        Add-Content -Path $outputMDFile -Value "    $entity"
    } else {
        # Class diagram with proper styling
        Add-Content -Path $outputFile -Value "    class `"$entity`" as `"$displayName`" {"
        Add-Content -Path $outputMDFile -Value "    class `"$entity`" as `"$displayName`" {"
        
        # Add properties based on entity type
        if ($entity -eq $FocusEntity) {
            # Focus entity gets prominent styling and key properties
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
        } elseif ($entity -eq "activityDef") {
            # activityDef gets its properties but not as prominent as focus
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
        } else {
            # Other entities get minimal properties
            Add-Content -Path $outputFile -Value "        +"
            Add-Content -Path $outputMDFile -Value "        +"
        }
        
        Add-Content -Path $outputFile -Value "    }"
        Add-Content -Path $outputMDFile -Value "    }"
    }
}

# Write the relationships
foreach ($relationship in $includedRels) {
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
        Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
    } else {
        Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
        Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
    }
}

# Close the markdown file
Add-Content -Path $outputMDFile -Value '```'

Write-Host "Diagram generated: $outputFile"
Write-Host "Markdown file generated: $outputMDFile"

# Generate URL for Mermaid Live Editor
$mermaidContent = Get-Content $outputFile -Raw
$compressedContent = [System.Web.HttpUtility]::UrlEncode($mermaidContent)
$url = "https://mermaid.live/edit#pako:$compressedContent"

Write-Host "Generated URL: $url"

# Open in browser
Start-Process $url 