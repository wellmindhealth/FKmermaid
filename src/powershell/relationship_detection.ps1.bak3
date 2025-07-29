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

# Function to extract relationships from CFC content
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
    
    # Handle multiline cfproperty tags properly
    $cfPropertyMatches = @()
    
    # First, try to find complete cfproperty tags (self-closing)
    $selfClosingMatches = [regex]::Matches($content, '<cfproperty[^>]*?>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $selfClosingMatches) {
        $cfPropertyMatches += $match
    }
    
    # Then find opening cfproperty tags that might span multiple lines
    $openingMatches = [regex]::Matches($content, '<cfproperty[^>]*>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    foreach ($match in $openingMatches) {
        # Skip if this is already a self-closing tag
        if ($match.Value -notmatch '>$') {
            $cfPropertyMatches += $match
        }
    }
    
    foreach ($match in $cfPropertyMatches) {
        $cfPropertyTag = $match.Value
        
        # Parse attributes from the opening tag
        $attributes = Parse-CFPropertyAttributes -cfPropertyTag $cfPropertyTag
        
        # Skip if attributes is null or no name attribute
        if (-not $attributes -or -not $attributes.ContainsKey("name")) { continue }
        
        $propertyName = $attributes["name"]
        
        # Check for exclusions
        if ($exclusionPatterns) {
            $isExcluded = Test-PropertyExclusion -attributes $attributes -exclusionPatterns $exclusionPatterns
            if ($isExcluded) {
                continue
            }
        }
        
        # Check if this is an array relationship (must have both type="array" AND ftJoin)
        if ($attributes -and $attributes.ContainsKey("type") -and $attributes["type"] -eq "array" -and $attributes.ContainsKey("ftJoin")) {
            $targetEntity = $attributes["ftJoin"]
            
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
    }
    
    return $relationships
} 