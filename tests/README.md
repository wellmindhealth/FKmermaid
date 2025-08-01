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
  - `test_5_tier_system.ps1` - Tests 5-tier semantic styling system
  - `test_domain_detection.ps1` - Tests domain detection and filtering
  - `test_manual_verification.ps1` - Tests manual verification outputs
- **Expected Outputs**: Generated `.mmd` files with known styling patterns

### 3. Baseline Tests (`baseline_tests/`)
- **Purpose**: Create baseline outputs for regression testing
- **Scripts**:
  - `generate_baselines.ps1` - Creates baseline outputs (26 edge cases)
  - `test_edge_cases.ps1` - Tests all 26 edge case baselines
- **Expected Outputs**: Stored baseline files for future comparison

### 4. Quick Test Scripts
- **Purpose**: Fast testing and development iteration
- **Scripts**:
  - `generate_all_cfc_diagrams_test.ps1` - Generates 6 test diagrams (3 CFCs × 2 domains)
  - `update_test_expectations.ps1` - Updates ExpectedEntityCount values after baseline changes
  - `test_cfc_cache_generation.ps1` - Tests CFC cache generation with inheritance support
- **Expected Outputs**: Quick validation and automated test maintenance

## Test Execution

### Running All Tests
```powershell
.\tests\run_all_tests.ps1
```

### Running Specific Test Categories
```powershell
.\tests\cfc_scan_tests\test_cfc_scan_generation.ps1
.\tests\main_script_tests\test_5_tier_system.ps1
```

### Quick Testing
```powershell
.\tests\generate_all_cfc_diagrams_test.ps1 -RefreshCFCs
```

### Baseline Generation
```powershell
.\tests\baseline_tests\generate_baselines.ps1 -Force
```

## Test Outputs

### Expected Results
- **CFC Scan**: 168 entities, comprehensive direct FK relationships
- **5-Tier System**: Orange (focus), Gold (same domain + directly related), Blue (directly related but different domain), Blue-grey (same domain but not directly related), Dark grey (different domain + not directly related)
- **Exclusions**: `farFilter`, `farTask`, `address` should not appear in outputs
- **Parameter Combinations**: Various combinations should produce predictable entity counts
- **Quick Test**: 6 diagrams (member, activityDef, progRole × provider, participant)

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