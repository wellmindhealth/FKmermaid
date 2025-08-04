# Mermaid Diagram Validation Report

Generated: 2025-08-04 00:40:02

## Summary

- **Total Diagrams**: 67
- **Diagrams With Issues**: 67

### Issues by Type

| Issue Type | Count |
|------------|-------|
| Layer Representation | 10 |
| Relationship Accuracy | 0 |
| Domain Boundaries | 148 |
| Style Logic | 312 |

## Detailed Results

### activity-participant.mmd

- **Focus Entity**: activity
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_activity: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_journal: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_library: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_tracker: Expected #7e4f2b, got #9d3100

### activityDef-pathway.mmd

- **Focus Entity**: activityDef
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_activity from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_progRole from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_activity: Expected #7e4f2b, got #883583
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_media: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #883583
- Incorrect style for pathway_testimonial: Expected #7e4f2b, got #883583
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #9d3100

### apiAccessKey-provider.mmd

- **Focus Entity**: apiAccessKey
- **Domains**: provider

#### Issues:
- Incorrect style for api_apiAccessKey: Expected #7e4f2b, got #d76400

### category-pathway.mmd

- **Focus Entity**: category
- **Domains**: pathway

#### Issues:
- Incorrect style for zfarcrycore_category: Expected #7e4f2b, got #d76400

### center-provider.mmd

- **Focus Entity**: center
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_dmImage from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #883583
- Incorrect style for pathway_center: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_intake: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100

### device-provider.mmd

- **Focus Entity**: device
- **Domains**: provider

#### Issues:
- Incorrect style for pathway_device: Expected #7e4f2b, got #d76400

### dmArchive-participant.mmd

- **Focus Entity**: dmArchive
- **Domains**: participant

#### Issues:
- Domain boundary violation: zfarcrycore_dmArchive from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_dmArchive: Expected #7e4f2b, got #d76400

### dmArchive-pathway.mmd

- **Focus Entity**: dmArchive
- **Domains**: pathway

#### Issues:
- Domain boundary violation: zfarcrycore_dmArchive from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_dmArchive: Expected #7e4f2b, got #d76400

### dmArchive-provider.mmd

- **Focus Entity**: dmArchive
- **Domains**: provider

#### Issues:
- Incorrect style for zfarcrycore_dmArchive: Expected #7e4f2b, got #d76400

### dmEmail-pathway.mmd

- **Focus Entity**: dmEmail
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for farcrycms_dmEmail: Expected #7e4f2b, got #d76400

### dmFacts-pathway.mmd

- **Focus Entity**: dmFacts
- **Domains**: pathway

#### Issues:
- Layer mismatch for pathway_ruleFacts: Expected utilities
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleFacts: Expected #7e4f2b, got #883583
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for farcrycms_dmFacts: Expected #7e4f2b, got #d76400

### dmFile-pathway.mmd

- **Focus Entity**: dmFile
- **Domains**: pathway

#### Issues:
- Layer mismatch for pathway_ruleFileListing: Expected utilities
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleFileListing: Expected #7e4f2b, got #883583
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmFile: Expected #7e4f2b, got #d76400

### dmHTML-pathway.mmd

- **Focus Entity**: dmHTML
- **Domains**: pathway

#### Issues:
- Layer mismatch for pathway_ruleFacts: Expected utilities
- Layer mismatch for pathway_ruleRelated: Expected utilities
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleFacts: Expected #7e4f2b, got #883583
- Incorrect style for pathway_ruleRelated: Expected #7e4f2b, got #883583
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmHTML: Expected #7e4f2b, got #d76400

### dmImage-pathway.mmd

- **Focus Entity**: dmImage
- **Domains**: pathway

#### Issues:
- Layer mismatch for farcrycms_dmCarouselItem: Expected utilities
- Layer mismatch for farcrycms_dmEvent: Expected utilities
- Domain boundary violation: pathway_center from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_partner from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_referer from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_dmNavigation: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmNews: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_center: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #883583
- Incorrect style for farcrycms_dmCarouselItem: Expected #7e4f2b, got #883583
- Incorrect style for farcrycms_dmEvent: Expected #7e4f2b, got #883583
- Incorrect style for farcrycms_dmFacts: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmFile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmHTML: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmInclude: Expected #7e4f2b, got #9d3100

