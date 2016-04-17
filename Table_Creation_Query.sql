GO
CREATE TABLE [dbo].[Instructor]
(

	[Instructor_ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](10) NOT NULL,
	[Active] [nvarchar](1) NOT NULL,	

 CONSTRAINT [PK_Instructor_Email] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Instructor] ADD  CONSTRAINT [DF_Instructor_Active]  DEFAULT (('Y')) FOR [Active]
GO

-- [dbo].[Student]

CREATE TABLE [dbo].[Student]
(
	[Student_ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[DOB] [datetime] NOT NULL,
	[MobileNumber] [nvarchar](12) NULL,
	[Adrress] [nvarchar](20) NULL,
	[City] [nvarchar](20) NULL,
	[State] [nvarchar](2) NULL,
	[Zip] [nvarchar](15) NULL,
	[Notes] [nvarchar](200) NULL,
	[Active] [nvarchar](1) NOT NULL,
		
 CONSTRAINT [PK_Student_Student_ID] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Student] ADD  CONSTRAINT [DF_Student_Active]  DEFAULT (('Y')) FOR [Active]
GO

--[dbo].[Subject]
CREATE TABLE [dbo].[Subject]
(

	[Subject_ID] [int] IDENTITY(1,1) NOT NULL,
	[SubjectName] [nvarchar](20) NOT NULL,
	[DepatmentID]  [int] NOT NULL,
	[DepatmentName] [nvarchar](20) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Active] [nvarchar](1) NOT NULL,	

 CONSTRAINT [PK_Subject_Subject_ID] PRIMARY KEY CLUSTERED 
(
	[Subject_ID] ASC
)
) ON [PRIMARY]

ALTER TABLE [dbo].[Subject] ADD  CONSTRAINT [DF_Subject_Active]  DEFAULT (('Y')) FOR [Active]


--[dbo].[Subject_Student]

CREATE TABLE [dbo].[Subject_Student]
(

	[Subject_ID] [int] NOT NULL,
	[Student_ID] [int] NOT NULL,
	[RegisterDT] [datetime] NOT NULL,
	[Active] [nvarchar](1) NOT NULL,	

 CONSTRAINT [PK_Subject_Student] PRIMARY KEY CLUSTERED 
(
	[Subject_ID],[Student_ID]
)
) ON [PRIMARY]

ALTER TABLE  [dbo].[Subject_Student] ADD  CONSTRAINT [DF_Subject_Student_RegisterDT]  DEFAULT (GETDATE()) FOR [RegisterDT]
ALTER TABLE	 [dbo].[Subject_Student] ADD  CONSTRAINT [DF_Subject_Student_Active]  DEFAULT (('Y')) FOR [Active]
--[dbo].[Subject_Instructor]

CREATE TABLE [dbo].[Subject_Instructor]
(

	[Subject_ID] [int] NOT NULL,
	[Instructor_ID] [int] NOT NULL,
	[RegisterDT] [datetime] NOT NULL,
	[Active] [nvarchar](1) NOT NULL,	

 CONSTRAINT [PK_Subject_Instructor] PRIMARY KEY CLUSTERED 
(
	[Subject_ID],[Instructor_ID]
)
) ON [PRIMARY]

ALTER TABLE  [dbo].[Subject_Instructor] ADD  CONSTRAINT [DF_Subject_Instructor_RegisterDT]  DEFAULT (GETDATE()) FOR [RegisterDT]
ALTER TABLE	 [dbo].[Subject_Instructor] ADD  CONSTRAINT [DF_Subject_Instructor_Active]  DEFAULT (('Y')) FOR [Active]

--[dbo].[Attendance]

CREATE TABLE [dbo].[Attendance]
(

	[Attendance_ID] [int] NOT NULL,
	[Instructor_ID] [int] NOT NULL,
	[Student_ID] [int] NOT NULL,
	[Subject_ID] [int] NOT NULL,
	[Hours] [nvarchar](5) NOT NULL,
	[AttendanceDT] [datetime] NOT NULL,
	[Active] [nvarchar](1) NOT NULL,	

 CONSTRAINT [PK_Attendance_Attendance_ID] PRIMARY KEY CLUSTERED 
(
	[Attendance_ID]
)
) ON [PRIMARY]

ALTER TABLE [dbo].[Attendance] ADD  CONSTRAINT [DF_Attendance_AttendanceDT]  DEFAULT (GETDATE()) FOR [AttendanceDT]
GO
ALTER TABLE	[dbo].[Attendance] ADD  CONSTRAINT [DF_Attendance_Active]  DEFAULT (('Y')) FOR [Active]

