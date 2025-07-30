# Update CFC Descriptions Script
# Updates CFC files with detailed descriptions and short hints

param(
    [string]$ConfigPath = "D:\GIT\farcry\Cursor\FKmermaid\config\component_hints.json",
    [string]$PathwayPath = "D:\GIT\farcry\plugins\pathway\packages\types",
    [string]$FarCryCorePath = "D:\GIT\farcry\zfarcrycore\packages\types",
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
    "dmFacts" = "$FarCryCorePath\dmFacts.cfc"
    "dmNews" = "$FarCryCorePath\dmNews.cfc"
    "dmInclude" = "$FarCryCorePath\dmInclude.cfc"
    "dmImage" = "$FarCryCorePath\dmImage.cfc"
    "dmFile" = "$FarCryCorePath\dmFile.cfc"
}

# Detailed descriptions for @@Description comments
$detailedDescriptions = @{
    "member" = @"
Participant Management Core

Business Context: The member represents an individual participant in Wellmind Health's digital therapeutic programs. This is the central entity that connects the human participant to the digital treatment ecosystem. Members are not just passive recipients but active participants in their own care journey, with personal preferences, progress tracking, and connections to the healthcare provider hierarchy.

Technical Role: The member entity serves as the primary participant record, containing personal details, treatment preferences, and critical relationships to the healthcare provider network (partner organizations, member groups, centers, and referrers). This creates a comprehensive participant profile that spans both personal health data and organizational access controls.

Key Relationships: Member connects to the healthcare provider hierarchy through partner organizations, member groups (for cohort management), centers (physical or virtual service delivery points), and referrers (healthcare professionals who initiated the referral). This multi-layered relationship structure enables both personalized care and organizational oversight.
"@

    "progMember" = @"
Program Enrollment & Progress Tracking

Business Context: progMember represents the active enrollment of a participant in a specific treatment program. This is where the rubber meets the road - where a participant's journey through a structured therapeutic intervention is tracked, measured, and managed. It's the bridge between the participant (member) and the treatment program structure.

Technical Role: This entity manages enrollment status, progress tracking, completion milestones, and program-specific participant data. It's the operational record that tracks a participant's engagement with a specific treatment pathway, including their current position in the program, completion status, and any program-specific adaptations or accommodations.

Key Relationships: progMember links the participant (member) to their chosen treatment program, creating a one-to-many relationship that allows participants to enroll in multiple programs while maintaining separate progress tracking for each enrollment.
"@

    "activity" = @"
Interactive Treatment Steps

Business Context: Activities represent the individual interactive steps that participants engage with during their treatment journey. These are derived from activityDef templates but become personalized instances for each participant. Activities are the building blocks of the therapeutic experience - the actual moments where participants interact with content, complete exercises, or engage with therapeutic interventions.

Technical Role: Each activity is a participant-specific instance of an activityDef, containing the participant's responses, progress, and interaction data. This creates a personalized treatment experience while maintaining the structured approach defined by the activityDef template.

Key Relationships: Activities are derived from activityDef templates, creating a template-instance relationship that ensures consistency while allowing personalization. Each activity belongs to a specific progMember enrollment, linking it to both the participant and their program journey.
"@

    "partner" = @"
Healthcare Organization Management

Business Context: Partners represent healthcare organizations, enterprises, or institutions that provide Wellmind Health programs to their populations. These could be hospitals, health systems, employers, insurance companies, or other healthcare entities that have purchased access to WMH's digital therapeutic programs for their members or participants.

Technical Role: The partner entity manages organizational relationships, access controls, and administrative oversight. It serves as the top-level organizational structure that determines which participants can access which programs, often through intake entitlements and member group assignments.

Key Relationships: Partners have multiple member groups, centers, referrers and intakes under their organizational umbrella, creating a hierarchical structure that supports both centralized administration and distributed care delivery.
"@

    "memberGroup" = @"
Participant Segmentation & Cohort Management

Business Context: Member groups represent categories or cohorts of participants that share common characteristics, treatment needs, or organizational structures. These could be based on clinical criteria (e.g., chronic pain participants), organizational units (e.g., specific departments), or program-specific cohorts (e.g., new vs. returning participants) *also mention research studies*.

Technical Role: Member groups enable segmentation, analysis, and organizational structure within the participant population. They support both clinical decision-making (grouping similar participants) and administrative oversight (organizational reporting and management).

Key Relationships: Member groups belong to partner organizations and contain multiple members, creating a hierarchical structure that supports both clinical and administrative needs.
"@

    "center" = @"
Service Delivery Points

Business Context: Centers represent the physical or virtual locations where healthcare services are delivered and participants receive care. While traditionally physical locations, centers can also represent virtual service delivery points, geo-based service areas, or categorical service groupings.

Technical Role: Centers manage service delivery logistics, participant access, and local resource allocation. They serve as the operational units that connect participants to specific service delivery models and local care teams.

Key Relationships: Centers belong to partner organizations and may have multiple referrers or intakes associated with them, creating a service delivery network that supports both centralized administration and local care delivery.
"@

    "referer" = @"
Healthcare Professional Network

Business Context: Referrers are healthcare professionals, HR representatives, or other authorized individuals responsible for referring participants to Wellmind Health programs (and ultimately responsible for care of participants). They serve as the human connection between the healthcare system and the digital therapeutic platform.

Technical Role: The referrer entity manages referral tracking, and professional oversight of participant care. It creates accountability and professional oversight while enabling the referral-based access model that many healthcare systems require.

Key Relationships: Referrers are associated with centers and may have relationships with specific member groups, creating a professional network that supports both individual care coordination and organizational oversight.
"@

    "intake" = @"
Capacity Management & Access Control

Business Context: Intake represents the healthcare organization's date or number-based entitlement of participant "places" on a program. This is essentially the capacity management system that controls how many participants can access specific programs within defined timeframes or organizational constraints.

Technical Role: Intake manages capacity limits, access controls, and entitlement tracking. It ensures that healthcare organizations can manage their program capacity while providing appropriate access to their populations. This includes tracking available slots, used capacity, and access control rules.

Key Relationships: Intake belongs to partner organizations or centers and controls access to specific programs, creating a capacity management system that balances organizational needs with participant access.
"@

    "programme" = @"
Treatment Program Architecture

Business Context: The programme entity represents the overarching treatment program structure that contains activity definitions, pacing logic, communication templates, educational resources, and lifecycle management. This is the master template that defines how a specific therapeutic intervention is structured and delivered.

Technical Role: Programmes serve as the container for all program-related content, logic, and structure. They define the treatment pathway, activity sequence, communication strategies, and supporting resources for a specific therapeutic intervention.

Key Relationships: Programmes contain multiple activity definitions, media resources, and interactive content, creating a comprehensive treatment structure that supports both standardized delivery and personalized adaptation.
"@

    "activityDef" = @"
Treatment Step Templates

Business Context: ActivityDefs (activity definitions) represent the definition of individual treatment steps within a program. These are the building blocks that define how participants interact with therapeutic content, complete exercises, or engage with educational materials. Each activityDef defines the structure, media requirements, interaction patterns, and progression logic for a specific treatment step.

Technical Role: ActivityDefs serve as templates that define the structure and requirements for individual treatment steps. They contain the logic for media integration, interaction patterns, progression rules, and content structure that will be instantiated for each participant.

Key Relationships: ActivityDefs belong to programmes and may reference multiple media resources, creating a template system that supports both consistency and flexibility in treatment delivery.
"@

    "media" = @"
Content Delivery System

Business Context: Media represents the video, audio, and document content that delivers therapeutic interventions and educational materials to participants. This includes educational videos, interactive exercises, guided meditations, and supporting documentation that form the core content of digital therapeutic programs.

Technical Role: Media entities manage content storage, delivery, and integration with treatment activities. They support multiple content types and delivery formats while maintaining the quality and accessibility standards required for therapeutic content.

Key Relationships: Media resources are referenced by activityDefs and programmes, creating a content management system that supports both structured treatment delivery and flexible content reuse across multiple programs.
"@

    # Admin Components - Enhanced Professional Descriptions
    "farUser" = @"
System User Management & Authentication

Business Context: farUser represents the comprehensive user management system for healthcare staff, administrators, clinicians, and operational personnel who require access to the Wellmind Health platform. These users are distinct from participants (members) and represent the human workforce responsible for managing the digital therapeutic ecosystem, including program administration, participant oversight, clinical support, and system operations. The system supports multiple user types including healthcare professionals, administrative staff, content creators, and system administrators, each with specific access requirements and operational responsibilities.

Technical Role: The farUser entity serves as the cornerstone of the platform's authentication and authorization system, managing user account lifecycle, session management, security credentials, and access control integration. It implements enterprise-grade user management including account creation, password policies, session timeout controls, and integration with organizational directory services. The system supports role-based access control (RBAC) through relationships with farRole and farGroup entities, enabling granular permission management across different organizational functions and data access requirements.

Key Relationships: farUser establishes critical connections to farRole and farGroup entities to implement comprehensive access control policies, while maintaining relationships with specific organizational units (partners, centers) to enforce data access boundaries and operational segregation. This multi-layered relationship structure ensures that users can only access data and functions appropriate to their organizational role and responsibilities, supporting both security compliance and operational efficiency.
"@

    "farGroup" = @"
Permission Group Organization & Access Management

Business Context: farGroup represents the strategic organization of system permissions and access rights into logical, manageable groupings that align with organizational structure and operational requirements. These groups serve as the foundation for efficient access control administration, enabling healthcare organizations to manage complex permission structures while maintaining security standards and operational flexibility. The system supports hierarchical group structures that mirror organizational hierarchies, allowing for inheritance of permissions and simplified administration across large healthcare networks with diverse user populations and varying access requirements.

Technical Role: farGroup implements an organizational layer within the permission system that groups related permissions into meaningful collections, supporting the principle of least privilege while maintaining administrative efficiency. The system provides sophisticated group management capabilities including nested group structures, dynamic group membership based on organizational attributes, and automated permission inheritance rules. This architecture enables scalable access control administration that can accommodate growing healthcare organizations with complex organizational structures and evolving security requirements.

Key Relationships: farGroup establishes hierarchical relationships with farRole entities to create comprehensive permission frameworks, while supporting assignment to farUser accounts through flexible membership models. The system maintains relationships with organizational entities to support location-based access control and department-specific permission structures, creating a robust access management system that balances security requirements with operational needs.
"@

    "farRole" = @"
Role-Based Access Control & Security Framework

Business Context: farRole defines the comprehensive role-based access control framework that governs user access to system functions, data areas, and operational capabilities within the Wellmind Health platform. The system implements sophisticated role definitions including Pathway Admin roles, Participant Admin roles, Basic Center roles, and specialized healthcare professional roles that reflect the complex organizational structure of modern healthcare delivery. These roles determine not only what functions users can access, but also what data they can view, modify, or manage, creating a structured approach to security that supports both clinical operations and administrative oversight while maintaining compliance with healthcare data protection regulations.

Technical Role: farRole implements enterprise-grade role-based access control (RBAC) by defining comprehensive collections of permissions that correspond to specific job functions, organizational positions, and operational responsibilities. The system supports advanced role features including role hierarchies, conditional permissions based on organizational context, and dynamic role assignment based on user attributes or organizational changes. This enables fine-grained access control while maintaining security standards and supporting audit compliance requirements for healthcare data management and patient privacy protection.

Key Relationships: farRole establishes critical connections to farPermission entities to define specific access rights and operational capabilities, while supporting assignment to farUser accounts through flexible group relationships. The system maintains relationships with organizational entities to support context-sensitive access control, creating a comprehensive security framework that adapts to organizational structure and operational requirements while maintaining data protection and access control standards.
"@

    "farPermission" = @"
Individual Access Rights & Security Granularity

Business Context: farPermission represents the fundamental building blocks of the platform's security architecture, defining granular permissions that control access to specific system functions, data areas, operational capabilities, and administrative features. These permissions implement the principle of least privilege by providing atomic-level access control that can be combined to create appropriate access profiles for different user types and organizational roles. The system supports healthcare-specific permissions including patient data access, clinical documentation rights, administrative functions, and system configuration capabilities, ensuring that users can only access the specific functions and data required for their role and responsibilities.

Technical Role: farPermission implements sophisticated permission management including context-sensitive access control, conditional permissions based on organizational relationships, and dynamic permission evaluation based on user attributes and operational context. The system supports permission inheritance, permission delegation, and audit trail capabilities that enable comprehensive security monitoring and compliance reporting. This architecture provides the flexibility to implement complex healthcare access control requirements while maintaining security standards and supporting regulatory compliance for healthcare data management.

Key Relationships: farPermission entities are strategically grouped into farRole definitions to create meaningful access profiles that align with organizational roles and operational requirements. The system supports binding permissions to specific content types or system areas to provide context-sensitive access control, while maintaining relationships with organizational entities to support location-based and department-specific permission structures that reflect the complex nature of healthcare delivery and data management.
"@

    "dmProfile" = @"
User Profile Management & Personalization System

Business Context: dmProfile represents the comprehensive user profile management system that extends beyond basic authentication to provide personalized user experiences, administrative configurations, and operational preferences for healthcare staff and administrators. The system supports sophisticated user customization including interface preferences, workflow configurations, notification settings, and administrative capabilities that enhance user productivity and operational efficiency. This includes personalized dashboards, workflow shortcuts, reporting preferences, and system configuration options that adapt to individual user needs and organizational requirements.

Technical Role: dmProfile manages the complete lifecycle of user-specific settings, preferences, and administrative configurations that customize the user experience and operational capabilities. The system implements advanced profile management including preference persistence, cross-device synchronization, and adaptive interface customization based on user behavior and organizational context. This supports both personalization requirements and administrative oversight of user accounts and their capabilities, enabling organizations to maintain operational standards while supporting individual user productivity and satisfaction.

Key Relationships: dmProfile establishes direct connections to farUser accounts to provide personalized configurations and operational preferences, while integrating with organizational structures to support role-based customization of user interfaces and capabilities. The system maintains relationships with organizational entities to support location-specific and department-specific profile configurations, creating a comprehensive user management system that balances individual customization with organizational standards and operational requirements.
"@

    # Tracking Components - Enhanced Professional Descriptions
    "ssq_stress01" = @"
Stress Assessment Instrument & Clinical Evaluation Framework

Business Context: ssq_stress01 represents a comprehensive, standardized stress assessment questionnaire designed to evaluate participant stress levels, psychological well-being, and treatment progress throughout their therapeutic journey. This instrument is part of a sophisticated clinical assessment framework that enables healthcare providers to establish baseline stress conditions, track treatment effectiveness, and make evidence-based clinical decisions regarding stress management interventions. The assessment supports both individual participant care and aggregate analysis for program effectiveness evaluation, research purposes, and clinical outcome measurement in stress management and mental health programs.

Technical Role: This entity manages the complete lifecycle of stress-related assessments including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including adaptive questioning based on participant responses, longitudinal trend analysis, and integration with clinical decision support systems. This provides healthcare providers with standardized measurement tools that support clinical decision-making, treatment outcome evaluation, and evidence-based practice in stress management and mental health interventions.

Key Relationships: ssq_stress01 establishes critical connections to tracker entities for comprehensive data collection and analysis, while supporting integration with activityDefs to trigger assessment-based treatment adaptations and progress monitoring. The system maintains relationships with clinical decision support systems to provide real-time assessment feedback and treatment recommendations, creating a comprehensive stress evaluation framework that supports both individual care and population health management.
"@

    "ssq_pain01" = @"
Pain Assessment Instrument & Clinical Measurement System

Business Context: ssq_pain01 represents a sophisticated, evidence-based pain assessment questionnaire designed to evaluate participant pain levels, functional limitations, and treatment outcomes throughout their therapeutic journey. This instrument supports comprehensive pain management programs by providing standardized measurement tools that enable healthcare providers to assess pain severity, track treatment effectiveness, and make evidence-based clinical decisions regarding pain management interventions. The assessment supports both individual participant care and aggregate analysis for program effectiveness evaluation, research purposes, and clinical outcome measurement in chronic pain and musculoskeletal health programs.

Technical Role: This entity manages the complete lifecycle of pain assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including multi-dimensional pain evaluation, functional assessment integration, and longitudinal trend analysis that supports clinical decision-making and treatment outcome measurement in pain management programs. This provides healthcare providers with comprehensive measurement tools that support evidence-based practice in pain management and musculoskeletal health interventions.

Key Relationships: ssq_pain01 establishes critical connections to tracker entities for comprehensive data management and analysis, while supporting integration with activityDefs to provide pain-sensitive treatment adaptations and progress monitoring. The system maintains relationships with clinical decision support systems to provide real-time assessment feedback and treatment recommendations, creating a comprehensive pain evaluation framework that supports both individual care and population health management.
"@

    "ssq_arthritis01" = @"
Arthritis Assessment Instrument & Musculoskeletal Health Evaluation

Business Context: ssq_arthritis01 represents a specialized, comprehensive assessment questionnaire designed to evaluate arthritis-related symptoms, functional limitations, and treatment outcomes throughout the participant's therapeutic journey. This instrument supports targeted evaluation of arthritis-specific outcomes and treatment effectiveness in musculoskeletal health programs by providing standardized measurement tools that enable healthcare providers to assess symptom severity, functional limitations, and quality of life measures. The assessment supports both individual participant care and aggregate analysis for program effectiveness evaluation, research purposes, and clinical outcome measurement in arthritis and musculoskeletal health programs.

Technical Role: This entity manages the complete lifecycle of arthritis-specific assessment data including instrument design, data collection protocols, scoring algorithms, and clinical interpretation frameworks. The system implements advanced assessment capabilities including symptom severity evaluation, functional limitation assessment, quality of life measurement, and longitudinal trend analysis that supports clinical decision-making and treatment outcome evaluation in musculoskeletal health programs. This provides healthcare providers with comprehensive measurement tools that support evidence-based practice in arthritis management and musculoskeletal health interventions.

Key Relationships: ssq_arthritis01 establishes critical connections to tracker entities for comprehensive data collection and analysis, while supporting integration with activityDefs to provide arthritis-specific treatment adaptations and progress monitoring. The system maintains relationships with clinical decision support systems to provide real-time assessment feedback and treatment recommendations, creating a comprehensive arthritis evaluation framework that supports both individual care and population health management.
"@

    "tracker" = @"
Assessment Data Management & Clinical Analytics Platform

Business Context: tracker represents the comprehensive data management and analytics platform for collecting, storing, analyzing, and reporting participant self-assessment data from various questionnaires and evaluation instruments. This system creates a robust data foundation for clinical decision-making, treatment effectiveness evaluation, research purposes, and population health management. The platform supports both individual participant care through personalized assessment tracking and aggregate analysis for program effectiveness evaluation, quality improvement initiatives, and research objectives across multiple therapeutic domains and clinical specialties.

Technical Role: tracker manages the complete data lifecycle for participant assessments including data collection protocols, secure storage systems, advanced analytics capabilities, and comprehensive reporting frameworks. The system implements sophisticated data management including real-time data collection, longitudinal trend analysis, predictive analytics, and integration with clinical decision support systems. This supports both individual participant care through personalized assessment tracking and aggregate analysis for program effectiveness evaluation, quality improvement initiatives, and research objectives across multiple therapeutic domains.

Key Relationships: tracker establishes comprehensive connections to various assessment instruments (ssq_stress01, ssq_pain01, ssq_arthritis01) and trackerDef entities, creating a unified assessment framework that supports both clinical care and research objectives. The system maintains relationships with clinical decision support systems to provide real-time analytics and treatment recommendations, while supporting integration with organizational reporting systems for quality improvement and population health management initiatives.
"@

    "trackerDef" = @"
Assessment Definition Templates & Clinical Instrument Framework

Business Context: trackerDef represents the comprehensive template definition system for various assessment instruments and questionnaires used throughout the platform. These templates define the structure, scoring methods, data collection protocols, and clinical interpretation frameworks for standardized clinical assessments across multiple therapeutic domains. The system supports both established clinical instruments and custom assessment development, enabling healthcare organizations to implement evidence-based assessment protocols while maintaining flexibility for specialized clinical requirements and research objectives.

Technical Role: trackerDef manages the complete metadata and configuration framework for assessment instruments including question structures, scoring algorithms, data collection protocols, and clinical interpretation guidelines. The system implements advanced template management including version control, instrument validation, scoring algorithm development, and integration with clinical decision support systems. This ensures consistency and standardization across different assessment types and implementations while supporting the development of new assessment instruments and the adaptation of existing instruments for specific clinical contexts.

Key Relationships: trackerDef establishes critical connections to tracker entities for comprehensive data collection and analysis, while supporting integration with activityDefs to define assessment requirements and trigger assessment-based treatment adaptations. The system maintains relationships with clinical decision support systems to provide real-time assessment guidance and treatment recommendations, creating a comprehensive assessment framework that supports both clinical care and research objectives across multiple therapeutic domains.
"@

    # Programme Components - Enhanced Professional Descriptions
    "progRole" = @"
Program-Specific Access Control & Treatment Personalization

Business Context: progRole represents the sophisticated program-specific access control system that manages participant access and content delivery within individual treatment programs. These roles determine what program content, activities, features, and resources each participant can access based on their enrollment status, treatment progress, clinical requirements, and program-specific adaptations. The system supports personalized treatment delivery while maintaining program structure and security requirements, enabling healthcare providers to implement evidence-based treatment protocols while accommodating individual participant needs and clinical requirements.

Technical Role: progRole implements advanced program-specific access control by defining comprehensive participant permissions within individual treatment programs. The system supports sophisticated access management including progress-based content unlocking, clinical condition-specific adaptations, and personalized treatment pathway management. This supports personalized treatment delivery while maintaining program structure and security requirements, enabling healthcare providers to implement evidence-based treatment protocols while accommodating individual participant needs and clinical requirements.

Key Relationships: progRole establishes critical connections to programme entities to establish program-specific access controls and treatment pathway management, while supporting integration with member entities to provide personalized program experiences based on participant characteristics, clinical needs, and treatment progress. The system maintains relationships with clinical decision support systems to provide real-time access control and treatment adaptation recommendations, creating a comprehensive program management framework that supports both standardized treatment delivery and personalized care pathways.
"@

    "journal" = @"
Participant Personal Documentation & Therapeutic Reflection System

Business Context: journal represents the comprehensive personal documentation and reflection system that enables participants to create, manage, and share personal notes, reflections, and treatment-related documentation throughout their therapeutic journey. This system supports participant engagement, self-reflection, and therapeutic progress by providing structured and unstructured documentation capabilities that capture the participant's subjective experience, treatment insights, and personal growth throughout their therapeutic journey. The system supports both individual reflection and therapeutic collaboration, enabling participants to share insights with healthcare providers while maintaining privacy and personal control over their documentation.

Technical Role: journal manages the complete lifecycle of participant-generated content including personal notes, reflections, treatment-related documentation, and therapeutic insights. The system implements advanced content management including privacy controls, content categorization, search capabilities, and integration with therapeutic assessment frameworks. This supports both participant engagement and provides valuable data for treatment effectiveness evaluation, clinical decision-making, and therapeutic outcome measurement while maintaining participant privacy and data protection standards.

Key Relationships: journal establishes direct connections to member entities to associate personal documentation with specific participants, while supporting integration with activity entities to capture reflections related to specific treatment activities, milestones, and therapeutic interventions. The system maintains relationships with clinical decision support systems to provide therapeutic insights and treatment recommendations, creating a comprehensive documentation framework that supports both individual reflection and therapeutic collaboration.
"@

    "journalDef" = @"
Journal Template Definitions & Therapeutic Reflection Framework

Business Context: journalDef represents the comprehensive template definition system for structured participant reflection and documentation activities that support treatment engagement and progress tracking. These templates define the prompts, structure, guidance, and therapeutic framework for participant journaling activities that enhance treatment engagement, support therapeutic progress, and provide valuable insights for clinical decision-making. The system supports both standardized reflection protocols and customized journaling activities that can be adapted to specific therapeutic domains, clinical requirements, and participant needs.

Technical Role: journalDef manages the complete metadata and configuration framework for journaling activities including prompts, structure, guidance, and therapeutic frameworks that ensure consistent and therapeutic journaling experiences across different programs and participants. The system implements advanced template management including therapeutic protocol integration, progress tracking capabilities, and clinical outcome measurement frameworks. This ensures consistency and standardization across different journaling activities while supporting the development of specialized reflection protocols for specific therapeutic domains and clinical requirements.

Key Relationships: journalDef establishes critical connections to journal entities for comprehensive data collection and therapeutic insight generation, while supporting integration with activityDefs to define journaling requirements and integrate reflection activities into treatment programs. The system maintains relationships with clinical decision support systems to provide therapeutic guidance and treatment recommendations, creating a comprehensive reflection framework that supports both individual therapeutic growth and clinical outcome measurement.
"@

    "library" = @"
Content Resource Management & Therapeutic Knowledge System

Business Context: library represents the comprehensive content library system for organizing, managing, and delivering therapeutic resources, educational materials, and supporting content to participants throughout their treatment journey. This system includes articles, exercises, guides, educational resources, and supplementary content that complements and enhances core treatment programs. The library supports both structured content delivery and flexible resource access based on participant needs, clinical requirements, and program objectives, enabling healthcare providers to provide comprehensive therapeutic support while maintaining evidence-based practice standards.

Technical Role: library manages the complete lifecycle of supplementary therapeutic content and resources including content creation, categorization, delivery, and integration with treatment programs. The system implements advanced content management including personalized recommendations, progress-based content delivery, and integration with clinical decision support systems. This supports both structured content delivery and flexible resource access based on participant needs, clinical requirements, and program objectives while maintaining content quality and therapeutic effectiveness standards.

Key Relationships: library establishes comprehensive connections to programme and activityDef entities to provide supplementary content and resources that enhance treatment effectiveness, while supporting integration with member entities to provide personalized content recommendations based on participant characteristics, clinical needs, and treatment progress. The system maintains relationships with clinical decision support systems to provide evidence-based content recommendations and therapeutic guidance, creating a comprehensive knowledge management framework that supports both individual care and population health management.
"@

    "guide" = @"
Healthcare Professional Support & Clinical Guidance System

Business Context: guide represents the comprehensive healthcare professional support and clinical guidance system that provides clinicians, healthcare staff, and administrative personnel with the resources, guidance, and support materials needed to effectively support participant treatment journeys. This system includes clinical guidance, best practices, support resources, and professional development materials that enhance healthcare provider effectiveness and ensure consistent, high-quality care delivery across different healthcare settings and professional specialties. The system supports both individual professional development and organizational quality improvement initiatives.

Technical Role: guide manages the complete lifecycle of professional support materials and clinical guidance including content creation, organization, delivery, and integration with clinical workflows. The system implements advanced content management including role-based content delivery, clinical protocol integration, and professional development tracking. This supports clinical decision-making and ensures consistent, high-quality care delivery across different healthcare settings and professional specialties while maintaining evidence-based practice standards and professional development requirements.

Key Relationships: guide establishes comprehensive connections to programme and activityDef entities to provide professional guidance and support materials that enhance treatment effectiveness, while supporting integration with partner and center entities to support organization-specific clinical practices and protocols. The system maintains relationships with clinical decision support systems to provide real-time guidance and professional development recommendations, creating a comprehensive support framework that enhances both individual professional effectiveness and organizational quality improvement.
"@

    # Site Components - Enhanced Professional Descriptions
    "dmNavigation" = @"
Website Structure Management & User Experience Architecture

Business Context: dmNavigation represents the comprehensive website navigation structure and user experience architecture that guides users through the platform's features, content, and functionality. This system manages the user interface structure, menu hierarchies, navigation pathways, and information architecture that create intuitive and efficient user experiences for healthcare professionals, administrators, and participants. The system supports both public-facing content delivery and secure healthcare platform functionality while maintaining accessibility standards and user experience best practices.

Technical Role: dmNavigation manages the complete hierarchical structure of website navigation including menu organization, page relationships, user interface flow, and information architecture optimization. The system implements advanced navigation management including responsive design support, accessibility compliance, and integration with permission-based access control systems. This supports both user experience design and content organization across the platform while maintaining security standards and supporting healthcare-specific user experience requirements.

Key Relationships: dmNavigation establishes comprehensive connections to various content entities (dmHTML, dmFacts, dmNews) to create navigable content structures that support user needs and organizational objectives, while integrating with farBarnacle for permission-based navigation control and access management. The system maintains relationships with user experience frameworks to provide consistent and intuitive navigation experiences across different user types and organizational contexts.
"@

    "dmHTML" = @"
Dynamic Content Management & Web Experience Platform

Business Context: dmHTML represents the comprehensive HTML content management system for website pages and dynamic content delivery that supports the platform's information architecture and user communication needs. This system manages the creation, editing, versioning, and delivery of web content that enhances user engagement, supports organizational communication, and maintains platform functionality across diverse user populations and organizational contexts. The system supports both static content management and dynamic content delivery based on user context, permissions, and organizational requirements.

Technical Role: dmHTML manages the complete lifecycle of web content including creation, editing, versioning, delivery, and integration with user experience frameworks. The system implements advanced content management including responsive design support, accessibility compliance, and integration with permission-based content delivery systems. This supports both content management workflows and dynamic content delivery based on user context and permissions while maintaining content quality and user experience standards.

Key Relationships: dmHTML establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with various content entities to support rich, dynamic web experiences that adapt to user needs and permissions. The system maintains relationships with user experience frameworks to provide consistent and engaging content delivery across different user types and organizational contexts.
"@

    "dmFacts" = @"
Information Resource Management & Educational Content System

Business Context: dmFacts represents the comprehensive factual content management system for website information and educational material that supports user understanding, platform navigation, and organizational communication objectives. This system includes static information, educational content, reference materials, and organizational resources that enhance user knowledge, support platform adoption, and maintain organizational transparency across diverse user populations and stakeholder groups. The system supports both public information delivery and secure healthcare platform functionality while maintaining content accuracy and accessibility standards.

Technical Role: dmFacts manages the complete lifecycle of factual and educational content including content creation, organization, delivery, and integration with user experience frameworks. The system implements advanced content management including version control, accessibility compliance, and integration with organizational knowledge management systems. This supports both information architecture and educational objectives while maintaining content quality and accessibility standards for healthcare technology platforms.

Key Relationships: dmFacts establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with library entities to provide educational resources and reference materials that support user understanding and engagement. The system maintains relationships with organizational knowledge management systems to provide accurate and up-to-date information across different user types and organizational contexts.
"@

    "dmNews" = @"
Communication Management & Organizational Information System

Business Context: dmNews represents the comprehensive news content management system for website updates and announcements that supports organizational communication, user engagement, and platform transparency. This system manages platform communications, updates, announcements, and organizational information that keep users informed about system changes, new features, important information, and organizational developments. The system supports both internal communication needs and external stakeholder engagement while maintaining communication quality and delivery standards across diverse user populations and organizational contexts.

Technical Role: dmNews manages the complete lifecycle of news content and announcements including content creation, publication, delivery, and integration with organizational communication frameworks. The system implements advanced content management including targeted delivery, audience segmentation, and integration with organizational communication systems. This supports both internal and external communication needs while maintaining content quality and delivery standards for healthcare technology platforms.

Key Relationships: dmNews establishes direct connections to dmNavigation for content organization and user experience optimization, while supporting integration with various user entities to support targeted communication and announcement delivery based on user roles, preferences, and organizational relationships. The system maintains relationships with organizational communication frameworks to provide consistent and effective information delivery across different user types and organizational contexts.
"@

    "dmInclude" = @"
Component Content Management & Modular Content System

Business Context: dmInclude represents the comprehensive include content management system for website components and reusable elements that supports content consistency, development efficiency, and user experience optimization. This system manages modular content components that can be reused across different pages and contexts to maintain consistency, efficiency, and quality across the platform. The system supports both content development workflows and user experience optimization while maintaining content quality and delivery standards.

Technical Role: dmInclude manages the complete lifecycle of reusable content components including creation, versioning, delivery, and integration with content management frameworks. The system implements advanced component management including version control, dependency management, and integration with content delivery systems. This supports both content consistency and development efficiency by enabling modular content creation and reuse across the platform while maintaining quality and performance standards.

Key Relationships: dmInclude establishes comprehensive connections to various content entities (dmHTML, dmFacts, dmNews) to provide modular content components that enhance user experience and development efficiency, while supporting integration with dmNavigation to support component-based page construction and content organization. The system maintains relationships with content management frameworks to provide consistent and efficient content delivery across different user types and organizational contexts.
"@

    "dmImage" = @"
Visual Resource Management & Digital Asset System

Business Context: dmImage represents the comprehensive image resource management system for website graphics and visual content that supports the platform's visual design, user experience, and content delivery requirements. This system manages the storage, organization, optimization, and delivery of visual assets that enhance user engagement, support brand consistency, and maintain visual quality across diverse user populations and organizational contexts. The system supports both therapeutic content delivery and organizational communication needs while maintaining accessibility and quality standards.

Technical Role: dmImage manages the complete lifecycle of visual assets including upload, storage, optimization, delivery, and integration with content management frameworks. The system implements advanced asset management including responsive image delivery, accessibility compliance, and integration with content delivery systems. This supports both visual design requirements and performance optimization while maintaining accessibility and quality standards for healthcare technology platforms.

Key Relationships: dmImage establishes comprehensive connections to various content entities (dmHTML, dmFacts, dmNews) to provide visual assets that enhance user experience and content effectiveness, while supporting integration with media entities to support therapeutic content delivery and visual communication needs. The system maintains relationships with content management frameworks to provide consistent and high-quality visual delivery across different user types and organizational contexts.
"@

    "dmFile" = @"
Document Resource Management & Digital Asset System

Business Context: dmFile represents the comprehensive file resource management system for downloadable documents and secure digital asset storage that supports user needs, platform functionality, and organizational communication requirements. This system manages the storage, organization, versioning, and delivery of downloadable documents and resources that enhance user experience, support platform functionality, and maintain organizational transparency across diverse user populations and stakeholder groups. The system supports both educational resource delivery and organizational communication needs while maintaining security and accessibility standards.

Technical Role: dmFile manages the complete lifecycle of document resources including upload, storage, versioning, delivery, and integration with content management frameworks. The system implements advanced asset management including secure file delivery, version control, and integration with content delivery systems. This supports both user resource needs and platform functionality while maintaining security and accessibility standards for healthcare technology platforms.

Key Relationships: dmFile establishes comprehensive connections to various content entities to provide downloadable resources that enhance user experience and platform functionality, while supporting integration with library entities to support educational resource delivery and document management for therapeutic content. The system maintains relationships with content management frameworks to provide secure and efficient document delivery across different user types and organizational contexts.
"@
}

