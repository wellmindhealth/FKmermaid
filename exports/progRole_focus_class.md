```mermaid
classDiagram
    class "activityDef" as "Farcry Activity Definition" {
        +
        +
        +
        +
    }
    class "programme" as "Programme" {
        +
    }
    class "guide" as "Guide" {
        +
    }
    class "progRole" as "ProgRole" {
        +
    }
    class "media" as "Media" {
        +
    }
    class "partner" as "Partner" {
        +
    }
    class "member" as "Member" {
        +
    }
    activityDef -- programme : programmeID
    activityDef -- guide : guideID
    activityDef -- progRole : role
    activityDef -- activityDef : onEndID
    activityDef -- media : defaultMediaID
    activityDef -- activityDef : aCuePointActivities
    activityDef -- media : aMediaIDs
    activityDef -- activityDef : aInteract1Activities
    activityDef -- activityDef : aInteract2Activities
    activityDef -- activityDef : aInteract3Activities
    activityDef -- activityDef : aInteract4Activities
    activityDef -- activityDef : aInteract5Activities
    guide -- partner : partnerID
    media -- guide : guideID
    media -- partner : partnerID
    media -- programme : programmeID
    media -- progRole : roleID
    member -- progRole : roleID
    programme -- partner : partnerID
    programme -- activityDef : firstActivityDefID
    programme -- activityDef : lastActivityDefID
    programme -- activityDef : aFollowupActivityDefIDs
    progRole -- programme : programmeID
```
