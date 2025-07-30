# Update CFC Descriptions Script - Fixed Version
# Updates CFC files with concise descriptions and short hints
# ONLY updates component-level hint and @@Description, not property hints

param(
    [string]$ConfigPath = "D:\GIT\farcry\Cursor\FKmermaid\config\component_hints.json",
    [string]$PathwayPath = "D:\GIT\farcry\plugins\pathway\packages\types",
    [string]$FarCryCorePath = "D:\GIT\farcry\zfarcrycore\packages\types",
    [string]$FarCryCMSPath = "D:\GIT\farcry\plugins\farcrycms\packages\types",
    [switch]$DryRun = $false,
    [switch]$Verbose = $false
)

# Load component hints
$hintsConfig = Get-Content $ConfigPath | ConvertFrom-Json

# Component file path mapping
$componentPaths = @{
    # Pathway components
    "member" = "$PathwayPath\member.cfc"
    "progMember" = "$PathwayPath\progMember.cfc"
    "activity" = "$PathwayPath\activity.cfc"
    "partner" = "$PathwayPath\partner.cfc"
    "memberGroup" = "$PathwayPath\memberGroup.cfc"
    "center" = "$PathwayPath\center.cfc"
    "referer" = "$PathwayPath\referer.cfc"
    "intake" = "$PathwayPath\intake.cfc"
    "programme" = "$PathwayPath\programme.cfc"
    "activityDef" = "$PathwayPath\activityDef.cfc"
    "media" = "$PathwayPath\media.cfc"
    "SSQ_stress01" = "$PathwayPath\SSQ_stress01.cfc"
    "SSQ_pain01" = "$PathwayPath\SSQ_pain01.cfc"
    "SSQ_arthritis01" = "$PathwayPath\SSQ_arthritis01.cfc"
    "tracker" = "$PathwayPath\tracker.cfc"
    "trackerDef" = "$PathwayPath\trackerDef.cfc"
    "progRole" = "$PathwayPath\progRole.cfc"
    "journal" = "$PathwayPath\journal.cfc"
    "journalDef" = "$PathwayPath\journalDef.cfc"
    "library" = "$PathwayPath\library.cfc"
    "guide" = "$PathwayPath\guide.cfc"
    
    # FarCry Core components
    "farUser" = "$FarCryCorePath\farUser.cfc"
    "farGroup" = "$FarCryCorePath\farGroup.cfc"
    "farRole" = "$FarCryCorePath\farRole.cfc"
    "farPermission" = "$FarCryCorePath\farPermission.cfc"
    "dmProfile" = "$FarCryCorePath\dmProfile.cfc"
    "dmNavigation" = "$FarCryCorePath\dmNavigation.cfc"
    "dmHTML" = "$FarCryCorePath\dmHTML.cfc"
    "dmInclude" = "$FarCryCorePath\dmInclude.cfc"
    "dmImage" = "$FarCryCorePath\dmImage.cfc"
    "dmFile" = "$FarCryCorePath\dmFile.cfc"
    
    # FarCry CMS components
    "dmFacts" = "$FarCryCMSPath\dmFacts.cfc"
    "dmNews" = "$FarCryCMSPath\dmNews.cfc"
}