function Update-CFCFile {
    param(
        [string]$FilePath,
        [string]$ComponentName,
        [string]$ShortHint,
        [string]$DetailedDescription
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Warning "File not found: $FilePath"
        return $false
    }
    
    $content = Get-Content $FilePath -Raw
    $originalContent = $content
    
    # Update the @@Description comment
    $descriptionPattern = '<!--- @@Description:.*?--->'
    $newDescriptionComment = "<!--- @@Description: $ComponentName - $DetailedDescription --->"
    
    if ($content -match $descriptionPattern) {
        $content = $content -replace $descriptionPattern, $newDescriptionComment
    } else {
        # Add description comment after copyright
        $content = $content -replace '(<!--- @@Copyright:.*?--->)', "`$1`n$newDescriptionComment"
    }
    
    # Update the hint attribute in cfcomponent tag
    $hintPattern = 'hint="[^"]*"'
    $newHint = "hint=`"$ShortHint`""
    
    if ($content -match $hintPattern) {
        $content = $content -replace $hintPattern, $newHint
    }
    
    if ($content -ne $originalContent) {
        if ($DryRun) {
            Write-Host "DRY RUN: Would update $FilePath" -ForegroundColor Yellow
            if ($Verbose) {
                Write-Host "  - Updated hint: $ShortHint"
                Write-Host "  - Updated description: $ComponentName"
            }
        } else {
            Set-Content -Path $FilePath -Value $content -Encoding UTF8
            Write-Host "Updated: $FilePath" -ForegroundColor Green
        }
        return $true
    } else {
        Write-Host "No changes needed: $FilePath" -ForegroundColor Gray
        return $false
    }
}

# Main execution
Write-Host "CFC Description Update Script" -ForegroundColor Cyan
Write-Host "=============================" -ForegroundColor Cyan
Write-Host "Config Path: $ConfigPath" -ForegroundColor Gray
Write-Host "CFC Path: $PathwayPath" -ForegroundColor Gray
Write-Host "Dry Run: $DryRun" -ForegroundColor Gray
Write-Host ""

$updatedCount = 0
$totalCount = 0

foreach ($componentName in $hintsConfig.componentHints.PSObject.Properties.Name) {
    $cfcFile = $componentPaths[$componentName]
    
    if ($cfcFile) {
        $shortHint = $hintsConfig.componentHints.$componentName
        $detailedDescription = $detailedDescriptions[$componentName]
        
        if ($detailedDescription) {
            $totalCount++
            $updated = Update-CFCFile -FilePath $cfcFile -ComponentName $componentName -ShortHint $shortHint -DetailedDescription $detailedDescription
            if ($updated) { $updatedCount++ }
        } else {
            Write-Warning "No detailed description found for component: $componentName"
        }
    } else {
        Write-Warning "Component file not found for: $componentName"
    }
}

Write-Host ""
Write-Host "Summary:" -ForegroundColor Cyan
Write-Host "  Total components processed: $totalCount"
Write-Host "  Files updated: $updatedCount"
Write-Host "  Dry run mode: $DryRun"

if ($DryRun) {
    Write-Host ""
    Write-Host "To apply changes, run without -DryRun parameter" -ForegroundColor Yellow
} 