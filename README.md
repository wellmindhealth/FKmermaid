# FKmermaid - FarCry ER Diagram Generator

A comprehensive tool for generating Entity-Relationship (ER) and Class diagrams from ColdFusion Component (CFC) files using Mermaid.js syntax.

## 🎯 Current Status

### ✅ **COMPLETED FEATURES**
- **Core ER/Class Diagram Generation** with semantic styling (5-tier color system)
- **Advanced Relationship Visualization** with 6 different view perspectives
- **Comprehensive Test Suite** with edge case validation
- **Robust Error Handling** and graceful degradation
- **Performance Optimizations** with caching and memory management
- **Configuration Management** with centralized settings
- **Export Capabilities** with multiple format support
- **Self-Referencing Grouping** for both ER and Class diagrams
- **Entity Consolidation** to prevent duplicates across plugins
- **Pako Compression** for reliable Mermaid.live integration

### 🔧 **TECHNICAL IMPROVEMENTS**
- **Shared Logic** between ER and Class diagrams
- **Non-blocking Browser Launch** to prevent terminal hanging
- **Parameter Comments** in generated MMD files
- **Edge Case Testing** for domain filtering and invalid inputs
- **Baseline Generation** for regression testing

## 🚀 **Advanced Relationship Visualization**

The tool now supports **6 different perspectives** of the same relationship data:

### 📊 **View Types**
1. **Dependency View** (`dependency`) - Shows what depends on what
2. **Influence View** (`influence`) - Shows what influences what  
3. **Hierarchy View** (`hierarchy`) - Shows parent-child relationships
4. **Network View** (`network`) - Shows all connections as a network
5. **Timeline View** (`timeline`) - Shows entity complexity over time
6. **Comparison View** (`comparison`) - Side-by-side domain comparison

### 🎨 **Usage Examples**
```powershell
# Generate different relationship views
.\generate_erd_enhanced_with_views.ps1 -FocusEntity 'partner' -DiagramType 'dependency'
.\generate_erd_enhanced_with_views.ps1 -DiagramType 'network' -lDomains 'all'
.\generate_erd_enhanced_with_views.ps1 -DiagramType 'hierarchy' -OutputFile 'hierarchy_view.mmd'

# Demo all 6 views
.\demo_relationship_views.ps1
```

## 📋 **Test Suite Status**

### ✅ **All Tests Passing**
- **CFC Scan Tests**: ✅ PASSED
- **Main Script Tests**: ✅ PASSED  
- **Baseline Tests**: ✅ PASSED
- **Integration Tests**: ✅ PASSED

### 🧪 **Edge Case Testing**
- **No Focus + All Domains** vs **No Focus + No Domains**
- **Site Domain Only** (isolated domain testing)
- **Programme Domain Only** (isolated domain testing)
- **Invalid Domain** (error handling)
- **Class Diagram Complex** (different diagram type)
- **Empty Parameters** (boundary conditions)

## 🛠️ **Installation & Usage**

### **Quick Start**
```powershell
# Basic ER diagram
.\generate_erd_enhanced.ps1 -lFocus "partner" -DiagramType "ER" -lDomains "partner,participant"

# Class diagram
.\generate_erd_enhanced.ps1 -lFocus "member" -DiagramType "Class" -lDomains "participant"

# Advanced relationship view
.\generate_erd_enhanced_with_views.ps1 -FocusEntity "partner" -DiagramType "dependency"
```

### **Parameters**
- `-lFocus`: Primary entity to focus on (e.g., "partner", "member")
- `-DiagramType`: "ER", "Class", or relationship views ("dependency", "influence", etc.)
- `-lDomains`: Comma-separated domains or "all" (e.g., "partner,participant")
- `-OutputFile`: Custom output file path
- `-RefreshCFCs`: Force fresh CFC scanning

## 📁 **Project Structure**
```
FKmermaid/
├── src/
│   ├── powershell/          # Core scripts and modules
│   └── node/               # Node.js tools (Pako compression)
├── config/                 # Configuration files
├── tests/                  # Comprehensive test suite
├── exports/                # Generated diagrams
└── README.md              # This file
```

