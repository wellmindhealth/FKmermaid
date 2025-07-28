# FKmermaid ER Diagram Generator

A PowerShell-based tool for generating Entity-Relationship (ER) and Class diagrams from domain configurations, visualized with Mermaid diagrams.

## Features

- **Dual Diagram Types**: Generate ER diagrams or Class diagrams
- **Focus Entity Prioritization**: Primary focus entity appears first in the diagram
- **Domain Filtering**: Filter relationships by specific domains
- **Reliable Viewing**: Local HTML files with embedded Mermaid diagrams
- **Multiple Viewing Options**: HTML files, manual copy-paste, and content display
- **Clean Output**: User-friendly interface with clear instructions

## Domain Definitions

The tool recognizes four main domains for relationship filtering. Domain configurations are stored in `config/domains.json` for easy maintenance.

### **`partner`** - Partner/Business Domain
Partner-related entities for business relationships and organizational structure.

### **`participant`** - Participant/User Experience Domain
Participant-related entities for user journeys and personal data.

### **`programme`** - Programme/Content Domain
Programme-related entities for content structure and flow.

### **`site`** - Site/Website Domain
Site-related entities for website content and location management.

> **Note**: The complete list of entities for each domain is maintained in `config/domains.json`. This file can be updated as new entities are discovered or domains evolve.

## Configuration

### Generating Configuration from Database

The `generate_cfc_scan_config.ps1` script automatically generates the `cfc_scan_config.json` file by:

1. **Analyzing the database structure** from `config/dbdump.sql`
2. **Scanning folder locations** to find CFC files in:
   - `zfarcrycore/packages/types/` (core entities)
   - `plugins/*/packages/types/` (plugin entities)
3. **Creating accurate entity-plugin mappings** based on actual folder locations
4. **Filtering knownTables** to only include entities that exist in both database and CFC files

This ensures:
- ✅ **Accurate `knownTables`** based on actual database structure
- ✅ **Correct `entityPluginMapping`** based on folder locations (not hardcoded)
- ✅ **Automatic updates** when database or folder structure changes

```powershell
# Generate configuration from database and folder structure
.\generate_cfc_scan_config.ps1
```

### Exclusion System

The tool uses a two-level exclusion system to ensure entities are completely removed from diagram generation:

1. **`excludeFiles`** - Prevents CFC files from being scanned for relationships
2. **`knownTables` filtering** - Removes entities from the database-derived table list

**How it works:**
- The generator script reads the existing `cfc_scan_config.json`
- Extracts the `excludeFiles` array (e.g., `["farFilter.cfc", "farTask.cfc"]`)
- Converts `.cfc` filenames to entity names (e.g., `farFilter.cfc` → `farFilter`)
- Filters the `knownTables` array to exclude these entities
- Updates the config with the filtered `knownTables`

**To exclude an entity:**
1. Add the `.cfc` filename to the `excludeFiles` array in `cfc_scan_config.json`
2. Run `.\generate_cfc_scan_config.ps1` to regenerate the config
3. The entity will be excluded from both CFC scanning and `knownTables`

**Example:**
```json
{
  "scanSettings": {
    "excludeFiles": [
      "participant.cfc",
      "module.cfc", 
      "farFilter.cfc",
      "farTask.cfc"
    ]
  }
}
```

This ensures that excluded entities never appear in generated diagrams, even if they exist in the database.

## Usage
```powershell
.\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "programme"
```

### Advanced Usage with Multiple Domains
```powershell
.\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "programme","participant"
```

### Complete Parameter Reference

**REQUIRED PARAMETERS:**
- `-lFocus`: The primary entity to focus on (e.g., "activityDef", "progRole", "member")
- `-DiagramType`: Choose between "ER" or "Class" diagrams
- `-lDomains`: Array of domains to filter relationships (e.g., "partner","participant","programme","site")

**OPTIONAL PARAMETERS:**
- `-RefreshCFCs`: Switch to force fresh CFC scanning (bypasses cache)
- `-ConfigFile`: Custom config file path (default: config/cfc_scan_config.json)
- `-OutputFile`: Custom output file path (default: auto-generated timestamped file)

### Parameter Examples

```powershell
# Basic ER diagram with focus entity
.\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "programme"

# Class diagram with fresh scan
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "Class" -lDomains "participant" -RefreshCFCs

# Custom output file
.\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "programme" -OutputFile "custom_diagram.mmd"

# Multiple domains with custom config
.\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "programme","participant" -ConfigFile "custom_config.json"
```

## Output

The tool generates:
1. **`.mmd` file** - Mermaid diagram source code
2. **`.html` file** - Local HTML viewer with embedded diagram
3. **Automatic browser opening** - Opens the HTML file directly
4. **Content display** - Shows the generated Mermaid syntax
5. **Manual copy-paste instructions** - For use with Mermaid Live Editor

## Examples

### Generate ER diagram for progRole with programme domain
```powershell
.\generate_erd.ps1 -FocusEntity "progRole" -DiagramType "ER" -lDomains "programme"
```

### Generate Class diagram for member with participant domain
```powershell
.\generate_erd.ps1 -FocusEntity "member" -DiagramType "Class" -lDomains "participant"
```

### Generate ER diagram for activityDef with multiple domains
```powershell
.\generate_erd.ps1 -FocusEntity "activityDef" -DiagramType "ER" -lDomains "programme","participant"
```

### Generate ER diagram for partner with partner domain
```powershell
.\generate_erd.ps1 -FocusEntity "partner" -DiagramType "ER" -lDomains "partner"
```

### Generate Class diagram for dmImage with site domain
```powershell
.\generate_erd.ps1 -FocusEntity "dmImage" -DiagramType "Class" -lDomains "site"
```

## Viewing Options

### 1. Local HTML File (Recommended)
- Automatically opens in your browser
- Most reliable viewing method
- Works offline
- No URL encoding issues

### 2. Manual Copy-Paste
- Copy content from the `.mmd` file
- Go to https://mermaid.live/edit
- Paste the content into the editor

### 3. Content Display
- The script shows the generated Mermaid syntax
- Useful for verification and debugging

## Requirements

- PowerShell 5.1 or higher
- Web browser (Chrome recommended)
- Domain configuration file (`config/domains.json`)

## File Structure

```
FKmermaid/
├── config/
│   ├── domains.json          # Domain and entity definitions
│   ├── cfc_scan_config.json  # CFC scanning configuration
│   └── dbdump.sql           # Database structure reference
├── src/powershell/
│   ├── generate_erd_enhanced.ps1     # Main ER diagram generator
│   └── generate_cfc_scan_config.ps1  # Configuration generator from DB
├── exports/                  # Generated diagram files
│   ├── *.mmd                # Mermaid source files
│   └── *.html               # HTML viewer files
└── README.md                # This file
```

## Troubleshooting

- **No diagram displayed**: Check the generated `.mmd` file for syntax errors
- **Missing entities**: Verify the entity exists in the specified domains
- **Browser issues**: Try opening the `.html` file manually
- **Copy-paste issues**: Ensure you copy the entire content from the `.mmd` file 