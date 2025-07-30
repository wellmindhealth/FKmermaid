# FKmermaid - FarCry Codebase Documentation System

A comprehensive PowerShell-based tool for analyzing ColdFusion Components (CFCs) and generating automated documentation with Mermaid diagrams. **Now evolved into a complete codebase documentation ecosystem with ER diagrams, Component diagrams, Confluence integration, and automated documentation workflows!**

## 🎯 Project Vision

**Transform complex ColdFusion codebases into understandable, visual documentation that serves multiple audiences:**

- **👨‍💻 Developers**: Instant visual understanding of component relationships and inheritance
- **🏢 Business Stakeholders**: Clear view of business domains and data flows  
- **🔍 Auditors**: Comprehensive documentation for compliance and security reviews
- **📋 Project Managers**: Impact analysis and change management support
- **🏗️ Architects**: Refactoring planning and system evolution tracking

## 🚀 Current Capabilities

### ✅ **Core Diagram Generation**
- **ER Diagrams**: Entity-Relationship diagrams with 5-tier semantic styling
- **Component Diagrams**: Class diagrams showing inheritance and relationships
- **Dynamic CFC Scanning**: Real-time analysis of ColdFusion Components
- **Domain-Based Filtering**: Focus on specific business domains (partner, participant, programme, site)

### ✅ **Advanced Features**
- **5-Tier Semantic Styling**: Color-coded relationship prioritization
- **Inheritance Visualization**: FarCry CMS inheritance chain (schema → fourq → types → versions)
- **Relationship Detection**: Automatic FK and array relationship extraction
- **Exclusion System**: Two-level exclusion for complete entity removal
- **Caching System**: Optimized performance with relationship caching
- **Comprehensive Logging**: Multi-level logging with file output and rotation

### ✅ **Configuration Management**
- **Automated Config Generation**: From database structure and folder locations
- **Database Integration**: Reads actual database structure from `config/dbdump.sql`
- **Entity-Plugin Mapping**: Automatic mapping based on folder locations
- **Domain Configuration**: JSON-based domain and entity definitions

### ✅ **Testing & Quality**
- **Comprehensive Test Suite**: 5 categories with 26 edge case tests
- **Baseline Validation**: Regression testing with baseline comparison
- **Performance Monitoring**: Built-in metrics and analytics
- **Error Handling**: Graceful degradation and recovery mechanisms

## 🎨 Diagram Types

### **ER Diagrams (Entity-Relationship)**
Visualize database relationships and foreign key connections with advanced styling:

```powershell
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant,partner"
```

**Features:**
- 5-tier semantic styling system
- Focus entity prioritization
- Domain-based filtering
- Foreign key relationship detection
- Array relationship visualization

### **Component Diagrams (Class Diagrams)**
Show ColdFusion Component inheritance and relationships:

```powershell
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,partner"
```

**Features:**
- FarCry CMS inheritance chain visualization
- Component property extraction
- Relationship detection (FK and arrays)
- Domain-based component filtering
- Dynamic CFC scanning with exclusions

## 🏗️ Architecture & Workflow

### **1. Codebase Analysis**
- **CFC Scanning**: Dynamic analysis of ColdFusion Components
- **Database Integration**: Reads actual database structure
- **Relationship Detection**: Automatic FK and array relationship extraction
- **Domain Classification**: Business domain assignment based on `domains.json`

### **2. Diagram Generation**
- **ER Diagrams**: Database-focused relationship visualization
- **Component Diagrams**: Code-focused inheritance and relationship visualization
- **Semantic Styling**: 5-tier color-coded relationship prioritization
- **Focus Prioritization**: Primary entities highlighted for clarity

### **3. Documentation Automation**
- **Confluence Integration**: Automated page creation and diagram embedding
- **GitHub Hosting**: Version-controlled diagram storage
- **Export Formats**: MMD, HTML, PNG, SVG, PDF
- **Change Tracking**: Version comparison and diff visualization

## 🌍 Domain System

The system recognizes four main business domains for relationship filtering:

### **`partner`** - Partner/Business Domain
Business relationships and organizational structure:
- **Core**: partner, referer, intake, center, memberGroup
- **Admin**: farUser, farGroup, farRole, farPermission, dmProfile
- **Programme**: programme, progRole, activityDef, media

### **`participant`** - Participant/User Experience Domain
User journeys and personal data:
- **Core**: member, memberGroup, progMember, activity, programme
- **Tracking**: ssq_stress01, ssq_pain01, ssq_arthritis01, tracker, trackerDef
- **Programme**: progRole, activityDef, media, journal, journalDef, library, guide

