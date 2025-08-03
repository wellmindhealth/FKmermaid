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
- **Domain-Based Filtering**: Focus on specific business domains (provider, participant, pathway)

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
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant,provider"
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
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider"
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

### **4. Quality Assurance & Cross-Checking**
- **Automated Baseline Validation**: Cross-check system validates all generated baselines
- **Dynamic Compatibility**: Works with any diagram count (5, 43, 156, etc.)
- **Comprehensive Analysis**: Entity counts, relationship counts, styling validation
- **Issue Detection**: Identifies disconnected diagrams, syntax errors, count mismatches
- **Quality Reporting**: Detailed JSON reports with issue categorization

## 🌍 Domain System

### **How We Organize Components**

The system uses **4 domains** for diagram generation to preserve cross-domain relationships:

#### **`provider`** - Business relationships and organizational structure
- **Core**: partner, referer, intake, center, memberGroup
- **Admin**: farUser, farGroup, farRole, farPermission, dmProfile
- **Programme**: programme, progRole, activityDef, media

#### **`participant`** - User journeys and personal data
- **Core**: member, memberGroup, progMember, activity, programme
- **Tracking**: ssq_stress01, ssq_pain01, ssq_arthritis01, tracker, trackerDef
- **Programme**: progRole, activityDef, media, journal, journalDef, library, guide

#### **`pathway`** - Content structure and flow
- **Core**: programme, progRole, activityDef
- **Content**: media, defaultMediaID, aCuePointActivities, aMediaIDs, guide
- **Flow**: onEndID, aCuePointActivities, aInteract1Activities, etc.


- **Core**: dmNavigation, dmHTML, dmFacts, dmNews, dmInclude
- **Resources**: dmImage, dmFile



**Why 4 domains?** Because real components connect across boundaries. For example, `member` (participant) connects to `partner` (healthcare organization) - these cross-domain relationships are crucial for understanding the complete system.

## 🎨 **The Oracle of the 5-Tier Color System**

The FKmermaid system uses a sophisticated **5-tier semantic styling system** that creates visual hierarchy based on **domain membership** and **relationship proximity** to the focus entity.

### **🧠 The Color Oracle:**

#### **ORANGE** (`#d75500`) - **FOCUS TIER**
- **What**: The primary focus entity(ies) specified in the `-lFocus` parameter
- **Example**: When you focus on "journal", the journal entity gets orange styling
- **Logic**: Direct focus assignment

#### **GOLD** (`#693a00`) - **DOMAIN + DIRECTLY RELATED**
- **What**: Entities that are BOTH in the same domain as focus AND have direct relationships
- **Example**: If journal is in pathway domain, other pathway entities with direct FK relationships to journal get gold
- **Logic**: `Same Domain` + `Direct Relationship` = Gold

#### **BLUE** (`#1963d2`) - **DIRECTLY RELATED BUT DIFFERENT DOMAIN**
- **What**: Entities from other domains that have direct relationships to the focus
- **Example**: If journal is pathway domain, but dmFile (from zfarcrycore) has direct relationship to journal, dmFile gets blue
- **Logic**: `Different Domain` + `Direct Relationship` = Blue

#### **BLUE-GREY** (`#44517f`) - **SAME DOMAIN BUT NOT DIRECTLY RELATED**
- **What**: Entities in the same domain as focus but without direct relationships
- **Example**: Other pathway domain entities that don't directly relate to journal
- **Logic**: `Same Domain` + `No Direct Relationship` = Blue-Grey

#### **DARK GREY** (`#1a1a1a`) - **DEFAULT/OTHERS**
- **What**: All other entities (different domain + no direct relationship)
- **Example**: Entities from other domains with no direct relationships to focus
- **Logic**: `Different Domain` + `No Direct Relationship` = Dark Grey

### **🎯 The Oracle's Wisdom:**

**Proximity Logic**: Colors represent **relationship proximity** to the focus entity:
- **Orange**: You ARE the focus
- **Gold**: You're in the same "family" (domain) AND directly connected
- **Blue**: You're directly connected but from a different "family" 
- **Blue-Grey**: You're in the same "family" but not directly connected
- **Dark Grey**: You're neither in the same family nor directly connected

