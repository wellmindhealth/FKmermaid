USE [farcrybemindfulonline_new]
GO
/****** Object:  Table [dbo].[activity]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activity](
	[activityDefID] [varchar](50) NULL,
	[activityState] [nvarchar](250) NULL,
	[bMailed] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[list11] [nvarchar](250) NULL,
	[list12] [nvarchar](250) NULL,
	[list13] [nvarchar](250) NULL,
	[list21] [nvarchar](250) NULL,
	[list22] [nvarchar](250) NULL,
	[list23] [nvarchar](250) NULL,
	[list31] [nvarchar](250) NULL,
	[list32] [nvarchar](250) NULL,
	[list33] [nvarchar](250) NULL,
	[list41] [nvarchar](250) NULL,
	[list42] [nvarchar](250) NULL,
	[list43] [nvarchar](250) NULL,
	[list99] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[text11] [nvarchar](max) NULL,
	[text12] [nvarchar](max) NULL,
	[text13] [nvarchar](max) NULL,
	[text21] [nvarchar](max) NULL,
	[text22] [nvarchar](max) NULL,
	[text23] [nvarchar](max) NULL,
	[text31] [nvarchar](max) NULL,
	[text32] [nvarchar](max) NULL,
	[text33] [nvarchar](max) NULL,
	[text41] [nvarchar](max) NULL,
	[text42] [nvarchar](max) NULL,
	[text43] [nvarchar](max) NULL,
	[progMemberID] [varchar](50) NULL,
	[firstState] [nvarchar](250) NULL,
	[activityStates] [nvarchar](max) NULL,
	[mailedDate] [datetime2](3) NULL,
	[bComplete] [bit] NULL,
	[text51] [nvarchar](max) NULL,
	[text52] [nvarchar](max) NULL,
	[text53] [nvarchar](max) NULL,
	[list51] [nvarchar](250) NULL,
	[list52] [nvarchar](250) NULL,
	[list53] [nvarchar](250) NULL,
	[text99] [nvarchar](max) NULL,
	[status] [nvarchar](250) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[lastPlayedDate] [datetime2](3) NULL,
	[numPlays] [decimal](10, 2) NULL,
	[numDownloads] [decimal](10, 2) NULL,
	[bFavourite] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef](
	[bOptional] [bit] NULL,
	[buttonDoTitleInteract1] [nvarchar](250) NULL,
	[buttonDoTitleInteract2] [nvarchar](250) NULL,
	[buttonDoTitleInteract3] [nvarchar](250) NULL,
	[buttonDoTitleInteract4] [nvarchar](250) NULL,
	[buttonDoTitleRating] [nvarchar](250) NULL,
	[code] [nvarchar](250) NULL,
	[completeHTML] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[emailSubject] [nvarchar](250) NULL,
	[emailTXT] [nvarchar](max) NULL,
	[includeFieldsInteract1] [nvarchar](250) NULL,
	[includeFieldsInteract2] [nvarchar](250) NULL,
	[includeFieldsInteract3] [nvarchar](250) NULL,
	[includeFieldsInteract4] [nvarchar](250) NULL,
	[includeFieldsRating] [nvarchar](250) NULL,
	[interact1HTML] [nvarchar](max) NULL,
	[interact2HTML] [nvarchar](max) NULL,
	[Interact3HTML] [nvarchar](max) NULL,
	[Interact4HTML] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[list11FtClass] [nvarchar](250) NULL,
	[list11FtDefault] [nvarchar](250) NULL,
	[list11FtHelpSection] [nvarchar](250) NULL,
	[list11FtHint] [nvarchar](250) NULL,
	[list11FtIncludeDecimal] [nvarchar](250) NULL,
	[list11FtLabel] [nvarchar](250) NULL,
	[list11FtList] [nvarchar](max) NULL,
	[list11FtRenderType] [nvarchar](250) NULL,
	[list11FtType] [nvarchar](250) NULL,
	[list11FtValidation] [nvarchar](250) NULL,
	[list12FtClass] [nvarchar](250) NULL,
	[list12FtDefault] [nvarchar](250) NULL,
	[list12FtHelpSection] [nvarchar](250) NULL,
	[list12FtHint] [nvarchar](250) NULL,
	[list12FtIncludeDecimal] [nvarchar](250) NULL,
	[list12FtLabel] [nvarchar](250) NULL,
	[list12FtList] [nvarchar](max) NULL,
	[list12FtRenderType] [nvarchar](250) NULL,
	[list12FtType] [nvarchar](250) NULL,
	[list12FtValidation] [nvarchar](250) NULL,
	[list13FtClass] [nvarchar](250) NULL,
	[list13FtDefault] [nvarchar](250) NULL,
	[list13FtHelpSection] [nvarchar](250) NULL,
	[list13FtHint] [nvarchar](250) NULL,
	[list13FtIncludeDecimal] [nvarchar](250) NULL,
	[list13FtLabel] [nvarchar](250) NULL,
	[list13FtList] [nvarchar](max) NULL,
	[list13FtRenderType] [nvarchar](250) NULL,
	[list13FtType] [nvarchar](250) NULL,
	[list13FtValidation] [nvarchar](250) NULL,
	[list21FtClass] [nvarchar](250) NULL,
	[list21FtDefault] [nvarchar](250) NULL,
	[list21FtHelpSection] [nvarchar](250) NULL,
	[list21FtHint] [nvarchar](250) NULL,
	[list21FtIncludeDecimal] [nvarchar](250) NULL,
	[list21FtLabel] [nvarchar](250) NULL,
	[list21FtList] [nvarchar](max) NULL,
	[list21FtRenderType] [nvarchar](250) NULL,
	[list21FtType] [nvarchar](250) NULL,
	[list21FtValidation] [nvarchar](250) NULL,
	[list22FtClass] [nvarchar](250) NULL,
	[list22FtDefault] [nvarchar](250) NULL,
	[list22FtHelpSection] [nvarchar](250) NULL,
	[list22FtHint] [nvarchar](250) NULL,
	[list22FtIncludeDecimal] [nvarchar](250) NULL,
	[list22FtLabel] [nvarchar](250) NULL,
	[list22FtList] [nvarchar](max) NULL,
	[list22FtRenderType] [nvarchar](250) NULL,
	[list22FtType] [nvarchar](250) NULL,
	[list22FtValidation] [nvarchar](250) NULL,
	[list23FtClass] [nvarchar](250) NULL,
	[list23FtDefault] [nvarchar](250) NULL,
	[list23FtHelpSection] [nvarchar](250) NULL,
	[list23FtHint] [nvarchar](250) NULL,
	[list23FtIncludeDecimal] [nvarchar](250) NULL,
	[list23FtLabel] [nvarchar](250) NULL,
	[list23FtList] [nvarchar](max) NULL,
	[list23FtRenderType] [nvarchar](250) NULL,
	[list23FtType] [nvarchar](250) NULL,
	[list23FtValidation] [nvarchar](250) NULL,
	[list31FtClass] [nvarchar](250) NULL,
	[list31FtDefault] [nvarchar](250) NULL,
	[list31FtHelpSection] [nvarchar](250) NULL,
	[list31FtHint] [nvarchar](250) NULL,
	[list31FtIncludeDecimal] [nvarchar](250) NULL,
	[list31FtLabel] [nvarchar](250) NULL,
	[list31FtList] [nvarchar](max) NULL,
	[list31FtRenderType] [nvarchar](250) NULL,
	[list31FtType] [nvarchar](250) NULL,
	[list31FtValidation] [nvarchar](250) NULL,
	[list32FtClass] [nvarchar](250) NULL,
	[list32FtDefault] [nvarchar](250) NULL,
	[list32FtHelpSection] [nvarchar](250) NULL,
	[list32FtHint] [nvarchar](250) NULL,
	[list32FtIncludeDecimal] [nvarchar](250) NULL,
	[list32FtLabel] [nvarchar](250) NULL,
	[list32FtList] [nvarchar](max) NULL,
	[list32FtRenderType] [nvarchar](250) NULL,
	[list32FtType] [nvarchar](250) NULL,
	[list32FtValidation] [nvarchar](250) NULL,
	[list33FtClass] [nvarchar](250) NULL,
	[list33FtDefault] [nvarchar](250) NULL,
	[list33FtHelpSection] [nvarchar](250) NULL,
	[list33FtHint] [nvarchar](250) NULL,
	[list33FtIncludeDecimal] [nvarchar](250) NULL,
	[list33FtLabel] [nvarchar](250) NULL,
	[list33FtList] [nvarchar](max) NULL,
	[list33FtRenderType] [nvarchar](250) NULL,
	[list33FtType] [nvarchar](250) NULL,
	[list33FtValidation] [nvarchar](250) NULL,
	[list41FtClass] [nvarchar](250) NULL,
	[list41FtDefault] [nvarchar](250) NULL,
	[list41FtHelpSection] [nvarchar](250) NULL,
	[list41FtHint] [nvarchar](250) NULL,
	[list41FtIncludeDecimal] [nvarchar](250) NULL,
	[list41FtLabel] [nvarchar](250) NULL,
	[list41FtList] [nvarchar](max) NULL,
	[list41FtRenderType] [nvarchar](250) NULL,
	[list41FtType] [nvarchar](250) NULL,
	[list41FtValidation] [nvarchar](250) NULL,
	[list42FtClass] [nvarchar](250) NULL,
	[list42FtDefault] [nvarchar](250) NULL,
	[list42FtHelpSection] [nvarchar](250) NULL,
	[list42FtHint] [nvarchar](250) NULL,
	[list42FtIncludeDecimal] [nvarchar](250) NULL,
	[list42FtLabel] [nvarchar](250) NULL,
	[list42FtList] [nvarchar](max) NULL,
	[list42FtRenderType] [nvarchar](250) NULL,
	[list42FtType] [nvarchar](250) NULL,
	[list42FtValidation] [nvarchar](250) NULL,
	[list43FtClass] [nvarchar](250) NULL,
	[list43FtDefault] [nvarchar](250) NULL,
	[list43FtHelpSection] [nvarchar](250) NULL,
	[list43FtHint] [nvarchar](250) NULL,
	[list43FtIncludeDecimal] [nvarchar](250) NULL,
	[list43FtLabel] [nvarchar](250) NULL,
	[list43FtList] [nvarchar](max) NULL,
	[list43FtRenderType] [nvarchar](250) NULL,
	[list43FtType] [nvarchar](250) NULL,
	[list43FtValidation] [nvarchar](250) NULL,
	[list99FtClass] [nvarchar](250) NULL,
	[list99FtHelpSection] [nvarchar](250) NULL,
	[list99FtHint] [nvarchar](250) NULL,
	[list99FtIncludeDecimal] [nvarchar](250) NULL,
	[list99FtLabel] [nvarchar](250) NULL,
	[list99FtList] [nvarchar](max) NULL,
	[list99FtRenderType] [nvarchar](250) NULL,
	[list99FtType] [nvarchar](250) NULL,
	[list99FtValidation] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[nextStepComplete] [nvarchar](250) NOT NULL,
	[nextStepEmail] [nvarchar](250) NOT NULL,
	[nextStepInteract1] [nvarchar](250) NOT NULL,
	[nextStepInteract2] [nvarchar](250) NOT NULL,
	[nextStepInteract3] [nvarchar](250) NOT NULL,
	[nextStepInteract4] [nvarchar](250) NOT NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[onEndID] [varchar](50) NULL,
	[ownedby] [nvarchar](250) NULL,
	[stepReqComplete] [bit] NULL,
	[stepReqEmail] [bit] NULL,
	[stepReqInteract1] [bit] NULL,
	[stepReqInteract2] [bit] NULL,
	[stepReqInteract3] [bit] NULL,
	[stepReqInteract4] [bit] NULL,
	[stepReqRating] [bit] NULL,
	[text11FtClass] [nvarchar](250) NULL,
	[text11FtDefault] [nvarchar](250) NULL,
	[text11FtHelpSection] [nvarchar](250) NULL,
	[text11FtHint] [nvarchar](250) NULL,
	[text11FtLabel] [nvarchar](250) NULL,
	[text11FtValidation] [nvarchar](250) NULL,
	[text12FtClass] [nvarchar](250) NULL,
	[text12FtDefault] [nvarchar](250) NULL,
	[text12FtHelpSection] [nvarchar](250) NULL,
	[text12FtHint] [nvarchar](250) NULL,
	[text12FtLabel] [nvarchar](250) NULL,
	[text12FtValidation] [nvarchar](250) NULL,
	[text13FtClass] [nvarchar](250) NULL,
	[text13FtDefault] [nvarchar](250) NULL,
	[text13FtHelpSection] [nvarchar](250) NULL,
	[text13FtHint] [nvarchar](250) NULL,
	[text13FtLabel] [nvarchar](250) NULL,
	[text13FtValidation] [nvarchar](250) NULL,
	[text21FtClass] [nvarchar](250) NULL,
	[text21FtDefault] [nvarchar](250) NULL,
	[text21FtHelpSection] [nvarchar](250) NULL,
	[text21FtHint] [nvarchar](250) NULL,
	[text21FtLabel] [nvarchar](250) NULL,
	[text21FtValidation] [nvarchar](250) NULL,
	[text22FtClass] [nvarchar](250) NULL,
	[text22FtDefault] [nvarchar](250) NULL,
	[text22FtHelpSection] [nvarchar](250) NULL,
	[text22FtHint] [nvarchar](250) NULL,
	[text22FtLabel] [nvarchar](250) NULL,
	[text22FtValidation] [nvarchar](250) NULL,
	[text23FtClass] [nvarchar](250) NULL,
	[text23FtDefault] [nvarchar](250) NULL,
	[text23FtHelpSection] [nvarchar](250) NULL,
	[text23FtHint] [nvarchar](250) NULL,
	[text23FtLabel] [nvarchar](250) NULL,
	[text23FtValidation] [nvarchar](250) NULL,
	[text31FtClass] [nvarchar](250) NULL,
	[text31FtDefault] [nvarchar](250) NULL,
	[text31FtHelpSection] [nvarchar](250) NULL,
	[text31FtHint] [nvarchar](250) NULL,
	[text31FtLabel] [nvarchar](250) NULL,
	[text31FtValidation] [nvarchar](250) NULL,
	[text32FtClass] [nvarchar](250) NULL,
	[text32FtDefault] [nvarchar](250) NULL,
	[text32FtHelpSection] [nvarchar](250) NULL,
	[text32FtHint] [nvarchar](250) NULL,
	[text32FtLabel] [nvarchar](250) NULL,
	[text32FtValidation] [nvarchar](250) NULL,
	[text33FtClass] [nvarchar](250) NULL,
	[text33FtDefault] [nvarchar](250) NULL,
	[text33FtHelpSection] [nvarchar](250) NULL,
	[text33FtHint] [nvarchar](250) NULL,
	[text33FtLabel] [nvarchar](250) NULL,
	[text33FtValidation] [nvarchar](250) NULL,
	[text41FtClass] [nvarchar](250) NULL,
	[text41FtDefault] [nvarchar](250) NULL,
	[text41FtHelpSection] [nvarchar](250) NULL,
	[text41FtHint] [nvarchar](250) NULL,
	[text41FtLabel] [nvarchar](250) NULL,
	[text41FtValidation] [nvarchar](250) NULL,
	[text42FtClass] [nvarchar](250) NULL,
	[text42FtDefault] [nvarchar](250) NULL,
	[text42FtHelpSection] [nvarchar](250) NULL,
	[text42FtHint] [nvarchar](250) NULL,
	[text42FtLabel] [nvarchar](250) NULL,
	[text42FtValidation] [nvarchar](250) NULL,
	[text43FtClass] [nvarchar](250) NULL,
	[text43FtDefault] [nvarchar](250) NULL,
	[text43FtHelpSection] [nvarchar](250) NULL,
	[text43FtHint] [nvarchar](250) NULL,
	[text43FtLabel] [nvarchar](250) NULL,
	[text43FtValidation] [nvarchar](250) NULL,
	[text99FtClass] [nvarchar](250) NULL,
	[text99FtDefault] [nvarchar](250) NULL,
	[text99FtHint] [nvarchar](250) NULL,
	[text99FtValidation] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[defaultMediaID] [varchar](50) NULL,
	[nextStepMedia] [nvarchar](250) NOT NULL,
	[stepReqMedia] [bit] NULL,
	[interact4Script] [nvarchar](max) NULL,
	[interact3Script] [nvarchar](max) NULL,
	[interact2Script] [nvarchar](max) NULL,
	[interact1Script] [nvarchar](max) NULL,
	[stepNum] [nvarchar](250) NULL,
	[releaseMedia] [nvarchar](250) NOT NULL,
	[list11FtValidationAdd] [nvarchar](max) NULL,
	[list23FtValidationAdd] [nvarchar](max) NULL,
	[list31FtValidationAdd] [nvarchar](max) NULL,
	[list42FtValidationAdd] [nvarchar](max) NULL,
	[list43FtValidationAdd] [nvarchar](max) NULL,
	[list33FtValidationAdd] [nvarchar](max) NULL,
	[list41FtValidationAdd] [nvarchar](max) NULL,
	[list22FtValidationAdd] [nvarchar](max) NULL,
	[list12FtValidationAdd] [nvarchar](max) NULL,
	[list13FtValidationAdd] [nvarchar](max) NULL,
	[list32FtValidationAdd] [nvarchar](max) NULL,
	[list21FtValidationAdd] [nvarchar](max) NULL,
	[programmeID] [varchar](50) NOT NULL,
	[guideID] [varchar](50) NOT NULL,
	[jReviewHTML] [nvarchar](max) NULL,
	[tracker01ID] [varchar](50) NOT NULL,
	[journalSpot01Text] [nvarchar](max) NULL,
	[journalEntryTitle] [nvarchar](250) NULL,
	[journalSpot02Text] [nvarchar](max) NULL,
	[buttonDoTitleTracker] [nvarchar](250) NULL,
	[journalSpot03Text] [nvarchar](max) NULL,
	[jReviewScript] [nvarchar](max) NULL,
	[journalID] [nvarchar](50) NOT NULL,
	[tracker02ID] [varchar](50) NOT NULL,
	[showJournal] [bit] NULL,
	[tracker03ID] [varchar](50) NOT NULL,
	[tracker04ID] [varchar](50) NOT NULL,
	[tracker05ID] [varchar](50) NOT NULL,
	[trackersHTML] [nvarchar](max) NULL,
	[journalSpotSeq] [nvarchar](250) NULL,
	[journalSpot03Button] [nvarchar](250) NULL,
	[journalSpot02Button] [nvarchar](250) NULL,
	[journalSpot01Button] [nvarchar](250) NULL,
	[bGuide] [bit] NULL,
	[bogusStepNum] [nvarchar](250) NULL,
	[bOnEndAdvance] [bit] NULL,
	[buttonDoTitleComplete] [nvarchar](250) NULL,
	[list51FtType] [nvarchar](250) NULL,
	[list51FtClass] [nvarchar](250) NULL,
	[text53FtDefault] [nvarchar](250) NULL,
	[list53FtHelpSection] [nvarchar](250) NULL,
	[text51FtDefault] [nvarchar](250) NULL,
	[includeFieldsInteract5] [nvarchar](250) NULL,
	[list53FtType] [nvarchar](250) NULL,
	[text51FtHint] [nvarchar](250) NULL,
	[text52FtLabel] [nvarchar](250) NULL,
	[type] [nvarchar](250) NOT NULL,
	[list53FtValidationAdd] [nvarchar](max) NULL,
	[text51FtValidation] [nvarchar](250) NULL,
	[list52FtRenderType] [nvarchar](250) NULL,
	[list52FtLabel] [nvarchar](250) NULL,
	[list51FtList] [nvarchar](max) NULL,
	[text51FtHelpSection] [nvarchar](250) NULL,
	[list51FtLabel] [nvarchar](250) NULL,
	[list52FtList] [nvarchar](max) NULL,
	[list51FtHint] [nvarchar](250) NULL,
	[list53FtList] [nvarchar](max) NULL,
	[list52FtHint] [nvarchar](250) NULL,
	[list53FtHint] [nvarchar](250) NULL,
	[list51FtDefault] [nvarchar](250) NULL,
	[list52FtIncludeDecimal] [nvarchar](250) NULL,
	[stepReqInteract5] [bit] NULL,
	[list52FtHelpSection] [nvarchar](250) NULL,
	[text51FtClass] [nvarchar](250) NULL,
	[Interact5HTML] [nvarchar](max) NULL,
	[list51FtValidation] [nvarchar](250) NULL,
	[text52FtHelpSection] [nvarchar](250) NULL,
	[list51FtValidationAdd] [nvarchar](max) NULL,
	[nextStepInteract5] [nvarchar](250) NOT NULL,
	[text53FtLabel] [nvarchar](250) NULL,
	[list51FtIncludeDecimal] [nvarchar](250) NULL,
	[text52FtValidation] [nvarchar](250) NULL,
	[list52FtValidationAdd] [nvarchar](max) NULL,
	[buttonDoTitleInteract5] [nvarchar](250) NULL,
	[list53FtDefault] [nvarchar](250) NULL,
	[interact5Script] [nvarchar](max) NULL,
	[list53FtClass] [nvarchar](250) NULL,
	[list52FtType] [nvarchar](250) NULL,
	[list53FtRenderType] [nvarchar](250) NULL,
	[list53FtLabel] [nvarchar](250) NULL,
	[list52FtClass] [nvarchar](250) NULL,
	[list53FtValidation] [nvarchar](250) NULL,
	[text53FtClass] [nvarchar](250) NULL,
	[text52FtDefault] [nvarchar](250) NULL,
	[text51FtLabel] [nvarchar](250) NULL,
	[text53FtValidation] [nvarchar](250) NULL,
	[text52FtHint] [nvarchar](250) NULL,
	[text53FtHelpSection] [nvarchar](250) NULL,
	[list52FtDefault] [nvarchar](250) NULL,
	[list53FtIncludeDecimal] [nvarchar](250) NULL,
	[text53FtHint] [nvarchar](250) NULL,
	[list51FtHelpSection] [nvarchar](250) NULL,
	[text52FtClass] [nvarchar](250) NULL,
	[list52FtValidation] [nvarchar](250) NULL,
	[list51FtRenderType] [nvarchar](250) NULL,
	[RatingScript] [nvarchar](max) NULL,
	[text99FtHelpSection] [nvarchar](250) NULL,
	[list99FtDefault] [nvarchar](250) NULL,
	[text99FtLabel] [nvarchar](250) NULL,
	[nextStepRating] [nvarchar](250) NOT NULL,
	[ratingHTML] [nvarchar](max) NULL,
	[broadcastDay] [decimal](10, 2) NULL,
	[bActive] [bit] NULL,
	[showJournalStep] [nvarchar](250) NULL,
	[journalHTML] [nvarchar](max) NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[journalSpotTitle] [nvarchar](max) NULL,
	[cuePointTime] [nvarchar](250) NULL,
	[noJournalSpotTitle] [nvarchar](max) NULL,
	[teaserImage] [nvarchar](50) NULL,
	[context] [nvarchar](max) NULL,
	[emailTeaseTXT] [nvarchar](max) NULL,
	[emailTeaseSubject] [nvarchar](250) NULL,
	[emailHTMLNag7] [nvarchar](max) NULL,
	[emailSubjectNag3] [nvarchar](250) NULL,
	[emailSubjectNag6month] [nvarchar](250) NULL,
	[emailHTMLNag3] [nvarchar](max) NULL,
	[emailSubjectNag14] [nvarchar](250) NULL,
	[emailSubjectNag3month] [nvarchar](250) NULL,
	[emailHTMLNagYearly] [nvarchar](max) NULL,
	[emailHTMLNag6month] [nvarchar](max) NULL,
	[emailSubjectNag7] [nvarchar](250) NULL,
	[emailHTMLNag28] [nvarchar](max) NULL,
	[emailHTMLNag14] [nvarchar](max) NULL,
	[emailHTMLNag3month] [nvarchar](max) NULL,
	[emailSubjectNag28] [nvarchar](250) NULL,
	[emailSubjectNagYearly] [nvarchar](250) NULL,
	[cuePointClass] [nvarchar](250) NULL,
	[catTopic] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
	[cloneActivityDefID] [nvarchar](50) NOT NULL,
	[role] [nvarchar](50) NULL,
	[completeScript] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aCuePointActivities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aCuePointActivities](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aInteract1Activities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aInteract1Activities](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aInteract2Activities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aInteract2Activities](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aInteract3Activities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aInteract3Activities](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aInteract4Activities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aInteract4Activities](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aInteract5Activities]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aInteract5Activities](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[activityDef_aMediaIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[activityDef_aMediaIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[address]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[Address1] [nvarchar](250) NULL,
	[Address2] [nvarchar](250) NULL,
	[Address3] [nvarchar](250) NULL,
	[Address4] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[FirstName] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[LastName] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[Postcode] [nvarchar](250) NULL,
	[country] [nvarchar](250) NULL,
	[memberID] [nvarchar](50) NULL,
	[dmProfileID] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[apiAccessKey]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apiAccessKey](
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[accessKeySecret] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[bActive] [bit] NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[authorisation] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[title] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[accessKeyID] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[accessKey] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[userid] [nvarchar](250) NULL,
	[bJWTverify] [bit] NULL,
	[status] [nvarchar](250) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[auth0]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[auth0](
	[state] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[sand_deployment] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[sand_client_secret] [nvarchar](250) NULL,
	[partnerID] [nvarchar](250) NULL,
	[prod_client_id] [nvarchar](250) NULL,
	[bActive] [bit] NULL,
	[sand_authEndpoint] [nvarchar](250) NULL,
	[stage_redirect_uri] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[sand_redirect_uri] [nvarchar](250) NULL,
	[prod_accessTokenEndpoint] [nvarchar](250) NULL,
	[stage_client_id] [nvarchar](250) NULL,
	[subName] [nvarchar](250) NULL,
	[stage_authEndpoint] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[subType] [nvarchar](250) NULL,
	[stage_accessTokenEndpoint] [nvarchar](250) NULL,
	[sand_accessTokenEndpoint] [nvarchar](250) NULL,
	[prod_client_secret] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[stage_client_secret] [nvarchar](250) NULL,
	[prod_deployment] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[stage_deployment] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[prod_authEndpoint] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[title] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[sand_client_id] [nvarchar](250) NULL,
	[prod_redirect_uri] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[center]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[center](
	[Body] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[Logo] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerID] [varchar](50) NULL,
	[Title] [nvarchar](250) NULL,
	[memberGroupID] [varchar](50) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[bAllowComms] [bit] NULL,
	[commsLiasonEmail] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[center_aReferers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[center_aReferers](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[center_aUsers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[center_aUsers](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[container]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[container](
	[bShared] [bit] NULL,
	[displayMethod] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[mirrorID] [varchar](50) NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[container_aRules]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[container_aRules](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[device]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[device](
	[sub] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[DeviceName] [nvarchar](max) NULL,
	[DeviceGroupKey] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[DeviceKey] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[username] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[status] [nvarchar](250) NOT NULL,
	[DevicePassword] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[DeviceNameDerived] [nvarchar](250) NULL,
	[bTrusted] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
	[aLogins] [nvarchar](max) NULL,
	[lastloginAgent] [nvarchar](250) NULL,
	[lastloginIP] [nvarchar](250) NULL,
	[lastloginDatetime] [datetime2](3) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmArchive]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmArchive](
	[archiveID] [varchar](50) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[objectWDDX] [nvarchar](max) NULL,
	[ownedby] [nvarchar](250) NULL,
	[objectTypename] [nvarchar](250) NULL,
	[bDeleted] [bit] NULL,
	[event] [nvarchar](250) NULL,
	[metaWDDX] [nvarchar](max) NULL,
	[lRoles] [nvarchar](250) NULL,
	[username] [nvarchar](250) NULL,
	[ipaddress] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmCarouselItem]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmCarouselItem](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[imgCarouselThumb] [nvarchar](250) NULL,
	[teaser] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[imgSourceID] [nvarchar](50) NULL,
	[imgCarousel] [nvarchar](250) NULL,
	[link] [nvarchar](50) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmCategory]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmCategory](
	[alias] [nvarchar](250) NULL,
	[categoryLabel] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[imgCategory] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmCron]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmCron](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[endDate] [datetime2](3) NOT NULL,
	[frequency] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[parameters] [nvarchar](250) NULL,
	[startDate] [datetime2](3) NOT NULL,
	[template] [nvarchar](250) NULL,
	[timeOut] [decimal](11, 0) NULL,
	[title] [nvarchar](250) NULL,
	[bAutoStart] [bit] NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmCSS]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmCSS](
	[bThisNodeOnly] [bit] NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[filename] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[mediaType] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEmail]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEmail](
	[Body] [nvarchar](max) NULL,
	[bSent] [bit] NOT NULL,
	[charset] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[failTo] [nvarchar](250) NULL,
	[fromEmail] [nvarchar](250) NOT NULL,
	[htmlBody] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[lGroups] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[replyTo] [nvarchar](250) NULL,
	[Title] [nvarchar](250) NOT NULL,
	[wraptext] [nvarchar](250) NULL,
	[catEmail] [nvarchar](250) NULL,
	[customGroupQuery] [nvarchar](max) NULL,
	[datasource] [nvarchar](250) NULL,
	[fromEmailDisplay] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEmail_aGroups]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEmail_aGroups](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEmail_aObjectIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEmail_aObjectIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEmail_aRelatedIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEmail_aRelatedIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEvent]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEvent](
	[body] [nvarchar](max) NULL,
	[catEvent] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[endDate] [datetime2](3) NULL,
	[expiryDate] [datetime2](3) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[Location] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[publishDate] [datetime2](3) NULL,
	[startDate] [datetime2](3) NULL,
	[status] [nvarchar](250) NOT NULL,
	[teaser] [nvarchar](2000) NULL,
	[teaserImage] [varchar](50) NULL,
	[title] [nvarchar](250) NULL,
	[versionID] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEvent_aObjectIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEvent_aObjectIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmEventListing]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmEventListing](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[numEvents] [decimal](11, 0) NOT NULL,
	[Teaser] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[status] [nvarchar](250) NOT NULL,
	[catCalendar] [nvarchar](250) NULL,
	[bPagination] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[bMatchAllKeywords] [bit] NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmFacts]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmFacts](
	[body] [nvarchar](max) NULL,
	[catFacts] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NULL,
	[imageID] [varchar](50) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[link] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[title] [nvarchar](250) NULL,
	[imgThumb] [nvarchar](250) NULL,
	[faIcon] [nvarchar](250) NULL,
	[linkText] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[catAimHelpText] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmFile]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmFile](
	[catFile] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[documentDate] [datetime2](3) NULL,
	[filename] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[title] [nvarchar](250) NULL,
	[teaserImage] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmFlash]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmFlash](
	[bLibrary] [bit] NULL,
	[catFlash] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[flashAlign] [nvarchar](250) NULL,
	[flashBgcolor] [nvarchar](250) NULL,
	[flashHeight] [decimal](10, 2) NULL,
	[flashLoop] [bit] NOT NULL,
	[flashMenu] [bit] NOT NULL,
	[flashMovie] [nvarchar](250) NULL,
	[flashParams] [nvarchar](250) NULL,
	[flashPlay] [bit] NOT NULL,
	[flashQuality] [nvarchar](250) NULL,
	[flashURL] [nvarchar](250) NULL,
	[flashVersion] [nvarchar](250) NULL,
	[flashWidth] [decimal](10, 2) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[metaKeywords] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NULL,
	[teaser] [nvarchar](max) NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmHTML]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmHTML](
	[Body] [nvarchar](max) NULL,
	[catHTML] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[extendedmetadata] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[metaKeywords] [nvarchar](max) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[reviewDate] [datetime2](3) NULL,
	[status] [nvarchar](250) NOT NULL,
	[Teaser] [nvarchar](max) NULL,
	[teaserImage] [varchar](50) NULL,
	[Title] [nvarchar](250) NULL,
	[versionID] [varchar](50) NULL,
	[seoTitle] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmHTML_aObjectIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmHTML_aObjectIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmHTML_aRelatedIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmHTML_aRelatedIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmImage]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmImage](
	[alt] [nvarchar](1000) NULL,
	[catImage] [nvarchar](1000) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[SourceImage] [nvarchar](250) NULL,
	[StandardImage] [nvarchar](250) NULL,
	[ThumbnailImage] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[description] [nvarchar](1000) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmInclude]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmInclude](
	[catInclude] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NULL,
	[include] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[teaser] [nvarchar](max) NULL,
	[teaserImage] [varchar](50) NULL,
	[title] [nvarchar](250) NULL,
	[webskin] [nvarchar](250) NULL,
	[webskinTypename] [nvarchar](250) NULL,
	[metaKeywords] [nvarchar](max) NULL,
	[extendedmetadata] [nvarchar](max) NULL,
	[versionID] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmLink]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmLink](
	[catLink] [ntext] NULL,
	[createdby] [nvarchar](512) NULL,
	[datetimecreated] [datetime] NULL,
	[datetimelastupdated] [datetime] NULL,
	[displayMethod] [varchar](255) NULL,
	[label] [nvarchar](512) NULL,
	[lastupdatedby] [nvarchar](512) NULL,
	[link] [varchar](255) NULL,
	[locked] [int] NULL,
	[lockedBy] [nvarchar](512) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](512) NULL,
	[status] [varchar](255) NULL,
	[teaser] [ntext] NULL,
	[teaserImage] [varchar](50) NULL,
	[title] [varchar](255) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNavigation]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNavigation](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[ExternalLink] [nvarchar](50) NULL,
	[fu] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[lNavIDAlias] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[options] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[title] [nvarchar](250) NULL,
	[bannerTagLine] [nvarchar](max) NULL,
	[internalRedirectID] [nvarchar](50) NULL,
	[bannerTitle] [nvarchar](250) NULL,
	[externalRedirectURL] [nvarchar](250) NULL,
	[sourceImageID] [nvarchar](50) NULL,
	[navType] [nvarchar](250) NOT NULL,
	[target] [nvarchar](250) NULL,
	[bBannerBack] [bit] NOT NULL,
	[bannerImage] [nvarchar](250) NULL,
	[lNavIDRel] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNavigation_aObjectIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNavigation_aObjectIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNews]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNews](
	[Body] [nvarchar](max) NOT NULL,
	[catNews] [nvarchar](max) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[expiryDate] [datetime2](3) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[publishDate] [datetime2](3) NULL,
	[source] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[Teaser] [nvarchar](2000) NOT NULL,
	[teaserImage] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[versionID] [varchar](50) NULL,
	[TeaserTitle] [nvarchar](2000) NOT NULL,
	[extendedmetadata] [nvarchar](max) NULL,
	[metaKeywords] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNews_aObjectIds]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNews_aObjectIds](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNews_aRelatedIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNews_aRelatedIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmNewsListing]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmNewsListing](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[Teaser] [nvarchar](max) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[numNews] [decimal](11, 0) NOT NULL,
	[bPagination] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[bMatchAllKeywords] [bit] NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[locked] [bit] NOT NULL,
	[catNews] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmProfile]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmProfile](
	[bActive] [bit] NOT NULL,
	[bReceiveEmail] [bit] NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[department] [nvarchar](250) NULL,
	[emailAddress] [nvarchar](250) NOT NULL,
	[firstName] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastName] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locale] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[notes] [nvarchar](max) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[overviewHome] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[phone] [nvarchar](250) NULL,
	[position] [nvarchar](250) NULL,
	[userDirectory] [nvarchar](250) NOT NULL,
	[userName] [nvarchar](250) NOT NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[memberActivityReportFreq] [nvarchar](250) NULL,
	[avatar] [nvarchar](250) NULL,
	[wddxPersonalisation] [nvarchar](max) NULL,
	[lastLogin] [datetime2](3) NULL,
	[previousLastLogin] [datetime2](3) NULL,
	[bReceiveEmailReports] [bit] NOT NULL,
	[memberGroupID] [nvarchar](50) NULL,
	[userstatus] [nvarchar](250) NULL,
	[FLmostRecentActivity] [datetime2](3) NULL,
	[orgRole] [nvarchar](250) NULL,
	[bEmailSuspended] [bit] NULL,
	[timeFormat] [nvarchar](250) NOT NULL,
	[mappedID] [nvarchar](250) NULL,
	[SSOData] [nvarchar](max) NULL,
	[identityProvider] [nvarchar](250) NULL,
	[farUserID] [nvarchar](50) NULL,
	[TOTP] [nvarchar](250) NULL,
	[bEmailValidated] [bit] NOT NULL,
	[bPhoneValidated] [bit] NOT NULL,
	[TOTPtimeout] [datetime2](3) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmRedirect]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmRedirect](
	[createdby] [nvarchar](512) NULL,
	[datetimecreated] [datetime] NULL,
	[datetimelastupdated] [datetime] NULL,
	[destinationURL] [varchar](255) NULL,
	[hits] [numeric](10, 2) NULL,
	[label] [nvarchar](512) NULL,
	[lastupdatedby] [nvarchar](512) NULL,
	[locked] [int] NULL,
	[lockedBy] [nvarchar](512) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](512) NULL,
	[redirectType] [varchar](255) NULL,
	[shortID] [varchar](255) NULL,
	[title] [nvarchar](512) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmTout]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmTout](
	[linkURL] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[teaser] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[link] [nvarchar](50) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[linkLabel] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmWebskinAncestor]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmWebskinAncestor](
	[ancestorID] [nvarchar](50) NOT NULL,
	[ancestorTemplate] [nvarchar](250) NOT NULL,
	[ancestorTypename] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[webskinObjectID] [nvarchar](50) NOT NULL,
	[webskinTemplate] [nvarchar](250) NULL,
	[webskinTypename] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmWizard]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmWizard](
	[createdby] [nvarchar](250) NOT NULL,
	[CurrentStep] [decimal](10, 2) NULL,
	[Data] [nvarchar](max) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[PrimaryObjectID] [varchar](50) NULL,
	[ReferenceID] [nvarchar](250) NOT NULL,
	[Steps] [nvarchar](max) NULL,
	[UserLogin] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dmXMLExport]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dmXMLExport](
	[contentType] [varchar](255) NULL,
	[createdby] [nvarchar](512) NULL,
	[creator] [varchar](255) NULL,
	[datetimecreated] [datetime] NULL,
	[datetimelastupdated] [datetime] NULL,
	[description] [ntext] NULL,
	[errorReportsTo] [varchar](255) NULL,
	[generatorAgent] [varchar](255) NULL,
	[label] [nvarchar](512) NULL,
	[language] [varchar](255) NULL,
	[lastupdatedby] [nvarchar](512) NULL,
	[locked] [int] NULL,
	[lockedBy] [nvarchar](512) NULL,
	[numberOfItems] [numeric](10, 2) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](512) NULL,
	[rights] [varchar](255) NULL,
	[title] [nvarchar](512) NULL,
	[updateBase] [varchar](255) NULL,
	[updateFrequency] [numeric](10, 2) NULL,
	[updatePeriod] [varchar](255) NULL,
	[xmlFile] [varchar](255) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dont_use___member_aAddresses]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dont_use___member_aAddresses](
	[typename] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[addressType] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentID] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farBarnacle]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farBarnacle](
	[barnaclevalue] [decimal](10, 2) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[objecttype] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[permissionid] [varchar](50) NULL,
	[referenceid] [varchar](50) NULL,
	[roleid] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farCoapi]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farCoapi](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[name] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farConfig]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farConfig](
	[configdata] [nvarchar](max) NULL,
	[configkey] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[configtypename] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farFeedback]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farFeedback](
	[comments] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[emailfrom] [nvarchar](250) NOT NULL,
	[emailto] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[name] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[subject] [nvarchar](250) NOT NULL,
	[comments2] [nvarchar](max) NULL,
	[memberID] [varchar](50) NOT NULL,
	[rating] [nvarchar](250) NULL,
	[bJoinMailing] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farFilter]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farFilter](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[profileID] [nvarchar](50) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[lRoles] [nvarchar](250) NULL,
	[listID] [nvarchar](250) NULL,
	[filterTypename] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[title] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farFilterProperty]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farFilterProperty](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[property] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[wddxDefinition] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[filterID] [nvarchar](50) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[type] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farFilterProperty_aRelated]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farFilterProperty_aRelated](
	[typename] [nvarchar](250) NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farFU]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farFU](
	[applicationName] [nvarchar](250) NULL,
	[bDefault] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[friendlyURL] [nvarchar](250) NULL,
	[fuStatus] [decimal](11, 0) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[queryString] [nvarchar](250) NULL,
	[redirectionType] [nvarchar](250) NULL,
	[redirectTo] [nvarchar](250) NULL,
	[refobjectid] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farGroup]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farGroup](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farImageGallery]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farImageGallery](
	[imgCoverSourceID] [nvarchar](50) NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[teaser] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[status] [nvarchar](250) NOT NULL,
	[SourceID] [nvarchar](50) NULL,
	[imgCover] [nvarchar](250) NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[catImageGallery] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[Body] [nvarchar](max) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farImageGallery_aImage]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farImageGallery_aImage](
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farImageGalleryListing]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farImageGalleryListing](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[teaser] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[status] [nvarchar](250) NOT NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farLog]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farLog](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[event] [nvarchar](250) NULL,
	[ipaddress] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[location] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[notes] [nvarchar](max) NULL,
	[object] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[type] [nvarchar](250) NULL,
	[userid] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farPermission]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farPermission](
	[aRoles] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[shortcut] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[bSystem] [bit] NOT NULL,
	[hint] [nvarchar](max) NULL,
	[bDisabled] [bit] NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farPermission_aRelatedtypes]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farPermission_aRelatedtypes](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farQueueResult]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farQueueResult](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[jobID] [nvarchar](50) NULL,
	[resultTick] [decimal](15, 0) NULL,
	[label] [nvarchar](250) NULL,
	[taskOwnedBy] [nvarchar](250) NULL,
	[wddxResult] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[jobType] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[taskID] [nvarchar](250) NULL,
	[resultTimestamp] [datetime2](3) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farQueueTask]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farQueueTask](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[taskTimestamp] [datetime2](3) NULL,
	[jobID] [nvarchar](50) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[taskOwnedBy] [nvarchar](250) NULL,
	[wddxDetails] [nvarchar](max) NULL,
	[threadID] [nvarchar](50) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[jobType] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[wddxStackTrace] [nvarchar](max) NULL,
	[action] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[taskStatus] [nvarchar](250) NULL,
	[objectid] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farRole]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farRole](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[isdefault] [bit] NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[webskins] [nvarchar](max) NULL,
	[sitePermissions] [nvarchar](max) NULL,
	[webtopPermissions] [nvarchar](max) NULL,
	[typePermissions] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farRole_aGroups]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farRole_aGroups](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farRole_aPermissions]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farRole_aPermissions](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farTask]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farTask](
	[bComplete] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[taskDefID] [varchar](50) NULL,
	[taskWebskin] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[userID] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farTaskDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farTaskDef](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[taskWebskin] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farTaskDef_aRoles]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farTaskDef_aRoles](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farUser]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farUser](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[lGroups] [nvarchar](max) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[password] [nvarchar](250) NULL,
	[userid] [nvarchar](250) NULL,
	[userstatus] [nvarchar](250) NULL,
	[failedLogins] [nvarchar](max) NULL,
	[forgotPasswordHash] [nvarchar](250) NULL,
	[bCPL] [bit] NOT NULL,
	[bCognito] [bit] NOT NULL,
	[bSSOonly] [bit] NOT NULL,
	[MFAtype] [nvarchar](250) NULL,
	[bPasswordUpgraded] [bit] NOT NULL,
	[bSoftwareMFAsetup] [bit] NOT NULL,
	[sub] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farUser_aGroups]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farUser_aGroups](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWebfeed]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWebfeed](
	[atomicon] [nvarchar](250) NULL,
	[bAuthor] [bit] NULL,
	[catFilter] [nvarchar](max) NULL,
	[contentproperty] [nvarchar](250) NULL,
	[copyright] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[dateproperty] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](250) NULL,
	[directory] [nvarchar](250) NULL,
	[editor] [nvarchar](250) NULL,
	[editoremail] [nvarchar](250) NULL,
	[enclosurefileproperty] [nvarchar](250) NULL,
	[feedimage] [nvarchar](250) NULL,
	[generator] [nvarchar](250) NULL,
	[itemtype] [nvarchar](250) NULL,
	[itunesauthor] [nvarchar](250) NULL,
	[itunescategories] [nvarchar](250) NULL,
	[itunesdurationproperty] [nvarchar](250) NULL,
	[iTunesFeedId] [decimal](11, 0) NULL,
	[itunesimage] [nvarchar](250) NULL,
	[itunessubtitleproperty] [nvarchar](250) NULL,
	[keywords] [nvarchar](250) NULL,
	[keywordsproperty] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[language] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[skipdays] [nvarchar](250) NULL,
	[skiphours] [nvarchar](250) NULL,
	[subtitle] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[titleproperty] [nvarchar](250) NULL,
	[url] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWebtopDashboard]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWebtopDashboard](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lRoles] [nvarchar](max) NULL,
	[lCards] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[bShowInSubNav] [bit] NULL,
	[seq] [decimal](10, 2) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWebtopDashboard_aRoles]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWebtopDashboard_aRoles](
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWorkflow]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWorkflow](
	[bActive] [bit] NULL,
	[bTasksComplete] [bit] NULL,
	[bWorkflowComplete] [bit] NULL,
	[bWorkflowSetupComplete] [bit] NULL,
	[completionDate] [datetime2](3) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[referenceID] [varchar](50) NULL,
	[title] [nvarchar](250) NULL,
	[workflowDefID] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWorkflow_aTaskIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWorkflow_aTaskIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWorkflowDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWorkflowDef](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[lTypenames] [nvarchar](max) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[workflowEnd] [nvarchar](250) NULL,
	[workflowStart] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[farWorkflowDef_aTaskDefs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[farWorkflowDef_aTaskDefs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fqAudit]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fqAudit](
	[AuditID] [char](50) NOT NULL,
	[objectid] [char](50) NULL,
	[datetimeStamp] [datetime] NULL,
	[username] [nvarchar](250) NOT NULL,
	[location] [nvarchar](250) NOT NULL,
	[auditType] [nvarchar](50) NULL,
	[note] [nvarchar](250) NULL,
PRIMARY KEY NONCLUSTERED 
(
	[AuditID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[guide]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guide](
	[biog] [nvarchar](max) NULL,
	[centerID] [nvarchar](50) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[email] [nvarchar](250) NOT NULL,
	[firstname] [nvarchar](250) NOT NULL,
	[gender] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastname] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerID] [nvarchar](50) NOT NULL,
	[picture] [varchar](50) NULL,
	[quals] [nvarchar](max) NULL,
	[salutation] [nvarchar](250) NULL,
	[position] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[intake]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[intake](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberGroupID] [nvarchar](50) NOT NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[places] [decimal](10, 2) NULL,
	[centerID] [varchar](50) NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[bIAPTUS] [bit] NULL,
	[placesMinLimit] [decimal](10, 2) NULL,
	[placesRemaining] [decimal](10, 2) NULL,
	[bAlert] [bit] NULL,
	[bLimited] [bit] NULL,
	[startDate] [datetime2](3) NULL,
	[daysRemaining] [decimal](10, 2) NULL,
	[daysMinLimit] [decimal](10, 2) NULL,
	[endDate] [datetime2](3) NULL,
	[pipeOrgID] [decimal](10, 2) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[intake_aMembers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[intake_aMembers](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[journal]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[journal](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[journalDefID] [varchar](50) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[progMemberID] [varchar](50) NULL,
	[text01] [nvarchar](max) NULL,
	[text02] [nvarchar](max) NULL,
	[text03] [nvarchar](max) NULL,
	[text04] [nvarchar](max) NULL,
	[activityID] [varchar](50) NULL,
	[trackerID] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[journalDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[journalDef](
	[buttonDoTitleJournal] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[journalEntry01FtClass] [nvarchar](250) NULL,
	[journalEntry01FtDefault] [nvarchar](250) NULL,
	[journalEntry01FtHelpSection] [nvarchar](250) NULL,
	[journalEntry01FtHint] [nvarchar](250) NULL,
	[journalEntry01FtLabel] [nvarchar](250) NULL,
	[journalEntry01FtStyle] [nvarchar](250) NULL,
	[journalEntry01FtValidation] [nvarchar](250) NULL,
	[journalEntry02FtClass] [nvarchar](250) NULL,
	[journalEntry02FtDefault] [nvarchar](250) NULL,
	[journalEntry02FtHelpSection] [nvarchar](250) NULL,
	[journalEntry02FtHint] [nvarchar](250) NULL,
	[journalEntry02FtLabel] [nvarchar](250) NULL,
	[journalEntry02FtStyle] [nvarchar](250) NULL,
	[journalEntry02FtValidation] [nvarchar](250) NULL,
	[journalEntry03FtClass] [nvarchar](250) NULL,
	[journalEntry03FtDefault] [nvarchar](250) NULL,
	[journalEntry03FtHelpSection] [nvarchar](250) NULL,
	[journalEntry03FtHint] [nvarchar](250) NULL,
	[journalEntry03FtLabel] [nvarchar](250) NULL,
	[journalEntry03FtStyle] [nvarchar](250) NULL,
	[journalEntry03FtValidation] [nvarchar](250) NULL,
	[journalEntry04FtClass] [nvarchar](250) NULL,
	[journalEntry04FtDefault] [nvarchar](250) NULL,
	[journalEntry04FtHelpSection] [nvarchar](250) NULL,
	[journalEntry04FtHint] [nvarchar](250) NULL,
	[journalEntry04FtLabel] [nvarchar](250) NULL,
	[journalEntry04FtStyle] [nvarchar](250) NULL,
	[journalEntry04FtValidation] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[programmeID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[tracker01ID] [varchar](50) NULL,
	[tracker01Title] [nvarchar](250) NULL,
	[tracker02Title] [nvarchar](250) NULL,
	[tracker02ID] [nvarchar](50) NULL,
	[versionID] [nvarchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JWTapp]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JWTapp](
	[location] [nvarchar](250) NULL,
	[pemPrivateKey] [nvarchar](max) NULL,
	[pemPrivateKeyPK8] [nvarchar](max) NULL,
	[environment] [nvarchar](250) NULL,
	[grant_type] [nvarchar](250) NULL,
	[aud] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[notes] [nvarchar](max) NULL,
	[status] [nvarchar](250) NOT NULL,
	[bActive] [bit] NULL,
	[label] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[type] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[KID] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[pemPublicKey] [nvarchar](max) NULL,
	[pemPublicKeyJSON] [nvarchar](max) NULL,
	[client_assertion_type] [nvarchar](250) NULL,
	[callbackURL] [nvarchar](250) NULL,
	[APIkey] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[JWKSEndpoint] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[title] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[alg] [nvarchar](250) NULL,
	[applicationID] [nvarchar](250) NULL,
	[bUseExp] [bit] NULL,
	[bUseSub] [bit] NULL,
	[algType] [nvarchar](250) NULL,
	[bUseGrant_type] [bit] NULL,
	[bUseJti] [bit] NULL,
	[IssField] [nvarchar](250) NULL,
	[bUseAud] [bit] NULL,
	[strGrant_type] [nvarchar](250) NULL,
	[SubField] [nvarchar](250) NULL,
	[bUseKid] [bit] NULL,
	[bUseClient_assertion_type] [bit] NULL,
	[bUseIss] [bit] NULL,
	[strClient_assertion] [nvarchar](250) NULL,
	[strClient_assertion_type] [nvarchar](250) NULL,
	[JWTtokenName] [nvarchar](250) NULL,
	[ISS] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[landingPage]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[landingPage](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[seoTitle] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[locked] [bit] NOT NULL,
	[extendedmetadata] [nvarchar](250) NULL,
	[metaKeywords] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[landingPage_aCarouselItems]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[landingPage_aCarouselItems](
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[landingPage_aTouts]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[landingPage_aTouts](
	[typename] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lead]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lead](
	[locked] [bit] NOT NULL,
	[memberID] [nvarchar](50) NOT NULL,
	[emailfrom] [nvarchar](250) NOT NULL,
	[comments2] [nvarchar](max) NULL,
	[comments] [nvarchar](max) NULL,
	[organisation] [nvarchar](250) NOT NULL,
	[name] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[rating] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[subject] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[bJoinMailing] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[emailto] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[library]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[library](
	[activityID] [varchar](50) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[mediaID] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[progMemberID] [varchar](50) NULL,
	[new] [bit] NULL,
	[rating] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[media]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[media](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NOT NULL,
	[partnerID] [nvarchar](50) NOT NULL,
	[programmeID] [nvarchar](50) NOT NULL,
	[type] [nvarchar](250) NOT NULL,
	[library] [bit] NOT NULL,
	[releaseOnStep] [bit] NULL,
	[dynamicPDF] [bit] NOT NULL,
	[method] [nvarchar](250) NULL,
	[guideID] [nvarchar](50) NOT NULL,
	[jwMediaID] [nvarchar](250) NULL,
	[tag] [nvarchar](250) NULL,
	[ratingCount] [decimal](10, 2) NULL,
	[alias] [nvarchar](250) NOT NULL,
	[length] [nvarchar](250) NOT NULL,
	[assistiveBody] [nvarchar](max) NULL,
	[extendedMetaData] [nvarchar](max) NULL,
	[oldFU] [nvarchar](250) NOT NULL,
	[free] [bit] NULL,
	[goodfor] [nvarchar](250) NOT NULL,
	[ratingSum] [decimal](10, 2) NULL,
	[strapline] [nvarchar](250) NOT NULL,
	[color] [nvarchar](250) NOT NULL,
	[eyesClosed] [nvarchar](250) NOT NULL,
	[eyesOpen] [nvarchar](250) NOT NULL,
	[libraryType] [nvarchar](250) NOT NULL,
	[keywords] [nvarchar](250) NOT NULL,
	[description] [nvarchar](max) NULL,
	[status] [nvarchar](250) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[bHasCaptions] [bit] NOT NULL,
	[calltoaction] [nvarchar](max) NULL,
	[welcomebackunlocked] [nvarchar](max) NULL,
	[seriesNum] [nvarchar](250) NULL,
	[bonusintro] [nvarchar](max) NULL,
	[welcomebacksample] [nvarchar](max) NULL,
	[tourguide01] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
	[bHasThumbs] [bit] NOT NULL,
	[bHasChapters] [bit] NOT NULL,
	[bCanShare] [bit] NOT NULL,
	[bHasTranscript] [bit] NOT NULL,
	[bShowAssistive] [bit] NOT NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
	[cloneMediaID] [nvarchar](50) NOT NULL,
	[roleID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member](
	[consent] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[firstname] [nvarchar](250) NULL,
	[gender] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lastname] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[otherID] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerID] [varchar](50) NULL,
	[salutation] [nvarchar](250) NULL,
	[username] [nvarchar](250) NULL,
	[programmeID] [varchar](50) NULL,
	[password] [nvarchar](250) NULL,
	[memberGroupID] [varchar](50) NULL,
	[bActivated] [bit] NULL,
	[memberTypeID] [varchar](50) NULL,
	[email] [nvarchar](250) NULL,
	[referrer] [nvarchar](250) NULL,
	[selfPaid] [bit] NULL,
	[country] [nvarchar](250) NULL,
	[phone] [nvarchar](250) NULL,
	[paymentMade] [bit] NULL,
	[paymentCurrency] [nvarchar](250) NULL,
	[paymentAmount] [nvarchar](250) NULL,
	[promoCode] [nvarchar](250) NULL,
	[mailingList] [bit] NULL,
	[bAfterCarePosted] [bit] NULL,
	[dobYear] [nvarchar](250) NULL,
	[refunded] [bit] NULL,
	[bSuspended] [bit] NULL,
	[centerID] [nvarchar](50) NULL,
	[refererID] [nvarchar](50) NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[bCompleted] [bit] NULL,
	[dept] [nvarchar](250) NULL,
	[position] [nvarchar](250) NULL,
	[nhsNumber] [nvarchar](250) NULL,
	[IAPTUSreferralId] [nvarchar](250) NULL,
	[IAPTUSreferrerId] [nvarchar](250) NULL,
	[IAPTUSpatientId] [nvarchar](250) NULL,
	[IAPTUSreferralDate] [datetime2](3) NULL,
	[bMHFconsent] [bit] NULL,
	[creditcardnumber] [nvarchar](16) NULL,
	[creditcardexpiry] [nvarchar](7) NULL,
	[creditcardtype] [nvarchar](16) NULL,
	[PPresultStr] [nvarchar](250) NULL,
	[resetKey] [nvarchar](250) NULL,
	[creditcardcvv] [nvarchar](4) NULL,
	[bSocialPublish] [bit] NULL,
	[bDownload] [bit] NULL,
	[PPtransID] [nvarchar](250) NULL,
	[IAPTUStherapistId] [nvarchar](250) NULL,
	[failedLogins] [nvarchar](max) NULL,
	[daysLastNagged] [nvarchar](250) NULL,
	[dateLastNagged] [datetime2](3) NULL,
	[dateCreatedFake] [datetime2](3) NULL,
	[previousLastLogin] [datetime2](3) NULL,
	[lastLogin] [datetime2](3) NULL,
	[courseCompleted] [datetime2](3) NULL,
	[courseActivated] [datetime2](3) NULL,
	[courseStarted] [datetime2](3) NULL,
	[bPaused] [bit] NULL,
	[activityDefID] [nvarchar](50) NULL,
	[courseFollowedUp] [datetime2](3) NULL,
	[bCourseFollowedUp] [bit] NULL,
	[wddxPersonalisation] [nvarchar](max) NULL,
	[giverEmail] [nvarchar](250) NULL,
	[giftDate] [datetime2](3) NULL,
	[bGift] [bit] NULL,
	[giverName] [nvarchar](250) NULL,
	[bRememberme] [nvarchar](250) NULL,
	[FLmostRecentActivity] [datetime2](3) NULL,
	[suspensionReason] [nvarchar](250) NULL,
	[bRetired] [bit] NULL,
	[bMGNHS] [bit] NULL,
	[caseness] [bit] NULL,
	[bMGDefault] [bit] NULL,
	[bMGIAPTUS] [bit] NULL,
	[bMGResearch] [bit] NULL,
	[bMGApiAccess] [bit] NULL,
	[bMGDummy] [bit] NULL,
	[bMGDemo] [bit] NULL,
	[bMGHealthcare] [bit] NULL,
	[bMGBusDev] [bit] NULL,
	[bMGShowPublic] [bit] NULL,
	[bMGMDS] [bit] NULL,
	[ssoID] [nvarchar](250) NULL,
	[ssoIDP] [nvarchar](250) NULL,
	[ssoIDhashed] [nvarchar](250) NULL,
	[profileData] [nvarchar](max) NULL,
	[SSOData] [nvarchar](max) NULL,
	[sub] [nvarchar](250) NULL,
	[DOB] [datetime2](3) NULL,
	[reliableRec] [bit] NULL,
	[recovery] [bit] NULL,
	[reliableImp] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
	[bAssistive] [bit] NULL,
	[progRoleVia] [nvarchar](250) NOT NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
	[roleID] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_aAddresses]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_aAddresses](
	[data] [nvarchar](250) NULL,
	[parentID] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentID] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[member_aOrderIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[member_aOrderIDs](
	[typename] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[memberGroup]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberGroup](
	[Body] [nvarchar](max) NULL,
	[BodyBot] [nvarchar](max) NULL,
	[BodyConsent] [nvarchar](max) NULL,
	[BodyTop] [nvarchar](max) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[Logo] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[coordinatorEmail] [nvarchar](250) NULL,
	[partnerID] [nvarchar](50) NOT NULL,
	[createEmailBot] [nvarchar](max) NULL,
	[createEmailTop] [nvarchar](max) NULL,
	[URL] [nvarchar](250) NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[createEmailSubject] [nvarchar](250) NULL,
	[supportPage] [varchar](50) NULL,
	[bShowPublic] [bit] NULL,
	[emailAllocation] [nvarchar](250) NULL,
	[lSSQpoints] [nvarchar](250) NULL,
	[bIAPTUS] [bit] NULL,
	[bMDS] [bit] NULL,
	[IAPTUSid] [nvarchar](250) NULL,
	[bAftercare] [bit] NULL,
	[bShowLogo] [bit] NULL,
	[resourcePosterID] [nvarchar](50) NULL,
	[resourceHandoutID] [nvarchar](50) NULL,
	[UtmSourceID] [nvarchar](250) NULL,
	[lMemberProps] [nvarchar](250) NULL,
	[include] [nvarchar](250) NULL,
	[lMemberPropsActivate] [nvarchar](250) NULL,
	[bOneMonthFollowUp] [bit] NOT NULL,
	[bDummy] [bit] NOT NULL,
	[defaultSSQSignposting] [nvarchar](max) NULL,
	[positivePHQ0909SSQSignposting] [nvarchar](max) NULL,
	[bShowPHQ0909] [bit] NULL,
	[bDefault] [bit] NULL,
	[bHealthcare] [bit] NULL,
	[selfRegNavID] [nvarchar](50) NULL,
	[bApiAccess] [bit] NULL,
	[bResearch] [bit] NOT NULL,
	[emailSubjectActivatePortal] [nvarchar](250) NOT NULL,
	[activateEmailPortalTop] [nvarchar](max) NULL,
	[activateEmailPortalBot] [nvarchar](max) NULL,
	[selfRegQrFileID] [nvarchar](50) NULL,
	[bAnnualFollowUp] [bit] NOT NULL,
	[bAllowComms] [bit] NULL,
	[commsLiasonEmail] [nvarchar](250) NULL,
	[bSSQComp] [bit] NOT NULL,
	[bTrackersComp] [bit] NOT NULL,
	[bAllowRememberMe] [bit] NOT NULL,
	[bSSQ] [bit] NOT NULL,
	[bTrackers] [bit] NOT NULL,
	[bNHS] [bit] NULL,
	[bBusdev] [bit] NOT NULL,
	[bDemo] [bit] NOT NULL,
	[bPSEQ] [bit] NULL,
	[bODI] [bit] NULL,
	[bMSKHQ] [bit] NULL,
	[bSixMonthFollowUp] [bit] NOT NULL,
	[bThreeMonthFollowUp] [bit] NOT NULL,
	[daysStale] [decimal](10, 2) NULL,
	[xealthDeployment] [nvarchar](250) NULL,
	[bXealth] [bit] NULL,
	[licenseLength] [decimal](10, 2) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[memberGroup_aFarcryUsers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberGroup_aFarcryUsers](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[memberType]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberType](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[Title] [nvarchar](250) NULL,
	[bBroadcaster] [bit] NULL,
	[bNavTools] [bit] NULL,
	[bSimpleNavTools] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[module]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[module](
	[bActive] [bit] NULL,
	[bActivitysComplete] [bit] NULL,
	[bModuleComplete] [bit] NULL,
	[bModuleSetupComplete] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[moduleDefID] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[referenceID] [varchar](50) NULL,
	[title] [nvarchar](250) NULL,
	[progMemberID] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[module_aActivityIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[module_aActivityIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[moduleDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[moduleDef](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[lTypenames] [nvarchar](250) NULL,
	[moduleEnd] [nvarchar](250) NULL,
	[moduleStart] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[lActivityDefs] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nested_tree_objects]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nested_tree_objects](
	[ObjectID] [nvarchar](50) NOT NULL,
	[ParentID] [nvarchar](50) NULL,
	[ObjectName] [nvarchar](250) NOT NULL,
	[TypeName] [nvarchar](250) NOT NULL,
	[nLeft] [decimal](11, 0) NOT NULL,
	[nRight] [decimal](11, 0) NOT NULL,
	[nLevel] [decimal](11, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[oauth2]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[oauth2](
	[ownedby] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[redirect_uri] [nvarchar](250) NULL,
	[accessTokenEndpoint] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[authEndpoint] [nvarchar](250) NULL,
	[client_id] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[client_secret] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[oauth2Facebook]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[oauth2Facebook](
	[ownedby] [nvarchar](250) NULL,
	[redirect_uri] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[accessTokenEndpoint] [nvarchar](250) NULL,
	[authEndpoint] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[client_id] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[client_secret] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[oAuth2service]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[oAuth2service](
	[state] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[sand_deployment] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[sand_client_secret] [nvarchar](250) NULL,
	[partnerID] [nvarchar](250) NULL,
	[prod_client_id] [nvarchar](250) NULL,
	[bActive] [bit] NULL,
	[sand_authEndpoint] [nvarchar](250) NULL,
	[stage_redirect_uri] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[sand_redirect_uri] [nvarchar](250) NULL,
	[prod_accessTokenEndpoint] [nvarchar](250) NULL,
	[stage_client_id] [nvarchar](250) NULL,
	[subName] [nvarchar](250) NULL,
	[stage_authEndpoint] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[subType] [nvarchar](250) NULL,
	[stage_accessTokenEndpoint] [nvarchar](250) NULL,
	[sand_accessTokenEndpoint] [nvarchar](250) NULL,
	[prod_client_secret] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[stage_client_secret] [nvarchar](250) NULL,
	[prod_deployment] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[stage_deployment] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[prod_authEndpoint] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[title] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[sand_client_id] [nvarchar](250) NULL,
	[prod_redirect_uri] [nvarchar](250) NULL,
	[JWTappID] [nvarchar](50) NULL,
	[sand_logout_uri] [nvarchar](250) NULL,
	[prod_logout_uri] [nvarchar](250) NULL,
	[stage_logout_uri] [nvarchar](250) NULL,
	[sand_scope] [nvarchar](250) NULL,
	[prod_scope] [nvarchar](250) NULL,
	[stage_scope] [nvarchar](250) NULL,
	[prod_userpool_id] [nvarchar](250) NULL,
	[sand_userpool_id] [nvarchar](250) NULL,
	[stage_userpool_id] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderItem]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderItem](
	[ownedby] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[shopItemID] [nvarchar](50) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[quantity] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderMaster]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderMaster](
	[paymentCurrency] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[paymentSuccess] [bit] NULL,
	[paymentAmount] [nvarchar](250) NULL,
	[PPresultStr] [nvarchar](max) NULL,
	[promoCode] [nvarchar](250) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[PPtransID] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[referrer] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[braintreeNonce] [nvarchar](250) NULL,
	[status] [nvarchar](250) NULL,
	[braintreePaymentType] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orderMaster_aOrderItemIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orderMaster_aOrderItemIDs](
	[typename] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[partner]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partner](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[Logo] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[Title] [nvarchar](250) NULL,
	[URL] [nvarchar](250) NULL,
	[dmProfileID] [nvarchar](50) NULL,
	[versionID] [nvarchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[UtmSourceID] [nvarchar](250) NULL,
	[seniorSupportID] [nvarchar](50) NULL,
	[MGintakeMostRecentActivity] [datetime2](3) NULL,
	[tenantID] [nvarchar](250) NULL,
	[lODS] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[partner_aCenters]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partner_aCenters](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[partner_aReferers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partner_aReferers](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[progMember]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[progMember](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberID] [nvarchar](50) NOT NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[currActivityID] [varchar](50) NULL,
	[DOW] [decimal](10, 2) NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[programmeID] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[programme]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[programme](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[Logo] [varchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerID] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[consentBody] [nvarchar](max) NULL,
	[mediaPath] [nvarchar](250) NOT NULL,
	[firstActivityDefID] [varchar](50) NULL,
	[lastActivityDefID] [varchar](50) NULL,
	[overviewHTML] [nvarchar](max) NOT NULL,
	[journalHTML] [nvarchar](max) NOT NULL,
	[libraryHTML] [nvarchar](max) NOT NULL,
	[progressHTML] [nvarchar](max) NOT NULL,
	[journalEntryHTML] [nvarchar](max) NOT NULL,
	[activateTop] [nvarchar](max) NULL,
	[emailFooterTXT] [nvarchar](max) NULL,
	[emailSubjectActivate] [nvarchar](250) NULL,
	[emailSubjectCreate] [nvarchar](250) NULL,
	[emailSubjectTXT1] [nvarchar](250) NULL,
	[emailSubjectTXT2] [nvarchar](250) NULL,
	[emailFromAddress] [nvarchar](250) NULL,
	[loginURL] [nvarchar](250) NOT NULL,
	[activateURL] [nvarchar](250) NOT NULL,
	[priceUSD] [numeric](10, 2) NULL,
	[priceGBP] [numeric](10, 2) NULL,
	[priceEUR] [numeric](10, 2) NULL,
	[trackersHTML] [nvarchar](max) NOT NULL,
	[priceCorpUSD] [numeric](10, 2) NULL,
	[emailHTMLNagPay3] [nvarchar](max) NULL,
	[emailHTMLNagPrep3] [nvarchar](max) NULL,
	[emailSubjectNagPay3] [nvarchar](250) NULL,
	[emailSubjectNagPrep3] [nvarchar](250) NULL,
	[emailSubjectNagPay3month] [nvarchar](250) NULL,
	[emailHTMLNagPrep3month] [nvarchar](max) NULL,
	[emailHTMLNagActivate3month] [nvarchar](max) NULL,
	[emailSubjectNagPrep3month] [nvarchar](250) NULL,
	[emailSubjectNagActivate3month] [nvarchar](250) NULL,
	[emailHTMLNagPay3month] [nvarchar](max) NULL,
	[emailSubjectNagActivate14] [nvarchar](250) NULL,
	[emailHTMLNagActivate3] [nvarchar](max) NULL,
	[emailHTMLNagActivate7] [nvarchar](max) NULL,
	[emailSubjectNagActivate3] [nvarchar](250) NULL,
	[emailHTMLNagActivate14] [nvarchar](max) NULL,
	[emailHTMLNagActivate28] [nvarchar](max) NULL,
	[emailSubjectNagActivate7] [nvarchar](250) NULL,
	[emailSubjectNagActivate28] [nvarchar](250) NULL,
	[priceDownloadsGBP] [numeric](10, 2) NULL,
	[emailCatchallAddress] [nvarchar](250) NULL,
	[priceDownloadsEUR] [numeric](10, 2) NULL,
	[priceSingleUSD] [numeric](10, 2) NULL,
	[priceSingleEUR] [numeric](10, 2) NULL,
	[priceDownloadsUSD] [numeric](10, 2) NULL,
	[priceSingleGBP] [numeric](10, 2) NULL,
	[emailHTMLNagPrep7] [nvarchar](max) NULL,
	[emailSubjectNagPrep7] [nvarchar](250) NULL,
	[emailHTMLNagPay28] [nvarchar](max) NULL,
	[emailSubjectNagPrep28] [nvarchar](250) NULL,
	[emailSubjectNagPay14] [nvarchar](250) NULL,
	[emailHTMLNagPay7] [nvarchar](max) NULL,
	[emailSubjectNagPay7] [nvarchar](250) NULL,
	[emailHTMLNagPay14] [nvarchar](max) NULL,
	[emailSubjectNagPay6month] [nvarchar](250) NULL,
	[emailSubjectNagActivate6month] [nvarchar](250) NULL,
	[emailHTMLNagPrep28] [nvarchar](max) NULL,
	[emailSubjectNagPrep6month] [nvarchar](250) NULL,
	[emailSubjectNagPrep14] [nvarchar](250) NULL,
	[emailHTMLNagActivate6month] [nvarchar](max) NULL,
	[emailHTMLNagPrep6month] [nvarchar](max) NULL,
	[emailSubjectNagPay28] [nvarchar](250) NULL,
	[emailHTMLNagPay6month] [nvarchar](max) NULL,
	[emailHTMLNagPrep14] [nvarchar](max) NULL,
	[lSSQpoints] [nvarchar](250) NULL,
	[programmeURL] [nvarchar](250) NOT NULL,
	[priceCorpGBP] [numeric](10, 2) NULL,
	[resetPasswordURL] [nvarchar](250) NOT NULL,
	[priceCorpEUR] [numeric](10, 2) NULL,
	[forgottenPasswordURL] [nvarchar](250) NOT NULL,
	[emailHTMLNagPayYearly] [nvarchar](max) NULL,
	[emailSubjectNagPrepYearly] [nvarchar](250) NULL,
	[emailHTMLNagPrepYearly] [nvarchar](max) NULL,
	[emailSubjectNagPayYearly] [nvarchar](250) NULL,
	[emailHTMLNagActivateYearly] [nvarchar](max) NULL,
	[emailSubjectNagActivateYearly] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[emailSubjectNagEvaluators28] [nvarchar](250) NULL,
	[emailHTMLNagEvaluators28] [nvarchar](max) NULL,
	[emailHTMLNagEvaluators3month] [nvarchar](max) NULL,
	[emailSubjectNagEvaluators3month] [nvarchar](250) NULL,
	[emailHTMLNagEvaluatorsYearly] [nvarchar](max) NULL,
	[emailSubjectNagEvaluatorsYearly] [nvarchar](250) NULL,
	[emailSubjectNagEvaluators6month] [nvarchar](250) NULL,
	[emailHTMLNagEvaluators6month] [nvarchar](max) NULL,
	[emailSubjectNagEvaluators7] [nvarchar](250) NULL,
	[emailHTMLNagEvaluators7] [nvarchar](max) NULL,
	[emailBroadcasterAddress] [nvarchar](250) NULL,
	[activateEmailTop] [nvarchar](max) NULL,
	[activateEmailBot] [nvarchar](max) NULL,
	[paynowURL] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NOT NULL,
	[unsubDelete] [nvarchar](250) NOT NULL,
	[unsubSuspend] [nvarchar](250) NOT NULL,
	[unsubMaillist] [nvarchar](250) NOT NULL,
	[purchaseReturnBulkURL] [nvarchar](250) NOT NULL,
	[paynowBulkURL] [nvarchar](250) NOT NULL,
	[purchaseReturnURL] [nvarchar](250) NOT NULL,
	[emailBounceAddress] [nvarchar](250) NULL,
	[emailHTMLNagV33] [nvarchar](max) NULL,
	[emailHTMLNagV37] [nvarchar](max) NULL,
	[emailSubjectNagV27] [nvarchar](250) NULL,
	[emailHTMLNagV23month] [nvarchar](max) NULL,
	[emailSubjectNagV23] [nvarchar](250) NULL,
	[emailHTMLNagV26month] [nvarchar](max) NULL,
	[emailSubjectNagV314] [nvarchar](250) NULL,
	[emailHTMLNagV33month] [nvarchar](max) NULL,
	[emailSubjectNagV214] [nvarchar](250) NULL,
	[emailHTMLNagV36month] [nvarchar](max) NULL,
	[emailSubjectNagV3Yearly] [nvarchar](250) NULL,
	[emailSubjectNagV23month] [nvarchar](250) NULL,
	[emailHTMLNagV314] [nvarchar](max) NULL,
	[emailHTMLNagV214] [nvarchar](max) NULL,
	[emailSubjectNagV26month] [nvarchar](250) NULL,
	[emailHTMLNagV23] [nvarchar](max) NULL,
	[emailHTMLNagV27] [nvarchar](max) NULL,
	[emailHTMLNagV328] [nvarchar](max) NULL,
	[emailSubjectNagV37] [nvarchar](250) NULL,
	[emailHTMLNagV2Yearly] [nvarchar](max) NULL,
	[emailSubjectNagV33] [nvarchar](250) NULL,
	[emailHTMLNagV3Yearly] [nvarchar](max) NULL,
	[emailSubjectNagV36month] [nvarchar](250) NULL,
	[emailSubjectNagV328] [nvarchar](250) NULL,
	[emailSubjectNagV228] [nvarchar](250) NULL,
	[emailSubjectNagV33month] [nvarchar](250) NULL,
	[emailHTMLNagV228] [nvarchar](max) NULL,
	[emailSubjectNagV2Yearly] [nvarchar](250) NULL,
	[emailSubjectActivatePortal] [nvarchar](250) NOT NULL,
	[activateEmailPortalTop] [nvarchar](max) NULL,
	[activateEmailPortalBot] [nvarchar](max) NULL,
	[xealthProgramId] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[programme_aFollowupActivityDefIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[programme_aFollowupActivityDefIDs](
	[typename] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[programme_aObjectIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[programme_aObjectIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[programme_aTrackerIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[programme_aTrackerIDs](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[progRole]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[progRole](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[programmeID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[promotion]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[promotion](
	[affiliate] [varchar](50) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[dateEnd] [nvarchar](250) NOT NULL,
	[dateStart] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[defaultCurrency] [nvarchar](250) NOT NULL,
	[discPercent] [numeric](10, 2) NULL,
	[discPrice_EUR] [numeric](10, 2) NULL,
	[discPrice_GBP] [numeric](10, 2) NULL,
	[discPrice_USD] [numeric](10, 2) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[product] [varchar](50) NULL,
	[productType] [nvarchar](250) NOT NULL,
	[promoCode] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[url] [nvarchar](250) NULL,
	[versionID] [varchar](50) NULL,
	[partner] [varchar](50) NULL,
	[body] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[refCategories]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[refCategories](
	[categoryid] [varchar](50) NOT NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC,
	[categoryid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[refContainers]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[refContainers](
	[objectid] [nvarchar](50) NOT NULL,
	[containerid] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectid] ASC,
	[containerid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[referer]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[referer](
	[biog] [nvarchar](250) NULL,
	[centerID] [nvarchar](50) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[dmProfileID] [nvarchar](50) NOT NULL,
	[email] [nvarchar](250) NOT NULL,
	[firstname] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastname] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberGroupID] [nvarchar](50) NOT NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerID] [nvarchar](50) NOT NULL,
	[picture] [varchar](50) NULL,
	[position] [nvarchar](250) NOT NULL,
	[quals] [nvarchar](max) NULL,
	[salutation] [nvarchar](250) NULL,
	[IAPTUStherapistId] [nvarchar](250) NULL,
	[versionID] [nvarchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[bInactive] [bit] NULL,
	[courseCode] [nvarchar](250) NULL,
	[progRoleID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reffriendlyURL]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reffriendlyURL](
	[objectid] [varchar](50) NOT NULL,
	[refobjectid] [varchar](50) NOT NULL,
	[friendlyurl] [varchar](8000) NULL,
	[query_string] [varchar](8000) NULL,
	[datetimelastupdated] [datetime] NULL,
	[status] [numeric](18, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[refObjects]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[refObjects](
	[objectid] [varchar](50) NOT NULL,
	[typename] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[frame] [bit] NULL,
	[height] [nvarchar](250) NULL,
	[label] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[lFields] [nvarchar](max) NULL,
	[lObjectIDs] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberID] [nvarchar](50) NOT NULL,
	[memberTypeID] [nvarchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[programmeID] [nvarchar](50) NOT NULL,
	[sortOn] [nvarchar](250) NULL,
	[width] [nvarchar](250) NULL,
	[xAxismajorUnit] [nvarchar](250) NULL,
	[xAxisMaximum] [nvarchar](250) NULL,
	[xAxisMinimum] [nvarchar](250) NULL,
	[xAxisminorUnit] [nvarchar](250) NULL,
	[xAxisTitle] [nvarchar](max) NULL,
	[xAxisType] [nvarchar](250) NULL,
	[xField] [nvarchar](max) NULL,
	[yAxismajorUnit] [nvarchar](250) NULL,
	[yAxisMaximum] [nvarchar](250) NULL,
	[yAxisMinimum] [nvarchar](250) NULL,
	[yAxisminorUnit] [nvarchar](250) NULL,
	[yAxisTitle] [nvarchar](250) NULL,
	[yAxisType] [nvarchar](250) NULL,
	[yField] [nvarchar](250) NULL,
	[dTypename] [nvarchar](250) NULL,
	[sortDir] [nvarchar](250) NULL,
	[title] [nvarchar](250) NOT NULL,
	[lFields2] [nvarchar](250) NULL,
	[joinTypename] [nvarchar](250) NULL,
	[joinOn] [nvarchar](250) NULL,
	[yType] [nvarchar](250) NULL,
	[joinType] [nvarchar](250) NULL,
	[xAxisLabelRenderer] [nvarchar](max) NULL,
	[yAxisLabelRenderer] [nvarchar](max) NULL,
	[lGroupField] [nvarchar](250) NULL,
	[lFieldCalc] [nvarchar](250) NULL,
	[legend] [bit] NULL,
	[lFtLists] [nvarchar](250) NULL,
	[help] [nvarchar](250) NULL,
	[invertVals] [nvarchar](250) NULL,
	[addOneVals] [bit] NULL,
	[SQLtop] [nvarchar](250) NULL,
	[SQLstatement] [nvarchar](max) NOT NULL,
	[showOptions] [nvarchar](250) NOT NULL,
	[partnerID] [varchar](50) NULL,
	[gender] [nvarchar](250) NOT NULL,
	[stepNum] [nvarchar](250) NOT NULL,
	[activated] [nvarchar](250) NOT NULL,
	[ftListsTypename] [nvarchar](250) NULL,
	[bDisplayPublic] [bit] NULL,
	[Body] [nvarchar](max) NULL,
	[xtype] [nvarchar](250) NOT NULL,
	[dataField] [nvarchar](250) NULL,
	[categoryField] [nvarchar](250) NULL,
	[groupField] [nvarchar](250) NULL,
	[markup] [nvarchar](250) NULL,
	[dateEnd] [datetime2](3) NULL,
	[dateStart] [datetime2](3) NULL,
	[bShowDateFilters] [bit] NULL,
	[versionID] [varchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[showFieldLabel] [nvarchar](max) NULL,
	[switchColours] [bit] NULL,
	[strValueBox] [nvarchar](max) NULL,
	[strTooltipProps] [nvarchar](max) NULL,
	[plotArea] [nvarchar](max) NULL,
	[legendAttr] [nvarchar](250) NULL,
	[YAXISBOVERLAP] [bit] NULL,
	[XAXISBOVERLAP] [bit] NULL,
	[yAxisbShowAxisLabel] [bit] NULL,
	[yAxis2bShowAxisLabel] [bit] NULL,
	[dateRange] [nvarchar](250) NULL,
	[yAxis2LabelRenderer] [nvarchar](250) NULL,
	[yAxis2Maximum] [nvarchar](250) NULL,
	[yAxis2Type] [nvarchar](250) NULL,
	[bXAxisPreview] [bit] NULL,
	[yAxis2majorUnit] [nvarchar](250) NULL,
	[y2Type] [nvarchar](250) NULL,
	[yAxis2minorUnit] [nvarchar](250) NULL,
	[YLOGSCALE] [nvarchar](250) NULL,
	[yAxis2Minimum] [nvarchar](250) NULL,
	[y2Field] [nvarchar](250) NULL,
	[Y2LOGSCALE] [nvarchar](250) NULL,
	[yAxis2Title] [nvarchar](250) NULL,
	[YAXIS2BOVERLAP] [bit] NULL,
	[YAXIS2LABEL] [nvarchar](250) NULL,
	[YAXISLABEL] [nvarchar](250) NULL,
	[yColours] [nvarchar](250) NULL,
	[y2Colours] [nvarchar](250) NULL,
	[strCrosshairXProps] [nvarchar](max) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report_aMemberGroupID]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report_aMemberGroupID](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleActivityDefListing]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleActivityDefListing](
	[objectID] [nvarchar](50) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[bMatchAllKeywords] [bit] NULL,
	[intro] [nvarchar](250) NULL,
	[categories] [nvarchar](max) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[slick_autoplaySpeed] [decimal](10, 2) NULL,
	[slick_vertical] [bit] NULL,
	[bSlick] [bit] NULL,
	[numItems] [decimal](10, 2) NULL,
	[slick_arrows] [bit] NULL,
	[slick_autoplay] [bit] NULL,
	[slick_infinite] [bit] NULL,
	[slick_speed] [decimal](10, 2) NULL,
	[slick_fade] [bit] NULL,
	[columnsize] [decimal](10, 2) NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[section] [nvarchar](250) NULL,
	[slick_dots] [bit] NULL,
	[slick_BP1_slidesToScroll] [decimal](10, 2) NULL,
	[slick_slidesToShow] [decimal](10, 2) NULL,
	[slick_BP2_infinite] [bit] NULL,
	[slick_BP3_slidesToScroll] [decimal](10, 2) NULL,
	[slick_BP3_infinite] [bit] NULL,
	[slick_slidesToScroll] [decimal](10, 2) NULL,
	[slick_BP2] [decimal](10, 2) NULL,
	[slick_BP1] [decimal](10, 2) NULL,
	[containerClass] [nvarchar](250) NULL,
	[slick_BP1_slidesToShow] [decimal](10, 2) NULL,
	[slick_BP3] [decimal](10, 2) NULL,
	[slick_BP2_slidesToScroll] [decimal](10, 2) NULL,
	[slick_BP2_slidesToShow] [decimal](10, 2) NULL,
	[slick_BP3_slidesToShow] [decimal](10, 2) NULL,
	[aspectRatio] [nvarchar](250) NULL,
	[slick_BP1_infinite] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleActivityDefListing_aActivityDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleActivityDefListing_aActivityDef](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleChildLinks]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleChildLinks](
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleDidYouKnowFact]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleDidYouKnowFact](
	[objectID] [nvarchar](50) NOT NULL,
	[numItems] [decimal](10, 2) NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleEvents]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleEvents](
	[bArchive] [int] NULL,
	[bMatchAllKeywords] [int] NULL,
	[datetimelastupdated] [datetime] NULL,
	[displayMethod] [varchar](255) NULL,
	[intro] [ntext] NULL,
	[label] [nvarchar](512) NULL,
	[metadata] [ntext] NULL,
	[numItems] [numeric](10, 2) NULL,
	[objectID] [varchar](50) NOT NULL,
	[suffix] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleEventsCalendar]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleEventsCalendar](
	[bMatchAllKeywords] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[metadata] [nvarchar](250) NULL,
	[months] [decimal](10, 2) NOT NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFacts]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFacts](
	[objectID] [nvarchar](50) NOT NULL,
	[numItems] [decimal](10, 2) NULL,
	[bMatchAllKeywords] [bit] NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[metadata] [nvarchar](max) NULL,
	[section] [nvarchar](250) NULL,
	[columnsize] [decimal](10, 2) NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[bSlick] [bit] NULL,
	[slick_autoplaySpeed] [decimal](10, 2) NULL,
	[slick_arrows] [bit] NULL,
	[slick_autoplay] [bit] NULL,
	[slick_infinite] [bit] NULL,
	[slick_speed] [decimal](10, 2) NULL,
	[slick_dots] [bit] NULL,
	[slick_vertical] [bit] NULL,
	[slick_fade] [bit] NULL,
	[dsn] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFacts_aFacts]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFacts_aFacts](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFeedback]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFeedback](
	[datetimelastupdated] [datetime2](3) NULL,
	[emailto] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[objectID] [varchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[successResponse] [nvarchar](max) NULL,
	[successTitle] [nvarchar](250) NULL,
	[subject] [nvarchar](250) NULL,
	[buttonLabel] [nvarchar](250) NULL,
	[buttonIcon] [nvarchar](250) NULL,
	[class] [nvarchar](250) NULL,
	[body] [nvarchar](250) NULL,
	[buttonClass] [nvarchar](250) NULL,
	[SubscribeHint] [nvarchar](250) NULL,
	[bShowSubscribe] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFeedbackAndRate]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFeedbackAndRate](
	[someBodyBot] [nvarchar](max) NULL,
	[successResponse] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[someBodyTop] [nvarchar](max) NULL,
	[emailto] [nvarchar](250) NOT NULL,
	[successTitle] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[objectID] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFileListing]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFileListing](
	[objectID] [nvarchar](50) NOT NULL,
	[bMatchAllKeywords] [bit] NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[categories] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleFileListing_aFiles]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleFileListing_aFiles](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleHandpicked]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleHandpicked](
	[datetimelastupdated] [datetime2](3) NULL,
	[intro] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleHandpicked_aObjects]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleHandpicked_aObjects](
	[data] [nvarchar](250) NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[webskin] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleImageGallery]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleImageGallery](
	[catImageGallery] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[label] [nvarchar](250) NULL,
	[numItems] [decimal](10, 2) NOT NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleImageGalleryGalleria]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleImageGalleryGalleria](
	[galleria_bShow_imagenav] [bit] NULL,
	[displayType] [nvarchar](250) NULL,
	[galleria_transition] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[galleria_bShow_info] [bit] NULL,
	[galleria_autoplay] [decimal](10, 2) NULL,
	[catImageGallery] [nvarchar](250) NULL,
	[galleria_height] [decimal](10, 2) NULL,
	[galleria_bShow_counter] [bit] NULL,
	[objectID] [nvarchar](50) NOT NULL,
	[galleria_carousel_speed] [decimal](10, 2) NULL,
	[galleria_lightbox] [bit] NULL,
	[galleria_theme] [nvarchar](250) NULL,
	[galleria_thumbnails] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleImageGalleryGalleria_aImages]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleImageGalleryGalleria_aImages](
	[typename] [nvarchar](250) NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleImageGallerySlick]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleImageGallerySlick](
	[slick_BP1_slidesToScroll] [decimal](10, 2) NULL,
	[slick_infinite] [bit] NULL,
	[slick_BP3_infinite] [bit] NULL,
	[slick_speed] [decimal](10, 2) NULL,
	[slick_slidesToScroll] [decimal](10, 2) NULL,
	[slick_BP2] [decimal](10, 2) NULL,
	[slick_BP1] [decimal](10, 2) NULL,
	[slick_BP1_slidesToShow] [decimal](10, 2) NULL,
	[slick_BP3] [decimal](10, 2) NULL,
	[objectID] [nvarchar](50) NOT NULL,
	[slick_BP2_slidesToShow] [decimal](10, 2) NULL,
	[slick_BP3_slidesToShow] [decimal](10, 2) NULL,
	[label] [nvarchar](250) NULL,
	[catImageGallery] [nvarchar](250) NULL,
	[slick_BP1_infinite] [bit] NULL,
	[slick_dots] [bit] NULL,
	[slick_autoplaySpeed] [decimal](10, 2) NULL,
	[slick_slidesToShow] [decimal](10, 2) NULL,
	[slick_arrows] [bit] NULL,
	[slick_autoplay] [bit] NULL,
	[slick_BP2_infinite] [bit] NULL,
	[slick_BP3_slidesToScroll] [decimal](10, 2) NULL,
	[containerClass] [nvarchar](250) NULL,
	[slick_BP2_slidesToScroll] [decimal](10, 2) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[slick_vertical] [bit] NULL,
	[slick_fade] [bit] NULL,
	[intro] [nvarchar](250) NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[aspectRatio] [nvarchar](250) NULL,
	[section] [nvarchar](250) NULL,
	[slick_slidesPerRow] [decimal](10, 2) NULL,
	[slick_rows] [decimal](10, 2) NULL,
	[bShowCaptions] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleImageGallerySlick_aImages]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleImageGallerySlick_aImages](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleLatesttestimonial]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleLatesttestimonial](
	[bPaginate] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[itemsPerPage] [decimal](10, 2) NULL,
	[label] [nvarchar](250) NOT NULL,
	[numItems] [decimal](10, 2) NULL,
	[objectID] [nvarchar](50) NOT NULL,
	[pageLinksShown] [decimal](10, 2) NULL,
	[bSlick] [bit] NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[columnsize] [decimal](10, 2) NULL,
	[section] [nvarchar](250) NULL,
	[intro] [nvarchar](250) NULL,
	[totalItems] [decimal](10, 2) NULL,
	[slick_autoplaySpeed] [decimal](10, 2) NULL,
	[slick_arrows] [bit] NULL,
	[slick_autoplay] [bit] NULL,
	[slick_infinite] [bit] NULL,
	[slick_speed] [decimal](10, 2) NULL,
	[slick_dots] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleLatesttestimonial_aTestimonials]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleLatesttestimonial_aTestimonials](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleLeadFeedback]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleLeadFeedback](
	[buttonLabel] [nvarchar](250) NULL,
	[SubscribeHint] [nvarchar](250) NULL,
	[class] [nvarchar](250) NULL,
	[buttonClass] [nvarchar](250) NULL,
	[objectID] [nvarchar](50) NOT NULL,
	[successTitle] [nvarchar](250) NULL,
	[successResponse] [nvarchar](max) NULL,
	[subject] [nvarchar](250) NULL,
	[buttonIcon] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[title] [nvarchar](250) NULL,
	[bShowSubscribe] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[body] [nvarchar](250) NULL,
	[emailto] [nvarchar](250) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleLinks]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleLinks](
	[bArchive] [int] NULL,
	[bMatchAllKeywords] [int] NULL,
	[datetimelastupdated] [datetime] NULL,
	[displayMethod] [varchar](255) NULL,
	[intro] [ntext] NULL,
	[label] [nvarchar](512) NULL,
	[metadata] [ntext] NULL,
	[numItems] [numeric](10, 2) NULL,
	[objectID] [varchar](50) NOT NULL,
	[suffix] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleNews]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleNews](
	[bArchive] [bit] NOT NULL,
	[bMatchAllKeywords] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NOT NULL,
	[intro] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[metadata] [nvarchar](250) NULL,
	[numItems] [decimal](10, 2) NOT NULL,
	[objectID] [varchar](50) NOT NULL,
	[suffix] [nvarchar](max) NULL,
	[numPages] [decimal](10, 2) NOT NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[section] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleNews_aNews]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleNews_aNews](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleRandomFact]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleRandomFact](
	[bMatchAllKeywords] [bit] NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[metadata] [nvarchar](max) NULL,
	[numItems] [decimal](10, 2) NULL,
	[objectID] [varchar](50) NOT NULL,
	[dsn] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleRelated]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleRelated](
	[objectID] [nvarchar](50) NOT NULL,
	[numItems] [decimal](10, 2) NULL,
	[bMatchAllKeywords] [bit] NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[displayMethod] [nvarchar](250) NULL,
	[metadata] [nvarchar](max) NULL,
	[section] [nvarchar](250) NULL,
	[columnsize] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleRelated_aObjs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleRelated_aObjs](
	[parentid] [nvarchar](50) NOT NULL,
	[typename] [nvarchar](250) NULL,
	[data] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials](
	[objectID] [nvarchar](50) NOT NULL,
	[numItems] [decimal](10, 2) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[programmeURL] [nvarchar](250) NULL,
	[programmeDSN] [nvarchar](250) NULL,
	[programmeID] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleRichText]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleRichText](
	[datetimelastupdated] [datetime2](3) NULL,
	[label] [nvarchar](250) NULL,
	[objectID] [varchar](50) NOT NULL,
	[text] [nvarchar](max) NOT NULL,
	[title] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleSelfRegistration]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleSelfRegistration](
	[partnerID] [nvarchar](50) NOT NULL,
	[referringURLPart] [nvarchar](250) NOT NULL,
	[referringURL] [nvarchar](250) NOT NULL,
	[memberGroupID] [nvarchar](50) NOT NULL,
	[centerID] [nvarchar](50) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NULL,
	[refererID] [nvarchar](50) NOT NULL,
	[objectID] [nvarchar](50) NOT NULL,
	[bDoCheck] [bit] NULL,
	[bActivation] [bit] NULL,
	[memberTypeID] [nvarchar](50) NOT NULL,
	[buttonLabel] [nvarchar](250) NOT NULL,
	[CFlocationTo] [nvarchar](250) NOT NULL,
	[successBubbleMessage] [nvarchar](250) NULL,
	[successBubbleTitle] [nvarchar](250) NULL,
	[bFacebook] [bit] NULL,
	[bSales] [bit] NULL,
	[bGift] [bit] NULL,
	[giftDate] [datetime2](3) NULL,
	[intro] [nvarchar](250) NULL,
	[sectionClasses] [nvarchar](250) NULL,
	[section] [nvarchar](250) NULL,
	[bnAV] [bit] NULL,
	[bGoogle] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleShowWebfeed]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleShowWebfeed](
	[datetimelastupdated] [datetime] NULL,
	[label] [nvarchar](512) NULL,
	[objectID] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleShowWebfeed_aWebDisplayFeeds]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleShowWebfeed_aWebDisplayFeeds](
	[data] [varchar](255) NOT NULL,
	[parentid] [varchar](50) NOT NULL,
	[seq] [numeric](10, 2) NULL,
	[typename] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleText]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleText](
	[datetimelastupdated] [datetime2](3) NULL,
	[label] [nvarchar](250) NULL,
	[objectID] [varchar](50) NOT NULL,
	[text] [nvarchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ruleXMLFeed]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ruleXMLFeed](
	[datetimelastupdated] [datetime2](3) NULL,
	[feedName] [nvarchar](250) NULL,
	[intro] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[maxRecords] [decimal](10, 2) NULL,
	[objectID] [varchar](50) NOT NULL,
	[XMLFeedURL] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[objectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shopItem]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shopItem](
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[Teaser] [nvarchar](2000) NULL,
	[label] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[priceGBP] [decimal](10, 2) NULL,
	[publishStepNum] [decimal](10, 2) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[publishDelay] [decimal](10, 2) NULL,
	[teaserImage] [nvarchar](50) NULL,
	[bPublishCriteria] [decimal](10, 2) NULL,
	[Body] [nvarchar](max) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[priceUSD] [decimal](10, 2) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[publishType] [decimal](10, 2) NULL,
	[priceEUR] [decimal](10, 2) NULL,
	[locked] [bit] NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shopItem_aPublishCriteriaIDs]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shopItem_aPublishCriteriaIDs](
	[typename] [nvarchar](250) NULL,
	[seq] [decimal](10, 2) NOT NULL,
	[parentid] [nvarchar](50) NOT NULL,
	[data] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[parentid] ASC,
	[seq] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSQ_arthritis01]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSQ_arthritis01](
	[PHQ910] [nvarchar](250) NULL,
	[sickpayStatus] [nvarchar](250) NULL,
	[PSEQ06] [nvarchar](250) NULL,
	[PSEQ05] [nvarchar](250) NULL,
	[PSEQ08] [nvarchar](250) NULL,
	[PSEQ07] [nvarchar](250) NULL,
	[PSEQ02] [nvarchar](250) NULL,
	[PSEQ01] [nvarchar](250) NULL,
	[PSEQ04] [nvarchar](250) NULL,
	[PSEQ03] [nvarchar](250) NULL,
	[bogusTrackers] [decimal](10, 2) NULL,
	[PSEQ09] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[WSAS1] [nvarchar](250) NULL,
	[WSAS2] [nvarchar](250) NULL,
	[WSAS3] [nvarchar](250) NULL,
	[PHQ909] [nvarchar](250) NULL,
	[WSAS4] [nvarchar](250) NULL,
	[PHQ908] [nvarchar](250) NULL,
	[WSAS5] [nvarchar](250) NULL,
	[PHQ907] [nvarchar](250) NULL,
	[PHQ906] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[PHQ905] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[PHQ904] [nvarchar](250) NULL,
	[PHQ903] [nvarchar](250) NULL,
	[PHQ902] [nvarchar](250) NULL,
	[PHQ901] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ODIcombined] [nvarchar](250) NULL,
	[PHQ9] [nvarchar](250) NULL,
	[PHOBIA2] [nvarchar](250) NULL,
	[occupationalStatus] [nvarchar](250) NULL,
	[PHOBIA1] [nvarchar](250) NULL,
	[STarTrisk] [nvarchar](250) NULL,
	[PSEQcombined] [nvarchar](250) NULL,
	[IAPTUSrejectionReason] [nvarchar](250) NULL,
	[PHOBIA3] [nvarchar](250) NULL,
	[employmentStatus] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[memberID] [nvarchar](50) NULL,
	[painDurationYears] [nvarchar](250) NULL,
	[PsychoMed] [nvarchar](250) NULL,
	[GAD706] [nvarchar](250) NULL,
	[GAD705] [nvarchar](250) NULL,
	[GAD704] [nvarchar](250) NULL,
	[ODI10] [nvarchar](250) NULL,
	[GAD703] [nvarchar](250) NULL,
	[WSAS1NA] [bit] NULL,
	[GAD707] [nvarchar](250) NULL,
	[STarT1] [nvarchar](250) NULL,
	[EQ5D01] [nvarchar](250) NULL,
	[EQ5D02] [nvarchar](250) NULL,
	[EQ5D03] [nvarchar](250) NULL,
	[STarT4] [decimal](10, 2) NULL,
	[EQ5D04] [nvarchar](250) NULL,
	[STarT5] [decimal](10, 2) NULL,
	[GAD702] [nvarchar](250) NULL,
	[STarT6] [decimal](10, 2) NULL,
	[GAD701] [nvarchar](250) NULL,
	[STarT7] [decimal](10, 2) NULL,
	[STarT8] [decimal](10, 2) NULL,
	[STarT9] [decimal](10, 2) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[painLocation] [nvarchar](250) NULL,
	[IAPTUSackStatus] [nvarchar](250) NULL,
	[ODI05] [nvarchar](250) NULL,
	[ODI04] [nvarchar](250) NULL,
	[ODI07] [nvarchar](250) NULL,
	[ODI06] [nvarchar](250) NULL,
	[ODI09] [nvarchar](250) NULL,
	[ODI08] [nvarchar](250) NULL,
	[benefitsStatus] [nvarchar](250) NULL,
	[bogusFinish] [decimal](10, 2) NULL,
	[EQ5D05] [nvarchar](250) NULL,
	[ODI01] [nvarchar](250) NULL,
	[GAD7] [nvarchar](250) NULL,
	[painDurationMonths] [nvarchar](250) NULL,
	[EQ5D06] [nvarchar](250) NULL,
	[ODI03] [nvarchar](250) NULL,
	[ODI02] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[preDisclaimer] [bit] NULL,
	[SSQSignposting] [bit] NULL,
	[stepNum] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[consent] [bit] NULL,
	[PSEQ10] [nvarchar](250) NULL,
	[MSKHQcombined] [nvarchar](250) NULL,
	[MSKHQ10] [nvarchar](250) NULL,
	[MSKHQ11] [nvarchar](250) NULL,
	[MSKHQ01] [nvarchar](250) NULL,
	[MSKHQ12] [nvarchar](250) NULL,
	[MSKHQ06] [nvarchar](250) NULL,
	[MSKHQ07] [nvarchar](250) NULL,
	[MSKHQ08] [nvarchar](250) NULL,
	[MSKHQ09] [nvarchar](250) NULL,
	[MSKHQ02] [nvarchar](250) NULL,
	[MSKHQ13] [nvarchar](250) NULL,
	[MSKHQ03] [nvarchar](250) NULL,
	[MSKHQ14] [nvarchar](250) NULL,
	[MSKHQ04] [nvarchar](250) NULL,
	[MSKHQ15] [nvarchar](250) NULL,
	[MSKHQ05] [nvarchar](250) NULL,
	[bogusStepNum] [nvarchar](250) NULL,
	[q10] [nvarchar](250) NULL,
	[PSS] [nvarchar](250) NULL,
	[q02] [nvarchar](250) NULL,
	[q01] [nvarchar](250) NULL,
	[q04] [nvarchar](250) NULL,
	[q03] [nvarchar](250) NULL,
	[q06] [nvarchar](250) NULL,
	[q05] [nvarchar](250) NULL,
	[q08] [nvarchar](250) NULL,
	[q07] [nvarchar](250) NULL,
	[q09] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progMemberID] [nvarchar](50) NULL,
	[programmeID] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSQ_pain01]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSQ_pain01](
	[PHQ910] [nvarchar](250) NULL,
	[sickpayStatus] [nvarchar](250) NULL,
	[PSEQ06] [nvarchar](250) NULL,
	[PSEQ05] [nvarchar](250) NULL,
	[PSEQ08] [nvarchar](250) NULL,
	[PSEQ07] [nvarchar](250) NULL,
	[PSEQ02] [nvarchar](250) NULL,
	[PSEQ01] [nvarchar](250) NULL,
	[PSEQ04] [nvarchar](250) NULL,
	[PSEQ03] [nvarchar](250) NULL,
	[bogusTrackers] [decimal](10, 2) NULL,
	[PSEQ09] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[WSAS1] [nvarchar](250) NULL,
	[WSAS2] [nvarchar](250) NULL,
	[WSAS3] [nvarchar](250) NULL,
	[PHQ909] [nvarchar](250) NULL,
	[WSAS4] [nvarchar](250) NULL,
	[PHQ908] [nvarchar](250) NULL,
	[WSAS5] [nvarchar](250) NULL,
	[PHQ907] [nvarchar](250) NULL,
	[PHQ906] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[PHQ905] [nvarchar](250) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[PHQ904] [nvarchar](250) NULL,
	[PHQ903] [nvarchar](250) NULL,
	[PHQ902] [nvarchar](250) NULL,
	[PHQ901] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[ODIcombined] [nvarchar](250) NULL,
	[PHQ9] [nvarchar](250) NULL,
	[PHOBIA2] [nvarchar](250) NULL,
	[occupationalStatus] [nvarchar](250) NULL,
	[PHOBIA1] [nvarchar](250) NULL,
	[STarTrisk] [nvarchar](250) NULL,
	[PSEQcombined] [nvarchar](250) NULL,
	[IAPTUSrejectionReason] [nvarchar](250) NULL,
	[PHOBIA3] [nvarchar](250) NULL,
	[employmentStatus] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[memberID] [nvarchar](50) NULL,
	[painDurationYears] [nvarchar](250) NULL,
	[PsychoMed] [nvarchar](250) NULL,
	[GAD706] [nvarchar](250) NULL,
	[GAD705] [nvarchar](250) NULL,
	[GAD704] [nvarchar](250) NULL,
	[ODI10] [nvarchar](250) NULL,
	[GAD703] [nvarchar](250) NULL,
	[WSAS1NA] [bit] NULL,
	[GAD707] [nvarchar](250) NULL,
	[STarT1] [nvarchar](250) NULL,
	[EQ5D01] [nvarchar](250) NULL,
	[EQ5D02] [nvarchar](250) NULL,
	[EQ5D03] [nvarchar](250) NULL,
	[STarT4] [decimal](10, 2) NULL,
	[EQ5D04] [nvarchar](250) NULL,
	[STarT5] [decimal](10, 2) NULL,
	[GAD702] [nvarchar](250) NULL,
	[STarT6] [decimal](10, 2) NULL,
	[GAD701] [nvarchar](250) NULL,
	[STarT7] [decimal](10, 2) NULL,
	[STarT8] [decimal](10, 2) NULL,
	[STarT9] [decimal](10, 2) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[painLocation] [nvarchar](250) NULL,
	[IAPTUSackStatus] [nvarchar](250) NULL,
	[ODI05] [nvarchar](250) NULL,
	[ODI04] [nvarchar](250) NULL,
	[ODI07] [nvarchar](250) NULL,
	[ODI06] [nvarchar](250) NULL,
	[ODI09] [nvarchar](250) NULL,
	[ODI08] [nvarchar](250) NULL,
	[benefitsStatus] [nvarchar](250) NULL,
	[bogusFinish] [decimal](10, 2) NULL,
	[EQ5D05] [nvarchar](250) NULL,
	[ODI01] [nvarchar](250) NULL,
	[GAD7] [nvarchar](250) NULL,
	[painDurationMonths] [nvarchar](250) NULL,
	[EQ5D06] [nvarchar](250) NULL,
	[ODI03] [nvarchar](250) NULL,
	[ODI02] [nvarchar](250) NULL,
	[ownedby] [nvarchar](250) NULL,
	[preDisclaimer] [bit] NULL,
	[SSQSignposting] [bit] NULL,
	[stepNum] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[consent] [bit] NULL,
	[PSEQ10] [nvarchar](250) NULL,
	[MSKHQcombined] [nvarchar](250) NULL,
	[MSKHQ10] [nvarchar](250) NULL,
	[MSKHQ11] [nvarchar](250) NULL,
	[MSKHQ01] [nvarchar](250) NULL,
	[MSKHQ12] [nvarchar](250) NULL,
	[MSKHQ06] [nvarchar](250) NULL,
	[MSKHQ07] [nvarchar](250) NULL,
	[MSKHQ08] [nvarchar](250) NULL,
	[MSKHQ09] [nvarchar](250) NULL,
	[MSKHQ02] [nvarchar](250) NULL,
	[MSKHQ13] [nvarchar](250) NULL,
	[MSKHQ03] [nvarchar](250) NULL,
	[MSKHQ14] [nvarchar](250) NULL,
	[MSKHQ04] [nvarchar](250) NULL,
	[MSKHQ15] [nvarchar](250) NULL,
	[MSKHQ05] [nvarchar](250) NULL,
	[bogusStepNum] [nvarchar](250) NULL,
	[q10] [nvarchar](250) NULL,
	[PSS] [nvarchar](250) NULL,
	[q02] [nvarchar](250) NULL,
	[q01] [nvarchar](250) NULL,
	[q04] [nvarchar](250) NULL,
	[q03] [nvarchar](250) NULL,
	[q06] [nvarchar](250) NULL,
	[q05] [nvarchar](250) NULL,
	[q08] [nvarchar](250) NULL,
	[q07] [nvarchar](250) NULL,
	[q09] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progMemberID] [nvarchar](50) NULL,
	[programmeID] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SSQ_stress01]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SSQ_stress01](
	[bogusFinish] [decimal](10, 2) NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberID] [nvarchar](50) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[q01] [nvarchar](250) NULL,
	[q02] [nvarchar](250) NULL,
	[q03] [nvarchar](250) NULL,
	[q04] [nvarchar](250) NULL,
	[q05] [nvarchar](250) NULL,
	[q06] [nvarchar](250) NULL,
	[q07] [nvarchar](250) NULL,
	[q08] [nvarchar](250) NULL,
	[q09] [nvarchar](250) NULL,
	[q10] [nvarchar](250) NULL,
	[PSS] [nvarchar](250) NULL,
	[bogusStepNum] [nvarchar](250) NULL,
	[GAD701] [nvarchar](250) NULL,
	[PHQ901] [nvarchar](250) NULL,
	[GAD702] [nvarchar](250) NULL,
	[GAD7] [nvarchar](250) NULL,
	[GAD703] [nvarchar](250) NULL,
	[PHQ909] [nvarchar](250) NULL,
	[GAD704] [nvarchar](250) NULL,
	[GAD706] [nvarchar](250) NULL,
	[PHQ910] [nvarchar](250) NULL,
	[GAD707] [nvarchar](250) NULL,
	[PHQ9] [nvarchar](250) NULL,
	[PHQ906] [nvarchar](250) NULL,
	[PHQ907] [nvarchar](250) NULL,
	[PHQ908] [nvarchar](250) NULL,
	[GAD705] [nvarchar](250) NULL,
	[PHQ902] [nvarchar](250) NULL,
	[PHQ903] [nvarchar](250) NULL,
	[PHQ904] [nvarchar](250) NULL,
	[PHQ905] [nvarchar](250) NULL,
	[IAPTUSrejectionReason] [nvarchar](250) NULL,
	[IAPTUSackStatus] [nvarchar](250) NULL,
	[employmentStatus] [nvarchar](250) NULL,
	[sickpayStatus] [nvarchar](250) NULL,
	[PHOBIA1] [nvarchar](250) NULL,
	[PHOBIA2] [nvarchar](250) NULL,
	[PHOBIA3] [nvarchar](250) NULL,
	[benefitsStatus] [nvarchar](250) NULL,
	[WSAS1] [nvarchar](250) NULL,
	[WSAS1NA] [bit] NULL,
	[WSAS5] [nvarchar](250) NULL,
	[WSAS4] [nvarchar](250) NULL,
	[WSAS3] [nvarchar](250) NULL,
	[WSAS2] [nvarchar](250) NULL,
	[SSQSignposting] [bit] NULL,
	[PSYCHOMED] [nvarchar](250) NULL,
	[PSEQ06] [nvarchar](250) NULL,
	[PSEQ05] [nvarchar](250) NULL,
	[PSEQ08] [nvarchar](250) NULL,
	[PSEQ07] [nvarchar](250) NULL,
	[PSEQ02] [nvarchar](250) NULL,
	[PSEQ01] [nvarchar](250) NULL,
	[PSEQ04] [nvarchar](250) NULL,
	[PSEQ03] [nvarchar](250) NULL,
	[bogusTrackers] [decimal](10, 2) NULL,
	[MSKHQ01] [nvarchar](250) NULL,
	[PSEQ09] [nvarchar](250) NULL,
	[MSKHQ06] [nvarchar](250) NULL,
	[MSKHQ07] [nvarchar](250) NULL,
	[MSKHQ08] [nvarchar](250) NULL,
	[MSKHQ09] [nvarchar](250) NULL,
	[MSKHQ02] [nvarchar](250) NULL,
	[MSKHQ03] [nvarchar](250) NULL,
	[MSKHQ04] [nvarchar](250) NULL,
	[MSKHQ05] [nvarchar](250) NULL,
	[ODIcombined] [nvarchar](250) NULL,
	[occupationalStatus] [nvarchar](250) NULL,
	[STarTrisk] [nvarchar](250) NULL,
	[PSEQcombined] [nvarchar](250) NULL,
	[MSKHQcombined] [nvarchar](250) NULL,
	[painDurationYears] [nvarchar](250) NULL,
	[ODI10] [nvarchar](250) NULL,
	[STarT1] [nvarchar](250) NULL,
	[EQ5D01] [nvarchar](250) NULL,
	[EQ5D02] [nvarchar](250) NULL,
	[STarT4] [decimal](10, 2) NULL,
	[EQ5D03] [nvarchar](250) NULL,
	[STarT5] [decimal](10, 2) NULL,
	[EQ5D04] [nvarchar](250) NULL,
	[STarT6] [decimal](10, 2) NULL,
	[STarT7] [decimal](10, 2) NULL,
	[STarT8] [decimal](10, 2) NULL,
	[STarT9] [decimal](10, 2) NULL,
	[painLocation] [nvarchar](250) NULL,
	[ODI05] [nvarchar](250) NULL,
	[ODI04] [nvarchar](250) NULL,
	[ODI07] [nvarchar](250) NULL,
	[ODI06] [nvarchar](250) NULL,
	[ODI09] [nvarchar](250) NULL,
	[ODI08] [nvarchar](250) NULL,
	[MSKHQ10] [nvarchar](250) NULL,
	[MSKHQ11] [nvarchar](250) NULL,
	[MSKHQ12] [nvarchar](250) NULL,
	[ODI01] [nvarchar](250) NULL,
	[EQ5D05] [nvarchar](250) NULL,
	[painDurationMonths] [nvarchar](250) NULL,
	[EQ5D06] [nvarchar](250) NULL,
	[ODI03] [nvarchar](250) NULL,
	[ODI02] [nvarchar](250) NULL,
	[preDisclaimer] [bit] NULL,
	[stepNum] [nvarchar](250) NULL,
	[MSKHQ13] [nvarchar](250) NULL,
	[MSKHQ14] [nvarchar](250) NULL,
	[MSKHQ15] [nvarchar](250) NULL,
	[consent] [bit] NULL,
	[PSEQ10] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
	[progMemberID] [nvarchar](50) NULL,
	[programmeID] [nvarchar](50) NULL,
	[workEdCon01] [decimal](10, 2) NULL,
	[workEdCon10] [decimal](10, 2) NULL,
	[workEdCon05] [decimal](10, 2) NULL,
	[workEdCon04] [decimal](10, 2) NULL,
	[workEdCon03] [decimal](10, 2) NULL,
	[workEdCon02] [decimal](10, 2) NULL,
	[workEdCon09] [decimal](10, 2) NULL,
	[workEdCon08] [decimal](10, 2) NULL,
	[workEdCon07] [decimal](10, 2) NULL,
	[workEdSituation] [nvarchar](250) NULL,
	[workEdCon06] [decimal](10, 2) NULL,
	[workEdSitExtra] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[test]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[status] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[versionID] [nvarchar](50) NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetest] [datetime2](3) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[testimonial]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[testimonial](
	[body] [nvarchar](max) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[memberID] [varchar](50) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[title] [nvarchar](250) NOT NULL,
	[rating] [nvarchar](250) NULL,
	[activityDefID] [nvarchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[token]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[token](
	[sub] [nvarchar](250) NULL,
	[locked] [bit] NOT NULL,
	[id_token] [nvarchar](max) NULL,
	[refresh_token] [nvarchar](max) NULL,
	[accessTokenExp] [nvarchar](250) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[access_token] [nvarchar](max) NULL,
	[username] [nvarchar](250) NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[DeviceKey] [nvarchar](250) NULL,
	[DeviceGroupKey] [nvarchar](250) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tracker]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tracker](
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[progMemberID] [varchar](50) NULL,
	[trackerData] [nvarchar](250) NULL,
	[trackerDefID] [varchar](50) NULL,
	[activityID] [varchar](50) NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trackerDef]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trackerDef](
	[bOptional] [bit] NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[description] [nvarchar](max) NULL,
	[label] [nvarchar](250) NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[ObjectID] [varchar](50) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[programmeID] [nvarchar](50) NOT NULL,
	[title] [nvarchar](250) NULL,
	[trackerFtClass] [nvarchar](250) NULL,
	[trackerFtDefault] [nvarchar](250) NULL,
	[trackerFtHelpSection] [nvarchar](250) NULL,
	[trackerFtHint] [nvarchar](250) NULL,
	[trackerFtIncludeDecimal] [nvarchar](250) NULL,
	[trackerFtLabel] [nvarchar](250) NULL,
	[trackerFtList] [nvarchar](max) NULL,
	[trackerFtMaxLabel] [nvarchar](250) NULL,
	[trackerFtMaxValue] [nvarchar](250) NULL,
	[trackerFtMinLabel] [nvarchar](250) NULL,
	[trackerFtMinValue] [nvarchar](250) NULL,
	[trackerFtRenderType] [nvarchar](250) NULL,
	[trackerFtStyle] [nvarchar](250) NULL,
	[trackerFtType] [nvarchar](250) NULL,
	[trackerFtValidation] [nvarchar](250) NULL,
	[trackerFtWidth] [nvarchar](250) NULL,
	[trackerFtValidationAdd] [nvarchar](250) NULL,
	[trackerftMinPic] [nvarchar](250) NULL,
	[trackerftMaxPic] [nvarchar](250) NULL,
	[trackerFtOffsetVal] [nvarchar](250) NULL,
	[trackerFtReversed] [bit] NULL,
	[versionID] [nvarchar](50) NULL,
	[status] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xealth_notification]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xealth_notification](
	[deployment] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[programId] [nvarchar](250) NOT NULL,
	[eventTimeStamp] [nvarchar](250) NOT NULL,
	[eventId] [nvarchar](250) NOT NULL,
	[patientIdentity] [nvarchar](max) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[orderId] [nvarchar](250) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[eventType] [nvarchar](250) NOT NULL,
	[partnerId] [nvarchar](250) NOT NULL,
	[eventContext] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[eventStatus] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xealth_order]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xealth_order](
	[deployment] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[programId] [nvarchar](250) NOT NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[orderId] [nvarchar](250) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[bPreorder] [bit] NOT NULL,
	[partnerId] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xealth_patient]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xealth_patient](
	[deployment] [nvarchar](250) NOT NULL,
	[locked] [bit] NOT NULL,
	[memberID] [nvarchar](50) NULL,
	[programId] [nvarchar](250) NOT NULL,
	[patientIdentity] [nvarchar](max) NOT NULL,
	[datasets] [nvarchar](max) NULL,
	[ObjectID] [nvarchar](50) NOT NULL,
	[orderId] [nvarchar](250) NOT NULL,
	[ownedby] [nvarchar](250) NULL,
	[partnerId] [nvarchar](250) NOT NULL,
	[lastupdatedby] [nvarchar](250) NOT NULL,
	[label] [nvarchar](250) NULL,
	[datetimecreated] [datetime2](3) NOT NULL,
	[lockedBy] [nvarchar](250) NULL,
	[datetimelastupdated] [datetime2](3) NOT NULL,
	[patientId] [nvarchar](250) NOT NULL,
	[createdby] [nvarchar](250) NOT NULL,
	[courseCode] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[ObjectID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[zzRemote]    Script Date: 7/16/2025 8:55:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[zzRemote](
	[createdby] [nvarchar](512) NULL,
	[datetimecreated] [datetime] NULL,
	[datetimelastupdated] [datetime] NULL,
	[label] [nvarchar](512) NULL,
	[lastupdatedby] [nvarchar](512) NULL,
	[locked] [int] NULL,
	[lockedBy] [nvarchar](512) NULL,
	[ObjectID] [varchar](50) NULL,
	[ownedby] [nvarchar](512) NULL,
	[title] [varchar](255) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_activityState]  DEFAULT ('Email') FOR [activityState]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_bMailed]  DEFAULT ((0)) FOR [bMailed]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_datetimecreated]  DEFAULT ('2223-03-19T16:37:06') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:00') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_mailedDate]  DEFAULT (NULL) FOR [mailedDate]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_bComplete]  DEFAULT ((0)) FOR [bComplete]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[activity] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[activity] ADD  CONSTRAINT [def_activity_lastPlayedDate]  DEFAULT (NULL) FOR [lastPlayedDate]
GO
ALTER TABLE [dbo].[activity] ADD  DEFAULT ((0)) FOR [numPlays]
GO
ALTER TABLE [dbo].[activity] ADD  DEFAULT ((0)) FOR [numDownloads]
GO
ALTER TABLE [dbo].[activity] ADD  DEFAULT ((0)) FOR [bFavourite]
GO
ALTER TABLE [dbo].[activity] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_bOptional]  DEFAULT ((0)) FOR [bOptional]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleInteract1]  DEFAULT ('Next') FOR [buttonDoTitleInteract1]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleInteract2]  DEFAULT ('Next') FOR [buttonDoTitleInteract2]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleInteract3]  DEFAULT ('Next') FOR [buttonDoTitleInteract3]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleInteract4]  DEFAULT ('Next') FOR [buttonDoTitleInteract4]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleRating]  DEFAULT ('Done') FOR [buttonDoTitleRating]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_datetimecreated]  DEFAULT ('2223-03-19T16:19:40') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_datetimelastupdated]  DEFAULT ('2223-03-19T16:19:40') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list11FtClass]  DEFAULT ('inputRadioBig') FOR [list11FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list11FtIncludeDecimal]  DEFAULT ('false') FOR [list11FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list11FtRenderType]  DEFAULT ('radio') FOR [list11FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list11FtType]  DEFAULT ('list') FOR [list11FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list11FtValidation]  DEFAULT ('validate-one-required') FOR [list11FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list12FtClass]  DEFAULT ('inputRadioBig') FOR [list12FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list12FtIncludeDecimal]  DEFAULT ('false') FOR [list12FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list12FtRenderType]  DEFAULT ('radio') FOR [list12FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list12FtType]  DEFAULT ('list') FOR [list12FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list12FtValidation]  DEFAULT ('validate-one-required') FOR [list12FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list13FtClass]  DEFAULT ('inputRadioBig') FOR [list13FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list13FtIncludeDecimal]  DEFAULT ('false') FOR [list13FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list13FtRenderType]  DEFAULT ('radio') FOR [list13FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list13FtType]  DEFAULT ('list') FOR [list13FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list13FtValidation]  DEFAULT ('validate-one-required') FOR [list13FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list21FtClass]  DEFAULT ('inputRadioBig') FOR [list21FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list21FtIncludeDecimal]  DEFAULT ('false') FOR [list21FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list21FtRenderType]  DEFAULT ('radio') FOR [list21FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list21FtType]  DEFAULT ('list') FOR [list21FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list21FtValidation]  DEFAULT ('validate-one-required') FOR [list21FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list22FtClass]  DEFAULT ('inputRadioBig') FOR [list22FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list22FtIncludeDecimal]  DEFAULT ('false') FOR [list22FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list22FtRenderType]  DEFAULT ('radio') FOR [list22FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list22FtType]  DEFAULT ('list') FOR [list22FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list22FtValidation]  DEFAULT ('validate-one-required') FOR [list22FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list23FtClass]  DEFAULT ('inputRadioBig') FOR [list23FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list23FtIncludeDecimal]  DEFAULT ('false') FOR [list23FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list23FtRenderType]  DEFAULT ('radio') FOR [list23FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list23FtType]  DEFAULT ('list') FOR [list23FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list23FtValidation]  DEFAULT ('validate-one-required') FOR [list23FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list31FtClass]  DEFAULT ('inputRadioBig') FOR [list31FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list31FtIncludeDecimal]  DEFAULT ('false') FOR [list31FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list31FtRenderType]  DEFAULT ('radio') FOR [list31FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list31FtType]  DEFAULT ('list') FOR [list31FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list31FtValidation]  DEFAULT ('validate-one-required') FOR [list31FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list32FtClass]  DEFAULT ('inputRadioBig') FOR [list32FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list32FtIncludeDecimal]  DEFAULT ('false') FOR [list32FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list32FtRenderType]  DEFAULT ('radio') FOR [list32FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list32FtType]  DEFAULT ('list') FOR [list32FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list32FtValidation]  DEFAULT ('validate-one-required') FOR [list32FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list33FtClass]  DEFAULT ('inputRadioBig') FOR [list33FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list33FtIncludeDecimal]  DEFAULT ('false') FOR [list33FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list33FtRenderType]  DEFAULT ('radio') FOR [list33FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list33FtType]  DEFAULT ('list') FOR [list33FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list33FtValidation]  DEFAULT ('validate-one-required') FOR [list33FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list41FtClass]  DEFAULT ('inputRadioBig') FOR [list41FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list41FtIncludeDecimal]  DEFAULT ('false') FOR [list41FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list41FtRenderType]  DEFAULT ('radio') FOR [list41FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list41FtType]  DEFAULT ('list') FOR [list41FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list41FtValidation]  DEFAULT ('validate-one-required') FOR [list41FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list42FtClass]  DEFAULT ('inputRadioBig') FOR [list42FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list42FtIncludeDecimal]  DEFAULT ('false') FOR [list42FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list42FtRenderType]  DEFAULT ('radio') FOR [list42FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list42FtType]  DEFAULT ('list') FOR [list42FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list42FtValidation]  DEFAULT ('validate-one-required') FOR [list42FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list43FtClass]  DEFAULT ('inputRadioBig') FOR [list43FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list43FtIncludeDecimal]  DEFAULT ('false') FOR [list43FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list43FtRenderType]  DEFAULT ('radio') FOR [list43FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list43FtType]  DEFAULT ('list') FOR [list43FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list43FtValidation]  DEFAULT ('validate-one-required') FOR [list43FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtClass]  DEFAULT ('inputRadioBig') FOR [list99FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtHint]  DEFAULT ('Choose one') FOR [list99FtHint]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtIncludeDecimal]  DEFAULT ('false') FOR [list99FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtLabel]  DEFAULT ('Rate') FOR [list99FtLabel]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtRenderType]  DEFAULT ('radio') FOR [list99FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtType]  DEFAULT ('list') FOR [list99FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list99FtValidation]  DEFAULT ('validate-one-required') FOR [list99FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepComplete]  DEFAULT ('None') FOR [nextStepComplete]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepEmail]  DEFAULT ('None') FOR [nextStepEmail]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepInteract1]  DEFAULT ('None') FOR [nextStepInteract1]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepInteract2]  DEFAULT ('None') FOR [nextStepInteract2]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepInteract3]  DEFAULT ('None') FOR [nextStepInteract3]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepInteract4]  DEFAULT ('None') FOR [nextStepInteract4]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text11FtValidation]  DEFAULT ('required') FOR [text11FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text12FtValidation]  DEFAULT ('required') FOR [text12FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text13FtValidation]  DEFAULT ('required') FOR [text13FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text21FtValidation]  DEFAULT ('required') FOR [text21FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text22FtValidation]  DEFAULT ('required') FOR [text22FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text23FtValidation]  DEFAULT ('required') FOR [text23FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text31FtValidation]  DEFAULT ('required') FOR [text31FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text32FtValidation]  DEFAULT ('required') FOR [text32FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text33FtValidation]  DEFAULT ('required') FOR [text33FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text41FtValidation]  DEFAULT ('required') FOR [text41FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text42FtValidation]  DEFAULT ('required') FOR [text42FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text43FtValidation]  DEFAULT ('required') FOR [text43FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text99FtHint]  DEFAULT ('Type in the box') FOR [text99FtHint]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepMedia]  DEFAULT ('None') FOR [nextStepMedia]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_releaseMedia]  DEFAULT ('None') FOR [releaseMedia]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleTracker]  DEFAULT ('Done') FOR [buttonDoTitleTracker]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_journalID]  DEFAULT ('D6EA92C0-A790-11DE-AEE4000E0C6C1628') FOR [journalID]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_showJournal]  DEFAULT ((0)) FOR [showJournal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_journalSpot03Button]  DEFAULT ('Done') FOR [journalSpot03Button]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_journalSpot02Button]  DEFAULT ('Done') FOR [journalSpot02Button]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_journalSpot01Button]  DEFAULT ('Done') FOR [journalSpot01Button]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_bOnEndAdvance]  DEFAULT ((0)) FOR [bOnEndAdvance]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleComplete]  DEFAULT ('Next') FOR [buttonDoTitleComplete]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list51FtType]  DEFAULT ('list') FOR [list51FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list51FtClass]  DEFAULT ('inputRadioBig') FOR [list51FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list53FtType]  DEFAULT ('list') FOR [list53FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_type]  DEFAULT ('default') FOR [type]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text51FtValidation]  DEFAULT ('required') FOR [text51FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list52FtRenderType]  DEFAULT ('radio') FOR [list52FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list52FtIncludeDecimal]  DEFAULT ('false') FOR [list52FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list51FtValidation]  DEFAULT ('validate-one-required') FOR [list51FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepInteract5]  DEFAULT ('None') FOR [nextStepInteract5]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list51FtIncludeDecimal]  DEFAULT ('false') FOR [list51FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text52FtValidation]  DEFAULT ('required') FOR [text52FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_buttonDoTitleInteract5]  DEFAULT ('Next') FOR [buttonDoTitleInteract5]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list53FtClass]  DEFAULT ('inputRadioBig') FOR [list53FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list52FtType]  DEFAULT ('list') FOR [list52FtType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list53FtRenderType]  DEFAULT ('radio') FOR [list53FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list52FtClass]  DEFAULT ('inputRadioBig') FOR [list52FtClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list53FtValidation]  DEFAULT ('validate-one-required') FOR [list53FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text53FtValidation]  DEFAULT ('required') FOR [text53FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list53FtIncludeDecimal]  DEFAULT ('false') FOR [list53FtIncludeDecimal]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list52FtValidation]  DEFAULT ('validate-one-required') FOR [list52FtValidation]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_list51FtRenderType]  DEFAULT ('radio') FOR [list51FtRenderType]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_text99FtLabel]  DEFAULT ('Your Comments') FOR [text99FtLabel]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_nextStepRating]  DEFAULT ('None') FOR [nextStepRating]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_broadcastDay]  DEFAULT ((1)) FOR [broadcastDay]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_bActive]  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_showJournalStep]  DEFAULT ('Interact2') FOR [showJournalStep]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[activityDef] ADD  CONSTRAINT [def_activityDef_cuePointTime]  DEFAULT ('00:00:00') FOR [cuePointTime]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT ('modal-sm') FOR [cuePointClass]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT (NULL) FOR [catTopic]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT ('') FOR [cloneActivityDefID]
GO
ALTER TABLE [dbo].[activityDef] ADD  DEFAULT (NULL) FOR [role]
GO
ALTER TABLE [dbo].[activityDef_aCuePointActivities] ADD  CONSTRAINT [def_activityDef_aCuePointActivities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aCuePointActivities] ADD  CONSTRAINT [def_activityDef_aCuePointActivities_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aCuePointActivities] ADD  CONSTRAINT [def_activityDef_aCuePointActivities_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aInteract1Activities] ADD  CONSTRAINT [def_activityDef_aInteract1Activities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aInteract1Activities] ADD  CONSTRAINT [def_activityDef_aInteract1Activities_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aInteract1Activities] ADD  CONSTRAINT [def_activityDef_aInteract1Activities_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aInteract2Activities] ADD  CONSTRAINT [def_activityDef_aInteract2Activities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aInteract2Activities] ADD  CONSTRAINT [def_activityDef_aInteract2Activities_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aInteract2Activities] ADD  CONSTRAINT [def_activityDef_aInteract2Activities_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aInteract3Activities] ADD  CONSTRAINT [def_activityDef_aInteract3Activities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aInteract3Activities] ADD  CONSTRAINT [def_activityDef_aInteract3Activities_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aInteract3Activities] ADD  CONSTRAINT [def_activityDef_aInteract3Activities_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aInteract4Activities] ADD  CONSTRAINT [def_activityDef_aInteract4Activities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aInteract4Activities] ADD  CONSTRAINT [def_activityDef_aInteract4Activities_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aInteract4Activities] ADD  CONSTRAINT [def_activityDef_aInteract4Activities_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aInteract5Activities] ADD  CONSTRAINT [def_activityDef_aInteract5Activities_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aInteract5Activities] ADD  CONSTRAINT [def_activityDef_aInteract5Activities_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aInteract5Activities] ADD  CONSTRAINT [def_activityDef_aInteract5Activities_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[activityDef_aMediaIDs] ADD  CONSTRAINT [def_activityDef_aMediaIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[activityDef_aMediaIDs] ADD  CONSTRAINT [def_activityDef_aMediaIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[activityDef_aMediaIDs] ADD  CONSTRAINT [def_activityDef_aMediaIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_Address1]  DEFAULT (NULL) FOR [Address1]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_Address2]  DEFAULT (NULL) FOR [Address2]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_Address3]  DEFAULT (NULL) FOR [Address3]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_Address4]  DEFAULT (NULL) FOR [Address4]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_datetimecreated]  DEFAULT ('2223-03-19T16:43:04') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:04') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_FirstName]  DEFAULT (NULL) FOR [FirstName]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_LastName]  DEFAULT (NULL) FOR [LastName]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_Postcode]  DEFAULT (NULL) FOR [Postcode]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_country]  DEFAULT (NULL) FOR [country]
GO
ALTER TABLE [dbo].[address] ADD  CONSTRAINT [def_address_memberID]  DEFAULT (NULL) FOR [memberID]
GO
ALTER TABLE [dbo].[address] ADD  DEFAULT (NULL) FOR [dmProfileID]
GO
ALTER TABLE [dbo].[address] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [accessKeySecret]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  CONSTRAINT [def_apiAccessKey_datetimecreated]  DEFAULT ('2223-03-19T16:19:39') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [accessKeyID]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  CONSTRAINT [def_apiAccessKey_datetimelastupdated]  DEFAULT ('2223-03-19T16:19:39') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [accessKey]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [userid]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ((0)) FOR [bJWTverify]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[apiAccessKey] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [state]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_deployment]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_client_secret]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [partnerID]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_client_id]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_authEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_redirect_uri]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_redirect_uri]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_client_id]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [subName]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_authEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [subType]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_client_secret]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_client_secret]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_deployment]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [stage_deployment]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_authEndpoint]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('2223-12-21T15:31:19') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT ('2223-12-21T15:31:19') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [sand_client_id]
GO
ALTER TABLE [dbo].[auth0] ADD  DEFAULT (NULL) FOR [prod_redirect_uri]
GO
ALTER TABLE [dbo].[center] ADD  CONSTRAINT [def_center_datetimecreated]  DEFAULT ('2223-03-19T16:43:07') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[center] ADD  CONSTRAINT [def_center_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:07') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[center] ADD  CONSTRAINT [def_center_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[center] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[center] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[center] ADD  DEFAULT (NULL) FOR [commsLiasonEmail]
GO
ALTER TABLE [dbo].[center] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[center] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[center_aReferers] ADD  CONSTRAINT [def_center_aReferers_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[center_aUsers] ADD  CONSTRAINT [def_center_aUsers_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[container] ADD  CONSTRAINT [def_container_bShared]  DEFAULT ((0)) FOR [bShared]
GO
ALTER TABLE [dbo].[container] ADD  CONSTRAINT [def_container_displayMethod]  DEFAULT (NULL) FOR [displayMethod]
GO
ALTER TABLE [dbo].[container] ADD  CONSTRAINT [def_container_label]  DEFAULT ('(unspecified)') FOR [label]
GO
ALTER TABLE [dbo].[container_aRules] ADD  CONSTRAINT [def_container_aRules_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[container_aRules] ADD  CONSTRAINT [def_container_aRules_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[container_aRules] ADD  CONSTRAINT [def_container_aRules_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [sub]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [DeviceGroupKey]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [DeviceKey]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('2224-08-20T17:17:46') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('2224-08-20T17:17:46') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [DevicePassword]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [DeviceNameDerived]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [lastloginAgent]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [lastloginIP]
GO
ALTER TABLE [dbo].[device] ADD  DEFAULT (NULL) FOR [lastloginDatetime]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_datetimecreated]  DEFAULT ('2223-03-19T17:12:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_datetimelastupdated]  DEFAULT ('2223-03-19T19:37:29') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmArchive] ADD  CONSTRAINT [def_dmArchive_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [objectTypename]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT ((0)) FOR [bDeleted]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [event]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [lRoles]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [ipaddress]
GO
ALTER TABLE [dbo].[dmArchive] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [imgCarouselThumb]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [teaser]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  CONSTRAINT [def_dmCarouselItem_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:06') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [imgSourceID]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [imgCarousel]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [link]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  CONSTRAINT [def_dmCarouselItem_datetimecreated]  DEFAULT ('2223-03-19T16:43:06') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmCarouselItem] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_alias]  DEFAULT (NULL) FOR [alias]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_categoryLabel]  DEFAULT ('') FOR [categoryLabel]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_datetimecreated]  DEFAULT ('2223-03-19T16:43:06') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:06') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_imgCategory]  DEFAULT (NULL) FOR [imgCategory]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmCategory] ADD  CONSTRAINT [def_dmCategory_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmCategory] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_datetimecreated]  DEFAULT ('2223-03-19T17:51:20') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:21') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_endDate]  DEFAULT ('2223-03-19T17:51:21') FOR [endDate]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_frequency]  DEFAULT ('daily') FOR [frequency]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_parameters]  DEFAULT (NULL) FOR [parameters]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_startDate]  DEFAULT ('2223-03-19T17:51:20') FOR [startDate]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_template]  DEFAULT (NULL) FOR [template]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_timeOut]  DEFAULT ((60)) FOR [timeOut]
GO
ALTER TABLE [dbo].[dmCron] ADD  CONSTRAINT [def_dmCron_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmCron] ADD  DEFAULT ((1)) FOR [bAutoStart]
GO
ALTER TABLE [dbo].[dmCron] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_bThisNodeOnly]  DEFAULT ((0)) FOR [bThisNodeOnly]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_datetimecreated]  DEFAULT ('2223-03-19T16:43:05') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:06') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_filename]  DEFAULT (NULL) FOR [filename]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_mediaType]  DEFAULT (NULL) FOR [mediaType]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmCSS] ADD  CONSTRAINT [def_dmCSS_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmCSS] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_bSent]  DEFAULT ((0)) FOR [bSent]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_charset]  DEFAULT ('UTF-8') FOR [charset]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_datetimecreated]  DEFAULT ('2223-03-19T17:27:23') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:24') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_failTo]  DEFAULT (NULL) FOR [failTo]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_fromEmail]  DEFAULT ('') FOR [fromEmail]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_lGroups]  DEFAULT (NULL) FOR [lGroups]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_replyTo]  DEFAULT (NULL) FOR [replyTo]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_Title]  DEFAULT ('') FOR [Title]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_wraptext]  DEFAULT (NULL) FOR [wraptext]
GO
ALTER TABLE [dbo].[dmEmail] ADD  CONSTRAINT [def_dmEmail_catEmail]  DEFAULT (NULL) FOR [catEmail]
GO
ALTER TABLE [dbo].[dmEmail] ADD  DEFAULT (NULL) FOR [datasource]
GO
ALTER TABLE [dbo].[dmEmail] ADD  DEFAULT ('') FOR [fromEmailDisplay]
GO
ALTER TABLE [dbo].[dmEmail] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmEmail_aGroups] ADD  CONSTRAINT [def_dmEmail_aGroups_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmEmail_aGroups] ADD  CONSTRAINT [def_dmEmail_aGroups_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmEmail_aGroups] ADD  CONSTRAINT [def_dmEmail_aGroups_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmEmail_aObjectIDs] ADD  CONSTRAINT [def_dmEmail_aObjectIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmEmail_aObjectIDs] ADD  CONSTRAINT [def_dmEmail_aObjectIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmEmail_aObjectIDs] ADD  CONSTRAINT [def_dmEmail_aObjectIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmEmail_aRelatedIDs] ADD  CONSTRAINT [def_dmEmail_aRelatedIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmEmail_aRelatedIDs] ADD  CONSTRAINT [def_dmEmail_aRelatedIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmEmail_aRelatedIDs] ADD  CONSTRAINT [def_dmEmail_aRelatedIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_catEvent]  DEFAULT (NULL) FOR [catEvent]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_datetimecreated]  DEFAULT ('2223-03-19T17:27:25') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:25') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_displayMethod]  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_endDate]  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_expiryDate]  DEFAULT (NULL) FOR [expiryDate]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_location]  DEFAULT (NULL) FOR [Location]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_publishDate]  DEFAULT (NULL) FOR [publishDate]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_startDate]  DEFAULT (NULL) FOR [startDate]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_teaser]  DEFAULT (NULL) FOR [teaser]
GO
ALTER TABLE [dbo].[dmEvent] ADD  CONSTRAINT [def_dmEvent_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmEvent] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmEvent_aObjectIDs] ADD  CONSTRAINT [def_dmEvent_aObjectIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmEvent_aObjectIDs] ADD  CONSTRAINT [def_dmEvent_aObjectIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmEvent_aObjectIDs] ADD  CONSTRAINT [def_dmEvent_aObjectIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ((0)) FOR [numEvents]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  CONSTRAINT [def_dmEventListing_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:24') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  CONSTRAINT [def_dmEventListing_catCalendar]  DEFAULT (NULL) FOR [catCalendar]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ((0)) FOR [bPagination]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ((0)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  CONSTRAINT [def_dmEventListing_datetimecreated]  DEFAULT ('2223-03-19T17:27:24') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmEventListing] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_datetimecreated]  DEFAULT ('2223-03-19T17:27:25') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:25') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_displayMethod]  DEFAULT (NULL) FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_link]  DEFAULT (NULL) FOR [link]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_status]  DEFAULT ('approved') FOR [status]
GO
ALTER TABLE [dbo].[dmFacts] ADD  CONSTRAINT [def_dmFacts_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [imgThumb]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [faIcon]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [linkText]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [catAimHelpText]
GO
ALTER TABLE [dbo].[dmFacts] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_catFile]  DEFAULT (NULL) FOR [catFile]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_datetimecreated]  DEFAULT ('2223-03-19T17:49:44') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:45') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_filename]  DEFAULT (NULL) FOR [filename]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmFile] ADD  CONSTRAINT [def_dmFile_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmFile] ADD  DEFAULT (NULL) FOR [teaserImage]
GO
ALTER TABLE [dbo].[dmFile] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_bLibrary]  DEFAULT ((1)) FOR [bLibrary]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_catFlash]  DEFAULT (NULL) FOR [catFlash]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_datetimecreated]  DEFAULT ('2223-03-19T17:49:47') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:47') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_displayMethod]  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashAlign]  DEFAULT ('center') FOR [flashAlign]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashBgcolor]  DEFAULT ('#FFFFFF') FOR [flashBgcolor]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashHeight]  DEFAULT ((0)) FOR [flashHeight]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashLoop]  DEFAULT ((0)) FOR [flashLoop]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashMenu]  DEFAULT ((0)) FOR [flashMenu]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashMovie]  DEFAULT (NULL) FOR [flashMovie]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashParams]  DEFAULT (NULL) FOR [flashParams]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashPlay]  DEFAULT ((1)) FOR [flashPlay]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashQuality]  DEFAULT ('high') FOR [flashQuality]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashURL]  DEFAULT (NULL) FOR [flashURL]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashVersion]  DEFAULT ('8,0,0,0') FOR [flashVersion]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_flashWidth]  DEFAULT ((0)) FOR [flashWidth]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_metaKeywords]  DEFAULT (NULL) FOR [metaKeywords]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_status]  DEFAULT (NULL) FOR [status]
GO
ALTER TABLE [dbo].[dmFlash] ADD  CONSTRAINT [def_dmFlash_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmFlash] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_catHTML]  DEFAULT (NULL) FOR [catHTML]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_datetimecreated]  DEFAULT ('2223-03-19T17:51:30') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_datetimelastupdated]  DEFAULT ('2223-03-19T20:26:12') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_displayMethod]  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_reviewDate]  DEFAULT (NULL) FOR [reviewDate]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmHTML] ADD  CONSTRAINT [def_dmHTML_Title]  DEFAULT (NULL) FOR [Title]
GO
ALTER TABLE [dbo].[dmHTML] ADD  DEFAULT (NULL) FOR [seoTitle]
GO
ALTER TABLE [dbo].[dmHTML] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmHTML_aObjectIDs] ADD  CONSTRAINT [def_dmHTML_aObjectIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmHTML_aObjectIDs] ADD  CONSTRAINT [def_dmHTML_aObjectIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmHTML_aObjectIDs] ADD  CONSTRAINT [def_dmHTML_aObjectIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmHTML_aRelatedIDs] ADD  CONSTRAINT [def_dmHTML_aRelatedIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmHTML_aRelatedIDs] ADD  CONSTRAINT [def_dmHTML_aRelatedIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmHTML_aRelatedIDs] ADD  CONSTRAINT [def_dmHTML_aRelatedIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_alt]  DEFAULT (NULL) FOR [alt]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_catImage]  DEFAULT (NULL) FOR [catImage]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_datetimecreated]  DEFAULT ('2223-03-19T17:49:50') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:51') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_SourceImage]  DEFAULT (NULL) FOR [SourceImage]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_StandardImage]  DEFAULT (NULL) FOR [StandardImage]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_ThumbnailImage]  DEFAULT (NULL) FOR [ThumbnailImage]
GO
ALTER TABLE [dbo].[dmImage] ADD  CONSTRAINT [def_dmImage_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmImage] ADD  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[dmImage] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_catInclude]  DEFAULT (NULL) FOR [catInclude]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_datetimecreated]  DEFAULT ('2223-03-19T17:49:54') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:54') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_displayMethod]  DEFAULT (NULL) FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_include]  DEFAULT ('') FOR [include]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_webskin]  DEFAULT (NULL) FOR [webskin]
GO
ALTER TABLE [dbo].[dmInclude] ADD  CONSTRAINT [def_dmInclude_webskinTypename]  DEFAULT (NULL) FOR [webskinTypename]
GO
ALTER TABLE [dbo].[dmInclude] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[dmInclude] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_datetimecreated]  DEFAULT ('2223-03-19T17:50:37') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:38') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_ExternalLink]  DEFAULT (NULL) FOR [ExternalLink]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_fu]  DEFAULT (NULL) FOR [fu]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_lNavIDAlias]  DEFAULT (NULL) FOR [lNavIDAlias]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_options]  DEFAULT (NULL) FOR [options]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  CONSTRAINT [def_dmNavigation_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [internalRedirectID]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [bannerTitle]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [externalRedirectURL]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [sourceImageID]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT ('aObjectIDs') FOR [navType]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [target]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT ((0)) FOR [bBannerBack]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [bannerImage]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [lNavIDRel]
GO
ALTER TABLE [dbo].[dmNavigation] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmNavigation_aObjectIDs] ADD  CONSTRAINT [def_dmNavigation_aObjectIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmNavigation_aObjectIDs] ADD  CONSTRAINT [def_dmNavigation_aObjectIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmNavigation_aObjectIDs] ADD  CONSTRAINT [def_dmNavigation_aObjectIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_datetimecreated]  DEFAULT ('2223-03-19T17:50:40') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:41') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_displayMethod]  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_expiryDate]  DEFAULT (NULL) FOR [expiryDate]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_publishDate]  DEFAULT (NULL) FOR [publishDate]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_source]  DEFAULT (NULL) FOR [source]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_Teaser]  DEFAULT ('') FOR [Teaser]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_teaserImage]  DEFAULT ('') FOR [teaserImage]
GO
ALTER TABLE [dbo].[dmNews] ADD  CONSTRAINT [def_dmNews_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmNews] ADD  DEFAULT ('') FOR [TeaserTitle]
GO
ALTER TABLE [dbo].[dmNews] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmNews_aObjectIds] ADD  CONSTRAINT [def_dmNews_aObjectIds_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmNews_aObjectIds] ADD  CONSTRAINT [def_dmNews_aObjectIds_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmNews_aObjectIds] ADD  CONSTRAINT [def_dmNews_aObjectIds_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmNews_aRelatedIDs] ADD  CONSTRAINT [def_dmNews_aRelatedIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[dmNews_aRelatedIDs] ADD  CONSTRAINT [def_dmNews_aRelatedIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dmNews_aRelatedIDs] ADD  CONSTRAINT [def_dmNews_aRelatedIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  CONSTRAINT [def_dmNewsListing_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:41') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ((0)) FOR [numNews]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ((0)) FOR [bPagination]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ((0)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  CONSTRAINT [def_dmNewsListing_datetimecreated]  DEFAULT ('2223-03-19T17:50:41') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  CONSTRAINT [def_dmNewsListing_catNews]  DEFAULT (NULL) FOR [catNews]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[dmNewsListing] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_bActive]  DEFAULT ((0)) FOR [bActive]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_bReceiveEmail]  DEFAULT ((0)) FOR [bReceiveEmail]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_datetimecreated]  DEFAULT ('2223-03-19T17:51:29') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:29') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_department]  DEFAULT (NULL) FOR [department]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_emailAddress]  DEFAULT ('') FOR [emailAddress]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_firstName]  DEFAULT ('') FOR [firstName]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_lastName]  DEFAULT ('') FOR [lastName]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_locale]  DEFAULT ('en_GB') FOR [locale]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_overviewHome]  DEFAULT (NULL) FOR [overviewHome]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_position]  DEFAULT (NULL) FOR [position]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_userDirectory]  DEFAULT ('') FOR [userDirectory]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_userName]  DEFAULT ('') FOR [userName]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_memberActivityReportFreq]  DEFAULT ('Weekly') FOR [memberActivityReportFreq]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [avatar]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_lastLogin]  DEFAULT (NULL) FOR [lastLogin]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_previousLastLogin]  DEFAULT (NULL) FOR [previousLastLogin]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT ((1)) FOR [bReceiveEmailReports]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [memberGroupID]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_userstatus]  DEFAULT (NULL) FOR [userstatus]
GO
ALTER TABLE [dbo].[dmProfile] ADD  CONSTRAINT [def_dmProfile_FLmostRecentActivity]  DEFAULT (NULL) FOR [FLmostRecentActivity]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [orgRole]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT ((0)) FOR [bEmailSuspended]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT ('12h') FOR [timeFormat]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [mappedID]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [identityProvider]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [farUserID]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [TOTP]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT ((0)) FOR [bEmailValidated]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT ((0)) FOR [bPhoneValidated]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [TOTPtimeout]
GO
ALTER TABLE [dbo].[dmProfile] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [linkURL]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmTout] ADD  CONSTRAINT [def_dmTout_teaser]  DEFAULT (NULL) FOR [teaser]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmTout] ADD  CONSTRAINT [def_dmTout_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:25') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [link]
GO
ALTER TABLE [dbo].[dmTout] ADD  CONSTRAINT [def_dmTout_datetimecreated]  DEFAULT ('2223-03-19T17:51:25') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [linkLabel]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[dmTout] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_ancestorID]  DEFAULT ('') FOR [ancestorID]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_ancestorTemplate]  DEFAULT ('') FOR [ancestorTemplate]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_ancestorTypename]  DEFAULT ('') FOR [ancestorTypename]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_datetimecreated]  DEFAULT ('2223-03-19T17:51:33') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_webskinObjectID]  DEFAULT ('') FOR [webskinObjectID]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_webskinTemplate]  DEFAULT (NULL) FOR [webskinTemplate]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  CONSTRAINT [def_dmWebskinAncestor_webskinTypename]  DEFAULT (NULL) FOR [webskinTypename]
GO
ALTER TABLE [dbo].[dmWebskinAncestor] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_CurrentStep]  DEFAULT ((1)) FOR [CurrentStep]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_datetimecreated]  DEFAULT ('2223-03-19T17:51:36') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:37') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_ReferenceID]  DEFAULT ('') FOR [ReferenceID]
GO
ALTER TABLE [dbo].[dmWizard] ADD  CONSTRAINT [def_dmWizard_UserLogin]  DEFAULT (NULL) FOR [UserLogin]
GO
ALTER TABLE [dbo].[dmWizard] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('Delivery') FOR [addressType]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  CONSTRAINT [def_dont_use___member_aAddresses_datetimecreated]  DEFAULT ('2223-03-19T17:51:38') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  CONSTRAINT [def_dont_use___member_aAddresses_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:38') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('') FOR [parentID]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('') FOR [data]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[dont_use___member_aAddresses] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_barnaclevalue]  DEFAULT ((0)) FOR [barnaclevalue]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_datetimecreated]  DEFAULT ('2223-03-19T16:43:04') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:05') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_objecttype]  DEFAULT (NULL) FOR [objecttype]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  CONSTRAINT [def_farBarnacle_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farBarnacle] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_datetimecreated]  DEFAULT ('2223-03-19T17:27:26') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:26') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_name]  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farCoapi] ADD  CONSTRAINT [def_farCoapi_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farCoapi] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_configkey]  DEFAULT (NULL) FOR [configkey]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_datetimecreated]  DEFAULT ('2223-03-19T16:43:07') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_datetimelastupdated]  DEFAULT ('2223-03-19T16:43:08') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farConfig] ADD  CONSTRAINT [def_farConfig_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farConfig] ADD  DEFAULT (NULL) FOR [configtypename]
GO
ALTER TABLE [dbo].[farConfig] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farFeedback] ADD  CONSTRAINT [def_farFeedback_datetimecreated]  DEFAULT ('2223-03-19T17:49:41') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farFeedback] ADD  CONSTRAINT [def_farFeedback_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:41') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farFeedback] ADD  CONSTRAINT [def_farFeedback_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farFeedback] ADD  DEFAULT ((0)) FOR [bJoinMailing]
GO
ALTER TABLE [dbo].[farFeedback] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [profileID]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farFilter] ADD  CONSTRAINT [def_farFilter_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:22') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [lRoles]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [listID]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [filterTypename]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farFilter] ADD  CONSTRAINT [def_farFilter_datetimecreated]  DEFAULT ('2223-03-19T17:27:21') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farFilter] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [property]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  CONSTRAINT [def_farFilterProperty_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:46') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [filterID]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  CONSTRAINT [def_farFilterProperty_datetimecreated]  DEFAULT ('2223-03-19T17:49:45') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [type]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farFilterProperty] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farFilterProperty_aRelated] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farFilterProperty_aRelated] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[farFilterProperty_aRelated] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farFilterProperty_aRelated] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_applicationName]  DEFAULT (NULL) FOR [applicationName]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_bDefault]  DEFAULT ((0)) FOR [bDefault]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_datetimecreated]  DEFAULT ('2223-03-19T17:27:26') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_datetimelastupdated]  DEFAULT ('2223-03-19T17:27:26') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_friendlyURL]  DEFAULT (NULL) FOR [friendlyURL]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_queryString]  DEFAULT (NULL) FOR [queryString]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_redirectionType]  DEFAULT (NULL) FOR [redirectionType]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_redirectTo]  DEFAULT (NULL) FOR [redirectTo]
GO
ALTER TABLE [dbo].[farFU] ADD  CONSTRAINT [def_farFU_refobjectid]  DEFAULT (NULL) FOR [refobjectid]
GO
ALTER TABLE [dbo].[farFU] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_datetimecreated]  DEFAULT ('2223-03-19T17:49:48') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:48') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farGroup] ADD  CONSTRAINT [def_farGroup_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farGroup] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [imgCoverSourceID]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  CONSTRAINT [def_farImageGallery_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:52') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [SourceID]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [imgCover]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  CONSTRAINT [def_farImageGallery_datetimecreated]  DEFAULT ('2223-03-19T17:49:51') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farImageGallery] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farImageGallery_aImage] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farImageGallery_aImage] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farImageGallery_aImage] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[farImageGallery_aImage] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  CONSTRAINT [def_farImageGalleryListing_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:54') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ('displayPageStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  CONSTRAINT [def_farImageGalleryListing_datetimecreated]  DEFAULT ('2223-03-19T17:49:53') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farImageGalleryListing] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_datetimecreated]  DEFAULT ('2223-03-19T20:13:33') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:29') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_event]  DEFAULT (NULL) FOR [event]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_ipaddress]  DEFAULT (NULL) FOR [ipaddress]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_location]  DEFAULT (NULL) FOR [location]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_type]  DEFAULT (NULL) FOR [type]
GO
ALTER TABLE [dbo].[farLog] ADD  CONSTRAINT [def_farLog_userid]  DEFAULT (NULL) FOR [userid]
GO
ALTER TABLE [dbo].[farLog] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_aRoles]  DEFAULT (NULL) FOR [aRoles]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_datetimecreated]  DEFAULT ('2223-03-19T17:50:54') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:54') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_shortcut]  DEFAULT (NULL) FOR [shortcut]
GO
ALTER TABLE [dbo].[farPermission] ADD  CONSTRAINT [def_farPermission_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farPermission] ADD  DEFAULT ((0)) FOR [bSystem]
GO
ALTER TABLE [dbo].[farPermission] ADD  DEFAULT ((0)) FOR [bDisabled]
GO
ALTER TABLE [dbo].[farPermission] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farPermission_aRelatedtypes] ADD  CONSTRAINT [def_farPermission_aRelatedtypes_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farPermission_aRelatedtypes] ADD  CONSTRAINT [def_farPermission_aRelatedtypes_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farPermission_aRelatedtypes] ADD  CONSTRAINT [def_farPermission_aRelatedtypes_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  CONSTRAINT [def_farQueueResult_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:05') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [jobID]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT ((0)) FOR [resultTick]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [taskOwnedBy]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  CONSTRAINT [def_farQueueResult_datetimecreated]  DEFAULT ('2223-03-19T17:51:05') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  CONSTRAINT [def_farQueueResult_jobType]  DEFAULT ('Unknown') FOR [jobType]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [taskID]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  CONSTRAINT [def_farQueueResult_resultTimestamp]  DEFAULT (NULL) FOR [resultTimestamp]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farQueueResult] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  CONSTRAINT [def_farQueueTask_taskTimestamp]  DEFAULT (NULL) FOR [taskTimestamp]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [jobID]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  CONSTRAINT [def_farQueueTask_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:07') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [taskOwnedBy]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [threadID]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  CONSTRAINT [def_farQueueTask_datetimecreated]  DEFAULT ('2223-03-19T17:51:07') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT ('Unkown') FOR [jobType]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [action]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [taskStatus]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT ('') FOR [objectid]
GO
ALTER TABLE [dbo].[farQueueTask] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_datetimecreated]  DEFAULT ('2223-03-19T17:51:13') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:14') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_isdefault]  DEFAULT ((0)) FOR [isdefault]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farRole] ADD  CONSTRAINT [def_farRole_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farRole] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farRole_aGroups] ADD  CONSTRAINT [def_farRole_aGroups_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farRole_aGroups] ADD  CONSTRAINT [def_farRole_aGroups_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farRole_aGroups] ADD  CONSTRAINT [def_farRole_aGroups_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farRole_aPermissions] ADD  CONSTRAINT [def_farRole_aPermissions_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farRole_aPermissions] ADD  CONSTRAINT [def_farRole_aPermissions_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farRole_aPermissions] ADD  CONSTRAINT [def_farRole_aPermissions_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_bComplete]  DEFAULT ((0)) FOR [bComplete]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_datetimecreated]  DEFAULT ('2223-03-19T17:49:35') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:35') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_taskWebskin]  DEFAULT (NULL) FOR [taskWebskin]
GO
ALTER TABLE [dbo].[farTask] ADD  CONSTRAINT [def_farTask_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farTask] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_datetimecreated]  DEFAULT ('2223-03-19T17:49:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_taskWebskin]  DEFAULT (NULL) FOR [taskWebskin]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  CONSTRAINT [def_farTaskDef_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farTaskDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farTaskDef_aRoles] ADD  CONSTRAINT [def_farTaskDef_aRoles_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farTaskDef_aRoles] ADD  CONSTRAINT [def_farTaskDef_aRoles_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farTaskDef_aRoles] ADD  CONSTRAINT [def_farTaskDef_aRoles_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_datetimecreated]  DEFAULT ('2223-03-19T17:49:37') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:37') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_password]  DEFAULT ('xxxxxxxx') FOR [password]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_userid]  DEFAULT (NULL) FOR [userid]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_userstatus]  DEFAULT ('pending') FOR [userstatus]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT (NULL) FOR [forgotPasswordHash]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT ((0)) FOR [bCPL]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT ((0)) FOR [bCognito]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT ((0)) FOR [bSSOonly]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_MFAtype]  DEFAULT (NULL) FOR [MFAtype]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT ((0)) FOR [bPasswordUpgraded]
GO
ALTER TABLE [dbo].[farUser] ADD  CONSTRAINT [def_farUser_bSoftwareMFAsetup]  DEFAULT ((0)) FOR [bSoftwareMFAsetup]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT (NULL) FOR [sub]
GO
ALTER TABLE [dbo].[farUser] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farUser_aGroups] ADD  CONSTRAINT [def_farUser_aGroups_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farUser_aGroups] ADD  CONSTRAINT [def_farUser_aGroups_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farUser_aGroups] ADD  CONSTRAINT [def_farUser_aGroups_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_atomicon]  DEFAULT (NULL) FOR [atomicon]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_bAuthor]  DEFAULT ((0)) FOR [bAuthor]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_contentproperty]  DEFAULT ('teaser') FOR [contentproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_copyright]  DEFAULT (NULL) FOR [copyright]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_dateproperty]  DEFAULT ('datetimecreated') FOR [dateproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_datetimecreated]  DEFAULT ('2223-03-19T17:51:31') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:32') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_description]  DEFAULT (NULL) FOR [description]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_directory]  DEFAULT (NULL) FOR [directory]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_editor]  DEFAULT (NULL) FOR [editor]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_editoremail]  DEFAULT (NULL) FOR [editoremail]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_enclosurefileproperty]  DEFAULT (NULL) FOR [enclosurefileproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_feedimage]  DEFAULT (NULL) FOR [feedimage]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_generator]  DEFAULT ('http://www.farcrycms.org/') FOR [generator]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itemtype]  DEFAULT (NULL) FOR [itemtype]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itunesauthor]  DEFAULT (NULL) FOR [itunesauthor]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itunescategories]  DEFAULT (NULL) FOR [itunescategories]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itunesdurationproperty]  DEFAULT (NULL) FOR [itunesdurationproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itunesimage]  DEFAULT (NULL) FOR [itunesimage]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_itunessubtitleproperty]  DEFAULT (NULL) FOR [itunessubtitleproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_keywords]  DEFAULT (NULL) FOR [keywords]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_keywordsproperty]  DEFAULT (NULL) FOR [keywordsproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_language]  DEFAULT (NULL) FOR [language]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_skipdays]  DEFAULT (NULL) FOR [skipdays]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_skiphours]  DEFAULT (NULL) FOR [skiphours]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_subtitle]  DEFAULT (NULL) FOR [subtitle]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_titleproperty]  DEFAULT ('title') FOR [titleproperty]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  CONSTRAINT [def_farWebfeed_url]  DEFAULT (NULL) FOR [url]
GO
ALTER TABLE [dbo].[farWebfeed] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  CONSTRAINT [def_farWebtopDashboard_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  CONSTRAINT [def_farWebtopDashboard_datetimecreated]  DEFAULT ('2223-03-19T17:51:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ((0)) FOR [bShowInSubNav]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT ((50)) FOR [seq]
GO
ALTER TABLE [dbo].[farWebtopDashboard] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farWebtopDashboard_aRoles] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farWebtopDashboard_aRoles] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farWebtopDashboard_aRoles] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[farWebtopDashboard_aRoles] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_bActive]  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_bTasksComplete]  DEFAULT ((0)) FOR [bTasksComplete]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_bWorkflowComplete]  DEFAULT ((0)) FOR [bWorkflowComplete]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_bWorkflowSetupComplete]  DEFAULT ((0)) FOR [bWorkflowSetupComplete]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_completionDate]  DEFAULT (NULL) FOR [completionDate]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_datetimecreated]  DEFAULT ('2223-03-19T17:49:38') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:39') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  CONSTRAINT [def_farWorkflow_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farWorkflow] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farWorkflow_aTaskIDs] ADD  CONSTRAINT [def_farWorkflow_aTaskIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farWorkflow_aTaskIDs] ADD  CONSTRAINT [def_farWorkflow_aTaskIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farWorkflow_aTaskIDs] ADD  CONSTRAINT [def_farWorkflow_aTaskIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_datetimecreated]  DEFAULT ('2223-03-19T17:49:33') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:33') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_workflowEnd]  DEFAULT (NULL) FOR [workflowEnd]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  CONSTRAINT [def_farWorkflowDef_workflowStart]  DEFAULT (NULL) FOR [workflowStart]
GO
ALTER TABLE [dbo].[farWorkflowDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[farWorkflowDef_aTaskDefs] ADD  CONSTRAINT [def_farWorkflowDef_aTaskDefs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[farWorkflowDef_aTaskDefs] ADD  CONSTRAINT [def_farWorkflowDef_aTaskDefs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[farWorkflowDef_aTaskDefs] ADD  CONSTRAINT [def_farWorkflowDef_aTaskDefs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[fqAudit] ADD  CONSTRAINT [def_fqAudit_datetimeStamp]  DEFAULT (NULL) FOR [datetimeStamp]
GO
ALTER TABLE [dbo].[fqAudit] ADD  CONSTRAINT [def_fqAudit_username]  DEFAULT ('') FOR [username]
GO
ALTER TABLE [dbo].[fqAudit] ADD  CONSTRAINT [def_fqAudit_location]  DEFAULT ('') FOR [location]
GO
ALTER TABLE [dbo].[fqAudit] ADD  CONSTRAINT [def_fqAudit_auditType]  DEFAULT (NULL) FOR [auditType]
GO
ALTER TABLE [dbo].[fqAudit] ADD  CONSTRAINT [def_fqAudit_note]  DEFAULT (NULL) FOR [note]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_centerID]  DEFAULT ('') FOR [centerID]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_datetimecreated]  DEFAULT ('2223-03-19T17:49:49') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:49') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_firstname]  DEFAULT ('') FOR [firstname]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_gender]  DEFAULT ('') FOR [gender]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_lastname]  DEFAULT ('') FOR [lastname]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_partnerID]  DEFAULT ('') FOR [partnerID]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_salutation]  DEFAULT (NULL) FOR [salutation]
GO
ALTER TABLE [dbo].[guide] ADD  CONSTRAINT [def_guide_position]  DEFAULT ('') FOR [position]
GO
ALTER TABLE [dbo].[guide] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_datetimecreated]  DEFAULT ('2223-03-19T17:49:56') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:56') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_label]  DEFAULT ('intake') FOR [label]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_memberGroupID]  DEFAULT ('') FOR [memberGroupID]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_places]  DEFAULT ((0)) FOR [places]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[intake] ADD  DEFAULT ((0)) FOR [bIAPTUS]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_placesMinLimit]  DEFAULT ((5)) FOR [placesMinLimit]
GO
ALTER TABLE [dbo].[intake] ADD  DEFAULT ((1)) FOR [bLimited]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_startDate]  DEFAULT (NULL) FOR [startDate]
GO
ALTER TABLE [dbo].[intake] ADD  DEFAULT ((30)) FOR [daysMinLimit]
GO
ALTER TABLE [dbo].[intake] ADD  CONSTRAINT [def_intake_endDate]  DEFAULT (NULL) FOR [endDate]
GO
ALTER TABLE [dbo].[intake] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[intake_aMembers] ADD  CONSTRAINT [def_intake_aMembers_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[intake_aMembers] ADD  CONSTRAINT [def_intake_aMembers_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[intake_aMembers] ADD  CONSTRAINT [def_intake_aMembers_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_datetimecreated]  DEFAULT ('2223-03-19T17:50:04') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:06') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[journal] ADD  CONSTRAINT [def_journal_trackerID]  DEFAULT (NULL) FOR [trackerID]
GO
ALTER TABLE [dbo].[journal] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_buttonDoTitleJournal]  DEFAULT ('Save') FOR [buttonDoTitleJournal]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_datetimecreated]  DEFAULT ('2223-03-19T17:49:57') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_datetimelastupdated]  DEFAULT ('2223-03-19T17:49:58') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtClass]  DEFAULT ('journalEntry') FOR [journalEntry01FtClass]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtDefault]  DEFAULT (NULL) FOR [journalEntry01FtDefault]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtHelpSection]  DEFAULT (NULL) FOR [journalEntry01FtHelpSection]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtHint]  DEFAULT (NULL) FOR [journalEntry01FtHint]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtLabel]  DEFAULT (NULL) FOR [journalEntry01FtLabel]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtStyle]  DEFAULT (NULL) FOR [journalEntry01FtStyle]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry01FtValidation]  DEFAULT ('validate-required') FOR [journalEntry01FtValidation]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtClass]  DEFAULT ('journalEntry') FOR [journalEntry02FtClass]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtDefault]  DEFAULT (NULL) FOR [journalEntry02FtDefault]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtHelpSection]  DEFAULT (NULL) FOR [journalEntry02FtHelpSection]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtHint]  DEFAULT (NULL) FOR [journalEntry02FtHint]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtLabel]  DEFAULT (NULL) FOR [journalEntry02FtLabel]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtStyle]  DEFAULT (NULL) FOR [journalEntry02FtStyle]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry02FtValidation]  DEFAULT ('validate-required') FOR [journalEntry02FtValidation]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtClass]  DEFAULT ('journalEntry') FOR [journalEntry03FtClass]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtDefault]  DEFAULT (NULL) FOR [journalEntry03FtDefault]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtHelpSection]  DEFAULT (NULL) FOR [journalEntry03FtHelpSection]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtHint]  DEFAULT (NULL) FOR [journalEntry03FtHint]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtLabel]  DEFAULT (NULL) FOR [journalEntry03FtLabel]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtStyle]  DEFAULT (NULL) FOR [journalEntry03FtStyle]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry03FtValidation]  DEFAULT ('validate-required') FOR [journalEntry03FtValidation]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtClass]  DEFAULT ('journalEntry') FOR [journalEntry04FtClass]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtDefault]  DEFAULT (NULL) FOR [journalEntry04FtDefault]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtHelpSection]  DEFAULT (NULL) FOR [journalEntry04FtHelpSection]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtHint]  DEFAULT (NULL) FOR [journalEntry04FtHint]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtLabel]  DEFAULT (NULL) FOR [journalEntry04FtLabel]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtStyle]  DEFAULT (NULL) FOR [journalEntry04FtStyle]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_journalEntry04FtValidation]  DEFAULT ('validate-required') FOR [journalEntry04FtValidation]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_programmeID]  DEFAULT ('') FOR [programmeID]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_tracker01Title]  DEFAULT (NULL) FOR [tracker01Title]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_tracker02Title]  DEFAULT (NULL) FOR [tracker02Title]
GO
ALTER TABLE [dbo].[journalDef] ADD  CONSTRAINT [def_journalDef_tracker02ID]  DEFAULT (NULL) FOR [tracker02ID]
GO
ALTER TABLE [dbo].[journalDef] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[journalDef] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[journalDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [location]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [environment]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('client_credentials') FOR [grant_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [aud]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('NHS Developer') FOR [type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [KID]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('urn:ietf:params:oauth:client-assertion-type:jwt-bearer') FOR [client_assertion_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [callbackURL]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [APIkey]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [JWKSEndpoint]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('2223-04-30T14:44:44') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('2223-04-30T14:44:44') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('RS512') FOR [alg]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [applicationID]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseExp]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseSub]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('RSA') FOR [algType]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseGrant_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseJti]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('APIkey') FOR [IssField]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseAud]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('grant_type') FOR [strGrant_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('APIkey') FOR [SubField]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseKid]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseClient_assertion_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ((1)) FOR [bUseIss]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('client_assertion') FOR [strClient_assertion]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT ('client_assertion') FOR [strClient_assertion_type]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [JWTtokenName]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [ISS]
GO
ALTER TABLE [dbo].[JWTapp] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[landingPage] ADD  CONSTRAINT [def_landingPage_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:06') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[landingPage] ADD  CONSTRAINT [def_landingPage_datetimecreated]  DEFAULT ('2223-03-19T17:50:06') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [seoTitle]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[landingPage] ADD  CONSTRAINT [def_landingPage_extendedmetadata]  DEFAULT (NULL) FOR [extendedmetadata]
GO
ALTER TABLE [dbo].[landingPage] ADD  CONSTRAINT [def_landingPage_metaKeywords]  DEFAULT (NULL) FOR [metaKeywords]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[landingPage] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[landingPage_aCarouselItems] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[landingPage_aCarouselItems] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[landingPage_aCarouselItems] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[landingPage_aCarouselItems] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[landingPage_aTouts] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[landingPage_aTouts] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[landingPage_aTouts] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[landingPage_aTouts] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [memberID]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [emailfrom]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [organisation]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [name]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [rating]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [subject]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('2224-08-18T14:58:13') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ((0)) FOR [bJoinMailing]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('2224-08-18T14:58:13') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [emailto]
GO
ALTER TABLE [dbo].[lead] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_datetimecreated]  DEFAULT ('2223-03-19T17:50:18') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:19') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[library] ADD  CONSTRAINT [def_library_new]  DEFAULT ((1)) FOR [new]
GO
ALTER TABLE [dbo].[library] ADD  DEFAULT (NULL) FOR [rating]
GO
ALTER TABLE [dbo].[library] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_datetimecreated]  DEFAULT ('2223-03-19T17:50:20') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:20') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_partnerID]  DEFAULT ('B9035950-6496-11DE-BA1E000E0C6C1628') FOR [partnerID]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_programmeID]  DEFAULT ('') FOR [programmeID]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_type]  DEFAULT ('MP4') FOR [type]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_library]  DEFAULT ((0)) FOR [library]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_releaseOnStep]  DEFAULT ((0)) FOR [releaseOnStep]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_dynamicPDF]  DEFAULT ((0)) FOR [dynamicPDF]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_guideID]  DEFAULT ('2F5F77F0-4BAF-11DF-9E8B000E0C6C1628') FOR [guideID]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_ratingCount]  DEFAULT ((0)) FOR [ratingCount]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_free]  DEFAULT ((0)) FOR [free]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_ratingSum]  DEFAULT ((0)) FOR [ratingSum]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_libraryType]  DEFAULT ('false') FOR [libraryType]
GO
ALTER TABLE [dbo].[media] ADD  CONSTRAINT [def_media_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bHasCaptions]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT (NULL) FOR [seriesNum]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bHasThumbs]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bHasChapters]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bCanShare]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bHasTranscript]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ((0)) FOR [bShowAssistive]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ('') FOR [cloneMediaID]
GO
ALTER TABLE [dbo].[media] ADD  DEFAULT ('1C610CA0-6568-11DE-8693000E0C6C1628') FOR [roleID]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_consent]  DEFAULT ((0)) FOR [consent]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_datetimecreated]  DEFAULT ('2223-03-19T20:23:51') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_datetimelastupdated]  DEFAULT ('2223-03-19T20:23:52') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_firstname]  DEFAULT (NULL) FOR [firstname]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_gender]  DEFAULT (NULL) FOR [gender]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_lastname]  DEFAULT (NULL) FOR [lastname]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_otherID]  DEFAULT (NULL) FOR [otherID]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_salutation]  DEFAULT (NULL) FOR [salutation]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_username]  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_password]  DEFAULT (NULL) FOR [password]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bActivated]  DEFAULT ((0)) FOR [bActivated]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_email]  DEFAULT (NULL) FOR [email]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_referrer]  DEFAULT (NULL) FOR [referrer]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_selfPaid]  DEFAULT ((0)) FOR [selfPaid]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_country]  DEFAULT (NULL) FOR [country]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_phone]  DEFAULT (NULL) FOR [phone]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_paymentMade]  DEFAULT ((0)) FOR [paymentMade]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_paymentCurrency]  DEFAULT (NULL) FOR [paymentCurrency]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_paymentAmount]  DEFAULT (NULL) FOR [paymentAmount]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_promoCode]  DEFAULT (NULL) FOR [promoCode]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_mailingList]  DEFAULT ((1)) FOR [mailingList]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bAfterCarePosted]  DEFAULT ((0)) FOR [bAfterCarePosted]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_refunded]  DEFAULT ((0)) FOR [refunded]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bSuspended]  DEFAULT ((0)) FOR [bSuspended]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_centerID]  DEFAULT (NULL) FOR [centerID]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_refererID]  DEFAULT (NULL) FOR [refererID]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bCompleted]  DEFAULT ((0)) FOR [bCompleted]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_dept]  DEFAULT (NULL) FOR [dept]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_position]  DEFAULT (NULL) FOR [position]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_nhsNumber]  DEFAULT (NULL) FOR [nhsNumber]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_IAPTUSreferralId]  DEFAULT (NULL) FOR [IAPTUSreferralId]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_IAPTUSreferrerId]  DEFAULT (NULL) FOR [IAPTUSreferrerId]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_IAPTUSpatientId]  DEFAULT (NULL) FOR [IAPTUSpatientId]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_IAPTUSreferralDate]  DEFAULT (NULL) FOR [IAPTUSreferralDate]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bMHFconsent]  DEFAULT ((0)) FOR [bMHFconsent]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [creditcardnumber]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [creditcardexpiry]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [creditcardtype]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [PPresultStr]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [resetKey]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [creditcardcvv]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bSocialPublish]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bDownload]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [PPtransID]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [IAPTUStherapistId]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ('0') FOR [daysLastNagged]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_dateLastNagged]  DEFAULT (NULL) FOR [dateLastNagged]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_dateCreatedFake]  DEFAULT (NULL) FOR [dateCreatedFake]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_previousLastLogin]  DEFAULT (NULL) FOR [previousLastLogin]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_lastLogin]  DEFAULT (NULL) FOR [lastLogin]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_courseCompleted]  DEFAULT (NULL) FOR [courseCompleted]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_courseActivated]  DEFAULT (NULL) FOR [courseActivated]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_courseStarted]  DEFAULT (NULL) FOR [courseStarted]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bPaused]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [activityDefID]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_courseFollowedUp]  DEFAULT (NULL) FOR [courseFollowedUp]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bCourseFollowedUp]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [giverEmail]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_giftDate]  DEFAULT (NULL) FOR [giftDate]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bGift]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [giverName]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_bRememberme]  DEFAULT ('0') FOR [bRememberme]
GO
ALTER TABLE [dbo].[member] ADD  CONSTRAINT [def_member_FLmostRecentActivity]  DEFAULT (NULL) FOR [FLmostRecentActivity]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [suspensionReason]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bRetired]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [ssoID]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [ssoIDP]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [ssoIDhashed]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [sub]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [DOB]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ((0)) FOR [bAssistive]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ('') FOR [progRoleVia]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[member] ADD  DEFAULT (NULL) FOR [roleID]
GO
ALTER TABLE [dbo].[member_aAddresses] ADD  CONSTRAINT [def_member_aAddresses_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[member_aAddresses] ADD  CONSTRAINT [def_member_aAddresses_seq]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[member_aAddresses] ADD  CONSTRAINT [def_member_aAddresses_typename]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[member_aOrderIDs] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[member_aOrderIDs] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[member_aOrderIDs] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[member_aOrderIDs] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_datetimecreated]  DEFAULT ('2223-03-19T17:50:32') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:33') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_Label]  DEFAULT ('') FOR [label]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_coordinatorEmail]  DEFAULT (NULL) FOR [coordinatorEmail]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_partnerID]  DEFAULT ('') FOR [partnerID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_URL]  DEFAULT ('http://') FOR [URL]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_createEmailSubject]  DEFAULT (NULL) FOR [createEmailSubject]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_bShowPublic]  DEFAULT ((0)) FOR [bShowPublic]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_emailAllocation]  DEFAULT ('1') FOR [emailAllocation]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_lSSQpoints]  DEFAULT (NULL) FOR [lSSQpoints]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bIAPTUS]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_bMDS]  DEFAULT ((0)) FOR [bMDS]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [IAPTUSid]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_bAftercare]  DEFAULT ((0)) FOR [bAftercare]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bShowLogo]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [resourcePosterID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [resourceHandoutID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [UtmSourceID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [lMemberProps]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [include]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [lMemberPropsActivate]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((1)) FOR [bOneMonthFollowUp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bDummy]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bShowPHQ0909]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bDefault]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_bHealthcare]  DEFAULT ((0)) FOR [bHealthcare]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [selfRegNavID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bApiAccess]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bResearch]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ('') FOR [emailSubjectActivatePortal]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [selfRegQrFileID]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((1)) FOR [bAnnualFollowUp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [commsLiasonEmail]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bSSQComp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bTrackersComp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((1)) FOR [bAllowRememberMe]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bSSQ]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bTrackers]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bNHS]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bBusdev]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bDemo]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bPSEQ]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bODI]
GO
ALTER TABLE [dbo].[memberGroup] ADD  CONSTRAINT [def_memberGroup_bMSKHQ]  DEFAULT ((0)) FOR [bMSKHQ]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((1)) FOR [bSixMonthFollowUp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((1)) FOR [bThreeMonthFollowUp]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [xealthDeployment]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ((0)) FOR [bXealth]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[memberGroup] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[memberGroup_aFarcryUsers] ADD  CONSTRAINT [def_memberGroup_aFarcryUsers_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[memberGroup_aFarcryUsers] ADD  CONSTRAINT [def_memberGroup_aFarcryUsers_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[memberGroup_aFarcryUsers] ADD  CONSTRAINT [def_memberGroup_aFarcryUsers_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_datetimecreated]  DEFAULT ('2223-03-19T17:50:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_Title]  DEFAULT (NULL) FOR [Title]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_bBroadcaster]  DEFAULT ((0)) FOR [bBroadcaster]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_bNavTools]  DEFAULT ((0)) FOR [bNavTools]
GO
ALTER TABLE [dbo].[memberType] ADD  CONSTRAINT [def_memberType_bSimpleNavTools]  DEFAULT ((0)) FOR [bSimpleNavTools]
GO
ALTER TABLE [dbo].[memberType] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_bActive]  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_bActivitysComplete]  DEFAULT ((0)) FOR [bActivitysComplete]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_bModuleComplete]  DEFAULT ((0)) FOR [bModuleComplete]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_bModuleSetupComplete]  DEFAULT ((0)) FOR [bModuleSetupComplete]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_datetimecreated]  DEFAULT ('2223-03-19T17:50:35') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:36') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[module] ADD  CONSTRAINT [def_module_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[module] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[module_aActivityIDs] ADD  CONSTRAINT [def_module_aActivityIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[module_aActivityIDs] ADD  CONSTRAINT [def_module_aActivityIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[module_aActivityIDs] ADD  CONSTRAINT [def_module_aActivityIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_datetimecreated]  DEFAULT ('2223-03-19T17:50:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:35') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_lTypenames]  DEFAULT (NULL) FOR [lTypenames]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_moduleEnd]  DEFAULT (NULL) FOR [moduleEnd]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_moduleStart]  DEFAULT (NULL) FOR [moduleStart]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[moduleDef] ADD  CONSTRAINT [def_moduleDef_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[moduleDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[nested_tree_objects] ADD  CONSTRAINT [def_nested_tree_objects_objectid]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[nested_tree_objects] ADD  CONSTRAINT [def_nested_tree_objects_parentid]  DEFAULT (NULL) FOR [ParentID]
GO
ALTER TABLE [dbo].[nested_tree_objects] ADD  CONSTRAINT [def_nested_tree_objects_objectname]  DEFAULT ('') FOR [ObjectName]
GO
ALTER TABLE [dbo].[nested_tree_objects] ADD  CONSTRAINT [def_nested_tree_objects_typename]  DEFAULT ('') FOR [TypeName]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [redirect_uri]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [accessTokenEndpoint]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[oauth2] ADD  CONSTRAINT [def_oauth2_datetimecreated]  DEFAULT ('2223-03-19T17:51:38') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [authEndpoint]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [client_id]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[oauth2] ADD  CONSTRAINT [def_oauth2_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:39') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT (NULL) FOR [client_secret]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[oauth2] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [redirect_uri]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [accessTokenEndpoint]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [authEndpoint]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  CONSTRAINT [def_oauth2Facebook_datetimecreated]  DEFAULT ('2223-03-19T17:51:39') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [client_id]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  CONSTRAINT [def_oauth2Facebook_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:39') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT (NULL) FOR [client_secret]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[oauth2Facebook] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [state]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_deployment]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_client_secret]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [partnerID]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_client_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ((1)) FOR [bActive]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_authEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_redirect_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_redirect_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_client_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [subName]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_authEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [subType]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_accessTokenEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_client_secret]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_client_secret]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_deployment]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_deployment]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_authEndpoint]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('2223-12-30T13:30:07') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT ('2223-12-30T13:30:07') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_client_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_redirect_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [JWTappID]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_logout_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_logout_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_logout_uri]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_scope]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_scope]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_scope]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [prod_userpool_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [sand_userpool_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [stage_userpool_id]
GO
ALTER TABLE [dbo].[oAuth2service] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ('') FOR [shopItemID]
GO
ALTER TABLE [dbo].[orderItem] ADD  CONSTRAINT [def_orderItem_datetimecreated]  DEFAULT ('2223-03-19T17:50:46') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[orderItem] ADD  CONSTRAINT [def_orderItem_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:47') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT ('1') FOR [quantity]
GO
ALTER TABLE [dbo].[orderItem] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[orderMaster] ADD  CONSTRAINT [def_orderMaster_paymentCurrency]  DEFAULT ('GBP') FOR [paymentCurrency]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[orderMaster] ADD  CONSTRAINT [def_orderMaster_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:46') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT ((0)) FOR [paymentSuccess]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [paymentAmount]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [promoCode]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [PPtransID]
GO
ALTER TABLE [dbo].[orderMaster] ADD  CONSTRAINT [def_orderMaster_datetimecreated]  DEFAULT ('2223-03-19T17:50:46') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [referrer]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [braintreeNonce]
GO
ALTER TABLE [dbo].[orderMaster] ADD  CONSTRAINT [def_orderMaster_status]  DEFAULT ('approved') FOR [status]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [braintreePaymentType]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[orderMaster] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[orderMaster_aOrderItemIDs] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[orderMaster_aOrderItemIDs] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[orderMaster_aOrderItemIDs] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[orderMaster_aOrderItemIDs] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_datetimecreated]  DEFAULT ('2223-03-19T17:50:53') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_datetimelastupdated]  DEFAULT ('2223-03-19T17:50:53') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_Title]  DEFAULT (NULL) FOR [Title]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_URL]  DEFAULT (NULL) FOR [URL]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_dmProfileID]  DEFAULT (NULL) FOR [dmProfileID]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT (NULL) FOR [UtmSourceID]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT (NULL) FOR [seniorSupportID]
GO
ALTER TABLE [dbo].[partner] ADD  CONSTRAINT [def_partner_MGintakeMostRecentActivity]  DEFAULT (NULL) FOR [MGintakeMostRecentActivity]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT (NULL) FOR [tenantID]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[partner] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[partner_aCenters] ADD  CONSTRAINT [def_partner_aCenters_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[partner_aCenters] ADD  CONSTRAINT [def_partner_aCenters_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[partner_aCenters] ADD  CONSTRAINT [def_partner_aCenters_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[partner_aReferers] ADD  CONSTRAINT [def_partner_aReferers_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[partner_aReferers] ADD  CONSTRAINT [def_partner_aReferers_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[partner_aReferers] ADD  CONSTRAINT [def_partner_aReferers_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_datetimecreated]  DEFAULT ('2223-03-19T17:51:00') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:01') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_memberID]  DEFAULT ('') FOR [memberID]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_DOW]  DEFAULT ((0)) FOR [DOW]
GO
ALTER TABLE [dbo].[progMember] ADD  CONSTRAINT [def_progMember_status]  DEFAULT ('approved') FOR [status]
GO
ALTER TABLE [dbo].[progMember] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[progMember] ADD  DEFAULT (NULL) FOR [programmeID]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_datetimecreated]  DEFAULT ('2223-03-19T17:51:02') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:02') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_loginURL]  DEFAULT ('/login') FOR [loginURL]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_activateURL]  DEFAULT ('/activate') FOR [activateURL]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_programmeURL]  DEFAULT ('/programme') FOR [programmeURL]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_resetPasswordURL]  DEFAULT ('/reset-password') FOR [resetPasswordURL]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_forgottenPasswordURL]  DEFAULT ('/forgotten-password') FOR [forgottenPasswordURL]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_paynowURL]  DEFAULT ('/buy-now') FOR [paynowURL]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('') FOR [Description]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/delete-me') FOR [unsubDelete]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/suspend') FOR [unsubSuspend]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/unsubscribe') FOR [unsubMaillist]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/order-places/return') FOR [purchaseReturnBulkURL]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/order-places') FOR [paynowBulkURL]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('/purchase/return') FOR [purchaseReturnURL]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT ('bounce@wellmindhealth.com') FOR [emailBounceAddress]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV27]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV23]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV314]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV214]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV3Yearly]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV23month]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV26month]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV37]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV33]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV36month]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV328]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV228]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV33month]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [emailSubjectNagV2Yearly]
GO
ALTER TABLE [dbo].[programme] ADD  CONSTRAINT [def_programme_emailSubjectActivatePortal]  DEFAULT ('') FOR [emailSubjectActivatePortal]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [xealthProgramId]
GO
ALTER TABLE [dbo].[programme] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[programme_aFollowupActivityDefIDs] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[programme_aFollowupActivityDefIDs] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[programme_aFollowupActivityDefIDs] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[programme_aFollowupActivityDefIDs] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[programme_aObjectIDs] ADD  CONSTRAINT [def_programme_aObjectIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[programme_aObjectIDs] ADD  CONSTRAINT [def_programme_aObjectIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[programme_aObjectIDs] ADD  CONSTRAINT [def_programme_aObjectIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[programme_aTrackerIDs] ADD  CONSTRAINT [def_programme_aTrackerIDs_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[programme_aTrackerIDs] ADD  CONSTRAINT [def_programme_aTrackerIDs_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[programme_aTrackerIDs] ADD  CONSTRAINT [def_programme_aTrackerIDs_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_datetimecreated]  DEFAULT ('2223-03-19T17:51:01') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:02') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_programmeID]  DEFAULT ('') FOR [programmeID]
GO
ALTER TABLE [dbo].[progRole] ADD  CONSTRAINT [def_progRole_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[progRole] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_dateEnd]  DEFAULT ('01/01/2010') FOR [dateEnd]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_dateStart]  DEFAULT ('01/01/2010') FOR [dateStart]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_datetimecreated]  DEFAULT ('2223-03-19T17:51:03') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:03') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_defaultCurrency]  DEFAULT ('GBP') FOR [defaultCurrency]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_productType]  DEFAULT ('all') FOR [productType]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_promoCode]  DEFAULT (NULL) FOR [promoCode]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[promotion] ADD  CONSTRAINT [def_promotion_url]  DEFAULT (NULL) FOR [url]
GO
ALTER TABLE [dbo].[promotion] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[refContainers] ADD  CONSTRAINT [def_refContainers_objectid]  DEFAULT ('') FOR [objectid]
GO
ALTER TABLE [dbo].[refContainers] ADD  CONSTRAINT [def_refContainers_containerid]  DEFAULT ('') FOR [containerid]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_biog]  DEFAULT (NULL) FOR [biog]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_centerID]  DEFAULT ('') FOR [centerID]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_datetimecreated]  DEFAULT ('2223-03-19T17:51:09') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:09') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_dmProfileID]  DEFAULT ('') FOR [dmProfileID]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_email]  DEFAULT ('') FOR [email]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_firstname]  DEFAULT ('') FOR [firstname]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_lastname]  DEFAULT ('') FOR [lastname]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_memberGroupID]  DEFAULT ('') FOR [memberGroupID]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_partnerID]  DEFAULT ('') FOR [partnerID]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_position]  DEFAULT ('') FOR [position]
GO
ALTER TABLE [dbo].[referer] ADD  CONSTRAINT [def_referer_salutation]  DEFAULT (NULL) FOR [salutation]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT (NULL) FOR [IAPTUStherapistId]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT ((0)) FOR [bInactive]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[referer] ADD  DEFAULT ('') FOR [progRoleID]
GO
ALTER TABLE [dbo].[refObjects] ADD  CONSTRAINT [def_refObjects_typename]  DEFAULT ('') FOR [typename]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_datetimecreated]  DEFAULT ('2223-03-19T17:51:11') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:12') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_frame]  DEFAULT ((1)) FOR [frame]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_height]  DEFAULT ('400') FOR [height]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_label]  DEFAULT ('') FOR [label]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lObjectIDs]  DEFAULT (NULL) FOR [lObjectIDs]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_memberID]  DEFAULT ('') FOR [memberID]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_memberTypeID]  DEFAULT ('2485D3E0-DE6F-11DE-B912000E0C6C1628') FOR [memberTypeID]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_programmeID]  DEFAULT ('') FOR [programmeID]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_sortOn]  DEFAULT (NULL) FOR [sortOn]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_width]  DEFAULT ('600') FOR [width]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xAxismajorUnit]  DEFAULT ('10') FOR [xAxismajorUnit]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xAxisMaximum]  DEFAULT ('100') FOR [xAxisMaximum]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xAxisMinimum]  DEFAULT ('0') FOR [xAxisMinimum]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xAxisminorUnit]  DEFAULT ('1') FOR [xAxisminorUnit]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xAxisType]  DEFAULT ('NumericAxis') FOR [xAxisType]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxismajorUnit]  DEFAULT ('10') FOR [yAxismajorUnit]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxisMaximum]  DEFAULT ('100') FOR [yAxisMaximum]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxisMinimum]  DEFAULT ('0') FOR [yAxisMinimum]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxisminorUnit]  DEFAULT ('1') FOR [yAxisminorUnit]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxisTitle]  DEFAULT (NULL) FOR [yAxisTitle]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yAxisType]  DEFAULT ('NumericAxis') FOR [yAxisType]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yField]  DEFAULT ('0') FOR [yField]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_dTypename]  DEFAULT (NULL) FOR [dTypename]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_sortDir]  DEFAULT ('DESC') FOR [sortDir]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lFields2]  DEFAULT (NULL) FOR [lFields2]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_joinTypename]  DEFAULT (NULL) FOR [joinTypename]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_joinOn]  DEFAULT (NULL) FOR [joinOn]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_yType]  DEFAULT ('line') FOR [yType]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_joinType]  DEFAULT (NULL) FOR [joinType]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lGroupField]  DEFAULT (NULL) FOR [lGroupField]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lFieldCalc]  DEFAULT (NULL) FOR [lFieldCalc]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_legend]  DEFAULT ((1)) FOR [legend]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_lFtLists]  DEFAULT (NULL) FOR [lFtLists]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_help]  DEFAULT (NULL) FOR [help]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_invertVals]  DEFAULT (NULL) FOR [invertVals]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_addOneVals]  DEFAULT ((0)) FOR [addOneVals]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_SQLtop]  DEFAULT (NULL) FOR [SQLtop]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_showOptions]  DEFAULT ('All') FOR [showOptions]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_gender]  DEFAULT ('Both') FOR [gender]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_stepNum]  DEFAULT ('NA') FOR [stepNum]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_activated]  DEFAULT ('1') FOR [activated]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_ftListsTypename]  DEFAULT (NULL) FOR [ftListsTypename]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_bDisplayPublic]  DEFAULT ((0)) FOR [bDisplayPublic]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_xtype]  DEFAULT ('linechart') FOR [xtype]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_dataField]  DEFAULT (NULL) FOR [dataField]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_categoryField]  DEFAULT (NULL) FOR [categoryField]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_groupField]  DEFAULT (NULL) FOR [groupField]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_markup]  DEFAULT ('h2,highlight') FOR [markup]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_dateEnd]  DEFAULT (NULL) FOR [dateEnd]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_dateStart]  DEFAULT (NULL) FOR [dateStart]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_bShowDateFilters]  DEFAULT ((0)) FOR [bShowDateFilters]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_status]  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[report] ADD  CONSTRAINT [def_report_switchColours]  DEFAULT ((0)) FOR [switchColours]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [legendAttr]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((1)) FOR [YAXISBOVERLAP]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((1)) FOR [XAXISBOVERLAP]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((1)) FOR [yAxisbShowAxisLabel]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((1)) FOR [yAxis2bShowAxisLabel]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [dateRange]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('return val;') FOR [yAxis2LabelRenderer]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('100') FOR [yAxis2Maximum]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('NumericAxis') FOR [yAxis2Type]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((0)) FOR [bXAxisPreview]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('10') FOR [yAxis2majorUnit]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('line') FOR [y2Type]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('1') FOR [yAxis2minorUnit]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [YLOGSCALE]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ('0') FOR [yAxis2Minimum]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [y2Field]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [Y2LOGSCALE]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [yAxis2Title]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT ((1)) FOR [YAXIS2BOVERLAP]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [YAXIS2LABEL]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [YAXISLABEL]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [yColours]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [y2Colours]
GO
ALTER TABLE [dbo].[report] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[report_aMemberGroupID] ADD  CONSTRAINT [def_report_aMemberGroupID_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[report_aMemberGroupID] ADD  CONSTRAINT [def_report_aMemberGroupID_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[report_aMemberGroupID] ADD  CONSTRAINT [def_report_aMemberGroupID_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  CONSTRAINT [def_ruleActivityDefListing_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  CONSTRAINT [def_ruleActivityDefListing_bMatchAllKeywords]  DEFAULT ((1)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  CONSTRAINT [def_ruleActivityDefListing_displayMethod]  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  CONSTRAINT [def_ruleActivityDefListing_slick_autoplaySpeed]  DEFAULT ((5000)) FOR [slick_autoplaySpeed]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((0)) FOR [slick_vertical]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((0)) FOR [bSlick]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((3)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_arrows]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_autoplay]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((0)) FOR [slick_infinite]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((300)) FOR [slick_speed]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((0)) FOR [slick_fade]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((4)) FOR [columnsize]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT (NULL) FOR [section]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_dots]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP1_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((6)) FOR [slick_slidesToShow]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP2_infinite]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP3_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP3_infinite]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((768)) FOR [slick_BP2]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1200)) FOR [slick_BP1]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT (NULL) FOR [containerClass]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((3)) FOR [slick_BP1_slidesToShow]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((480)) FOR [slick_BP3]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP2_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((2)) FOR [slick_BP2_slidesToShow]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP3_slidesToShow]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ('56.25') FOR [aspectRatio]
GO
ALTER TABLE [dbo].[ruleActivityDefListing] ADD  DEFAULT ((1)) FOR [slick_BP1_infinite]
GO
ALTER TABLE [dbo].[ruleActivityDefListing_aActivityDef] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleActivityDefListing_aActivityDef] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleActivityDefListing_aActivityDef] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleActivityDefListing_aActivityDef] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleChildLinks] ADD  CONSTRAINT [def_ruleChildLinks_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleChildLinks] ADD  CONSTRAINT [def_ruleChildLinks_displayMethod]  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleChildLinks] ADD  CONSTRAINT [def_ruleChildLinks_intro]  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleChildLinks] ADD  CONSTRAINT [def_ruleChildLinks_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT ((1)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT ('Did you know?') FOR [intro]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleDidYouKnowFact] ADD  DEFAULT ('displayTeaserDidYouKnow') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_bMatchAllKeywords]  DEFAULT ((0)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_displayMethod]  DEFAULT ('displayTeaserCalendar') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_intro]  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_metadata]  DEFAULT (NULL) FOR [metadata]
GO
ALTER TABLE [dbo].[ruleEventsCalendar] ADD  CONSTRAINT [def_ruleEventsCalendar_months]  DEFAULT ((3)) FOR [months]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  CONSTRAINT [def_ruleFacts_numItems]  DEFAULT ((3)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((1)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  CONSTRAINT [def_ruleFacts_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT (NULL) FOR [section]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  CONSTRAINT [def_ruleFacts_columnsize]  DEFAULT ((4)) FOR [columnsize]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((0)) FOR [bSlick]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((15000)) FOR [slick_autoplaySpeed]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((1)) FOR [slick_arrows]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((1)) FOR [slick_autoplay]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((0)) FOR [slick_infinite]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((300)) FOR [slick_speed]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((1)) FOR [slick_dots]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((0)) FOR [slick_vertical]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT ((0)) FOR [slick_fade]
GO
ALTER TABLE [dbo].[ruleFacts] ADD  DEFAULT (NULL) FOR [dsn]
GO
ALTER TABLE [dbo].[ruleFacts_aFacts] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleFacts_aFacts] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleFacts_aFacts] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleFacts_aFacts] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  CONSTRAINT [def_ruleFeedback_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  CONSTRAINT [def_ruleFeedback_emailto]  DEFAULT ('') FOR [emailto]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  CONSTRAINT [def_ruleFeedback_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  CONSTRAINT [def_ruleFeedback_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  CONSTRAINT [def_ruleFeedback_successTitle]  DEFAULT ('Thank you for your message.') FOR [successTitle]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [subject]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [buttonLabel]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [buttonIcon]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT ('section-bg bg-dark text-center') FOR [class]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [body]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [buttonClass]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT (NULL) FOR [SubscribeHint]
GO
ALTER TABLE [dbo].[ruleFeedback] ADD  DEFAULT ((0)) FOR [bShowSubscribe]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  CONSTRAINT [def_ruleFeedbackAndRate_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  CONSTRAINT [def_ruleFeedbackAndRate_emailto]  DEFAULT ('') FOR [emailto]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  DEFAULT ('Thank you for your feedback.') FOR [successTitle]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  CONSTRAINT [def_ruleFeedbackAndRate_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[ruleFeedbackAndRate] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  DEFAULT ((0)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  CONSTRAINT [def_ruleFileListing_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  CONSTRAINT [def_ruleFileListing_displayMethod]  DEFAULT ('download') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleFileListing] ADD  DEFAULT (NULL) FOR [categories]
GO
ALTER TABLE [dbo].[ruleFileListing_aFiles] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleFileListing_aFiles] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleFileListing_aFiles] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleFileListing_aFiles] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleHandpicked] ADD  CONSTRAINT [def_ruleHandpicked_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleHandpicked] ADD  CONSTRAINT [def_ruleHandpicked_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleHandpicked_aObjects] ADD  CONSTRAINT [def_ruleHandpicked_aObjects_DATA]  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleHandpicked_aObjects] ADD  CONSTRAINT [def_ruleHandpicked_aObjects_SEQ]  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleHandpicked_aObjects] ADD  CONSTRAINT [def_ruleHandpicked_aObjects_TYPENAME]  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleHandpicked_aObjects] ADD  CONSTRAINT [def_ruleHandpicked_aObjects_webskin]  DEFAULT (NULL) FOR [webskin]
GO
ALTER TABLE [dbo].[ruleImageGallery] ADD  CONSTRAINT [def_ruleImageGallery_catImageGallery]  DEFAULT (NULL) FOR [catImageGallery]
GO
ALTER TABLE [dbo].[ruleImageGallery] ADD  CONSTRAINT [def_ruleImageGallery_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleImageGallery] ADD  CONSTRAINT [def_ruleImageGallery_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleImageGallery] ADD  CONSTRAINT [def_ruleImageGallery_numItems]  DEFAULT ((20)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_galleria_bShow_imagenav]  DEFAULT ((1)) FOR [galleria_bShow_imagenav]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_displayType]  DEFAULT ('galleriaImageGallery') FOR [displayType]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ('fade') FOR [galleria_transition]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_galleria_bShow_info]  DEFAULT ((1)) FOR [galleria_bShow_info]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_galleria_autoplay]  DEFAULT ((5000)) FOR [galleria_autoplay]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_catImageGallery]  DEFAULT (NULL) FOR [catImageGallery]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_galleria_height]  DEFAULT ((0.6)) FOR [galleria_height]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ((0)) FOR [galleria_bShow_counter]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ((500)) FOR [galleria_carousel_speed]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ((1)) FOR [galleria_lightbox]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  CONSTRAINT [def_ruleImageGalleryGalleria_galleria_theme]  DEFAULT ('classic') FOR [galleria_theme]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria] ADD  DEFAULT ((1)) FOR [galleria_thumbnails]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria_aImages] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria_aImages] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria_aImages] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleImageGalleryGalleria_aImages] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP1_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((0)) FOR [slick_infinite]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP3_infinite]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((300)) FOR [slick_speed]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  CONSTRAINT [def_ruleImageGallerySlick_slick_BP2]  DEFAULT ((768)) FOR [slick_BP2]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  CONSTRAINT [def_ruleImageGallerySlick_slick_BP1]  DEFAULT ((1200)) FOR [slick_BP1]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((3)) FOR [slick_BP1_slidesToShow]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  CONSTRAINT [def_ruleImageGallerySlick_slick_BP3]  DEFAULT ((480)) FOR [slick_BP3]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((2)) FOR [slick_BP2_slidesToShow]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP3_slidesToShow]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [catImageGallery]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP1_infinite]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_dots]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((5000)) FOR [slick_autoplaySpeed]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((6)) FOR [slick_slidesToShow]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_arrows]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_autoplay]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP2_infinite]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP3_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [containerClass]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_BP2_slidesToScroll]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  CONSTRAINT [def_ruleImageGallerySlick_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((0)) FOR [slick_vertical]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((0)) FOR [slick_fade]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ('56.25') FOR [aspectRatio]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT (NULL) FOR [section]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((1)) FOR [slick_slidesPerRow]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((0)) FOR [slick_rows]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick] ADD  DEFAULT ((0)) FOR [bShowCaptions]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick_aImages] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick_aImages] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick_aImages] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleImageGallerySlick_aImages] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_bPaginate]  DEFAULT ((1)) FOR [bPaginate]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_itemsPerPage]  DEFAULT ((10)) FOR [itemsPerPage]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_label]  DEFAULT ('') FOR [label]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_numItems]  DEFAULT ((3)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_objectID]  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_pageLinksShown]  DEFAULT ((5)) FOR [pageLinksShown]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((0)) FOR [bSlick]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((4)) FOR [columnsize]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_section]  DEFAULT ('rule_latestTestimonials') FOR [section]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  CONSTRAINT [def_ruleLatesttestimonial_totalItems]  DEFAULT ((9999)) FOR [totalItems]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((15000)) FOR [slick_autoplaySpeed]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((1)) FOR [slick_arrows]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((1)) FOR [slick_autoplay]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((0)) FOR [slick_infinite]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((300)) FOR [slick_speed]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial] ADD  DEFAULT ((1)) FOR [slick_dots]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial_aTestimonials] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial_aTestimonials] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial_aTestimonials] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleLatesttestimonial_aTestimonials] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [buttonLabel]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [SubscribeHint]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT ('section-bg bg-dark text-center') FOR [class]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [buttonClass]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT ('Thank you for your message.') FOR [successTitle]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [subject]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [buttonIcon]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT ((0)) FOR [bShowSubscribe]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT (NULL) FOR [body]
GO
ALTER TABLE [dbo].[ruleLeadFeedback] ADD  DEFAULT ('') FOR [emailto]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_bArchive]  DEFAULT ((0)) FOR [bArchive]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_bMatchAllKeywords]  DEFAULT ((1)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_displayMethod]  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_metadata]  DEFAULT (NULL) FOR [metadata]
GO
ALTER TABLE [dbo].[ruleNews] ADD  CONSTRAINT [def_ruleNews_numItems]  DEFAULT ((5)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleNews] ADD  DEFAULT ((10)) FOR [numPages]
GO
ALTER TABLE [dbo].[ruleNews] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleNews] ADD  DEFAULT (NULL) FOR [section]
GO
ALTER TABLE [dbo].[ruleNews_aNews] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleNews_aNews] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleNews_aNews] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleNews_aNews] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_bMatchAllKeywords]  DEFAULT ((1)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_displayMethod]  DEFAULT (NULL) FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_intro]  DEFAULT ('Did you know?') FOR [intro]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  CONSTRAINT [def_ruleRandomFact_numItems]  DEFAULT ((1)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleRandomFact] ADD  DEFAULT (NULL) FOR [dsn]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT ((1)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT ((1)) FOR [bMatchAllKeywords]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT (NULL) FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  CONSTRAINT [def_ruleRelated_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT ('displayTeaserStandard') FOR [displayMethod]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT (NULL) FOR [section]
GO
ALTER TABLE [dbo].[ruleRelated] ADD  DEFAULT ((6)) FOR [columnsize]
GO
ALTER TABLE [dbo].[ruleRelated_aObjs] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[ruleRelated_aObjs] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[ruleRelated_aObjs] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[ruleRelated_aObjs] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  CONSTRAINT [def_ruleReviewsAndRatingsSchemaFromTestimonials_numItems]  DEFAULT ((10)) FOR [numItems]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  CONSTRAINT [def_ruleReviewsAndRatingsSchemaFromTestimonials_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  DEFAULT (NULL) FOR [programmeURL]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  DEFAULT (NULL) FOR [programmeDSN]
GO
ALTER TABLE [dbo].[ruleReviewsAndRatingsSchemaFromTestimonials] ADD  DEFAULT (NULL) FOR [programmeID]
GO
ALTER TABLE [dbo].[ruleRichText] ADD  CONSTRAINT [def_ruleRichText_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleRichText] ADD  CONSTRAINT [def_ruleRichText_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleRichText] ADD  CONSTRAINT [def_ruleRichText_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('') FOR [partnerID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('') FOR [referringURLPart]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('') FOR [referringURL]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('') FOR [memberGroupID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('9BC22C10-50D7-11E1-B2210026B9838679') FOR [centerID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('71D571F0-50D7-11E1-B2210026B9838679') FOR [refererID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('') FOR [objectID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_bDoCheck]  DEFAULT ((0)) FOR [bDoCheck]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_bActivation]  DEFAULT ((0)) FOR [bActivation]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('2485D3E0-DE6F-11DE-B912000E0C6C1628') FOR [memberTypeID]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('Start Now') FOR [buttonLabel]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('programmeURL') FOR [CFlocationTo]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT (NULL) FOR [successBubbleMessage]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT (NULL) FOR [successBubbleTitle]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ((0)) FOR [bFacebook]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_bSales]  DEFAULT ((0)) FOR [bSales]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ((0)) FOR [bGift]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_giftDate]  DEFAULT (NULL) FOR [giftDate]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_sectionClasses]  DEFAULT ('bg-dark') FOR [sectionClasses]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ('rule_selfRegistration') FOR [section]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  DEFAULT ((0)) FOR [bnAV]
GO
ALTER TABLE [dbo].[ruleSelfRegistration] ADD  CONSTRAINT [def_ruleSelfRegistration_bGoogle]  DEFAULT ((1)) FOR [bGoogle]
GO
ALTER TABLE [dbo].[ruleText] ADD  CONSTRAINT [def_ruleText_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleText] ADD  CONSTRAINT [def_ruleText_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_datetimelastupdated]  DEFAULT (NULL) FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_feedName]  DEFAULT (NULL) FOR [feedName]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_intro]  DEFAULT (NULL) FOR [intro]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_maxRecords]  DEFAULT ((15)) FOR [maxRecords]
GO
ALTER TABLE [dbo].[ruleXMLFeed] ADD  CONSTRAINT [def_ruleXMLFeed_XMLFeedURL]  DEFAULT (NULL) FOR [XMLFeedURL]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [Teaser]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[shopItem] ADD  CONSTRAINT [def_shopItem_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:23') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [teaserImage]
GO
ALTER TABLE [dbo].[shopItem] ADD  CONSTRAINT [def_shopItem_datetimecreated]  DEFAULT ('2223-03-19T17:51:22') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[shopItem] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[shopItem_aPublishCriteriaIDs] ADD  DEFAULT (NULL) FOR [typename]
GO
ALTER TABLE [dbo].[shopItem_aPublishCriteriaIDs] ADD  DEFAULT ((0)) FOR [seq]
GO
ALTER TABLE [dbo].[shopItem_aPublishCriteriaIDs] ADD  DEFAULT ('') FOR [parentid]
GO
ALTER TABLE [dbo].[shopItem_aPublishCriteriaIDs] ADD  DEFAULT (NULL) FOR [data]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ910]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [sickpayStatus]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ06]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ05]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ08]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ07]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ02]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ01]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ04]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ03]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((0)) FOR [bogusTrackers]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ09]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [WSAS1]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [WSAS2]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [WSAS3]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ909]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [WSAS4]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ908]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [WSAS5]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ907]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ906]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ905]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ904]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ903]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ902]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ901]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODIcombined]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHQ9]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHOBIA2]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [occupationalStatus]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHOBIA1]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [STarTrisk]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQcombined]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [IAPTUSrejectionReason]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PHOBIA3]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [employmentStatus]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ('2223-04-25T12:20:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ('2223-04-25T12:20:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [memberID]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [painDurationYears]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PsychoMed]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD706]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD705]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD704]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI10]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD703]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((0)) FOR [WSAS1NA]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD707]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [STarT1]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D01]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D02]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D03]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D04]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD702]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD701]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [painLocation]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [IAPTUSackStatus]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI05]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI04]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI07]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI06]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI09]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI08]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [benefitsStatus]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((0)) FOR [bogusFinish]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D05]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI01]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [GAD7]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [painDurationMonths]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [EQ5D06]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI03]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ODI02]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((0)) FOR [preDisclaimer]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [stepNum]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT ((1)) FOR [consent]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSEQ10]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQcombined]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ10]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ11]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ01]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ12]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ06]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ07]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ08]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ09]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ02]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ13]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ03]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ14]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ04]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ15]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [MSKHQ05]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [bogusStepNum]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q10]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [PSS]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q02]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q01]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q04]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q03]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q06]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q05]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q08]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q07]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [q09]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [progMemberID]
GO
ALTER TABLE [dbo].[SSQ_arthritis01] ADD  DEFAULT (NULL) FOR [programmeID]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ910]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [sickpayStatus]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ06]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ05]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ08]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ07]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ02]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ01]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ04]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ03]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((0)) FOR [bogusTrackers]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ09]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [WSAS1]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [WSAS2]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [WSAS3]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ909]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [WSAS4]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ908]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [WSAS5]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ907]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ906]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ905]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ904]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ903]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ902]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ901]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODIcombined]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHQ9]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHOBIA2]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [occupationalStatus]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHOBIA1]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [STarTrisk]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQcombined]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [IAPTUSrejectionReason]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PHOBIA3]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [employmentStatus]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ('2223-04-25T12:20:34') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ('2223-04-25T12:20:34') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [memberID]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [painDurationYears]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PsychoMed]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD706]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD705]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD704]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI10]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD703]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((0)) FOR [WSAS1NA]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD707]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [STarT1]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D01]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D02]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D03]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D04]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD702]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD701]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [painLocation]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [IAPTUSackStatus]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI05]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI04]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI07]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI06]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI09]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI08]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [benefitsStatus]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((0)) FOR [bogusFinish]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D05]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI01]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [GAD7]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [painDurationMonths]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [EQ5D06]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI03]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ODI02]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((0)) FOR [preDisclaimer]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [stepNum]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT ((1)) FOR [consent]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSEQ10]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQcombined]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ10]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ11]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ01]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ12]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ06]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ07]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ08]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ09]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ02]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ13]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ03]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ14]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ04]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ15]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [MSKHQ05]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [bogusStepNum]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q10]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [PSS]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q02]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q01]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q04]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q03]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q06]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q05]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q08]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q07]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [q09]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [progMemberID]
GO
ALTER TABLE [dbo].[SSQ_pain01] ADD  DEFAULT (NULL) FOR [programmeID]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_bogusFinish]  DEFAULT ((0)) FOR [bogusFinish]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_datetimecreated]  DEFAULT ('2223-03-19T17:51:18') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:19') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_memberID]  DEFAULT (NULL) FOR [memberID]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q01]  DEFAULT (NULL) FOR [q01]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q02]  DEFAULT (NULL) FOR [q02]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q03]  DEFAULT (NULL) FOR [q03]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q04]  DEFAULT (NULL) FOR [q04]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q05]  DEFAULT (NULL) FOR [q05]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q06]  DEFAULT (NULL) FOR [q06]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q07]  DEFAULT (NULL) FOR [q07]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q08]  DEFAULT (NULL) FOR [q08]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q09]  DEFAULT (NULL) FOR [q09]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_q10]  DEFAULT (NULL) FOR [q10]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PSS]  DEFAULT (NULL) FOR [PSS]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_bogusStepNum]  DEFAULT (NULL) FOR [bogusStepNum]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD701]  DEFAULT (NULL) FOR [GAD701]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ901]  DEFAULT (NULL) FOR [PHQ901]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD702]  DEFAULT (NULL) FOR [GAD702]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD7]  DEFAULT (NULL) FOR [GAD7]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD703]  DEFAULT (NULL) FOR [GAD703]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ909]  DEFAULT (NULL) FOR [PHQ909]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD704]  DEFAULT (NULL) FOR [GAD704]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD706]  DEFAULT (NULL) FOR [GAD706]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ910]  DEFAULT (NULL) FOR [PHQ910]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD707]  DEFAULT (NULL) FOR [GAD707]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ9]  DEFAULT (NULL) FOR [PHQ9]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ906]  DEFAULT (NULL) FOR [PHQ906]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ907]  DEFAULT (NULL) FOR [PHQ907]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ908]  DEFAULT (NULL) FOR [PHQ908]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_GAD705]  DEFAULT (NULL) FOR [GAD705]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ902]  DEFAULT (NULL) FOR [PHQ902]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ903]  DEFAULT (NULL) FOR [PHQ903]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ904]  DEFAULT (NULL) FOR [PHQ904]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHQ905]  DEFAULT (NULL) FOR [PHQ905]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_IAPTUSrejectionReason]  DEFAULT (NULL) FOR [IAPTUSrejectionReason]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_IAPTUSackStatus]  DEFAULT (NULL) FOR [IAPTUSackStatus]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_employmentStatus]  DEFAULT (NULL) FOR [employmentStatus]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_sickpayStatus]  DEFAULT (NULL) FOR [sickpayStatus]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHOBIA1]  DEFAULT (NULL) FOR [PHOBIA1]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHOBIA2]  DEFAULT (NULL) FOR [PHOBIA2]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_PHOBIA3]  DEFAULT (NULL) FOR [PHOBIA3]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_benefitsStatus]  DEFAULT (NULL) FOR [benefitsStatus]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS1]  DEFAULT (NULL) FOR [WSAS1]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS1NA]  DEFAULT ((0)) FOR [WSAS1NA]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS5]  DEFAULT (NULL) FOR [WSAS5]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS4]  DEFAULT (NULL) FOR [WSAS4]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS3]  DEFAULT (NULL) FOR [WSAS3]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  CONSTRAINT [def_SSQ_stress01_WSAS2]  DEFAULT (NULL) FOR [WSAS2]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSYCHOMED]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ06]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ05]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ08]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ07]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ02]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ01]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ04]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ03]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT ((0)) FOR [bogusTrackers]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ01]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ09]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ06]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ07]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ08]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ09]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ02]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ03]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ04]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ05]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODIcombined]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [occupationalStatus]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [STarTrisk]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQcombined]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQcombined]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [painDurationYears]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI10]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [STarT1]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D01]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D02]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D03]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D04]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [painLocation]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI05]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI04]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI07]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI06]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI09]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI08]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ10]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ11]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ12]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI01]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D05]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [painDurationMonths]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [EQ5D06]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI03]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [ODI02]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT ((0)) FOR [preDisclaimer]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [stepNum]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ13]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ14]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [MSKHQ15]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT ((1)) FOR [consent]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [PSEQ10]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [progMemberID]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [programmeID]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [workEdSituation]
GO
ALTER TABLE [dbo].[SSQ_stress01] ADD  DEFAULT (NULL) FOR [workEdSitExtra]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[test] ADD  CONSTRAINT [def_test_datetimecreated]  DEFAULT ('2223-03-19T17:51:40') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[test] ADD  CONSTRAINT [def_test_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:40') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[test] ADD  CONSTRAINT [def_test_datetest]  DEFAULT (NULL) FOR [datetest]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_datetimecreated]  DEFAULT ('2223-03-19T17:51:24') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:24') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_ObjectID]  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_title]  DEFAULT ('') FOR [title]
GO
ALTER TABLE [dbo].[testimonial] ADD  CONSTRAINT [def_testimonial_rating]  DEFAULT (NULL) FOR [rating]
GO
ALTER TABLE [dbo].[testimonial] ADD  DEFAULT (NULL) FOR [activityDefID]
GO
ALTER TABLE [dbo].[testimonial] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [sub]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [accessTokenExp]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [username]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ('2224-08-16T14:56:26') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ('2224-08-16T14:56:26') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [DeviceKey]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [DeviceGroupKey]
GO
ALTER TABLE [dbo].[token] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_datetimecreated]  DEFAULT ('2223-03-19T17:51:27') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:27') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[tracker] ADD  CONSTRAINT [def_tracker_trackerData]  DEFAULT ('empty') FOR [trackerData]
GO
ALTER TABLE [dbo].[tracker] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_bOptional]  DEFAULT ((0)) FOR [bOptional]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_createdby]  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_datetimecreated]  DEFAULT ('2223-03-19T17:51:26') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_datetimelastupdated]  DEFAULT ('2223-03-19T17:51:26') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_label]  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_lastupdatedby]  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_locked]  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_lockedBy]  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_ownedby]  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_programmeID]  DEFAULT ('') FOR [programmeID]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_title]  DEFAULT (NULL) FOR [title]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtClass]  DEFAULT (NULL) FOR [trackerFtClass]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtDefault]  DEFAULT ('empty') FOR [trackerFtDefault]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtHelpSection]  DEFAULT (NULL) FOR [trackerFtHelpSection]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtHint]  DEFAULT (NULL) FOR [trackerFtHint]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtIncludeDecimal]  DEFAULT ('false') FOR [trackerFtIncludeDecimal]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtLabel]  DEFAULT (NULL) FOR [trackerFtLabel]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtMaxLabel]  DEFAULT ('High') FOR [trackerFtMaxLabel]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtMaxValue]  DEFAULT ('100') FOR [trackerFtMaxValue]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtMinLabel]  DEFAULT ('Low') FOR [trackerFtMinLabel]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtMinValue]  DEFAULT ('0') FOR [trackerFtMinValue]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtRenderType]  DEFAULT (NULL) FOR [trackerFtRenderType]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtStyle]  DEFAULT (NULL) FOR [trackerFtStyle]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtType]  DEFAULT ('mySlider') FOR [trackerFtType]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtValidation]  DEFAULT ('validate-required') FOR [trackerFtValidation]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtWidth]  DEFAULT (NULL) FOR [trackerFtWidth]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtValidationAdd]  DEFAULT (NULL) FOR [trackerFtValidationAdd]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerftMinPic]  DEFAULT ('weather_sun') FOR [trackerftMinPic]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerftMaxPic]  DEFAULT ('weather_lightning') FOR [trackerftMaxPic]
GO
ALTER TABLE [dbo].[trackerDef] ADD  CONSTRAINT [def_trackerDef_trackerFtOffsetVal]  DEFAULT ('0') FOR [trackerFtOffsetVal]
GO
ALTER TABLE [dbo].[trackerDef] ADD  DEFAULT ((0)) FOR [trackerFtReversed]
GO
ALTER TABLE [dbo].[trackerDef] ADD  DEFAULT (NULL) FOR [versionID]
GO
ALTER TABLE [dbo].[trackerDef] ADD  DEFAULT ('draft') FOR [status]
GO
ALTER TABLE [dbo].[trackerDef] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [deployment]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [programId]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [eventTimeStamp]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [eventId]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [orderId]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [eventType]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [partnerId]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [eventContext]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('2223-12-30T13:30:07') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('2223-12-30T13:30:07') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT ('') FOR [eventStatus]
GO
ALTER TABLE [dbo].[xealth_notification] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [deployment]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [programId]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [orderId]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ((0)) FOR [bPreorder]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [partnerId]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('2224-01-05T13:47:21') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('2224-01-05T13:47:21') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[xealth_order] ADD  DEFAULT (NULL) FOR [courseCode]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [deployment]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ((0)) FOR [locked]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT (NULL) FOR [memberID]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [programId]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [ObjectID]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [orderId]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT (NULL) FOR [ownedby]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [partnerId]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [lastupdatedby]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT (NULL) FOR [label]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('2224-01-05T13:47:21') FOR [datetimecreated]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT (NULL) FOR [lockedBy]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('2224-01-05T13:47:21') FOR [datetimelastupdated]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [patientId]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT ('') FOR [createdby]
GO
ALTER TABLE [dbo].[xealth_patient] ADD  DEFAULT (NULL) FOR [courseCode]
GO