### dmInclude-pathway.mmd

- **Focus Entity**: dmInclude
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmInclude: Expected #7e4f2b, got #d76400

### dmNavigation-pathway.mmd

- **Focus Entity**: dmNavigation
- **Domains**: pathway

#### Issues:
- Layer mismatch for zfarcrycore_farFilterProperty: Expected utilities
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmNavigation: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farFilterProperty: Expected #7e4f2b, got #883583

### dmNews-pathway.mmd

- **Focus Entity**: dmNews
- **Domains**: pathway

#### Issues:
- Layer mismatch for farcrycms_ruleNews: Expected utilities
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmNews: Expected #7e4f2b, got #d76400
- Incorrect style for farcrycms_ruleNews: Expected #7e4f2b, got #883583

### dmProfile-pathway.mmd

- **Focus Entity**: dmProfile
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_center from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_partner from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_referer from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_center: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #883583
- Incorrect style for pathway_referer: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #9d3100

### dmProfile-provider.mmd

- **Focus Entity**: dmProfile
- **Domains**: provider

#### Issues:
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #9d3100

### dmWizard-pathway.mmd

- **Focus Entity**: dmWizard
- **Domains**: pathway

#### Issues:
- Incorrect style for zfarcrycore_dmWizard: Expected #7e4f2b, got #d76400

### farBarnacle-pathway.mmd

- **Focus Entity**: farBarnacle
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100

### farConfig-pathway.mmd

- **Focus Entity**: farConfig
- **Domains**: pathway

#### Issues:
- Incorrect style for zfarcrycore_farConfig: Expected #7e4f2b, got #d76400

### FarcryUD-pathway.mmd

- **Focus Entity**: FarcryUD
- **Domains**: pathway

#### Issues:
- Incorrect style for zfarcrycore_FarcryUD: Expected #7e4f2b, got #d76400

### farFeedback-participant.mmd

- **Focus Entity**: farFeedback
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for farcrycms_farFeedback: Expected #7e4f2b, got #d76400

### farFeedback-pathway.mmd

- **Focus Entity**: farFeedback
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for farcrycms_farFeedback: Expected #7e4f2b, got #d76400

### farFU-pathway.mmd

- **Focus Entity**: farFU
- **Domains**: pathway

#### Issues:
- Incorrect style for zfarcrycore_farFU: Expected #7e4f2b, got #d76400

### farGroup-participant.mmd

- **Focus Entity**: farGroup
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #883583

### farGroup-pathway.mmd

- **Focus Entity**: farGroup
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #9d3100

### farGroup-provider.mmd

- **Focus Entity**: farGroup
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #9d3100

### farLog-participant.mmd

- **Focus Entity**: farLog
- **Domains**: participant

#### Issues:
- Domain boundary violation: zfarcrycore_farLog from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farLog: Expected #7e4f2b, got #d76400

### farLog-pathway.mmd

- **Focus Entity**: farLog
- **Domains**: pathway

#### Issues:
- Domain boundary violation: zfarcrycore_farLog from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farLog: Expected #7e4f2b, got #d76400

### farLog-provider.mmd

- **Focus Entity**: farLog
- **Domains**: provider

#### Issues:
- Incorrect style for zfarcrycore_farLog: Expected #7e4f2b, got #d76400

### farPermission-participant.mmd