**Domain + Relationship Matrix**:
```
                    | Direct Relationship | No Direct Relationship
Same Domain         | GOLD              | BLUE-GREY
Different Domain    | BLUE              | DARK GREY
```

This creates a visual hierarchy showing how "close" each entity is to the focus entity in terms of both domain membership and relationship strength!

## 🏥 Component Familiarization Guide

This section provides detailed descriptions of all components, organized by business function for easy understanding. Each component includes both a **snappy description** (for quick reference) and a **detailed explanation** (for deep understanding).

### **🎯 Participant Management**
**Snappy:** Central participant record connecting individuals to digital therapeutic ecosystem with HCP hierarchy relationships

**Detailed:** The member represents an individual participant in Wellmind Health's digital therapeutic programs. This is the central entity that connects the human participant to the digital treatment ecosystem with personal preferences, progress tracking, and connections to the healthcare provider hierarchy. The member entity serves as the primary participant record, containing personal details, treatment preferences, and critical relationships to the healthcare provider network (partner organizations, member groups, centers, and referrers).

#### **progMember** - Program Enrollment & Progress Tracking
**Snappy:** Active enrollment tracking participant's journey through structured treatment programs with progress monitoring

**Detailed:** progMember represents the active enrollment of a participant in a specific treatment program. This is where the rubber meets the road - where a participant's journey through a structured therapeutic intervention is tracked, measured, and managed. This entity manages enrollment status, progress tracking, completion milestones, and program-specific participant data. It's the operational record that tracks a participant's engagement with a specific treatment pathway.

#### **activity** - Interactive Treatment Steps
**Snappy:** Personalized treatment step instances derived from activityDef templates for participant interaction

**Detailed:** Activities represent the individual interactive steps that participants engage with during their treatment journey. These are derived from activityDef templates but become personalized instances for each participant. Each activity is a participant-specific instance of an activityDef, containing the participant's responses, progress, and interaction data. This creates a personalized treatment experience while maintaining the structured approach defined by the activityDef template.

### **🏢 Healthcare Organization**

#### **partner** - Healthcare Organization Management
**Snappy:** Healthcare organization managing participant access and program delivery across populations

**Detailed:** Partners represent healthcare organizations, enterprises, or institutions that provide Wellmind Health programs to their populations. These could be hospitals, health systems, employers, insurance companies, or other healthcare entities. The partner entity manages organizational relationships, access controls, and administrative oversight. It serves as the top-level organizational structure that determines which participants can access which programs.

#### **memberGroup** - Participant Segmentation & Cohort Management
**Snappy:** Participant cohorts for segmentation, analysis, and organizational structure

**Detailed:** Member groups represent categories or cohorts of participants that share common characteristics, treatment needs, or organizational structures. These could be based on clinical criteria, organizational units, or program-specific cohorts including research studies. Member groups enable segmentation, analysis, and organizational structure within the participant population. They support both clinical decision-making and administrative oversight.

#### **center** - Service Delivery Points
**Snappy:** Physical or virtual service delivery points connecting participants to local care teams

**Detailed:** Centers represent the physical or virtual locations where healthcare services are delivered and participants receive care. While traditionally physical locations, centers can also represent virtual service delivery points, geo-based service areas, or categorical service groupings. Centers manage service delivery logistics, participant access, and local resource allocation. They serve as the operational units that connect participants to specific service delivery models and local care teams.

#### **referer** - Healthcare Professional Network
**Snappy:** Healthcare professionals responsible for participant referrals and ongoing care coordination

**Detailed:** Referrers are healthcare professionals, HR representatives, or other authorized individuals responsible for referring participants to Wellmind Health programs and ultimately responsible for care of participants. The referrer entity manages referral tracking and professional oversight of participant care. It creates accountability and professional oversight while enabling the referral-based access model that many healthcare systems require.