### **`programme`** - Programme/Content Domain
Content structure and flow:
- **Core**: programme, progRole, activityDef
- **Content**: media, defaultMediaID, aCuePointActivities, aMediaIDs, guide
- **Flow**: onEndID, aCuePointActivities, aInteract1Activities, etc.

### **`site`** - Site/Website Domain
Website content and structure:
- **Core**: dmNavigation, dmHTML, dmFacts, dmNews, dmInclude
- **Resources**: dmImage, dmFile

## 🔄 Recent Major Enhancements

### **Component Diagram System** ✅ COMPLETED
- [x] **Dynamic CFC Scanning**: Real-time analysis of ColdFusion Components
- [x] **Inheritance Visualization**: FarCry CMS inheritance chain
- [x] **Property Extraction**: Automatic property detection with exclusions
- [x] **Relationship Detection**: FK and array relationship identification
- [x] **Domain Filtering**: Business domain-based component filtering
- [x] **Exclusion System**: Two-level exclusion for complete component removal

### **Confluence Integration** 🚧 IN PROGRESS
- [x] **Automated Page Creation**: PowerShell scripts for Confluence page management
- [x] **GitHub Integration**: Stratus add-on for diagram hosting
- [ ] **Template-Based Approach**: Instructions for viewing diagrams via Stratus
- [ ] **Direct Embedding**: HTML macro structure for Stratus diagrams
- [ ] **Automated Workflow**: End-to-end documentation pipeline
- [ ] **Change Tracking**: Version comparison and diff visualization

### **Configuration Management** ✅ COMPLETED
- [x] **Automated Config Generation**: From database structure and folder locations
- [x] **Database Integration**: Reads actual database structure from `config/dbdump.sql`
- [x] **Entity-Plugin Mapping**: Automatic mapping based on folder locations
- [x] **Exclusion System**: Two-level exclusion for complete entity removal

### **Comprehensive Testing** ✅ COMPLETED
- [x] **5 Test Categories**: CFC scan, exclusions, styling, domain detection, manual verification
- [x] **26 Edge Case Tests**: Comprehensive validation under unusual conditions
- [x] **Baseline Management**: Regression testing with baseline comparison
- [x] **Performance Monitoring**: Built-in metrics and analytics

## 🚀 Roadmap & Future Enhancements

### Phase 1: Documentation Automation (Q1 2025) 🚧 IN PROGRESS
- [x] **Component Diagram System**: Dynamic CFC scanning and visualization
- [x] **Confluence Integration Foundation**: Page creation and diagram embedding
- [ ] **Automated Documentation Pipeline**: End-to-end workflow automation
- [ ] **Change Tracking**: Version comparison and diff visualization
- [ ] **Multi-Format Export**: PNG, SVG, PDF with high resolution

### Phase 2: Enterprise Integration (Q2 2025)
- [ ] **CI/CD Integration**: Automated testing and deployment pipeline
- [ ] **Advanced Relationship Analysis**: Deep relationship analysis and impact assessment
- [ ] **Cross-Domain Analysis**: Relationship patterns across business domains
- [ ] **Performance Optimization**: Enhanced caching and parallel processing

### Phase 3: Intelligence & Automation (Q3 2025)
- [ ] **AI-Powered Features**: Smart entity grouping and pattern recognition
- [ ] **Documentation Automation**: Auto-generated API documentation and change logs
- [ ] **Collaboration Features**: Multi-user editing and review workflows
- [ ] **Advanced Analytics**: Usage analytics and complexity metrics

### Phase 4: Ecosystem Integration (Q4 2025)
- [ ] **IDE Integration**: Visual Studio Code and Cursor extensions
- [ ] **API Documentation**: Auto-generated API docs with visual context
- [ ] **Migration Tools**: Refactoring planning and impact analysis
- [ ] **Compliance Documentation**: Automated audit and compliance reports

## 🎯 Holy Grail: Complete Documentation Ecosystem

### **The Ultimate Vision: Automated Documentation Ecosystem**

Imagine a system where:
- **Developers** get instant visual understanding of code relationships
- **Auditors** receive comprehensive documentation automatically
- **Project Managers** see impact analysis for every change
- **Architects** can plan refactoring with confidence
- **Business Stakeholders** understand data flows and business processes

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

## 🧪 Testing & Quality Assurance

### **Comprehensive Test Suite**
The system includes **26 comprehensive tests** across 5 categories:

```powershell
# Run all tests
cd tests
.\run_all_tests.ps1
```

