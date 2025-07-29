# FKmermaid ER Diagram Generator

A PowerShell-based tool for generating Entity-Relationship (ER) and Class diagrams from ColdFusion Components (CFCs), visualized with Mermaid diagrams. **Now with comprehensive testing, shared logic, and roadmap for enterprise integration!**

## 🎯 Current Status

✅ **All tests passing** - Comprehensive test suite with 4 categories  
✅ **Shared logic** - ER and Class diagrams use unified relationship processing  
✅ **Entity consolidation** - Prevents duplicate entities (e.g., `dmImage`)  
✅ **Self-referencing grouping** - Both diagram types properly group self-refs  
✅ **Robust error handling** - Directory creation and parameter validation  
✅ **Caching system** - Optimized performance with relationship caching  

## 🔄 Upcoming Enhancements

### **Enhanced Testing & Analysis**
- [ ] **Deeper Entity Mapping** - More sophisticated relationship pattern recognition
- [ ] **Cross-Domain Analysis** - Better understanding of relationships across domains
- [ ] **Relationship Strength Scoring** - Quantify relationship importance
- [ ] **Advanced Test Scenarios** - Edge cases and complex relationship testing
- [ ] **Performance Benchmarking** - Test suite for large-scale diagrams

### **Advanced Relationship Analysis**
- [ ] **Impact Analysis** - What happens when entities change
- [ ] **Dependency Chains** - Multi-level relationship tracing
- [ ] **Circular Dependency Detection** - Identify problematic relationship cycles
- [ ] **Relationship Visualization** - Different views of the same relationships

## 🚀 Roadmap & Future Enhancements

### Phase 1: Foundation Improvements (Q1 2024)
- [ ] **Configuration Management**
  - [ ] Remove hardcoded paths (`D:\GIT\farcry\Cursor\FKmermaid`)
  - [ ] Environment variable support
  - [ ] Portable configuration system
  - [ ] Cross-platform compatibility

- [ ] **Performance Optimizations**
  - [ ] Enhanced caching with TTL (Time To Live)
  - [ ] Memory usage optimization for large diagrams
  - [ ] Parallel processing for CFC scanning
  - [ ] Incremental updates (only scan changed files)

- [ ] **Advanced Error Handling**
  - [ ] Comprehensive exception handling
  - [ ] Detailed error logging
  - [ ] Graceful degradation
  - [ ] Recovery mechanisms

### Phase 2: Enhanced Features (Q2 2024) ✅ COMPLETED
- [x] **Analytics & Monitoring**
  - [x] Performance metrics collection
  - [x] Usage analytics dashboard
  - [x] Error tracking and reporting
  - [x] Diagram complexity metrics

- [x] **Advanced Diagram Types**
  - [x] Sequence diagrams
  - [x] Flowcharts
  - [x] State diagrams
  - [x] Component diagrams

- [x] **Export Formats**
  - [x] PNG export with high resolution
  - [x] SVG export for web use
  - [x] PDF export for documentation
  - [x] Multiple format batch export

- [x] **Enhanced Testing**
  - [x] Comprehensive test suite with 4 categories
  - [x] Baseline validation and regression testing
  - [x] Fresh generation approach with expectation updates
  - [x] Automated test result analysis

### Phase 3: Enterprise Integration (Q3 2024)
- [ ] **🦄 HOLY GRAIL: Confluence Integration**
  - [ ] **Automated Confluence page creation**
  - [ ] **Diagram sets for auto-upload to Confluence**
  - [ ] **Developer documentation automation**
  - [ ] **Auditor-friendly relationship documentation**
  - [ ] **Refactoring planning support**
  - [ ] **Version control integration**
  - [ ] **Change tracking and diff visualization**

- [ ] **CI/CD Integration**
  - [ ] Automated testing pipeline
  - [ ] Deployment automation
  - [ ] Version management
  - [ ] Release automation

- [ ] **Advanced Relationship Analysis**
  - [ ] Deep relationship analysis
  - [ ] Impact analysis for changes
  - [ ] Dependency mapping
  - [ ] Circular dependency detection
  - [ ] Deeper entity mapping and relationship patterns
  - [ ] Cross-domain relationship analysis
  - [ ] Relationship strength scoring

### Phase 4: Intelligence & Automation (Q4 2024)
- [ ] **AI-Powered Features**
  - [ ] Smart entity grouping
  - [ ] Automatic domain detection
  - [ ] Relationship pattern recognition
  - [ ] Anomaly detection

- [ ] **Documentation Automation**
  - [ ] Auto-generated API documentation
  - [ ] Code comments from diagrams
  - [ ] Change log generation
  - [ ] Migration guides

- [ ] **Collaboration Features**
  - [ ] Multi-user diagram editing
  - [ ] Comment and annotation system
  - [ ] Review and approval workflows
  - [ ] Real-time collaboration

## 🎯 Holy Grail: Confluence Integration Vision

### **The Ultimate Goal: Automated Documentation Ecosystem**

Imagine a system where:
- **Developers** get instant visual understanding of code relationships
- **Auditors** receive comprehensive documentation automatically
- **Project Managers** see impact analysis for every change
- **Architects** can plan refactoring with confidence

### **Confluence Integration Features:**
1. **Automated Page Creation**
   - Generate Confluence pages from diagram sets
   - Automatic table of contents
   - Cross-referenced documentation

2. **Developer Documentation**
   - Entity relationship guides
   - API documentation with visual context
   - Code change impact analysis

3. **Auditor Documentation**
   - Compliance documentation
   - Data flow diagrams
   - Security relationship mapping

4. **Refactoring Support**
   - Before/after comparison views
   - Impact analysis for changes
   - Migration planning tools

## Features

- **Dual Diagram Types**: Generate ER diagrams or Class diagrams
- **Focus Entity Prioritization**: Primary focus entity appears first in the diagram
- **Domain Filtering**: Filter relationships by specific domains
- **Reliable Viewing**: Local HTML files with embedded Mermaid diagrams
- **Multiple Viewing Options**: HTML files, manual copy-paste, and content display
- **Clean Output**: User-friendly interface with clear instructions
- **Comprehensive Testing**: Full test suite with baseline validation
- **Shared Logic**: Unified relationship processing for both diagram types

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

## Testing

The project includes a comprehensive test suite:

```powershell
# Run all tests
cd tests
.\run_all_tests.ps1
```

### Test Categories:
- **CFC Scan Tests**: Configuration generation and validation
- **Main Script Tests**: 4-tier semantic styling system
- **Baseline Tests**: Regression testing with known outputs
- **Integration Tests**: End-to-end workflow validation

### Test Results:
- ✅ **All tests passing**
- ✅ **Comprehensive validation**
- ✅ **Baseline regression protection**
- ✅ **Performance monitoring**

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
│   ├── generate_cfc_scan_config.ps1  # Configuration generator from DB
│   └── relationship_detection.ps1     # CFC relationship detection
├── tests/
│   ├── run_all_tests.ps1             # Main test runner
│   ├── main_script_tests/            # Core functionality tests
│   ├── baseline_tests/               # Regression testing
│   └── results/                      # Test results and reports
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
- **Test failures**: Run `.\run_all_tests.ps1` to identify specific issues

## Contributing

We welcome contributions! Areas for improvement:
- Performance optimizations
- New diagram types
- Enhanced error handling
- Documentation improvements
- Test coverage expansion

## License

This project is part of the FarCry ecosystem and follows the same licensing terms. 