#### **intake** - Capacity Management & Access Control
**Snappy:** Capacity management system controlling participant access to programs with entitlement tracking

**Detailed:** Intake represents the healthcare organization's date or number-based entitlement of participant "places" on a program. This is essentially the capacity management system that controls how many participants can access specific programs. Intake manages capacity limits, access controls, and entitlement tracking. It ensures that healthcare organizations can manage their program capacity while providing appropriate access to their populations.

### **📋 Treatment Program**

#### **programme** - Treatment Program Architecture
**Snappy:** Master treatment template containing activity structure, pacing, and lifecycle management

**Detailed:** The programme entity represents the overarching treatment program structure that contains activity definitions, pacing logic, communication templates, educational resources, and lifecycle management. This is the master template that defines how a specific therapeutic intervention is structured and delivered. Programmes serve as the container for all program-related content, logic, and structure. They define the treatment pathway, activity sequence, communication strategies, and supporting resources for a specific therapeutic intervention.

#### **activityDef** - Treatment Step Templates
**Snappy:** Treatment step templates defining interaction patterns, media requirements, and progression logic

**Detailed:** ActivityDefs represent the definition of individual treatment steps within a program. These are the building blocks that define how participants interact with therapeutic content, complete exercises, or engage with educational materials. Each activityDef defines the structure, media requirements, interaction patterns, and progression logic for a specific treatment step. ActivityDefs serve as templates that define the structure and requirements for individual treatment steps. They contain the logic for media integration, interaction patterns, progression rules, and content structure that will be instantiated for each participant.

#### **media** - Content Delivery System
**Snappy:** Therapeutic content delivery system for videos, audio, and educational materials

**Detailed:** Media represents the video, audio, and document content that delivers therapeutic interventions and educational materials to participants. This includes educational videos, interactive exercises, guided meditations, and supporting documentation that form the core content of digital therapeutic programs. Media entities manage content storage, delivery, and integration with treatment activities. They support multiple content types and delivery formats while maintaining the quality and accessibility standards required for therapeutic content.

### **📊 Assessment & Tracking**

#### **SSQ_stress01** - Stress Assessment Instrument
**Snappy:** Standardized stress assessment questionnaire for anxiety and psychological well-being evaluation

**Detailed:** ssq_stress01 represents a standardized stress assessment questionnaire designed to evaluate participant stress levels, psychological well-being, and treatment progress throughout their therapeutic journey. This entity manages the complete lifecycle of stress-related assessments including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including adaptive questioning and longitudinal trend analysis.

#### **SSQ_pain01** - Pain Assessment Instrument
**Snappy:** Standardized pain assessment questionnaire for chronic pain and functional limitation evaluation

**Detailed:** ssq_pain01 represents an evidence-based pain assessment questionnaire designed to evaluate participant pain levels, functional limitations, and treatment outcomes throughout their therapeutic journey. This entity manages the complete lifecycle of pain assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including multi-dimensional pain evaluation and functional assessment integration.

#### **SSQ_arthritis01** - Arthritis Assessment Instrument
**Snappy:** Standardized arthritis assessment questionnaire for musculoskeletal health and quality of life evaluation

**Detailed:** ssq_arthritis01 represents a specialized assessment questionnaire designed to evaluate arthritis-related symptoms, functional limitations, and treatment outcomes throughout the participant's therapeutic journey. This entity manages the complete lifecycle of arthritis-specific assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including symptom severity evaluation and functional limitation assessment.

#### **tracker** - Confidence Touchpoint Data Collection
**Snappy:** Simple confidence touchpoint system for single-slider assessments with gradual improvement tracking

**Detailed:** tracker represents a simple, lightweight data collection system for capturing participant confidence and satisfaction touchpoints throughout their treatment journey. These are typically single-slider assessments that measure confidence levels, satisfaction, or self-reported progress on specific conditions or treatment areas. tracker manages the collection and storage of simple touchpoint data including confidence ratings, satisfaction scores, and basic progress indicators. The system implements straightforward data collection with minimal participant burden, supporting frequent check-ins that complement more comprehensive assessment instruments.