### **Test Categories:**
- **CFC Scan Tests**: Configuration generation and validation
- **CFC Exclusions Tests**: Entity exclusion functionality  
- **5-Tier Semantic Styling Tests**: Color-coded relationship validation
- **Domain Detection Tests**: Focus entity and domain filtering
- **Manual Verification Tests**: End-to-end workflow validation

### **Expected Results:**
```
Total Tests: 26
Passed: 21
Expected Failures: 5 (script requires focus parameter)
Actual Failures: 0
Success Rate: 100%
```

## 📖 Usage Examples

### **ER Diagram Generation**
```powershell
# Basic ER diagram with focus entity
.\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "programme"

# Multiple domains with fresh scan
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant,partner" -RefreshCFCs

# Custom output file
.\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "programme" -OutputFile "custom_diagram.mmd"
```

### **Component Diagram Generation**
```powershell
# Basic component diagram
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,partner"

# With inheritance and relationships
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,partner" -ShowInheritance -ShowRelationships

# Force refresh of CFC scanning
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,partner" -RefreshCFCs
```

### **Configuration Management**
```powershell
# Generate configuration from database structure
.\generate_cfc_scan_config.ps1

# Test configuration generation
.\tests\cfc_scan_tests\test_config_generation.ps1
```

## 📁 Project Structure

```
FKmermaid/
├── config/
│   ├── domains.json              # Domain and entity definitions
│   ├── cfc_scan_config.json     # CFC scanning configuration
│   ├── cfc_cache.json           # Cached component data
│   ├── logging.json             # Logging configuration
│   └── dbdump.sql              # Database structure reference
├── src/powershell/
│   ├── generate_erd_enhanced.ps1        # Main ER diagram generator
│   ├── generate_component_diagram.ps1   # Component diagram generator
│   ├── generate_cfc_scan_config.ps1     # Configuration generator from DB
│   ├── relationship_detection.ps1       # CFC relationship detection
│   ├── confluence_integration.ps1       # Confluence page management
│   ├── logger.ps1                       # Logging module
│   └── logging_integration.ps1          # Logging integration helpers
├── tests/
│   ├── run_all_tests.ps1                # Main test runner
│   ├── main_script_tests/               # Core functionality tests
│   ├── baseline_tests/                  # Regression testing
│   ├── cfc_scan_tests/                 # Configuration tests
│   ├── logging_tests/                   # Logging system tests
│   └── results/                         # Test results and reports
├── logs/                        # Log files (auto-created)
│   ├── fkmermaid_*.log         # Application logs
│   └── *.log                   # Rotated log files
├── exports/                     # Generated diagram files
│   ├── *.mmd                   # Mermaid source files
│   └── *.html                  # HTML viewer files
└── README.md                   # This file
```

## 🔧 Configuration

### **Domain Configuration**
Domain definitions are stored in `config/domains.json`:

```json
{
  "domains": {
    "partner": {
      "description": "Partner/Business Domain - Business relationships and organizational structure",
      "entities": {
        "core": ["partner", "referer", "intake", "center", "memberGroup"],
        "admin": ["farUser", "farGroup", "farRole", "farPermission", "dmProfile"],
        "programme": ["programme", "progRole", "activityDef", "media"]
      }
    }
  }
}
```

### **CFC Scan Configuration**
Automatically generated from database structure:

```powershell
# Generate configuration from database and folder structure
.\generate_cfc_scan_config.ps1
```

### **Exclusion System**
Two-level exclusion for complete entity removal:

```json
{
  "scanSettings": {
    "excludeFiles": ["participant.cfc", "module.cfc"],
    "excludeFolders": ["farcrycms", "social", "aws"]
  }
}
```

### **Generating Configuration from Database**

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

### **How the Exclusion System Works**

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

## 🚨 Troubleshooting

### **Common Issues:**
- **No diagram displayed**: Check the generated `.mmd` file for syntax errors
- **Missing entities**: Verify the entity exists in the specified domains
- **Browser issues**: Try opening the `.html` file manually
- **Test failures**: Run `.\run_all_tests.ps1` to identify specific issues
- **Configuration issues**: Run `.\generate_cfc_scan_config.ps1` to regenerate config

### **Debug Mode:**
```powershell
# Enable debug logging
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant" -Debug
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,partner" -Debug
```

## 🤝 Contributing

We welcome contributions! Areas for improvement:
- Performance optimizations
- New diagram types
- Enhanced error handling
- Documentation improvements
- Test coverage expansion
- Confluence integration enhancements

## 📄 License

This project is part of the FarCry ecosystem and follows the same licensing terms. 