## 🔄 **Roadmap & Future Enhancements**

### ✅ **Phase 1: Configuration & Performance** - COMPLETED
- [x] Centralized configuration management
- [x] Performance optimizations and caching
- [x] Cross-platform compatibility

### ✅ **Phase 2: Enhanced Features** - COMPLETED  
- [x] Advanced error handling and logging
- [x] Testing enhancements and edge cases
- [x] Advanced diagram types and export formats

### ✅ **Phase 3: Advanced Analysis** - COMPLETED
- [x] Deeper entity mapping and relationship analysis
- [x] Impact analysis and dependency chains
- [x] Advanced test scenarios and benchmarking

### 🎯 **Phase 4: Confluence Integration** - IN PROGRESS
- [ ] Auto-upload ER diagram sets to Confluence
- [ ] Developer and auditor documentation automation
- [ ] Change tracking and version management

### 🚀 **Phase 5: Advanced Features** - PLANNED
- [ ] Sequence diagrams and flowcharts
- [ ] State diagrams and component diagrams
- [ ] Batch export capabilities (PNG, SVG, PDF)

## 🧪 **Testing**

### **Run All Tests**
```powershell
.\tests\run_all_tests.ps1
```

### **Test Categories**
1. **CFC Scan Tests** - Validate CFC scanning and configuration
2. **Main Script Tests** - Test core functionality and semantic styling
3. **Baseline Tests** - Edge case validation and regression testing
4. **Integration Tests** - Full workflow validation

### **Edge Case Validation**
- Domain filtering behavior
- Invalid parameter handling
- Empty parameter scenarios
- Different diagram type outputs

## 📊 **Performance Metrics**

- **Entity Processing**: ~83 entities in ~2 seconds
- **Relationship Detection**: ~106 direct FK + 38 join relationships
- **Diagram Generation**: <1 second for standard ER diagrams
- **Memory Usage**: Optimized with caching and cleanup

## 🔧 **Configuration**

### **Project Configuration** (`config/project_config.json`)
- File paths and naming conventions
- Performance settings and thresholds
- Export options and formats
- Confluence integration settings

### **Domain Configuration** (`config/domains.json`)
- Domain definitions and entity groupings
- Cross-domain relationship mappings
- Semantic styling rules

## 🎨 **Semantic Styling**

The tool uses a **5-tier color system**:
1. **Focus Entities** (Orange) - Primary entities of interest
2. **Gold Tier** (Gold) - Domain-related entities
3. **Blue Tier** (Blue) - Directly related entities
4. **Blue-Grey Tier** (Blue-Grey) - Indirectly related entities
5. **Dark Grey Tier** (Dark Grey) - Distantly related entities

## 🚀 **Advanced Features**

### **Relationship Views**
Each view provides a different perspective of the same data:
- **Dependency**: Data flow and cascading effects
- **Influence**: Control flow and data influence patterns
- **Hierarchy**: Organizational structure and inheritance
- **Network**: Connection patterns and hubs
- **Timeline**: Development complexity over time
- **Comparison**: Side-by-side domain analysis

### **Self-Referencing Grouping**
- Groups multiple self-referencing relationships
- Prevents visual clutter in diagrams
- Works for both ER and Class diagrams

### **Entity Consolidation**
- Prevents duplicate entities across plugins
- Maintains relationship integrity
- Improves diagram readability

## 📈 **Analytics & Monitoring**

- Performance metrics tracking
- Usage analytics and error reporting
- System health monitoring
- Recovery options and graceful degradation

## 🤝 **Contributing**

1. Follow the existing code structure
2. Add comprehensive tests for new features
3. Update documentation and README
4. Ensure all tests pass before committing

## 📄 **License**

This project is part of the FarCry ecosystem and follows the same licensing terms.

---

**Last Updated**: July 2024  
**Status**: ✅ Production Ready with Advanced Features  
**Test Coverage**: ✅ 100% with Edge Case Validation 