#### **trackerDef** - Touchpoint Assessment Template System
**Snappy:** Touchpoint template system for quick confidence and satisfaction check-ins throughout treatment

**Detailed:** trackerDef represents the template definition system for simple confidence and satisfaction touchpoints used throughout treatment programs. These templates define basic single-slider assessments that measure participant confidence, satisfaction, or self-reported progress on specific conditions or treatment areas. trackerDef manages the basic metadata and configuration for touchpoint assessments including question text, slider ranges, frequency settings, and basic scoring parameters. The system implements simple template management including basic version control and question configuration.

### **👤 Program Access & Personalization**

#### **progRole** - Program-Specific Access Control
**Snappy:** Program-specific role definitions for participant access control and content delivery

**Detailed:** progRole represents the program-specific access control system that manages participant access and content delivery within individual treatment programs. These roles determine what program content, activities, features, and resources each participant can access based on their enrollment status and treatment progress. progRole implements advanced program-specific access control by defining comprehensive participant permissions within individual treatment programs. The system supports sophisticated access management including progress-based content unlocking and personalized treatment pathway management.

#### **journal** - Participant Personal Documentation
**Snappy:** Private participant personal documentation system for therapeutic reflection and clinical insights

**Detailed:** journal represents the personal documentation and reflection system that enables participants to create and manage personal notes, reflections, and treatment-related documentation throughout their therapeutic journey. journal manages the complete lifecycle of participant-generated content including personal notes, reflections, treatment-related documentation, and therapeutic insights. The system implements advanced content management including privacy controls, content categorization, and search capabilities.

#### **journalDef** - Journal Template Definitions
**Snappy:** Journal template definition system for structured reflection prompts and therapeutic guidance

**Detailed:** journalDef represents the template definition system for structured participant reflection and documentation activities that support treatment engagement and progress tracking. These templates define the prompts, structure, guidance, and therapeutic framework for participant journaling activities. journalDef manages the complete metadata and configuration framework for journaling activities including prompts, structure, guidance, and therapeutic frameworks that ensure consistent and therapeutic journaling experiences across different programs and participants.

#### **library** - Content Resource Management
**Snappy:** Content library system for therapeutic resources, educational materials, and supplementary content

**Detailed:** library represents the content library system for organizing, managing, and delivering therapeutic resources, educational materials, and supporting content to participants throughout their treatment journey. This system includes media, articles, exercises, guides, and supplementary content that complements and enhances core treatment programs. library manages the complete lifecycle of supplementary therapeutic content and resources including content creation, categorization, delivery, and integration with treatment programs. The system implements advanced content management including recommendations and progress-based content delivery.

#### **guide** - Healthcare Professional Profile
**Snappy:** Healthcare professional profile system for content attribution and credibility establishment

**Detailed:** guide represents the professional profile and attribution system for healthcare professionals who deliver core video content and therapeutic interventions throughout treatment programs. These are the talking-head professionals - clinicians, therapists, and subject matter experts - who provide the human connection and expert guidance in the video content. guide manages professional profiles including credentials, expertise areas, professional affiliations, and content attribution for healthcare professionals featured in therapeutic video content. The system implements basic profile management including professional information, content associations, and credibility indicators.

### **🔐 System Administration**

#### **farUser** - System User Management
**Snappy:** Enterprise user management system for healthcare staff with authentication, authorization, and session control

**Detailed:** farUser represents the user management system for healthcare staff, administrators, clinicians, and operational personnel who require access to the Wellmind Health platform. These users are distinct from participants and represent the human workforce responsible for managing the digital therapeutic ecosystem. The farUser entity serves as the cornerstone of the platform's authentication and authorization system, managing user account lifecycle, session management, security credentials, and access control integration. It implements enterprise-grade user management including account creation, password policies, and session timeout controls.

#### **farGroup** - Permission Group Organization
**Snappy:** Strategic permission organization with hierarchical access control and administrative efficiency