- **Focus Entity**: farPermission
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Domain boundary violation: zfarcrycore_farBarnacle from pathway (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100

### farPermission-pathway.mmd

- **Focus Entity**: farPermission
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100

### farPermission-provider.mmd

- **Focus Entity**: farPermission
- **Domains**: provider

#### Issues:
- Domain boundary violation: zfarcrycore_farBarnacle from pathway (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100

### farRole-participant.mmd

- **Focus Entity**: farRole
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Domain boundary violation: zfarcrycore_farBarnacle from pathway (not directly connected and not common entity)
- Domain boundary violation: zfarcrycore_farWebtopDashboard from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farWebtopDashboard: Expected #7e4f2b, got #883583

### farRole-pathway.mmd

- **Focus Entity**: farRole
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Domain boundary violation: zfarcrycore_farWebtopDashboard from provider (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farWebtopDashboard: Expected #7e4f2b, got #883583

### farRole-provider.mmd

- **Focus Entity**: farRole
- **Domains**: provider

#### Issues:
- Domain boundary violation: zfarcrycore_farBarnacle from pathway (not directly connected and not common entity)
- Incorrect style for zfarcrycore_farBarnacle: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farPermission: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_farWebtopDashboard: Expected #7e4f2b, got #9d3100

### farUser-pathway.mmd

- **Focus Entity**: farUser
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #d76400

### farUser-provider.mmd

- **Focus Entity**: farUser
- **Domains**: provider

#### Issues:
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #d76400

### farWebtopDashboard-provider.mmd

- **Focus Entity**: farWebtopDashboard
- **Domains**: provider

#### Issues:
- Incorrect style for zfarcrycore_farRole: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farWebtopDashboard: Expected #7e4f2b, got #d76400

### intake-provider.mmd

- **Focus Entity**: intake
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_intake: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100

### journal-participant.mmd

- **Focus Entity**: journal
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_journalDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_activity: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_journal: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100

### journalDef-pathway.mmd

- **Focus Entity**: journalDef
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_journal from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_journal: Expected #7e4f2b, got #883583
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #9d3100

### JWTapp-pathway.mmd

- **Focus Entity**: JWTapp
- **Domains**: pathway

#### Issues:
- Incorrect style for pathway_JWTapp: Expected #7e4f2b, got #d76400

### library-participant.mmd

- **Focus Entity**: library
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_media from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_activity: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_library: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_media: Expected #7e4f2b, got #883583
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100

### media-pathway.mmd

- **Focus Entity**: media
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_library from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_partner from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_progRole from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_library: Expected #7e4f2b, got #883583
- Incorrect style for pathway_media: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_partner: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #883583

### member-participant.mmd

- **Focus Entity**: member
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_center from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_intake from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_memberGroup from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_memberType from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_partner from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_progRole from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_referer from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_report from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_center: Expected #7e4f2b, got #883583
- Incorrect style for pathway_intake: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberType: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #883583
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #883583
- Incorrect style for pathway_referer: Expected #7e4f2b, got #883583
- Incorrect style for pathway_report: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_arthritis01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_SSQ_pain01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_SSQ_stress01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_testimonial: Expected #7e4f2b, got #9d3100
- Incorrect style for farcrycms_farFeedback: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farGroup: Expected #7e4f2b, got #9d3100

### memberGroup-provider.mmd

- **Focus Entity**: memberGroup
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_dmImage from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_dmNavigation from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: farcrycms_dmEmail from pathway (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #883583
- Incorrect style for pathway_dmNavigation: Expected #7e4f2b, got #883583
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_intake: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_report: Expected #7e4f2b, got #9d3100
- Incorrect style for farcrycms_dmEmail: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmFile: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmHTML: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_farUser: Expected #7e4f2b, got #9d3100

### memberType-pathway.mmd

- **Focus Entity**: memberType
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_ruleSelfRegistration from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_report from provider (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberType: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_report: Expected #7e4f2b, got #883583

### nhs-provider.mmd

- **Focus Entity**: nhs
- **Domains**: provider

#### Issues:
- Incorrect style for pathway_nhs: Expected #7e4f2b, got #d76400

### partner-provider.mmd

- **Focus Entity**: partner
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_dmImage from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_media from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #883583
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_media: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_partner: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_report: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100

### progMember-participant.mmd

- **Focus Entity**: progMember
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_activity: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_journal: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_library: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_programme: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_arthritis01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_SSQ_pain01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_SSQ_stress01: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_tracker: Expected #7e4f2b, got #9d3100

### programme-pathway.mmd

- **Focus Entity**: programme
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_partner from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_progMember from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_progRole from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_report from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_arthritis01 from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_pain01 from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_stress01 from participant (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_media: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_partner: Expected #7e4f2b, got #883583
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #883583
- Incorrect style for pathway_report: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_arthritis01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_pain01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_stress01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #9d3100
- Incorrect style for zfarcrycore_dmFile: Expected #7e4f2b, got #9d3100

### programme-provider.mmd

- **Focus Entity**: programme
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_dmImage from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_journalDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_media from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_progMember from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_arthritis01 from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_pain01 from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_SSQ_stress01 from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_trackerDef from pathway (not directly connected and not common entity)
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #883583
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_media: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_report: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_SSQ_arthritis01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_pain01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_stress01: Expected #7e4f2b, got #883583
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #883583
- Incorrect style for zfarcrycore_dmFile: Expected #7e4f2b, got #883583

### progRole-provider.mmd

- **Focus Entity**: progRole
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_media from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_media: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progRole: Expected #7e4f2b, got #d76400

### referer-provider.mmd

- **Focus Entity**: referer
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_dmImage from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_dmImage: Expected #7e4f2b, got #883583
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #d76400
- Incorrect style for zfarcrycore_dmProfile: Expected #7e4f2b, got #9d3100

### report-provider.mmd

- **Focus Entity**: report
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Domain boundary violation: pathway_memberType from pathway (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberType: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_report: Expected #7e4f2b, got #d76400

### ruleSelfRegistration-provider.mmd

- **Focus Entity**: ruleSelfRegistration
- **Domains**: provider

#### Issues:
- Domain boundary violation: pathway_memberType from pathway (not directly connected and not common entity)
- Incorrect style for pathway_ruleSelfRegistration: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_center: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberGroup: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_memberType: Expected #7e4f2b, got #883583
- Incorrect style for pathway_partner: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_referer: Expected #7e4f2b, got #9d3100

### SSQ_arthritis01-participant.mmd

- **Focus Entity**: SSQ_arthritis01
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_programme: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_arthritis01: Expected #7e4f2b, got #d76400

### SSQ_pain01-participant.mmd

- **Focus Entity**: SSQ_pain01
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_programme: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_pain01: Expected #7e4f2b, got #d76400

### SSQ_stress01-participant.mmd

- **Focus Entity**: SSQ_stress01
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_programme: Expected #7e4f2b, got #883583
- Incorrect style for pathway_SSQ_stress01: Expected #7e4f2b, got #d76400

### testimonial-participant.mmd

- **Focus Entity**: testimonial
- **Domains**: participant

#### Issues:
- Layer mismatch for pathway_ruleLatesttestimonial: Expected utilities
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Incorrect style for pathway_ruleLatesttestimonial: Expected #7e4f2b, got #883583
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_testimonial: Expected #7e4f2b, got #d76400

### testimonial-provider.mmd

- **Focus Entity**: testimonial
- **Domains**: provider

#### Issues:
- Layer mismatch for pathway_ruleLatesttestimonial: Expected utilities
- Domain boundary violation: pathway_activityDef from pathway (not directly connected and not common entity)
- Domain boundary violation: pathway_member from participant (not directly connected and not common entity)
- Incorrect style for pathway_ruleLatesttestimonial: Expected #7e4f2b, got #883583
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #883583
- Incorrect style for pathway_member: Expected #7e4f2b, got #883583
- Incorrect style for pathway_testimonial: Expected #7e4f2b, got #d76400

### token-pathway.mmd

- **Focus Entity**: token
- **Domains**: pathway

#### Issues:
- Incorrect style for pathway_token: Expected #7e4f2b, got #d76400

### tracker-participant.mmd

- **Focus Entity**: tracker
- **Domains**: participant

#### Issues:
- Domain boundary violation: pathway_testimonial from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_trackerDef from pathway (not directly connected and not common entity)
- Incorrect style for pathway_activity: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_progMember: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_tracker: Expected #7e4f2b, got #d76400
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #883583

### trackerDef-pathway.mmd

- **Focus Entity**: trackerDef
- **Domains**: pathway

#### Issues:
- Domain boundary violation: pathway_programme from provider (not directly connected and not common entity)
- Domain boundary violation: pathway_tracker from participant (not directly connected and not common entity)
- Domain boundary violation: farcrycms_farFeedback from participant (not directly connected and not common entity)
- Incorrect style for pathway_activityDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_journalDef: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_programme: Expected #7e4f2b, got #9d3100
- Incorrect style for pathway_tracker: Expected #7e4f2b, got #883583
- Incorrect style for pathway_trackerDef: Expected #7e4f2b, got #d76400