# Refined detailed descriptions for @@Description comments
$detailedDescriptions = @{
    # Pathway Components
    "member" = @"
Participant Management Core

Business Context: The member represents an individual participant in Wellmind Health's digital therapeutic programs. This is the central entity that connects the human participant to the digital treatment ecosystem with personal preferences, progress tracking, and connections to the healthcare provider hierarchy.

Technical Role: The member entity serves as the primary participant record, containing personal details, treatment preferences, and critical relationships to the healthcare provider network (partner organizations, member groups, centers, and referrers).

Key Relationships: Member connects to the healthcare provider hierarchy through partner organizations, member groups, centers, and referrers, enabling both personalized care and organizational oversight.
"@

    "progMember" = @"
Program Enrollment & Progress Tracking

Business Context: progMember represents the active enrollment of a participant in a specific treatment program. This is where the rubber meets the road - where a participant's journey through a structured therapeutic intervention is tracked, measured, and managed.

Technical Role: This entity manages enrollment status, progress tracking, completion milestones, and program-specific participant data. It's the operational record that tracks a participant's engagement with a specific treatment pathway.

Key Relationships: progMember links the participant (member) to their chosen treatment program, creating a one-to-many relationship that allows participants to enroll in multiple programs while maintaining separate progress tracking for each enrollment.
"@

    "activity" = @"
Interactive Treatment Steps

Business Context: Activities represent the individual interactive steps that participants engage with during their treatment journey. These are derived from activityDef templates but become personalized instances for each participant.

Technical Role: Each activity is a participant-specific instance of an activityDef, containing the participant's responses, progress, and interaction data. This creates a personalized treatment experience while maintaining the structured approach defined by the activityDef template.

Key Relationships: Activities are derived from activityDef templates, creating a template-instance relationship that ensures consistency while allowing personalization. Each activity belongs to a specific progMember enrollment.
"@

    "partner" = @"
Healthcare Organization Management

Business Context: Partners represent healthcare organizations, enterprises, or institutions that provide Wellmind Health programs to their populations. These could be hospitals, health systems, employers, insurance companies, or other healthcare entities.

Technical Role: The partner entity manages organizational relationships, access controls, and administrative oversight. It serves as the top-level organizational structure that determines which participants can access which programs.

Key Relationships: Partners have multiple member groups, centers, referrers and intakes under their organizational umbrella, creating a hierarchical structure that supports both centralized administration and distributed care delivery.
"@

    "memberGroup" = @"
Participant Segmentation & Cohort Management

Business Context: Member groups represent categories or cohorts of participants that share common characteristics, treatment needs, or organizational structures. These could be based on clinical criteria, organizational units, or program-specific cohorts including research studies.

Technical Role: Member groups enable segmentation, analysis, and organizational structure within the participant population. They support both clinical decision-making and administrative oversight.

Key Relationships: Member groups belong to partner organizations and contain multiple members, creating a hierarchical structure that supports both clinical and administrative needs.
"@

    "center" = @"
Service Delivery Points

Business Context: Centers represent the physical or virtual locations where healthcare services are delivered and participants receive care. While traditionally physical locations, centers can also represent virtual service delivery points or categorical service groupings.

Technical Role: Centers manage service delivery logistics, participant access, and local resource allocation. They serve as the operational units that connect participants to specific service delivery models and local care teams.

Key Relationships: Centers belong to partner organizations and may have multiple referrers or intakes associated with them, creating a service delivery network.
"@

    "referer" = @"
Healthcare Professional Network

Business Context: Referrers are healthcare professionals, HR representatives, or other authorized individuals responsible for referring participants to Wellmind Health programs and ultimately responsible for care of participants.

Technical Role: The referrer entity manages referral tracking and professional oversight of participant care. It creates accountability and professional oversight while enabling the referral-based access model that many healthcare systems require.

Key Relationships: Referrers are associated with centers and may have relationships with specific member groups, creating a professional network that supports both individual care coordination and organizational oversight.
"@

    "intake" = @"
Capacity Management & Access Control

Business Context: Intake represents the healthcare organization's date or number-based entitlement of participant "places" on a program. This is essentially the capacity management system that controls how many participants can access specific programs.

Technical Role: Intake manages capacity limits, access controls, and entitlement tracking. It ensures that healthcare organizations can manage their program capacity while providing appropriate access to their populations.

Key Relationships: Intake belongs to partner organizations or centers and controls access to specific programs, creating a capacity management system that balances organizational needs with participant access.
"@

    "programme" = @"
Treatment Program Architecture

Business Context: The programme entity represents the overarching treatment program structure that contains activity definitions, pacing logic, communication templates, educational resources, and lifecycle management.

Technical Role: Programmes serve as the container for all program-related content, logic, and structure. They define the treatment pathway, activity sequence, communication strategies, and supporting resources for a specific therapeutic intervention.

Key Relationships: Programmes contain multiple activity definitions, media resources, and interactive content, creating a comprehensive treatment structure that supports both standardized delivery and personalized adaptation.
"@

    "activityDef" = @"
Treatment Step Templates

Business Context: ActivityDefs represent the definition of individual treatment steps within a program. These are the building blocks that define how participants interact with therapeutic content, complete exercises, or engage with educational materials.

Technical Role: ActivityDefs serve as templates that define the structure and requirements for individual treatment steps. They contain the logic for media integration, interaction patterns, progression rules, and content structure that will be instantiated for each participant.

Key Relationships: ActivityDefs belong to programmes and may reference multiple media resources, creating a template system that supports both consistency and flexibility in treatment delivery.
"@

    "media" = @"
Content Delivery System

Business Context: Media represents the video, audio, and document content that delivers therapeutic interventions and educational materials to participants. This includes educational videos, interactive exercises, guided meditations, and supporting documentation.

Technical Role: Media entities manage content storage, delivery, and integration with treatment activities. They support multiple content types and delivery formats while maintaining the quality and accessibility standards required for therapeutic content.

Key Relationships: Media resources are referenced by activityDefs and programmes, creating a content management system that supports both structured treatment delivery and flexible content reuse across multiple programs.
"@

    # Admin Components - Shortened
    "farUser" = @"
System User Management & Authentication

Business Context: farUser represents the user management system for healthcare staff, administrators, clinicians, and operational personnel who require access to the Wellmind Health platform. These users are distinct from participants and represent the human workforce responsible for managing the digital therapeutic ecosystem.

Technical Role: The farUser entity serves as the cornerstone of the platform's authentication and authorization system, managing user account lifecycle, session management, security credentials, and access control integration. It implements enterprise-grade user management including account creation, password policies, and session timeout controls.

Key Relationships: farUser establishes critical connections to farRole and farGroup entities to implement comprehensive access control policies, while maintaining relationships with specific organizational units to enforce data access boundaries and operational segregation.
"@

    "farGroup" = @"
Permission Group Organization & Access Management

Business Context: farGroup represents the strategic organization of system permissions and access rights into logical, manageable groupings that align with organizational structure and operational requirements. These groups serve as the foundation for efficient access control administration.

Technical Role: farGroup implements an organizational layer within the permission system that groups related permissions into meaningful collections, supporting the principle of least privilege while maintaining administrative efficiency. The system provides sophisticated group management capabilities including nested group structures and dynamic group membership.

Key Relationships: farGroup establishes hierarchical relationships with farRole entities to create comprehensive permission frameworks, while supporting assignment to farUser accounts through flexible membership models.
"@

    "farRole" = @"
Role-Based Access Control & Security Framework

Business Context: farRole defines the comprehensive role-based access control framework that governs user access to system functions, data areas, and operational capabilities within the Wellmind Health platform. The system implements sophisticated role definitions including Pathway Admin roles, Participant Admin roles, and Basic Center roles.

Technical Role: farRole implements enterprise-grade role-based access control (RBAC) by defining comprehensive collections of permissions that correspond to specific job functions, organizational positions, and operational responsibilities. The system supports advanced role features including role hierarchies and conditional permissions.

Key Relationships: farRole establishes critical connections to farPermission entities to define specific access rights and operational capabilities, while supporting assignment to farUser accounts through flexible group relationships.
"@

    "farPermission" = @"
Individual Access Rights & Security Granularity

Business Context: farPermission represents the fundamental building blocks of the platform's security architecture, defining granular permissions that control access to specific system functions, data areas, operational capabilities, and administrative features.

Technical Role: farPermission implements sophisticated permission management including context-sensitive access control, conditional permissions based on organizational relationships, and dynamic permission evaluation based on user attributes and operational context.

Key Relationships: farPermission entities are strategically grouped into farRole definitions to create meaningful access profiles that align with organizational roles and operational requirements.
"@

    "dmProfile" = @"
User Profile Management & Personalization System

Business Context: dmProfile represents the user profile management system that extends beyond basic authentication to provide personalized user experiences, administrative configurations, and operational preferences for healthcare staff and administrators.

Technical Role: dmProfile manages the complete lifecycle of user-specific settings, preferences, and administrative configurations that customize the user experience and operational capabilities. The system implements advanced profile management including preference persistence and cross-device synchronization.

Key Relationships: dmProfile establishes direct connections to farUser accounts to provide personalized configurations and operational preferences, while integrating with organizational structures to support role-based customization.
"@

    # Tracking Components - Shortened
    "SSQ_stress01" = @"
Stress Assessment Instrument & Clinical Evaluation Framework

Business Context: ssq_stress01 represents a standardized stress assessment questionnaire designed to evaluate participant stress levels, psychological well-being, and treatment progress throughout their therapeutic journey.

Technical Role: This entity manages the complete lifecycle of stress-related assessments including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including adaptive questioning and longitudinal trend analysis.

Key Relationships: ssq_stress01 establishes critical connections to tracker entities for comprehensive data collection and analysis, while supporting integration with activityDefs to trigger assessment-based treatment adaptations and progress monitoring.
"@

    "SSQ_pain01" = @"
Pain Assessment Instrument & Clinical Measurement System

Business Context: ssq_pain01 represents an evidence-based pain assessment questionnaire designed to evaluate participant pain levels, functional limitations, and treatment outcomes throughout their therapeutic journey.

Technical Role: This entity manages the complete lifecycle of pain assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including multi-dimensional pain evaluation and functional assessment integration.

Key Relationships: ssq_pain01 establishes critical connections to tracker entities for comprehensive data management and analysis, while supporting integration with activityDefs to provide pain-sensitive treatment adaptations and progress monitoring.
"@

    "SSQ_arthritis01" = @"
Arthritis Assessment Instrument & Musculoskeletal Health Evaluation

Business Context: ssq_arthritis01 represents a specialized assessment questionnaire designed to evaluate arthritis-related symptoms, functional limitations, and treatment outcomes throughout the participant's therapeutic journey.

Technical Role: This entity manages the complete lifecycle of arthritis-specific assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including symptom severity evaluation and functional limitation assessment.

Key Relationships: ssq_arthritis01 establishes critical connections to tracker entities for comprehensive data collection and analysis, while supporting integration with activityDefs to provide arthritis-specific treatment adaptations and progress monitoring.
"@

    "tracker" = @"
Confidence Touchpoint Data Collection System

Business Context: tracker represents a simple, lightweight data collection system for capturing participant confidence and satisfaction touchpoints throughout their treatment journey. These are typically single-slider assessments that measure confidence levels, satisfaction, or self-reported progress on specific conditions or treatment areas.

Technical Role: tracker manages the collection and storage of simple touchpoint data including confidence ratings, satisfaction scores, and basic progress indicators. The system implements straightforward data collection with minimal participant burden, supporting frequent check-ins that complement more comprehensive assessment instruments.

Key Relationships: tracker establishes basic connections to participant records to associate touchpoint data with specific individuals, while supporting integration with treatment activities to capture confidence and satisfaction at key moments in the therapeutic journey.
"@

    "trackerDef" = @"
Touchpoint Assessment Template System

Business Context: trackerDef represents the template definition system for simple confidence and satisfaction touchpoints used throughout treatment programs. These templates define basic single-slider assessments that measure participant confidence, satisfaction, or self-reported progress on specific conditions or treatment areas.

Technical Role: trackerDef manages the basic metadata and configuration for touchpoint assessments including question text, slider ranges, frequency settings, and basic scoring parameters. The system implements simple template management including basic version control and question configuration.

Key Relationships: trackerDef establishes basic connections to tracker entities for simple data collection and storage, while supporting integration with activityDefs to define when and how touchpoint assessments should be presented to participants.
"@

    # Programme Components - Shortened
    "progRole" = @"
Program-Specific Access Control & Treatment Personalization

Business Context: progRole represents the program-specific access control system that manages participant access and content delivery within individual treatment programs. These roles determine what program content, activities, features, and resources each participant can access based on their enrollment status and treatment progress.

Technical Role: progRole implements advanced program-specific access control by defining comprehensive participant permissions within individual treatment programs. The system supports sophisticated access management including progress-based content unlocking and personalized treatment pathway management.

Key Relationships: progRole establishes critical connections to programme entities to establish program-specific access controls and treatment pathway management, while supporting integration with member entities to provide personalized program experiences.
"@

    "journal" = @"
Participant Personal Documentation & Therapeutic Reflection System

Business Context: journal represents the personal documentation and reflection system that enables participants to create and manage personal notes, reflections, and treatment-related documentation throughout their therapeutic journey.

Technical Role: journal manages the complete lifecycle of participant-generated content including personal notes, reflections, treatment-related documentation, and therapeutic insights. The system implements advanced content management including privacy controls, content categorization, and search capabilities.

Key Relationships: journal establishes direct connections to member entities to associate personal documentation with specific participants, while supporting integration with activity entities to capture reflections related to specific treatment activities and therapeutic interventions.
"@

    "journalDef" = @"
Journal Template Definitions & Therapeutic Reflection Framework

Business Context: journalDef represents the template definition system for structured participant reflection and documentation activities that support treatment engagement and progress tracking. These templates define the prompts, structure, guidance, and therapeutic framework for participant journaling activities.

Technical Role: journalDef manages the complete metadata and configuration framework for journaling activities including prompts, structure, guidance, and therapeutic frameworks that ensure consistent and therapeutic journaling experiences across different programs and participants.

Key Relationships: journalDef establishes critical connections to journal entities for comprehensive data collection and therapeutic insight generation, while supporting integration with activityDefs to define journaling requirements and integrate reflection activities into treatment programs.
"@

    "library" = @"
Content Resource Management & Therapeutic Knowledge System

Business Context: library represents the content library system for organizing, managing, and delivering therapeutic resources, educational materials, and supporting content to participants throughout their treatment journey. This system includes media, articles, exercises, guides, and supplementary content that complements and enhances core treatment programs.

Technical Role: library manages the complete lifecycle of supplementary therapeutic content and resources including content creation, categorization, delivery, and integration with treatment programs. The system implements advanced content management including recommendations and progress-based content delivery.

Key Relationships: library establishes comprehensive connections to programme, media and activityDef entities to provide supplementary content and resources that enhance treatment effectiveness, while supporting integration with member entities to provide content recommendations based on participant characteristics and treatment progress.
"@

    "guide" = @"
Healthcare Professional Profile & Content Attribution System

Business Context: guide represents the professional profile and attribution system for healthcare professionals who deliver core video content and therapeutic interventions throughout treatment programs. These are the talking-head professionals - clinicians, therapists, and subject matter experts - who provide the human connection and expert guidance in the video content.

Technical Role: guide manages professional profiles including credentials, expertise areas, professional affiliations, and content attribution for healthcare professionals featured in therapeutic video content. The system implements basic profile management including professional information, content associations, and credibility indicators.

Key Relationships: guide establishes direct connections to media entities to associate healthcare professionals with specific video content and therapeutic interventions, while supporting integration with programme entities to ensure appropriate professional representation across different treatment areas.
"@

    # Site Components - Significantly Shortened
    "dmNavigation" = @"
Website Structure Management & User Experience Architecture

Business Context: dmNavigation represents the website navigation structure and user experience architecture that guides users through the platform's features, content, and functionality. This system manages the user interface structure, menu hierarchies, and navigation pathways.

Technical Role: dmNavigation manages the hierarchical structure of website navigation including menu organization, page relationships, user interface flow, and information architecture optimization. The system implements navigation management including responsive design support and accessibility compliance.

Key Relationships: dmNavigation establishes comprehensive connections to various content entities to create navigable content structures that support user needs and organizational objectives, while integrating with permission-based access control systems.
"@

    "dmHTML" = @"
Dynamic Content Management & Web Experience Platform

Business Context: dmHTML represents the HTML content management system for website pages and content delivery that supports the platform's information architecture and user communication needs. This system manages the creation, editing, versioning, and delivery of web content.

Technical Role: dmHTML manages the complete lifecycle of web content including creation, editing, versioning, delivery, and integration with user experience frameworks. The system implements content management including responsive design support and accessibility compliance.

Key Relationships: dmHTML establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with various content entities to support rich, dynamic web experiences.
"@

    "dmFacts" = @"
Information Resource Management & Educational Content System

Business Context: dmFacts represents the factual content management system for website information and educational material that supports user understanding, platform navigation, and organizational communication objectives. This system includes static information, educational content, and reference materials.

Technical Role: dmFacts manages the complete lifecycle of factual and educational content including content creation, organization, delivery, and integration with user experience frameworks. The system implements content management including version control and accessibility compliance.

Key Relationships: dmFacts establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with library entities to provide educational resources and reference materials.
"@

    "dmNews" = @"
Communication Management & Organizational Information System

Business Context: dmNews represents the news content management system for website updates and announcements that supports organizational communication, user engagement, and platform transparency. This system manages platform communications, updates, and organizational information.

Technical Role: dmNews manages the complete lifecycle of news content and announcements including content creation, publication, delivery, and integration with organizational communication frameworks. 

Key Relationships: dmNews establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with various user entities to support targeted communication and announcement delivery.
"@

    "dmInclude" = @"
Component Content Management & Modular Content System

Business Context: dmInclude represents the include content management system for website components and reusable elements that supports content consistency, development efficiency, and user experience optimization. This system manages modular content components that can be reused across different pages and contexts.

Technical Role: dmInclude manages the complete lifecycle of reusable content components including creation, versioning, delivery, and integration with content management frameworks. The system implements component management including version control and dependency management.

Key Relationships: dmInclude establishes comprehensive connections to various content entities to provide modular content components that enhance user experience and development efficiency, while supporting integration with dmNavigation to support component-based page construction.
"@

    "dmImage" = @"
Visual Resource Management & Digital Asset System

Business Context: dmImage represents the image resource management system for website graphics and visual content that supports the platform's visual design, user experience, and content delivery requirements. This system manages the storage, organization, optimization, and delivery of visual assets.

Technical Role: dmImage manages the complete lifecycle of visual assets including upload, storage, optimization, delivery, and integration with content management frameworks. The system implements asset management including responsive image delivery and accessibility compliance.

Key Relationships: dmImage establishes comprehensive connections to various content entities to provide visual assets that enhance user experience and content effectiveness, while supporting integration with media entities to support therapeutic content delivery.
"@

    "dmFile" = @"
Document Resource Management & Digital Asset System

Business Context: dmFile represents the file resource management system for downloadable documents and secure digital asset storage that supports bulk data access, user needs, platform functionality, and organizational communication requirements. This system manages the storage, organization, versioning, and delivery of downloadable documents and resources.

Technical Role: dmFile manages the complete lifecycle of document resources including upload, storage, versioning, delivery, and integration with content management frameworks. The system implements asset management including secure file delivery and version control.

Key Relationships: dmFile establishes comprehensive connections to various content entities to provide downloadable resources that enhance user experience and platform functionality, while supporting integration with library entities to support educational resource delivery.
"@
}