**Detailed:** farGroup represents the strategic organization of system permissions and access rights into logical, manageable groupings that align with organizational structure and operational requirements. These groups serve as the foundation for efficient access control administration. farGroup implements an organizational layer within the permission system that groups related permissions into meaningful collections, supporting the principle of least privilege while maintaining administrative efficiency. The system provides sophisticated group management capabilities including nested group structures and dynamic group membership.

#### **farRole** - Role-Based Access Control
**Snappy:** Comprehensive RBAC framework defining user access profiles and operational capabilities

**Detailed:** farRole defines the comprehensive role-based access control framework that governs user access to system functions, data areas, and operational capabilities within the Wellmind Health platform. The system implements sophisticated role definitions including Pathway Admin roles, Participant Admin roles, and Basic Center roles. farRole implements enterprise-grade role-based access control (RBAC) by defining comprehensive collections of permissions that correspond to specific job functions, organizational positions, and operational responsibilities. The system supports advanced role features including role hierarchies and conditional permissions.

#### **farPermission** - Individual Access Rights
**Snappy:** Granular security controls implementing least-privilege access with healthcare-specific permissions

**Detailed:** farPermission represents the fundamental building blocks of the platform's security architecture, defining granular permissions that control access to specific system functions, data areas, operational capabilities, and administrative features. farPermission implements sophisticated permission management including context-sensitive access control, conditional permissions based on organizational relationships, and dynamic permission evaluation based on user attributes and operational context.

#### **dmProfile** - User Profile Management
**Snappy:** User profile management system with personalized settings, preferences, and administrative configurations

**Detailed:** dmProfile represents the user profile management system that extends beyond basic authentication to provide personalized user experiences, administrative configurations, and operational preferences for healthcare staff and administrators. dmProfile manages the complete lifecycle of user-specific settings, preferences, and administrative configurations that customize the user experience and operational capabilities. The system implements advanced profile management including preference persistence and cross-device synchronization.



---



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
.\generate_erd_enhanced.ps1 -lFocus "activityDef" -DiagramType "ER" -lDomains "pathway"

# Multiple domains with fresh scan
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant,provider" -RefreshCFCs

# Custom output file
.\generate_erd_enhanced.ps1 -lFocus "progRole" -DiagramType "ER" -lDomains "pathway" -OutputFile "custom_diagram.mmd"

# Deep relationship exploration (depth 3)
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant" -ApplyDomainFilterAt 3
```

### **Component Diagram Generation**
```powershell
# Basic component diagram
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider"

# With inheritance and relationships
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider" -ShowInheritance -ShowRelationships

