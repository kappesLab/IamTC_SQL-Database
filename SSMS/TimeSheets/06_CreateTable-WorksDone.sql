USE [TimeSheets]
GO

/****** Object:  Table [dbo].[WorksDone]    Script Date: 03/12/2023 12:41:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorksDone](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[JobId] [int] NOT NULL,
	[LocationId] [int] NOT NULL,
	[HoursWorked] [int] NOT NULL,
	[Description] [varchar](2000) NOT NULL,
	[DatePerformed] [date] NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[UpdateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_WorksDone] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WorksDone] ADD  CONSTRAINT [DF_WorksDone_HoursWorked]  DEFAULT ((2)) FOR [HoursWorked]
GO

ALTER TABLE [dbo].[WorksDone] ADD  CONSTRAINT [DF_WorksDone_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO

ALTER TABLE [dbo].[WorksDone] ADD  CONSTRAINT [DF_WorksDone_UpdateDate]  DEFAULT (getdate()) FOR [UpdateDate]
GO

