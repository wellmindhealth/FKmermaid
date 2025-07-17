param(
    [string]$FocusEntity = "progRole",
    [int]$TopN = 20, # Adjust this number to control the number of related entities to show
    [ValidateSet("ER", "Class")]
    [string]$DiagramType = "ER", # Choose between ER diagram or Class diagram
    [string[]]$lDomains = @() # Optional: specify domains to include (e.g., "partner", "participant", "programme", "site"). Empty array means all domains.
)

Write-Host "Generating $DiagramType diagram for focus entity: $FocusEntity"
Write-Host "Top N related entities: $TopN"

# Get the directory of the currently running script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
# Assume the project root is two levels up from the script's directory
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..\..")
$FarcryRoot = Resolve-Path (Join-Path $ProjectRoot "..\..") 

# Define the paths for the output files
$outputFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus.mmd"
$outputMDFile = Join-Path $ProjectRoot "exports\$($FocusEntity)_focus.md"

# Overwrite the output file and the markdown file
if (Test-Path $outputFile) { Remove-Item $outputFile -Force }
if (Test-Path $outputMDFile) { Remove-Item $outputMDFile -Force }
New-Item -Path $outputFile -ItemType File -Force | Out-Null
New-Item -Path $outputMDFile -ItemType File -Force | Out-Null

# Set the search directory for CFCs
$searchPath = Join-Path $FarcryRoot "plugins"
# $searchPath = Join-Path $FarcryRoot "farcry\plugins\api" # More specific path for testing

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
    Write-Progress -Activity "Processing CFC files" -Status "Processing $($file.Name) ($i of $($cfcFiles.Count))" -PercentComplete ($i / $cfcFiles.Count * 100)
    
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

# Apply domain filtering if specified
if ($lDomains.Count -gt 0) {
    Write-Host "Filtering relationships by domains: $($lDomains -join ', ')"
    $filteredRelationships = @()
    foreach ($rel in $relationships) {
        $sourceInDomain = $lDomains | Where-Object { $rel.SourceTable -like "*$_*" }
        $targetInDomain = $lDomains | Where-Object { $rel.TargetTable -like "*$_*" }
        if ($sourceInDomain -or $targetInDomain -or $rel.SourceTable -eq $FocusEntity -or $rel.TargetTable -eq $FocusEntity) {
            $filteredRelationships += $rel
        }
    }
    $relationships = $filteredRelationships
    Write-Host "Filtered to $($relationships.Count) relationships"
}

# Load style variables
. "$PSScriptRoot/../../css/styles.ps1"

# Focus on the specified entity and its relationships
Write-Host "Focusing on entity: $FocusEntity"

# Find relationships involving the focus entity
$focusedRels = $relationships | Where-Object {
    $_.SourceTable -eq $FocusEntity -or $_.TargetTable -eq $FocusEntity
}

Write-Host "Found $($focusedRels.Count) direct relationships for $FocusEntity"

# Get entities directly related to the focus entity (1st level only)
$directlyRelated = $focusedRels | ForEach-Object { 
    if ($_.SourceTable -eq $FocusEntity) { $_.TargetTable } else { $_.SourceTable }
} | Select-Object -Unique

Write-Host "Directly related entities: $($directlyRelated -join ', ')"

# Only include the focus entity and its direct relationships
$focusEntities = @($FocusEntity) + $directlyRelated

Write-Host "Focus entities: $($focusEntities -join ', ')"

# Get relationships only between these entities (no further expansion)
$focusedRels = $relationships | Where-Object {
    $focusEntities -contains $_.SourceTable -and $focusEntities -contains $_.TargetTable
}
$includedEntities = $focusedRels | ForEach-Object { @($_.SourceTable, $_.TargetTable) } | Select-Object -Unique

# Find strongest connectors (entities with most links)
$centerCandidates = $includedEntities
$centerCounts = @{}
foreach ($entity in $centerCandidates) {
    $entityRels = $relationships | Where-Object { $_.SourceTable -eq $entity -or $_.TargetTable -eq $entity }
    $centerCounts[$entity] = $entityRels.Count
}
$strongestCenters = $centerCounts.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 3 | ForEach-Object { $_.Key }