# Force refresh of CFC scanning
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider" -RefreshCFCs
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
    "provider": {
      "description": "Provider/Business Domain - Business relationships and organizational structure",
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
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider" -Debug
```

## 🔧 **Unified CFC Cache System**

The project uses a unified cache generation system to ensure all scripts work with the same component metadata:

### **Primary Cache Generator:**
- **`generate_cfc_cache.ps1`** - The main cache generation script
  - Creates rich `componentMetadata` with `displayName`, `hint`, `description`, `faIcon`
  - Extracts full property details with `ftType`, `ftLabel`, `hint`
  - Preserves existing `cfc_cache.json` structure for backward compatibility
  - Used by all diagram generation scripts and the dev.html interface

### **Configuration Generator:**
- **`generate_cfc_scan_config.ps1`** - Creates the scan configuration (database-based)
  - Analyzes database structure from `config/dbdump.sql` (SQL Server schema dump)
  - Maps entities to plugins based on folder locations
  - Creates `cfc_scan_config.json` with `knownTables` and `entityPluginMapping`
  - **When to use**: After database changes or when adding new plugins
  - **Source**: `config/dbdump.sql` contains SQL Server CREATE TABLE statements for `farcrybemindfulonline_new` database

- **`generate_cfc_scan_config.ps1`** - Creates the scan configuration (CFC-based)
  - Analyzes CFC files to extract table names and entity mappings
  - No database dependency - completely self-contained
  - Creates `cfc_scan_config.json` with `knownTables` and `entityPluginMapping`
  - **When to use**: When CFCs change or when you want to eliminate database dependency
  - **Source**: CFC files with `@tableName`, `tableName` property, or filename-based extraction
  - **Exclusions**: Uses centralized `config/exclusions.json` for consistent filtering

## 📋 **Centralized Configuration:**

### **Configuration "Oracle":**
- **`config/cfc_scan_config.json`** - The central "oracle" of known tables and relationships
  - **Purpose**: Defines which CFCs are scanned and how they're categorized
  - **Source**: Generated from CFC analysis (not manually edited)
  - **Contains**: `knownTables`, `entityPluginMapping`, scan settings
  - **Usage**: All scripts reference this as the authoritative source

### **Exclusions Management:**
- **`config/exclusions.json`** - Centralized exclusions configuration (MANUALLY EDITABLE)
  - `excludeFiles`: CFC files to exclude from scanning
  - `excludeFolders`: Plugin folders to exclude
  - `workspaceFolders`: Active workspace folders
  - **Benefits**: Single source of truth, no hardcoded exclusions
  - **Note**: Edit this file to change exclusions, NOT `cfc_scan_config.json`

### **Usage:**
```powershell
# Generate configuration from database structure
.\generate_cfc_scan_config.ps1

# Generate unified CFC cache
.\generate_cfc_cache.ps1

# All other scripts will use the same cache file
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "ER" -lDomains "participant"
.\generate_component_diagram.ps1 -Focus "member" -lDomains "participant,provider"
```

## 🔄 **Workflow for Changes**

### **When CFCs or domains.json changes:**
```powershell
# Option 1: Regenerate everything with fresh cache (RECOMMENDED)
.\generate_all_cfc_diagrams.ps1 -RefreshCFCs

# Option 2: Manual cache refresh first
.\generate_cfc_cache.ps1
.\generate_all_cfc_diagrams.ps1
```

### **For dev.html interface:**
- Always run cache refresh before opening dev.html after changes
- dev.html reads from `config/cfc_cache.json`
- Smart detection checks cache timestamps vs CFC files

## 📋 **Change Impact Analysis:**

### **When CFCs change:**
- **Need**: `generate_cfc_cache.ps1` (updates component metadata)
- **Need**: `generate_cfc_scan_config_from_cfcs.ps1` (updates table mappings - CFC-based)
- **Need**: `generate_all_cfc_diagrams.ps1` (regenerates all diagrams)
- **Need**: `generate_baselines.ps1` (updates test expectations)
- **Workflow**: 
  ```powershell
  .\src\powershell\generate_cfc_scan_config_from_cfcs.ps1
  .\generate_all_cfc_diagrams.ps1 -RefreshCFCs
  .\tests\baseline_tests\generate_baselines.ps1 -Force
  .\tests\update_test_expectations.ps1
  .\tests\run_all_tests.ps1
  ```

### **When domains.json changes:**
- **Need**: `generate_all_cfc_diagrams.ps1` (regenerates all diagrams)
- **Need**: `generate_baselines.ps1` (updates test expectations - domains affect diagram content)
- **Don't need**: `generate_cfc_cache.ps1` (CFC metadata unchanged)
- **Workflow**: 
  ```powershell
  .\generate_all_cfc_diagrams.ps1 -RefreshCFCs
  .\tests\baseline_tests\generate_baselines.ps1 -Force
  .\tests\run_all_tests.ps1
  ```

### **Cache Generation Details:**
- **`generate_cfc_cache.ps1`** generates ALL sections of the cache on every run:
  - `componentMetadata` (component info, hints, descriptions)
  - `directFK` (foreign key relationships)
  - `joinTables` (many-to-many relationships)
  - `entities` (entity definitions)
  - `properties` (property details)
- **Full regeneration**: Always regenerates complete cache structure
- **Backward compatible**: Preserves existing cache format

## 🔄 **Complete Workflow Consolidation:**

### **Development Workflow:**
```powershell
# 1. Quick testing (6 diagrams)
.\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs

# 2. Full generation (dynamic diagrams based on domains.json)
.\generate_all_cfc_diagrams.ps1 -RefreshCFCs

# 3. Update test baselines
.\tests\baseline_tests\generate_baselines.ps1 -Force

# 4. Run test suite
.\tests\run_all_tests.ps1
```

### **File Management:**
- **`all_diagrams_results.json`**: Full diagrams (production)
- **`all_diagrams_results_test.json`**: 6 test diagrams (development)
- **Cleanup**: Remove old `165_diagrams_results.json` after migration

## 🧪 **Testing Workflow:**

### **Quick Testing:**
```powershell
# Generate 6 test diagrams (3 CFCs × 2 domains) for quick testing
.\tests\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs

# Run comprehensive test suite
.\tests\run_all_tests.ps1
```

### **Baseline Regeneration (After CFC or domains.json Changes):**
```powershell
# 1. Regenerate all test baselines
.\tests\baseline_tests\generate_baselines.ps1 -Force

# 2. Update test expectations with new entity counts
# (Manual step: Update ExpectedEntityCount values in test_edge_cases.ps1)

# 3. Run tests to verify baselines are correct
.\tests\run_all_tests.ps1
```

### **When to Regenerate Baselines:**
- **After CFC changes**: Component metadata, relationships, or properties change
- **After domains.json changes**: Domain definitions or entity mappings change (CRITICAL - affects diagram content)
- **After styling changes**: Diagram appearance or formatting changes
- **Before major releases**: Ensure all tests pass with current codebase

### **Test Expectation Updates:**
After baseline regeneration, automatically update `ExpectedEntityCount` values:
```powershell
# Automated update of test expectations
.\tests\update_test_expectations.ps1
```

This script analyzes generated baseline files and updates:
- `tests/baseline_tests/test_edge_cases.ps1` (26 edge case tests)
- `tests/main_script_tests/test_5_tier_system.ps1` (5-tier styling tests)
- `tests/main_script_tests/test_manual_verification.ps1` (manual verification tests)

**Note**: The `update_test_expectations.ps1` script is automatically called by `generate_baselines.ps1` after baseline generation.

### **Test Coverage:**
- **26 edge case baselines**: Comprehensive validation of diagram generation
- **5-tier semantic styling**: Visual consistency and hierarchy testing
- **Domain detection**: Filtering and relationship accuracy
- **Manual verification**: Output quality and completeness checks

## 🎯 **Complete Workflow Summary:**

### **For CFC Changes:**
```powershell
# 1. Quick test (6 diagrams)
.\tests\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs

# 2. Full generation (dynamic diagrams based on domains.json)
.\generate_all_cfc_diagrams.ps1 -RefreshCFCs

# 3. Regenerate baselines
.\tests\baseline_tests\generate_baselines.ps1 -Force

# 4. Update test expectations (automated)
.\tests\update_test_expectations.ps1

# 5. Run test suite
.\tests\run_all_tests.ps1
```

### **For domains.json Changes:**
```powershell
# 1. Full generation (domains affect all diagrams)
.\generate_all_cfc_diagrams.ps1 -RefreshCFCs

# 2. Regenerate baselines (CRITICAL - domains affect content)
.\tests\baseline_tests\generate_baselines.ps1 -Force

# 3. Update test expectations (automated)
.\tests\update_test_expectations.ps1

# 4. Run test suite
.\tests\run_all_tests.ps1
```

### **For Development/Testing:**
```powershell
# Quick iteration
.\tests\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs

# Full validation
.\tests\run_all_tests.ps1
```

### **Cache Structure:**
```json
{
  "directFK": [...],
  "joinTables": [...],
  "entities": [...],
  "componentMetadata": [
    {
      "name": "apiAccessKey",
      "displayName": "API Access Key",
      "hint": "Reference label for key",
      "description": "",
      "faIcon": "",
      "inheritance": "farcry.core.packages.types.versions",
      "properties": [...],
      "plugin": "api",
      "filePath": "/farcry/plugins/api/packages/types/apiAccessKey.cfc"
    }
  ]
}
```

## 📝 **N.B. CFC Documentation Enhancement**

The project includes tools for enhancing ColdFusion Component documentation with comprehensive business context:

### **Process:**
1. **Configuration**: Update `config/component_hints.json` with short descriptions
2. **Scripts**: Use `src/powershell/update_cfc_descriptions.ps1` for bulk updates
3. **Testing**: Use `src/powershell/test_activityDef_update.ps1` for single component testing

### **What Gets Enhanced:**
- **@@Description comments**: Full business context with Business Context, Technical Role, and Key Relationships
- **hint attributes**: Concise, professional descriptions for the `<cfcomponent>` tag

### **Usage:**
```powershell
# Test changes (dry run)
.\update_cfc_descriptions.ps1 -DryRun -Verbose

# Apply changes to all components
.\update_cfc_descriptions.ps1 -DryRun:$false

# Test single component
.\test_activityDef_update.ps1 -DryRun:$false
```

### **Quality Standards:**
- ✅ No quote characters that could break CFC files
- ✅ Consistent terminology (participants, not patients)
- ✅ Business-focused descriptions, not technical jargon
- ✅ Clear relationships explained
- ✅ Professional tone suitable for stakeholders

**This process transforms basic CFC files into comprehensive, self-documenting components that explain the business context to non-FarCry developers!**

## 🎨 **The Oracle of the 5-Tier Color System**

The FKmermaid system uses a sophisticated **5-tier semantic styling system** that creates visual hierarchy based on **domain membership** and **relationship proximity** to the focus entity.

### **🧠 The Color Oracle:**

#### **ORANGE** (`#d75500`) - **FOCUS TIER**
- **What**: The primary focus entity(ies) specified in the `-lFocus` parameter
- **Example**: When you focus on "journal", the journal entity gets orange styling
- **Logic**: Direct focus assignment

#### **RUST** (`#9d3100`) - **DOMAIN + DIRECTLY RELATED**
- **What**: Entities that are BOTH in the same domain as focus AND have direct relationships
- **Example**: If journal is in pathway domain, other pathway entities with direct FK relationships to journal get rust
- **Logic**: `Same Domain` + `Direct Relationship` = Rust

#### **MAGENTA** (`#883583`) - **DIRECTLY RELATED BUT DIFFERENT DOMAIN**
- **What**: Entities from other domains that have direct relationships to the focus
- **Example**: If journal is pathway domain, but dmFile (from zfarcrycore) has direct relationship to journal, dmFile gets magenta
- **Logic**: `Different Domain` + `Direct Relationship` = Magenta

#### **COFFEE** (`#7e4f2b`) - **SAME DOMAIN BUT NOT DIRECTLY RELATED**
- **What**: Entities in the same domain as focus but without direct relationships
- **Example**: Other pathway domain entities that don't directly relate to journal
- **Logic**: `Same Domain` + `No Direct Relationship` = Coffee

#### **DARK GREY** (`#1a1a1a`) - **DEFAULT/OTHERS**
- **What**: All other entities (different domain + no direct relationship)
- **Example**: Entities from other domains with no direct relationships to focus
- **Logic**: `Different Domain` + `No Direct Relationship` = Dark Grey

### **🎯 The Oracle's Wisdom:**

**Proximity Logic**: Colors represent **relationship proximity** to the focus entity:
- **Orange**: You ARE the focus
- **Rust**: You're in the same "family" (domain) AND directly connected
- **Magenta**: You're directly connected but from a different "family" 
- **Coffee**: You're in the same "family" but not directly connected
- **Dark Grey**: You're neither in the same family nor directly connected

**Domain + Relationship Matrix**:
```
                                | Direct Relationship | No Direct Relationship
Same Domain                     | RUST              | COFFEE
Different Domain                | MAGENTA           | DARK GREY
```

This creates a visual hierarchy showing how "close" each entity is to the focus entity in terms of both domain membership and relationship strength!

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