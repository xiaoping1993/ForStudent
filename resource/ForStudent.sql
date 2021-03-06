USE [master]
GO
/****** Object:  Database [ForStudent]    Script Date: 3/4/2019 6:45:25 PM ******/
CREATE DATABASE [ForStudent]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ForStudent', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ForStudent.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ForStudent_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\ForStudent_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ForStudent] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ForStudent].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ForStudent] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ForStudent] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ForStudent] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ForStudent] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ForStudent] SET ARITHABORT OFF 
GO
ALTER DATABASE [ForStudent] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ForStudent] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ForStudent] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ForStudent] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ForStudent] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ForStudent] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ForStudent] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ForStudent] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ForStudent] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ForStudent] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ForStudent] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ForStudent] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ForStudent] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ForStudent] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ForStudent] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ForStudent] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ForStudent] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ForStudent] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ForStudent] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ForStudent] SET  MULTI_USER 
GO
ALTER DATABASE [ForStudent] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ForStudent] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ForStudent] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ForStudent] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [ForStudent]
GO
/****** Object:  Table [dbo].[checkingIn]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[checkingIn](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gradeId] [int] NOT NULL,
	[studentXh] [varchar](50) NOT NULL,
	[status] [int] NOT NULL,
	[time] [datetime] NOT NULL,
	[position] [varchar](50) NOT NULL,
 CONSTRAINT [PK_checkingIn] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[courses]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[courses](
	[courseId] [int] IDENTITY(1,1) NOT NULL,
	[courseName] [varchar](50) NULL,
	[courseDes] [varchar](50) NULL,
 CONSTRAINT [PK_courses] PRIMARY KEY CLUSTERED 
(
	[courseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[courseSchedule]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[courseSchedule](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[courseId] [int] NULL,
	[gradeId] [int] NULL,
	[locationX] [int] NULL,
	[locationY] [int] NULL,
	[modifyTime] [datetime] NULL,
	[flag] [int] NULL,
 CONSTRAINT [PK_courseSchedule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[grades]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[grades](
	[gradeId] [int] IDENTITY(1,1) NOT NULL,
	[gradeNianji] [varchar](50) NULL,
	[gradeBanji] [varchar](50) NULL,
	[gradeXueyuan] [varchar](50) NULL,
	[gradeZhuanye] [varchar](50) NULL,
	[gradeQRCode] [varchar](50) NOT NULL,
 CONSTRAINT [PK_grades] PRIMARY KEY CLUSTERED 
(
	[gradeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Qingjia]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Qingjia](
	[qiangjiaId] [int] IDENTITY(1,1) NOT NULL,
	[studentXh] [varchar](50) NOT NULL,
	[qingjiaStartTime] [datetime] NOT NULL,
	[qingjiaEndTime] [datetime] NOT NULL,
	[flag] [int] NOT NULL,
 CONSTRAINT [PK_Qingjia] PRIMARY KEY CLUSTERED 
(
	[qiangjiaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[students]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[students](
	[studentXh] [varchar](50) NOT NULL,
	[studentName] [varchar](50) NULL,
	[studentGender] [int] NULL,
	[gradeId] [int] NULL,
	[password] [varchar](50) NULL,
 CONSTRAINT [PK_students] PRIMARY KEY CLUSTERED 
(
	[studentXh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sys_authority]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sys_authority](
	[authority_id] [int] NOT NULL,
	[authority_pid] [int] NOT NULL,
	[authority_name] [varchar](50) NULL,
	[authority_describe] [varchar](max) NULL,
 CONSTRAINT [PK_sys_authority] PRIMARY KEY CLUSTERED 
(
	[authority_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sys_role]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sys_role](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sys_role_authority]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role_authority](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[role_id] [int] NOT NULL,
	[authority_id] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_role_user]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_role_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[sys_role_id] [int] NOT NULL,
	[sys_user_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_user]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sys_user](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](100) NOT NULL,
	[cellphone] [varchar](13) NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK__sys_user__3213E83F2BD0CC37] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[teacherDuty]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[teacherDuty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[teacherId] [varchar](50) NULL,
	[courseId] [int] NULL,
	[gradeId] [int] NULL,
 CONSTRAINT [PK_teacher_course] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[teachers]    Script Date: 3/4/2019 6:45:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[teachers](
	[teacherId] [varchar](50) NOT NULL,
	[teacherName] [varchar](50) NULL,
	[teacherGender] [varchar](50) NULL,
	[password] [varchar](50) NULL,
 CONSTRAINT [PK_teachers] PRIMARY KEY CLUSTERED 
(
	[teacherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[checkingIn] ON 

INSERT [dbo].[checkingIn] ([id], [gradeId], [studentXh], [status], [time], [position]) VALUES (1, 1, N'001', 1, CAST(0x0000A87B00000000 AS DateTime), N'1,1')
INSERT [dbo].[checkingIn] ([id], [gradeId], [studentXh], [status], [time], [position]) VALUES (2, 1, N'002', 2, CAST(0x0000A87B00000000 AS DateTime), N'2,1')
INSERT [dbo].[checkingIn] ([id], [gradeId], [studentXh], [status], [time], [position]) VALUES (3, 2, N'003', 1, CAST(0x0000A87B00000000 AS DateTime), N'3,1')
INSERT [dbo].[checkingIn] ([id], [gradeId], [studentXh], [status], [time], [position]) VALUES (4, 1, N'001', 2, CAST(0x0000A87B00000000 AS DateTime), N'2,1')
INSERT [dbo].[checkingIn] ([id], [gradeId], [studentXh], [status], [time], [position]) VALUES (5, 1, N'001', 2, CAST(0x0000A87B00000000 AS DateTime), N'4,1')
SET IDENTITY_INSERT [dbo].[checkingIn] OFF
SET IDENTITY_INSERT [dbo].[courses] ON 

INSERT [dbo].[courses] ([courseId], [courseName], [courseDes]) VALUES (1, N'数学', NULL)
INSERT [dbo].[courses] ([courseId], [courseName], [courseDes]) VALUES (2, N'语文', NULL)
INSERT [dbo].[courses] ([courseId], [courseName], [courseDes]) VALUES (3, N'化学', NULL)
INSERT [dbo].[courses] ([courseId], [courseName], [courseDes]) VALUES (4, N'物理', NULL)
SET IDENTITY_INSERT [dbo].[courses] OFF
SET IDENTITY_INSERT [dbo].[courseSchedule] ON 

INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (1, 1, 1, 1, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (2, 2, 1, 1, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (3, 3, 1, 1, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (4, 4, 1, 1, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (5, 1, 1, 1, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (6, 2, 1, 1, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (7, 3, 1, 1, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (9, 1, 1, 2, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (10, 2, 1, 2, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (11, 3, 1, 2, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (12, 4, 1, 2, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (13, 1, 1, 2, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (14, 2, 1, 2, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (15, 3, 1, 2, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (16, 1, 1, 3, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (17, 2, 1, 3, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (18, 3, 1, 3, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (19, 4, 1, 3, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (20, 1, 1, 3, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (21, 2, 1, 3, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (22, 3, 1, 3, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (23, 1, 1, 4, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (24, 2, 1, 4, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (25, 3, 1, 4, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (26, 4, 1, 4, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (27, 1, 1, 4, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (28, 2, 1, 4, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (29, 3, 1, 4, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (30, 1, 1, 5, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (31, 2, 1, 5, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (32, 3, 1, 5, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (33, 4, 1, 5, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (34, 1, 1, 5, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (35, 2, 1, 5, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (36, 3, 1, 5, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (37, 1, 2, 1, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (38, 2, 2, 1, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (39, 3, 2, 1, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (40, 4, 2, 1, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (41, 1, 2, 1, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (42, 2, 2, 1, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (43, 3, 2, 1, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (44, 1, 2, 2, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (45, 2, 2, 2, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (46, 3, 2, 2, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (47, 4, 2, 2, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (48, 1, 2, 2, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (49, 2, 2, 2, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (50, 3, 2, 2, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (51, 1, 2, 3, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (52, 2, 2, 3, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (53, 3, 2, 3, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (54, 4, 2, 3, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (55, 1, 2, 3, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (56, 2, 2, 3, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (57, 3, 2, 3, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (58, 1, 2, 4, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (59, 2, 2, 4, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (60, 3, 2, 4, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (61, 4, 2, 4, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (62, 1, 2, 4, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (63, 2, 2, 4, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (64, 3, 2, 4, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (65, 1, 2, 5, 1, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (66, 2, 2, 5, 2, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (67, 3, 2, 5, 3, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (68, 4, 2, 5, 4, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (69, 1, 2, 5, 5, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (70, 2, 2, 5, 6, CAST(0x0000A9E800000000 AS DateTime), 1)
INSERT [dbo].[courseSchedule] ([id], [courseId], [gradeId], [locationX], [locationY], [modifyTime], [flag]) VALUES (71, 3, 2, 5, 7, CAST(0x0000A9E800000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[courseSchedule] OFF
SET IDENTITY_INSERT [dbo].[grades] ON 

INSERT [dbo].[grades] ([gradeId], [gradeNianji], [gradeBanji], [gradeXueyuan], [gradeZhuanye], [gradeQRCode]) VALUES (1, N'2015级', N'01班', N'土木工程学院', N'土木', N'201501tmgcxytm')
INSERT [dbo].[grades] ([gradeId], [gradeNianji], [gradeBanji], [gradeXueyuan], [gradeZhuanye], [gradeQRCode]) VALUES (2, N'2015级', N'02班', N'土木工程学院', N'水电', N'201502tmgcxysd')
INSERT [dbo].[grades] ([gradeId], [gradeNianji], [gradeBanji], [gradeXueyuan], [gradeZhuanye], [gradeQRCode]) VALUES (3, N'2016级', N'01班', N'人文与管理学院', N'信息管理与信息系统', N'201601ywyglxyxxglyxxxt')
INSERT [dbo].[grades] ([gradeId], [gradeNianji], [gradeBanji], [gradeXueyuan], [gradeZhuanye], [gradeQRCode]) VALUES (4, N'2016级', N'02班', N'人文与管理学院', N'法学', N'201601ywyglxyfx')
SET IDENTITY_INSERT [dbo].[grades] OFF
SET IDENTITY_INSERT [dbo].[Qingjia] ON 

INSERT [dbo].[Qingjia] ([qiangjiaId], [studentXh], [qingjiaStartTime], [qingjiaEndTime], [flag]) VALUES (2, N'001', CAST(0x0000AA0400000000 AS DateTime), CAST(0x0000AA0700000000 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Qingjia] OFF
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'001', N'小明', 1, 1, N'414468935752aa3b')
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'002', N'小红', 1, 1, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'003', N'小白', 1, 1, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'004', N'小兰', 1, 1, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'005', N'小黑', 2, 1, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'006', N'小1', 1, 2, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'007', N'小2', 1, 2, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'008', N'小3', 1, 2, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'009', N'小4', 2, 2, NULL)
INSERT [dbo].[students] ([studentXh], [studentName], [studentGender], [gradeId], [password]) VALUES (N'010', N'小5', 2, 2, NULL)
INSERT [dbo].[sys_authority] ([authority_id], [authority_pid], [authority_name], [authority_describe]) VALUES (1, 0, N'学生管理', NULL)
INSERT [dbo].[sys_authority] ([authority_id], [authority_pid], [authority_name], [authority_describe]) VALUES (3, 0, N'教师管理', NULL)
INSERT [dbo].[sys_authority] ([authority_id], [authority_pid], [authority_name], [authority_describe]) VALUES (5, 0, N'用户配置', NULL)
INSERT [dbo].[sys_authority] ([authority_id], [authority_pid], [authority_name], [authority_describe]) VALUES (7, 0, N'角色配置', NULL)
SET IDENTITY_INSERT [dbo].[sys_role] ON 

INSERT [dbo].[sys_role] ([id], [name]) VALUES (1, N'ROLE_ADMIN')
INSERT [dbo].[sys_role] ([id], [name]) VALUES (17, N'ROLE_RENJI')
INSERT [dbo].[sys_role] ([id], [name]) VALUES (2, N'ROLE_USER')
SET IDENTITY_INSERT [dbo].[sys_role] OFF
SET IDENTITY_INSERT [dbo].[sys_role_authority] ON 

INSERT [dbo].[sys_role_authority] ([id], [role_id], [authority_id]) VALUES (81, 1, 1)
INSERT [dbo].[sys_role_authority] ([id], [role_id], [authority_id]) VALUES (82, 1, 3)
INSERT [dbo].[sys_role_authority] ([id], [role_id], [authority_id]) VALUES (83, 1, 5)
INSERT [dbo].[sys_role_authority] ([id], [role_id], [authority_id]) VALUES (49, 17, 7)
INSERT [dbo].[sys_role_authority] ([id], [role_id], [authority_id]) VALUES (53, 2, 7)
SET IDENTITY_INSERT [dbo].[sys_role_authority] OFF
SET IDENTITY_INSERT [dbo].[sys_role_user] ON 

INSERT [dbo].[sys_role_user] ([id], [sys_role_id], [sys_user_id]) VALUES (1, 1, 1)
INSERT [dbo].[sys_role_user] ([id], [sys_role_id], [sys_user_id]) VALUES (3, 2, 1)
INSERT [dbo].[sys_role_user] ([id], [sys_role_id], [sys_user_id]) VALUES (16, 17, 3)
INSERT [dbo].[sys_role_user] ([id], [sys_role_id], [sys_user_id]) VALUES (18, 2, 5)
SET IDENTITY_INSERT [dbo].[sys_role_user] OFF
SET IDENTITY_INSERT [dbo].[sys_user] ON 

INSERT [dbo].[sys_user] ([id], [username], [password], [cellphone], [email]) VALUES (1, N'admin', N'$2a$10$C7AaeubQDO0hKo5uXGPo2eDpEdcxir70suKnKx5l/wGzSh3eEMQey', N'17625922615', N'1712@qq.com')
INSERT [dbo].[sys_user] ([id], [username], [password], [cellphone], [email]) VALUES (3, N'renji', N'$2a$10$csNmAl93.KVdB8J7n56r2OMOyVJRrhUEoKIh3jctFgqJDgqV7fiPa', N'1231231', N'')
INSERT [dbo].[sys_user] ([id], [username], [password], [cellphone], [email]) VALUES (5, N'xiaowang', N'$2a$10$dRH42gHnlc/S3vI4CF0XC.v0PLFTzhtZ9kH3RYAqHxLq5NdBDxEgC', N'', N'')
SET IDENTITY_INSERT [dbo].[sys_user] OFF
SET IDENTITY_INSERT [dbo].[teacherDuty] ON 

INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (1, N'1', 1, 1)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (2, N'2', 2, 1)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (3, N'3', 3, 1)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (4, N'4', 4, 1)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (5, N'1', 1, 2)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (6, N'2', 2, 3)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (7, N'3', 3, 3)
INSERT [dbo].[teacherDuty] ([id], [teacherId], [courseId], [gradeId]) VALUES (8, N'4', 4, 4)
SET IDENTITY_INSERT [dbo].[teacherDuty] OFF
INSERT [dbo].[teachers] ([teacherId], [teacherName], [teacherGender], [password]) VALUES (N'1', N'王老师', N'1', NULL)
INSERT [dbo].[teachers] ([teacherId], [teacherName], [teacherGender], [password]) VALUES (N'2', N'李老师', N'1', NULL)
INSERT [dbo].[teachers] ([teacherId], [teacherName], [teacherGender], [password]) VALUES (N'3', N'蒙老师', N'1', NULL)
INSERT [dbo].[teachers] ([teacherId], [teacherName], [teacherGender], [password]) VALUES (N'4', N'夏老师', N'1', NULL)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__sys_role__72E12F1B4983E9CA]    Script Date: 3/4/2019 6:45:25 PM ******/
ALTER TABLE [dbo].[sys_role] ADD UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__sys_user__F3DBC572CE78ADF2]    Script Date: 3/4/2019 6:45:25 PM ******/
ALTER TABLE [dbo].[sys_user] ADD  CONSTRAINT [UQ__sys_user__F3DBC572CE78ADF2] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[courseSchedule] ADD  CONSTRAINT [DF_courseSchedule_flag]  DEFAULT ((1)) FOR [flag]
GO
ALTER TABLE [dbo].[Qingjia] ADD  CONSTRAINT [DF_Qingjia_studentXh]  DEFAULT ((1)) FOR [studentXh]
GO
ALTER TABLE [dbo].[checkingIn]  WITH CHECK ADD  CONSTRAINT [FK_checkingIn_students] FOREIGN KEY([studentXh])
REFERENCES [dbo].[students] ([studentXh])
GO
ALTER TABLE [dbo].[checkingIn] CHECK CONSTRAINT [FK_checkingIn_students]
GO
ALTER TABLE [dbo].[checkingIn]  WITH CHECK ADD  CONSTRAINT [FK_checkingIn_students1] FOREIGN KEY([studentXh])
REFERENCES [dbo].[students] ([studentXh])
GO
ALTER TABLE [dbo].[checkingIn] CHECK CONSTRAINT [FK_checkingIn_students1]
GO
ALTER TABLE [dbo].[students]  WITH CHECK ADD  CONSTRAINT [FK_students_grades] FOREIGN KEY([gradeId])
REFERENCES [dbo].[grades] ([gradeId])
GO
ALTER TABLE [dbo].[students] CHECK CONSTRAINT [FK_students_grades]
GO
ALTER TABLE [dbo].[sys_role_authority]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_authority_sys_authority] FOREIGN KEY([authority_id])
REFERENCES [dbo].[sys_authority] ([authority_id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_authority] CHECK CONSTRAINT [FK_sys_role_authority_sys_authority]
GO
ALTER TABLE [dbo].[sys_role_authority]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_authority_sys_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[sys_role] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_authority] CHECK CONSTRAINT [FK_sys_role_authority_sys_role]
GO
ALTER TABLE [dbo].[sys_role_user]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_user_sys_role] FOREIGN KEY([sys_role_id])
REFERENCES [dbo].[sys_role] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_user] CHECK CONSTRAINT [FK_sys_role_user_sys_role]
GO
ALTER TABLE [dbo].[sys_role_user]  WITH CHECK ADD  CONSTRAINT [FK_sys_role_user_sys_user] FOREIGN KEY([sys_user_id])
REFERENCES [dbo].[sys_user] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[sys_role_user] CHECK CONSTRAINT [FK_sys_role_user_sys_user]
GO
ALTER TABLE [dbo].[teacherDuty]  WITH CHECK ADD  CONSTRAINT [FK_teacher_course_courses] FOREIGN KEY([courseId])
REFERENCES [dbo].[courses] ([courseId])
GO
ALTER TABLE [dbo].[teacherDuty] CHECK CONSTRAINT [FK_teacher_course_courses]
GO
ALTER TABLE [dbo].[teacherDuty]  WITH CHECK ADD  CONSTRAINT [FK_teacher_course_grades] FOREIGN KEY([gradeId])
REFERENCES [dbo].[grades] ([gradeId])
GO
ALTER TABLE [dbo].[teacherDuty] CHECK CONSTRAINT [FK_teacher_course_grades]
GO
ALTER TABLE [dbo].[teacherDuty]  WITH CHECK ADD  CONSTRAINT [FK_teacher_course_teachers] FOREIGN KEY([teacherId])
REFERENCES [dbo].[teachers] ([teacherId])
GO
ALTER TABLE [dbo].[teacherDuty] CHECK CONSTRAINT [FK_teacher_course_teachers]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1：迟到，2：旷课，3：请假（这张表的填充）4：签到成功' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'checkingIn', @level2type=N'COLUMN',@level2name=N'status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'坐标位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'checkingIn', @level2type=N'COLUMN',@level2name=N'position'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1：被使用，2：被启用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'courseSchedule', @level2type=N'COLUMN',@level2name=N'flag'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每个班级特定的二维码信息，教师，后台管理员可以修改' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'grades', @level2type=N'COLUMN',@level2name=N'gradeQRCode'
GO
USE [master]
GO
ALTER DATABASE [ForStudent] SET  READ_WRITE 
GO