# Detect SSQ and Interact* entities
$ssqEntities = $includedEntities | Where-Object { $_ -like 'SSQ_*' }
$interactEntities = $includedEntities | Where-Object { $_ -match '^activityDef$|^activityDef[1-5]aActivities$|^interact[1-5]aActivities$' }

# Preload and flatten all selected domain entity lists for secondary highlighting
$allDomainEntities = @()
if ($lDomains.Count -gt 0) {
    Write-Host "Loading domain entities for: $($lDomains -join ', ')"
    try {
        $domainConfig = Get-Content "$PSScriptRoot/../../config/domains.json" | ConvertFrom-Json
        Write-Host "JSON loaded successfully"
        foreach ($domain in $lDomains) {
            Write-Host "Processing domain: $domain"
            foreach ($cat in $domainConfig.domains.$domain.entities.PSObject.Properties.Name) {
                Write-Host "  Adding category: $cat"
                $allDomainEntities += $domainConfig.domains.$domain.entities.$cat
            }
        }
        Write-Host "Total domain entities loaded: $($allDomainEntities.Count)"
    } catch {
        Write-Host "Error loading domain config: $_"
        $allDomainEntities = @()
    }
}

# Style map
$entityStyles = @{}
foreach ($entity in $includedEntities) {
    if ($entity -eq $FocusEntity) {
        # Focus entity always gets focus style
        $entityStyles[$entity] = $focusStyle
    } elseif ($directlyRelated -contains $entity) {
        # Secondary highlight if in selected domain
        if ($allDomainEntities -contains $entity) {
            $entityStyles[$entity] = $secondaryDomainStyle
        } else {
            $entityStyles[$entity] = $defaultStyle
        }
    } elseif ($strongestCenters -contains $entity) {
        $entityStyles[$entity] = $focusStyle
    } elseif ($ssqEntities -contains $entity) {
        $entityStyles[$entity] = $ssqStyle
    } elseif ($interactEntities -contains $entity) {
        $entityStyles[$entity] = $interactStyle
    } else {
        $entityStyles[$entity] = $defaultStyle
    }
}

# Detect activityDef types (ftList) and assign style
$activityDefTypeStyles = @{
    'quiz'   = 'fill:#ffd600,stroke:#333,stroke-width:2px,color:#333'
    'video'  = 'fill:#00bcd4,stroke:#333,stroke-width:2px,color:#fff'
    'survey' = 'fill:#8bc34a,stroke:#333,stroke-width:2px,color:#333'
    # Add more as needed
}
foreach ($entity in $includedEntities) {
    if ($entity -like 'activityDef_*') {
        $type = $entity -replace 'activityDef_', ''
        if ($activityDefTypeStyles.ContainsKey($type)) {
            $entityStyles[$entity] = $activityDefTypeStyles[$type]
        }
    }
}

# Write the diagram header based on type
if ($DiagramType -eq "ER") {
    Set-Content -Path $outputFile -Value 'erDiagram'
    Set-Content -Path $outputMDFile -Value '```mermaid'
    Add-Content -Path $outputMDFile -Value 'erDiagram'
} else {
    Set-Content -Path $outputFile -Value 'classDiagram'
    Set-Content -Path $outputMDFile -Value '```mermaid'
    Add-Content -Path $outputMDFile -Value 'classDiagram'
}

