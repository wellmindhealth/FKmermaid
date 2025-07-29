# FKmermaid Test Suite

This directory contains comprehensive tests for the FKmermaid ER diagram generation system.

## Test Categories

### 1. CFC Scan Tests (`cfc_scan_tests/`)
- **Purpose**: Test CFC scanning and configuration generation
- **Scripts**: 
  - `test_cfc_scan_generation.ps1` - Tests `generate_cfc_scan_config.ps1`
  - `test_exclusions.ps1` - Tests entity exclusion functionality
- **Expected Outputs**: Known entity counts, exclusion lists, domain mappings

### 2. Main Script Tests (`main_script_tests/`)
- **Purpose**: Test the main ER diagram generation script
- **Scripts**:
  - `test_4_color_system.ps1` - Tests semantic styling system
  - `test_parameter_combinations.ps1` - Tests various parameter combinations
  - `test_diagram_types.ps1` - Tests ER vs Class diagrams
- **Expected Outputs**: Generated `.mmd` files with known styling patterns

### 3. Baseline Tests (`baseline_tests/`)
- **Purpose**: Create baseline outputs for regression testing
- **Scripts**:
  - `generate_baselines.ps1` - Creates baseline outputs
  - `compare_baselines.ps1` - Compares current vs baseline outputs
- **Expected Outputs**: Stored baseline files for future comparison

### 4. Integration Tests (`integration_tests/`)
- **Purpose**: Test end-to-end workflows
- **Scripts**:
  - `test_full_workflow.ps1` - Tests complete workflow from CFC scan to diagram
  - `test_mermaid_live_integration.ps1` - Tests Mermaid.live integration
- **Expected Outputs**: Complete workflow validation

## Test Execution

### Running All Tests
```powershell
.\tests\run_all_tests.ps1
```

### Running Specific Test Categories
```powershell
.\tests\cfc_scan_tests\test_cfc_scan_generation.ps1
.\tests\main_script_tests\test_4_color_system.ps1
```

### Baseline Generation
```powershell
.\tests\baseline_tests\generate_baselines.ps1
```

## Test Outputs

### Expected Results
- **CFC Scan**: 84 entities, 109 direct FK relationships
- **4-Color System**: Orange (focus), Blue (related), Blue-grey (same domain), Dark grey (other domains)
- **Exclusions**: `farFilter`, `farTask`, `address` should not appear in outputs
- **Parameter Combinations**: Various combinations should produce predictable entity counts

### Baseline Files
- Stored in `tests/baseline_tests/baselines/`
- Used for regression testing
- Updated when intentional changes are made

## Test Validation

### Manual Review Points
1. **Entity Counts**: Verify expected entity counts match
2. **Styling Colors**: Verify 4-color system applied correctly
3. **Exclusions**: Verify excluded entities don't appear
4. **Mermaid.live**: Verify diagrams open correctly in browser

### Automated Checks
1. **File Generation**: Verify `.mmd` files are created
2. **Entity Presence**: Check for expected entities
3. **Entity Absence**: Check excluded entities are missing
4. **Styling Application**: Verify style classes are applied

## Test Maintenance

### When to Update Baselines
- After intentional feature changes
- After bug fixes that change output
- After configuration changes

### How to Update Baselines
```powershell
.\tests\baseline_tests\generate_baselines.ps1 -Force
```

## Test Reporting

Test results are stored in:
- `tests/results/` - Test execution results
- `tests/logs/` - Detailed execution logs
- `tests/baseline_tests/baselines/` - Baseline comparison files