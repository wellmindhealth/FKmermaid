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
- **Domain-Based Filtering**: Focus on specific business domains (provider, participant, pathway, site)

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

#### **`site`** - Website content and structure
- **Core**: dmNavigation, dmHTML, dmFacts, dmNews, dmInclude
- **Resources**: dmImage, dmFile



**Why 4 domains?** Because real components connect across boundaries. For example, `member` (participant) connects to `partner` (healthcare organization) - these cross-domain relationships are crucial for understanding the complete system.

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

### **🌐 Website Content**

#### **dmNavigation** - Website Structure Management
**Snappy:** Website navigation structure and menu organization for user experience architecture

**Detailed:** dmNavigation represents the website navigation structure and user experience architecture that guides users through the platform's features, content, and functionality. This system manages the user interface structure, menu hierarchies, and navigation pathways. dmNavigation manages the hierarchical structure of website navigation including menu organization, page relationships, user interface flow, and information architecture optimization. The system implements navigation management including responsive design support and accessibility compliance.

#### **dmHTML** - Dynamic Content Management
**Snappy:** HTML content management system for dynamic web page creation and delivery

**Detailed:** dmHTML represents the HTML content management system for website pages and content delivery that supports the platform's information architecture and user communication needs. This system manages the creation, editing, versioning, and delivery of web content. dmHTML manages the complete lifecycle of web content including creation, editing, versioning, delivery, and integration with user experience frameworks. The system implements content management including responsive design support and accessibility compliance.

#### **dmFacts** - Information Resource Management
**Snappy:** Factual content management system for educational information and reference materials

**Detailed:** dmFacts represents the factual content management system for website information and educational material that supports user understanding, platform navigation, and organizational communication objectives. This system includes static information, educational content, and reference materials. dmFacts manages the complete lifecycle of factual and educational content including content creation, organization, delivery, and integration with user experience frameworks. The system implements content management including version control and accessibility compliance.

#### **dmNews** - Communication Management
**Snappy:** News content management system for announcements, updates, and organizational communications

**Detailed:** dmNews represents the news content management system for website updates and announcements that supports organizational communication, user engagement, and platform transparency. This system manages platform communications, updates, and organizational information. dmNews manages the complete lifecycle of news content and announcements including content creation, publication, delivery, and integration with organizational communication frameworks.

#### **dmInclude** - Component Content Management
**Snappy:** Include content management system for reusable website components and modular elements

**Detailed:** dmInclude represents the include content management system for website components and reusable elements that supports content consistency, development efficiency, and user experience optimization. This system manages modular content components that can be reused across different pages and contexts. dmInclude manages the complete lifecycle of reusable content components including creation, versioning, delivery, and integration with content management frameworks. The system implements component management including version control and dependency management.

#### **dmImage** - Visual Resource Management
**Snappy:** Image resource management system for visual assets and graphic content delivery

**Detailed:** dmImage represents the image resource management system for website graphics and visual content that supports the platform's visual design, user experience, and content delivery requirements. This system manages the storage, organization, optimization, and delivery of visual assets. dmImage manages the complete lifecycle of visual assets including upload, storage, optimization, delivery, and integration with content management frameworks. The system implements asset management including responsive image delivery and accessibility compliance.

#### **dmFile** - Document Resource Management
**Snappy:** File resource management system for downloadable documents and secure digital asset storage

**Detailed:** dmFile represents the file resource management system for downloadable documents and secure digital asset storage that supports bulk data access, user needs, platform functionality, and organizational communication requirements. This system manages the storage, organization, versioning, and delivery of downloadable documents and resources. dmFile manages the complete lifecycle of document resources including upload, storage, versioning, delivery, and integration with content management frameworks. The system implements asset management including secure file delivery and version control.

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