# Write the entities with grouping
# Focus entity first, then core entities (excluding grouped properties)
$coreEntities = $includedEntities | Where-Object { 
    $_ -notlike 'tracker*ID' -and 
    $_ -notlike '*Interact*Activities' -and 
    $_ -notlike 'SSQ_*' -and
    $_ -ne 'activityDef' -and  # We'll handle activityDef separately
    $_ -ne $FocusEntity  # We'll handle focus entity separately
}
# Write focus entity first for visual prominence
if ($includedEntities -contains $FocusEntity) {
    $displayName = if ($entityDisplayNames.ContainsKey($FocusEntity)) { $entityDisplayNames[$FocusEntity] } else { $FocusEntity }
    Write-Host "Focus Entity: $FocusEntity, DisplayName: $displayName"
    
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% $displayName %%"
        Add-Content -Path $outputMDFile -Value "    %% $displayName %%"
        Add-Content -Path $outputFile -Value "    $FocusEntity"
        Add-Content -Path $outputMDFile -Value "    $FocusEntity"
    } else {
        # Class diagram with stereotype for display name
        Add-Content -Path $outputFile -Value "    class $FocusEntity as $displayName"
        Add-Content -Path $outputMDFile -Value "    class $FocusEntity as $displayName"
        if ($displayName -ne $FocusEntity) {
            Add-Content -Path $outputFile -Value "    $FocusEntity : <<$displayName>>"
            Add-Content -Path $outputMDFile -Value "    $FocusEntity : <<$displayName>>"
        }
    }
}

foreach ($entity in $coreEntities) {
    $displayName = if ($entityDisplayNames.ContainsKey($entity)) { $entityDisplayNames[$entity] } else { $entity }
    Write-Host "Entity: $entity, DisplayName: $displayName"
    
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    $entity"
        Add-Content -Path $outputMDFile -Value "    $entity"
    } else {
        # Class diagram with stereotype for display name
        Add-Content -Path $outputFile -Value "    class $entity as $displayName"
        Add-Content -Path $outputMDFile -Value "    class $entity as $displayName"
        if ($displayName -ne $entity) {
            Add-Content -Path $outputFile -Value "    $entity : <<$displayName>>"
            Add-Content -Path $outputMDFile -Value "    $entity : <<$displayName>>"
        }
    }
}

# Handle focus entity with grouped properties
if ($includedEntities -contains $FocusEntity) {
    $displayName = if ($entityDisplayNames.ContainsKey($FocusEntity)) { $entityDisplayNames[$FocusEntity] } else { $FocusEntity }
    
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% $displayName %%"
        Add-Content -Path $outputMDFile -Value "    %% $displayName %%"
        Add-Content -Path $outputFile -Value "    $FocusEntity"
        Add-Content -Path $outputMDFile -Value "    $FocusEntity"
    } else {
        # Class diagram with properties and stereotype for focus entity
        Add-Content -Path $outputFile -Value "    class $FocusEntity as $displayName {"
        Add-Content -Path $outputMDFile -Value "    class $FocusEntity as $displayName {"
        Add-Content -Path $outputFile -Value "        %% Focus Entity Properties %%"
        Add-Content -Path $outputMDFile -Value "        %% Focus Entity Properties %%"
        Add-Content -Path $outputFile -Value "        +"
        Add-Content -Path $outputMDFile -Value "        +"
        Add-Content -Path $outputFile -Value "        +"
        Add-Content -Path $outputMDFile -Value "        +"
        Add-Content -Path $outputFile -Value "        +"
        Add-Content -Path $outputMDFile -Value "        +"
        Add-Content -Path $outputFile -Value "    }"
        Add-Content -Path $outputMDFile -Value "    }"
    }
}

# Handle activityDef with minimal properties (if not the focus entity)
if ($includedEntities -contains 'activityDef' -and $FocusEntity -ne 'activityDef') {
    $displayName = if ($entityDisplayNames.ContainsKey('activityDef')) { $entityDisplayNames['activityDef'] } else { 'Activity Definition' }
    
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% $displayName %%"
        Add-Content -Path $outputMDFile -Value "    %% $displayName %%"
        Add-Content -Path $outputFile -Value "    activityDef"
        Add-Content -Path $outputMDFile -Value "    activityDef"
    } else {
        # Class diagram with minimal properties for non-focus entity
        Add-Content -Path $outputFile -Value "    class activityDef as $displayName {"
        Add-Content -Path $outputMDFile -Value "    class activityDef as $displayName {"
        Add-Content -Path $outputFile -Value "        +"
        Add-Content -Path $outputMDFile -Value "        +"
        Add-Content -Path $outputFile -Value "        +"
        Add-Content -Path $outputMDFile -Value "        +"
        Add-Content -Path $outputFile -Value "    }"
        Add-Content -Path $outputMDFile -Value "    }"
    }
}

