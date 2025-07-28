# Relationship Detection Module
# This module handles CFC relationship detection using attribute parsing
# to be called from the main generate_erd_enhanced.ps1 script

# Function to parse cfproperty attributes
function Parse-CFPropertyAttributes {
    param([string]$cfPropertyTag)
    
    $attributes = @{}
    
    # Extract all attribute="value" pairs
    $attributeMatches = [regex]::Matches($cfPropertyTag, '(\w+)="([^"]*)"')
    foreach ($match in $attributeMatches) {
        $attributeName = $match.Groups[1].Value
        $attributeValue = $match.Groups[2].Value
        $attributes[$attributeName] = $attributeValue
    }
    
    return $attributes
}

# Function to check if property should be excluded
function Test-PropertyExclusion {
    param([hashtable]$attributes, [array]$exclusionPatterns)
    
    if (-not $exclusionPatterns) { return $false }
    
    foreach ($pattern in $exclusionPatterns) {
        # Check if any attribute matches the exclusion pattern
        foreach ($attrName in $attributes.Keys) {
            $attrValue = $attributes[$attrName]
            if ($attrValue -match $pattern) {
                return $true
            }
        }
    }
    
    return $false
}

# Function to detect relationships using attribute parsing
function Get-RelationshipsFromContent {
    param(
        [string]$content,
        [string]$entityName,
        [string]$pluginName,
        [object]$config
    )
    
    $relationships = @{
        directFK = @()
        joinTables = @()
        properties = @()
    }
    
    $exclusionPatterns = $config.relationshipPatterns.exclusions.patterns
    
    # Simple approach: Find all cfproperty tags (self-closing or not)
    # Use a basic pattern to find the opening tag, then parse attributes
    $cfPropertyMatches = [regex]::Matches($content, '<cfproperty[^>]*>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    Write-Host "🔍 Processing $entityName - Found $($cfPropertyMatches.Count) cfproperty tags" -ForegroundColor Cyan
    
    foreach ($match in $cfPropertyMatches) {
        $cfPropertyTag = $match.Value
        
        # Parse attributes from the opening tag
        $attributes = Parse-CFPropertyAttributes -cfPropertyTag $cfPropertyTag
        
        # Skip if attributes is null or no name attribute
        if (-not $attributes -or -not $attributes.ContainsKey("name")) { continue }
        
        $propertyName = $attributes["name"]
        
        # Check for exclusions
        if (Test-PropertyExclusion -attributes $attributes -exclusionPatterns $exclusionPatterns) {
            continue
        }
        
        # Check if this is an array relationship
        if ($attributes -and $attributes.ContainsKey("type") -and $attributes["type"] -eq "array" -and $attributes.ContainsKey("ftJoin")) {
            $targetEntity = $attributes["ftJoin"]
            
            Write-Host "  🔗 Array: $propertyName -> $targetEntity" -ForegroundColor Blue
            
            # Join table relationship
            $joinTableName = $config.relationshipPatterns.joinTables.namingPattern -replace "{entity}", $entityName -replace "{target}", $targetEntity
            $relationships.joinTables += @{
                source = $entityName
                sourcePlugin = $pluginName
                target = $targetEntity
                property = $propertyName
                joinTable = $joinTableName
            }
            
            # Store property info
            $relationships.properties += @{
                entity = $entityName
                plugin = $pluginName
                property = $propertyName
                target = $targetEntity
                isArray = $true
            }
        }
        
        # Check if this is a direct FK relationship
        if ($attributes -and $attributes.ContainsKey("ftJoin") -and -not ($attributes.ContainsKey("type") -and $attributes["type"] -eq "array")) {
            $targetEntity = $attributes["ftJoin"]
            
            Write-Host "  🔗 Direct FK: $propertyName -> $targetEntity" -ForegroundColor Green
            
            # Direct FK relationship
            $relationships.directFK += @{
                source = $entityName
                property = $propertyName
                target = $targetEntity
                plugin = $pluginName
            }
            
            # Store property info
            $relationships.properties += @{
                entity = $entityName
                plugin = $pluginName
                property = $propertyName
                target = $targetEntity
                isArray = $false
            }
        }
        # Store all properties for entity definition
        else {
            $ftType = if ($attributes -and $attributes.ContainsKey("ftType")) { $attributes["ftType"] } else { if ($attributes -and $attributes.ContainsKey("type")) { $attributes["type"] } else { "string" } }
            
            $relationships.properties += @{
                entity = $entityName
                plugin = $pluginName
                property = $propertyName
                ftType = $ftType
                isArray = $false
            }
        }
    }
    
    Write-Host "📊 $entityName results: $($relationships.directFK.Count) direct FK, $($relationships.joinTables.Count) join tables" -ForegroundColor Cyan
    
    return $relationships
} 