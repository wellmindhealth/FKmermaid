# FKmermaid ER Diagram Generator

A PowerShell-based tool for generating Entity-Relationship (ER) and Class diagrams from ColdFusion CFC files, visualized in Mermaid Live Editor.

## Features

- **Dual Diagram Types**: Generate ER diagrams or Class diagrams
- **Focus Entity Highlighting**: Primary focus entity gets distinct visual styling
- **Domain Filtering**: Filter relationships by specific domains
- **Smart Styling**: Automatic entity categorization and visual styling
- **Browser Integration**: Automatic browser launch with Mermaid Live Editor
- **ColdFusion Integration**: Scans CFC files and extracts `ftJoin` relationships

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

## Usage

### Basic Usage
```powershell
.\generate_erd.ps1 -FocusEntity "progRole" -DiagramType "ER"
```

### Advanced Usage with Domain Filtering
```powershell
.\generate_erd.ps1 -FocusEntity "progRole" -DiagramType "ER" -BroadenSpread $true -lDomains "partner","participant"
```

### Parameters

- `-FocusEntity`: The primary entity to focus on (default: "progRole")
- `-DiagramType`: Choose between "ER" or "Class" diagrams (default: "ER")
- `-BroadenSpread`: Include more related entities beyond direct relationships
- `-lDomains`: Array of domains to filter relationships (e.g., "partner","participant","programme","site")

## Visual Styling

- **Focus Entity**: Orange (#ff6b35) with thick white border - highly distinct
- **Partner Entities**: Green (#43a047) with white border
- **Participant Entities**: Blue (#0288d1) with white border
- **SSQ Entities**: Purple (#8e24aa) with white border
- **Interact Entities**: Teal (#009688) with white border
- **Default**: Dark gray (#222) with thin border

## Examples

### Generate ER diagram for progRole with all domains
```powershell
.\generate_erd.ps1 -FocusEntity "progRole" -DiagramType "ER"
```

### Generate Class diagram for member with participant domain only
```powershell
.\generate_erd.ps1 -FocusEntity "member" -DiagramType "Class" -lDomains "participant"
```

### Generate ER diagram for activityDef with programme and participant domains
```powershell
.\generate_erd.ps1 -FocusEntity "activityDef" -DiagramType "ER" -BroadenSpread $true -lDomains "programme","participant"
```

## Output

The tool generates:
1. A `.mmd` file with the Mermaid diagram code
2. A `.md` file with the diagram in markdown format
3. Automatically opens the browser with the diagram in Mermaid Live Editor

## Requirements

- PowerShell 5.1 or higher
- Node.js (for URL compression)
- ColdFusion CFC files with `ftJoin` attributes 