# Add interact activity entities to make them more visible
if ($DiagramType -eq "ER") {
    Add-Content -Path $outputFile -Value "    %% Interact Activity Entities %%"
    Add-Content -Path $outputMDFile -Value "    %% Interact Activity Entities %%"
    Add-Content -Path $outputFile -Value "    aInteract1Activities"
    Add-Content -Path $outputMDFile -Value "    aInteract1Activities"
    Add-Content -Path $outputFile -Value "    aInteract2Activities"
    Add-Content -Path $outputMDFile -Value "    aInteract2Activities"
    Add-Content -Path $outputFile -Value "    aInteract3Activities"
    Add-Content -Path $outputMDFile -Value "    aInteract3Activities"
    Add-Content -Path $outputFile -Value "    aInteract4Activities"
    Add-Content -Path $outputMDFile -Value "    aInteract4Activities"
    Add-Content -Path $outputFile -Value "    aInteract5Activities"
    Add-Content -Path $outputMDFile -Value "    aInteract5Activities"
} else {
    # Class diagram - interact activities as separate classes with stereotype
    $interactNames = @(
        @{name = 'aInteract1Activities'; label = 'Interact 1 Activities'},
        @{name = 'aInteract2Activities'; label = 'Interact 2 Activities'},
        @{name = 'aInteract3Activities'; label = 'Interact 3 Activities'},
        @{name = 'aInteract4Activities'; label = 'Interact 4 Activities'},
        @{name = 'aInteract5Activities'; label = 'Interact 5 Activities'}
    )
    foreach ($interact in $interactNames) {
        Add-Content -Path $outputFile -Value "    class $($interact.name)"
        Add-Content -Path $outputMDFile -Value "    class $($interact.name)"
        Add-Content -Path $outputFile -Value "    $($interact.name) : <<$($interact.label)>>"
        Add-Content -Path $outputMDFile -Value "    $($interact.name) : <<$($interact.label)>>"
    }
}

# Add SSQ_HUB node if there are SSQ entities (only if there are multiple SSQ entities)
if ($ssqEntities.Count -gt 1) {
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% SSQ Entities %%"
        Add-Content -Path $outputMDFile -Value "    %% SSQ Entities %%"
        Add-Content -Path $outputFile -Value "    SSQ_HUB"
        Add-Content -Path $outputMDFile -Value "    SSQ_HUB"
        foreach ($ssq in $ssqEntities) {
            $displayName = if ($entityDisplayNames.ContainsKey($ssq)) { $entityDisplayNames[$ssq] } else { $ssq }
            Add-Content -Path $outputFile -Value "    $ssq"
            Add-Content -Path $outputMDFile -Value "    $ssq"
        }
    } else {
        # Class diagram - SSQ entities with stereotype
        Add-Content -Path $outputFile -Value "    class SSQ_HUB"
        Add-Content -Path $outputMDFile -Value "    class SSQ_HUB"
        Add-Content -Path $outputFile -Value "    SSQ_HUB : <<SSQ Hub>>"
        Add-Content -Path $outputMDFile -Value "    SSQ_HUB : <<SSQ Hub>>"
        foreach ($ssq in $ssqEntities) {
            $displayName = if ($entityDisplayNames.ContainsKey($ssq)) { $entityDisplayNames[$ssq] } else { $ssq }
            Add-Content -Path $outputFile -Value "    class $ssq"
            Add-Content -Path $outputMDFile -Value "    class $ssq"
            Add-Content -Path $outputFile -Value "    $ssq : <<$displayName>>"
            Add-Content -Path $outputMDFile -Value "    $ssq : <<$displayName>>"
        }
    }
}

