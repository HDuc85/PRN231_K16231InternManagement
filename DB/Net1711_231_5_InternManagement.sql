create database [Net1711_231_5_InternManagement] 
go
USE [Net1711_231_5_InternManagement]
GO
-- User Table
CREATE TABLE [dbo].[User](
    [UserID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[FullName] [nvarchar](100) NOT NULL,
	[DOB] [date] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[Phone] [varchar](10) NOT NULL,
	[Email] [varchar](320) NOT NULL,
	[Username] [varchar] (16) NOT NULL,
	[Passwrod] [varchar] (16) NOT NULL,
	[University] [nvarchar](50) NULL,
	[Major] [nvarchar](50) NULL
);
GO
-- Company Table
CREATE TABLE [dbo].[Company](
	[CompanyID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[CompanyName] [nvarchar](100) NULL,
	[CompanyAddress] [nvarchar](255) NULL,
	[CompanyPhone] [varchar](10) NULL,
	[CompanyEmail] [varchar](320) NULL,
	[Description] [nvarchar](300) NULL
);
GO
-- Employee Table
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[EmployeeName] [nvarchar](100) NULL,
	[EmployeeAddress] [nvarchar](255) NULL,
	[EmployeePhone] [varchar](10) NULL,
	[EmployeeEmail] [varchar](320) NULL,
	[CompanyID] [int] NULL,
	FOREIGN KEY ([CompanyID]) REFERENCES [dbo].[Company]([CompanyID])
);
GO
-- MentorProfile Table
CREATE TABLE [dbo].[MentorProfile](
	[MentorID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[UserID] [int] NOT NULL,
	FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]([UserID])
);
GO
-- InternProfile Table
CREATE TABLE [dbo].[InternProfile](
	[InternID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[UserID] [int] NOT NULL,
	[MentorID] [int] NULL,
	FOREIGN KEY ([UserID]) REFERENCES [dbo].[User]([UserID]),
    FOREIGN KEY ([MentorID]) REFERENCES [dbo].[MentorProfile]([MentorID])
);
GO
-- TrainingProgram Table
CREATE TABLE [dbo].[TrainingProgram](
	[ProgramID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[ProgramName] [nvarchar](100) NULL,
	[ProgramDescription] [ntext] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
)ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO
-- Status table
CREATE TABLE [dbo].[Status](
	[StatusID] [int] NOT NULL Primary key IDENTITY(1,1),
	[StatusName] [nvarchar](1) NULL,
	[IsActive] [bit] NULL
);
GO
-- Task Table
CREATE TABLE [dbo].[Task](
	[TaskID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[TaskName] [nvarchar](100) NULL,
	[TaskDescription] [ntext] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[StatusID] [int] NULL,
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
GO

-- MentorIntern Table
CREATE TABLE [dbo].[MentorIntern](
	[MentorInternID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[InternID] [int] NULL,
	[MentorID] [int] NULL,
	[IsActive] [bit] NULL,
	FOREIGN KEY ([InternID]) REFERENCES [dbo].[InternProfile]([InternID]),
	FOREIGN KEY ([MentorID]) REFERENCES [dbo].[MentorProfile]([MentorID])
);
GO



-- ProgramIntern Table
CREATE TABLE [dbo].[ProgramIntern](
	[ProgramInternID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[InternID] [int] NULL,
	[ProgramID] [int] NULL,
	[IsActive] [bit] NULL,
	FOREIGN KEY ([InternID]) REFERENCES [dbo].[InternProfile]([InternID]),
	FOREIGN KEY ([ProgramID]) REFERENCES [dbo].[TrainingProgram]([ProgramID])
);
GO
-- ProgramTask Table
CREATE TABLE [dbo].[ProgramTask](
	[ProgramTaskID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[TaskID] [int] NULL,
	[ProgramID] [int] NULL,
	[IsActive] [bit] NULL,
	FOREIGN KEY ([TaskID]) REFERENCES [dbo].[Task]([TaskID]),
	FOREIGN KEY ([ProgramID]) REFERENCES [dbo].[TrainingProgram]([ProgramID])
);
GO


-- TaskManage Table
CREATE TABLE [dbo].[TaskManage](
    [TaskManageID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
    [TaskID] [int] NULL,
    [InternID] [int] NULL,
    [MentorID] [int] NULL,
    [StatusID] [int] NULL,
    FOREIGN KEY ([TaskID]) REFERENCES [dbo].[Task]([TaskID]),
    FOREIGN KEY ([InternID]) REFERENCES [dbo].[InternProfile]([InternID]),
    FOREIGN KEY ([MentorID]) REFERENCES [dbo].[MentorProfile]([MentorID]),
    FOREIGN KEY ([StatusID]) REFERENCES [dbo].[Status]([StatusID])
);
GO


-- Feedback table
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] NOT NULL PRIMARY KEY IDENTITY(1,1),
	[MentorID] [int] NOT NULL,
	[InternID] [int] NOT NULL,
	[Description] [nvarchar] (1000) NOT NULL,
	[Score] [int] CHECK ([Score] >= 1 AND [Score] <= 5) NOT NULL,
	FOREIGN KEY ([MentorID]) REFERENCES [dbo].[MentorProfile]([MentorID]),
	FOREIGN KEY ([InternID]) REFERENCES [dbo].[InternProfile]([InternID])
);
GO