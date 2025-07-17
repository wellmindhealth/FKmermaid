```mermaid
classDiagram
    class progRole
    class programme
    class media
    class member
    class "progRole" as "ProgRole" {
        %% Focus Entity Properties %%
        +
        +
        +
    }
    class "activityDef" as "Farcry Activity Definition" {
        +
        +
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
    activityDef -- aInteract1Activities : aInteract1Activities
    activityDef -- aInteract2Activities : aInteract2Activities
    activityDef -- aInteract3Activities : aInteract3Activities
    activityDef -- aInteract4Activities : aInteract4Activities
    activityDef -- aInteract5Activities : aInteract5Activities
    activityDef -- programme : programmeID
    activityDef -- progRole : role
    media -- programme : programmeID
    media -- progRole : roleID
    member -- progRole : roleID
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