# Write the relationships with grouping
if ($DiagramType -eq "ER") {
    # Group tracker relationships
    $trackerRels = $focusedRels | Where-Object { $_.ForeignKey -like 'tracker*ID' }
    if ($trackerRels.Count -gt 0) {
        Add-Content -Path $outputFile -Value "    %% Tracker ID Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Tracker ID Relationships %%"
        foreach ($relationship in $trackerRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
        }
    }
} else {
    # Class diagram relationships
    $trackerRels = $focusedRels | Where-Object { $_.ForeignKey -like 'tracker*ID' }
    if ($trackerRels.Count -gt 0) {
        Add-Content -Path $outputFile -Value "    %% Tracker ID Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Tracker ID Relationships %%"
        foreach ($relationship in $trackerRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
        }
    }
}

# Group interact activity relationships
$interactRels = $focusedRels | Where-Object { $_.ForeignKey -like 'aInteract*Activities' }
if ($interactRels.Count -gt 0) {
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Interact Activity Relationships %%"
        foreach ($relationship in $interactRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
        }
    } else {
        Add-Content -Path $outputFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Interact Activity Relationships %%"
        foreach ($relationship in $interactRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
        }
    }
} else {
    # If no interact relationships found in ftJoin, add them manually
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputFile -Value "    activityDef }o--|| aInteract1Activities : `"aInteract1Activities`""
        Add-Content -Path $outputMDFile -Value "    activityDef }o--|| aInteract1Activities : `"aInteract1Activities`""
        Add-Content -Path $outputFile -Value "    activityDef }o--|| aInteract2Activities : `"aInteract2Activities`""
        Add-Content -Path $outputMDFile -Value "    activityDef }o--|| aInteract2Activities : `"aInteract2Activities`""
        Add-Content -Path $outputFile -Value "    activityDef }o--|| aInteract3Activities : `"aInteract3Activities`""
        Add-Content -Path $outputMDFile -Value "    activityDef }o--|| aInteract3Activities : `"aInteract3Activities`""
        Add-Content -Path $outputFile -Value "    activityDef }o--|| aInteract4Activities : `"aInteract4Activities`""
        Add-Content -Path $outputMDFile -Value "    activityDef }o--|| aInteract4Activities : `"aInteract4Activities`""
        Add-Content -Path $outputFile -Value "    activityDef }o--|| aInteract5Activities : `"aInteract5Activities`""
        Add-Content -Path $outputMDFile -Value "    activityDef }o--|| aInteract5Activities : `"aInteract5Activities`""
    } else {
        Add-Content -Path $outputFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% Interact Activity Relationships %%"
        Add-Content -Path $outputFile -Value "    activityDef -- aInteract1Activities : aInteract1Activities"
        Add-Content -Path $outputMDFile -Value "    activityDef -- aInteract1Activities : aInteract1Activities"
        Add-Content -Path $outputFile -Value "    activityDef -- aInteract2Activities : aInteract2Activities"
        Add-Content -Path $outputMDFile -Value "    activityDef -- aInteract2Activities : aInteract2Activities"
        Add-Content -Path $outputFile -Value "    activityDef -- aInteract3Activities : aInteract3Activities"
        Add-Content -Path $outputMDFile -Value "    activityDef -- aInteract3Activities : aInteract3Activities"
        Add-Content -Path $outputFile -Value "    activityDef -- aInteract4Activities : aInteract4Activities"
        Add-Content -Path $outputMDFile -Value "    activityDef -- aInteract4Activities : aInteract4Activities"
        Add-Content -Path $outputFile -Value "    activityDef -- aInteract5Activities : aInteract5Activities"
        Add-Content -Path $outputMDFile -Value "    activityDef -- aInteract5Activities : aInteract5Activities"
    }
}

