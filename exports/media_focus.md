```mermaid
classDiagram
    class programme
    class guide
    class progRole
    class media
    class partner
    class activityDef {
        <<Farcry Activity Definition>>
        %% Core Properties %%
        +programmeID
        +teaserImage
        +guideID
        +role
        +onEndID
        +defaultMediaID
        +aCuePointActivities
        +aMediaIDs
        +journalID
        %% Tracker IDs %%
        +tracker01ID
        +tracker02ID
        +tracker03ID
        +tracker04ID
        +tracker05ID
        %% Interact Activities %%
        +aInteract1Activities
        +aInteract2Activities
        +aInteract3Activities
        +aInteract4Activities
        +aInteract5Activities
    }
    class aInteract1Activities
    aInteract1Activities : <<Interact 1 Activities>>
    class aInteract2Activities
    aInteract2Activities : <<Interact 2 Activities>>
    class aInteract3Activities
    aInteract3Activities : <<Interact 3 Activities>>
    class aInteract4Activities
    aInteract4Activities : <<Interact 4 Activities>>
    class aInteract5Activities
    aInteract5Activities : <<Interact 5 Activities>>
    %% Interact Activity Relationships %%
    activityDef -- activityDef : aInteract1Activities
    activityDef -- activityDef : aInteract2Activities
    activityDef -- activityDef : aInteract3Activities
    activityDef -- activityDef : aInteract4Activities
    activityDef -- activityDef : aInteract5Activities
    activityDef -- programme : programmeID
    activityDef -- guide : guideID
    activityDef -- progRole : role
    activityDef -- activityDef : onEndID
    activityDef -- media : defaultMediaID
    activityDef -- activityDef : aCuePointActivities
    activityDef -- media : aMediaIDs
    guide -- partner : partnerID
    media -- guide : guideID
    media -- partner : partnerID
    media -- programme : programmeID
    media -- progRole : roleID
    programme -- partner : partnerID
    programme -- activityDef : firstActivityDefID
    programme -- activityDef : lastActivityDefID
    programme -- activityDef : aFollowupActivityDefIDs
    progRole -- programme : programmeID
style SSQ_HUB fill:#e0e0e0,stroke:#bdbdbd,stroke-width:0px,color:#333
style member fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style progMember fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style activity fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style activityDef fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style programme fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style journal fill:#1976d2,stroke:#fff,stroke-width:4px,color:#fff
style tracker fill:#43a047,stroke:#fff,stroke-width:4px,color:#fff
style report fill:#388e3c,stroke:#fff,stroke-width:3px,color:#fff
style moduleDef fill:#388e3c,stroke:#fff,stroke-width:3px,color:#fff
style module fill:#388e3c,stroke:#fff,stroke-width:3px,color:#fff
style SSQ_arthritis01 fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222
style SSQ_pain01 fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222
style SSQ_stress01 fill:#b39ddb,stroke:#7e57c2,stroke-width:2px,color:#222
```
