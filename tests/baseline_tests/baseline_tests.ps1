# Baseline Tests Configuration
$baselineTests = @(
    @{
        Name = "Edge_Case_No_Focus_All_Domains"
        Description = "Tests behavior with no focus but all domains"
        Parameters = @{
            FocusEntity = ""
            Domains = "all"
            DiagramType = "ER"
        }
        ExpectedEntityCount = 83  # Should include all entities
    },
    @{
        Name = "Edge_Case_No_Focus_No_Domains"
        Description = "Tests behavior with no focus and no domains"
        Parameters = @{
            FocusEntity = ""
            Domains = ""
            DiagramType = "ER"
        }
        ExpectedEntityCount = 83  # Should include all entities
    },
    @{
        Name = "Edge_Case_Site_Domain_Only"
        Description = "Tests site domain entities (should be different from partner focus)"
        Parameters = @{
            FocusEntity = ""
            Domains = "site"
            DiagramType = "ER"
        }
        ExpectedEntityCount = 8  # Should only include site domain entities
    },
    @{
        Name = "Edge_Case_Programme_Domain_Only"
        Description = "Tests programme domain entities only"
        Parameters = @{
            FocusEntity = ""
            Domains = "programme"
            DiagramType = "ER"
        }
        ExpectedEntityCount = 15  # Should only include programme domain entities
    },
    @{
        Name = "Edge_Case_Class_Diagram_Complex"
        Description = "Tests Class diagram with complex relationships"
        Parameters = @{
            FocusEntity = "member"
            Domains = "participant,programme"
            DiagramType = "Class"
        }
        ExpectedEntityCount = 24  # Should show class relationships
    },
    @{
        Name = "Edge_Case_Invalid_Domain"
        Description = "Tests behavior with non-existent domain"
        Parameters = @{
            FocusEntity = "partner"
            Domains = "nonexistent"
            DiagramType = "ER"
        }
        ExpectedEntityCount = 1  # Should only include focus entity
    }
)