# Group SSQ relationships (only if there are multiple SSQ entities)
$ssqRels = $focusedRels | Where-Object { $_.SourceTable -like 'SSQ_*' -or $_.TargetTable -like 'SSQ_*' }
if ($ssqRels.Count -gt 0 -and $ssqEntities.Count -gt 1) {
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% SSQ Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% SSQ Relationships %%"
        foreach ($relationship in $ssqRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
        }
    } else {
        Add-Content -Path $outputFile -Value "    %% SSQ Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% SSQ Relationships %%"
        foreach ($relationship in $ssqRels) {
            Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
            Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
        }
    }
} else {
    # If no SSQ relationships found in ftJoin, add them manually (only if multiple SSQ entities)
    if ($ssqEntities.Count -gt 1) {
        if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    %% SSQ Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% SSQ Relationships %%"
        foreach ($ssq in $ssqEntities) {
            Add-Content -Path $outputFile -Value "    SSQ_HUB }o--|| $ssq : `"$ssq`""
            Add-Content -Path $outputMDFile -Value "    SSQ_HUB }o--|| $ssq : `"$ssq`""
        }
    } else {
        Add-Content -Path $outputFile -Value "    %% SSQ Relationships %%"
        Add-Content -Path $outputMDFile -Value "    %% SSQ Relationships %%"
        foreach ($ssq in $ssqEntities) {
            Add-Content -Path $outputFile -Value "    SSQ_HUB -- $ssq : $ssq"
            Add-Content -Path $outputMDFile -Value "    SSQ_HUB -- $ssq : $ssq"
        }
    }
}
}

# Write other relationships
$otherRels = $focusedRels | Where-Object { 
    $_.ForeignKey -notlike 'tracker*ID' -and 
    $_.ForeignKey -notlike 'aInteract*Activities' -and
    $_.SourceTable -notlike 'SSQ_*' -and 
    $_.TargetTable -notlike 'SSQ_*'
}
foreach ($relationship in $otherRels) {
    if ($DiagramType -eq "ER") {
        Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
        Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) }o--|| $($relationship.TargetTable) : `"$($relationship.ForeignKey)`""
    } else {
        Add-Content -Path $outputFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
        Add-Content -Path $outputMDFile -Value "    $($relationship.SourceTable) -- $($relationship.TargetTable) : $($relationship.ForeignKey)"
    }
}
# Add relationships from SSQ_HUB to each SSQ entity (only for ER diagrams and if hub exists)
if ($DiagramType -eq "ER" -and $ssqEntities.Count -gt 1) {
    foreach ($ssq in $ssqEntities) {
        Add-Content -Path $outputFile -Value "    SSQ_HUB ||--o{ $ssq : `"hub_connection`""
        Add-Content -Path $outputMDFile -Value "    SSQ_HUB ||--o{ $ssq : `"hub_connection`""
    }
}

# Style directives are now handled entirely by the external CSS file
# This prevents duplicate style definitions that can cause syntax errors

# Inject external Mermaid style directives from css/mermaid_styles.css
$cssLines = Get-Content "$PSScriptRoot/../../css/mermaid_styles.css"
foreach ($line in $cssLines) {
    $trimmedLine = $line.TrimEnd()
    if ($trimmedLine) {
        Add-Content -Path $outputFile -Value $trimmedLine
        Add-Content -Path $outputMDFile -Value $trimmedLine
    }
}

Add-Content -Path $outputMDFile -Value '```'

# Call the Node.js script to generate the URL
$nodeScriptPath = Join-Path $ProjectRoot "src\node\generate_url.js"
$encodedUrl = Get-Content $outputFile -Raw | node $nodeScriptPath 2>$null

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error generating URL. Please check the Node.js script."
    exit 1
}

# Launch the URL in Chrome with robust debug output
if ($encodedUrl -and $encodedUrl.Trim()) {
    $url = $encodedUrl.Trim()
    Write-Host "Generated URL: $url"
    Write-Host "Attempting to launch Chrome with URL:"
    Write-Host $url
    try {
        Start-Process "chrome.exe" $url -ErrorAction Stop
        Write-Host "Chrome launched successfully!"
    } catch {
        Write-Host "Failed to open Chrome automatically. Please copy and paste this URL:"
        Write-Host $url
    }
} else {
    Write-Host "No URL generated. Please check the Node.js script and output file."
} 