# Function to update CFC file - FIXED VERSION
function Update-CFCFile {
    param(
        [string]$FilePath,
        [string]$ComponentName,
        [string]$ShortHint,
        [string]$DetailedDescription
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Host "File not found: $FilePath" -ForegroundColor Yellow
        return
    }
    
    $content = Get-Content $FilePath -Raw
    $originalContent = $content
    
    # Update ONLY the component-level hint attribute (not property hints)
    # Look for <cfcomponent with hint attribute
    if ($content -match '<cfcomponent[^>]*hint\s*=\s*["''][^"'']*["''][^>]*>') {
        $content = $content -replace '<cfcomponent([^>]*hint\s*=\s*["''])[^"'']*([^>]*>)', "<cfcomponent`$1$ShortHint`$2"
    } else {
        # Add hint attribute to cfcomponent tag if it doesn't exist
        if ($content -match '<cfcomponent([^>]*)>') {
            $content = $content -replace '<cfcomponent([^>]*)>', "<cfcomponent`$1 hint=`"$ShortHint`">"
        }
    }
    
    # Update or add @@Description comment
    $descriptionComment = "<!--- @@Description: $DetailedDescription --->"
    
    if ($content -match '<!--- @@Description:.*?--->') {
        $content = $content -replace '<!--- @@Description:.*?--->', $descriptionComment
    } else {
        # Add @@Description comment after cfcomponent tag
        if ($content -match '<cfcomponent[^>]*>') {
            $content = $content -replace '<cfcomponent([^>]*)>', "<cfcomponent`$1>`n$descriptionComment"
        }
    }
    
    if ($DryRun) {
        Write-Host "DRY RUN - Would update $FilePath" -ForegroundColor Cyan
        if ($Verbose) {
            Write-Host "Original content length: $($originalContent.Length)" -ForegroundColor Gray
            Write-Host "New content length: $($content.Length)" -ForegroundColor Gray
        }
    } else {
        Set-Content -Path $FilePath -Value $content -NoNewline
        Write-Host "Updated: $FilePath" -ForegroundColor Green
    }
}

# Main execution
Write-Host "Starting CFC description updates (FIXED VERSION)..." -ForegroundColor Green
Write-Host "Config Path: $ConfigPath" -ForegroundColor Gray
Write-Host "Pathway Path: $PathwayPath" -ForegroundColor Gray
Write-Host "FarCry Core Path: $FarCryCorePath" -ForegroundColor Gray
Write-Host "FarCry CMS Path: $FarCryCMSPath" -ForegroundColor Gray
Write-Host "Dry Run: $DryRun" -ForegroundColor Gray

foreach ($componentName in $detailedDescriptions.Keys) {
    if ($componentPaths.ContainsKey($componentName)) {
        $filePath = $componentPaths[$componentName]
        $shortHint = $hintsConfig.componentHints.$componentName
        $detailedDescription = $detailedDescriptions[$componentName]
        
        if ($Verbose) {
            Write-Host "Processing: $componentName" -ForegroundColor Blue
            Write-Host "  File: $filePath" -ForegroundColor Gray
            Write-Host "  Hint: $shortHint" -ForegroundColor Gray
        }
        
        Update-CFCFile -FilePath $filePath -ComponentName $componentName -ShortHint $shortHint -DetailedDescription $detailedDescription
    } else {
        Write-Host "No file path found for component: $componentName" -ForegroundColor Yellow
    }
}

Write-Host "CFC description updates completed!" -ForegroundColor Green 