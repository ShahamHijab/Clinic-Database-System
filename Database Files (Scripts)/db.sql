USE [master]
GO
/****** Object:  Database [ClinicSystem]    Script Date: 1/23/2024 6:33:18 PM ******/
CREATE DATABASE [ClinicSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ClinicSystem', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ClinicSystem.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ClinicSystem_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ClinicSystem_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ClinicSystem] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ClinicSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ClinicSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ClinicSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ClinicSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ClinicSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ClinicSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [ClinicSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ClinicSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ClinicSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ClinicSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ClinicSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ClinicSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ClinicSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ClinicSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ClinicSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ClinicSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ClinicSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ClinicSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ClinicSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ClinicSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ClinicSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ClinicSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ClinicSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ClinicSystem] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ClinicSystem] SET  MULTI_USER 
GO
ALTER DATABASE [ClinicSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ClinicSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ClinicSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ClinicSystem] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ClinicSystem] SET DELAYED_DURABILITY = DISABLED 
GO
USE [ClinicSystem]
GO
/****** Object:  Table [dbo].[accounts_clinic]    Script Date: 1/23/2024 6:33:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[accounts_clinic](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[account_user_id] [int] NULL,
	[account_name] [varchar](50) NOT NULL,
	[account_dob] [date] NULL,
	[account_creation_date] [datetime] NOT NULL,
	[account_notes] [varchar](200) NULL,
	[account_type] [int] NOT NULL,
	[account_phone] [varchar](50) NULL,
 CONSTRAINT [PK_accounts_clinic] PRIMARY KEY CLUSTERED 
(
	[account_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Reservation_clinic]    Script Date: 1/23/2024 6:33:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation_clinic](
	[reservation_id] [int] IDENTITY(1,1) NOT NULL,
	[reservation_patient_id] [int] NOT NULL,
	[reservation_secretary_id] [int] NOT NULL,
	[reservation_visit_date] [date] NOT NULL,
	[reservation_visit_slot] [int] NOT NULL,
	[reservation_date] [datetime] NOT NULL,
 CONSTRAINT [PK_Reservation_clinic] PRIMARY KEY CLUSTERED 
(
	[reservation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 1/23/2024 6:33:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[user_username] [varchar](50) NOT NULL,
	[user_password] [varchar](max) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 1/23/2024 6:33:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Visit](
	[visit_id] [int] IDENTITY(1,1) NOT NULL,
	[visit_reservation_id] [int] NOT NULL,
	[visit_doctor_id] [int] NOT NULL,
	[visit_reasons] [varchar](200) NULL,
	[visit_diagnosis] [varchar](200) NOT NULL,
	[visit_notes] [varchar](200) NULL,
	[visit_date] [date] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[accounts_clinic]  WITH CHECK ADD  CONSTRAINT [FK_accounts_clinic_User] FOREIGN KEY([account_user_id])
REFERENCES [dbo].[User] ([user_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[accounts_clinic] CHECK CONSTRAINT [FK_accounts_clinic_User]
GO
ALTER TABLE [dbo].[Reservation_clinic]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_clinic_accounts_clinic1] FOREIGN KEY([reservation_patient_id])
REFERENCES [dbo].[accounts_clinic] ([account_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Reservation_clinic] CHECK CONSTRAINT [FK_Reservation_clinic_accounts_clinic1]
GO
ALTER TABLE [dbo].[Reservation_clinic]  WITH CHECK ADD  CONSTRAINT [FK_Reservation_clinic_accounts_clinic2] FOREIGN KEY([reservation_secretary_id])
REFERENCES [dbo].[accounts_clinic] ([account_id])
GO
ALTER TABLE [dbo].[Reservation_clinic] CHECK CONSTRAINT [FK_Reservation_clinic_accounts_clinic2]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_accounts_clinic] FOREIGN KEY([visit_doctor_id])
REFERENCES [dbo].[accounts_clinic] ([account_id])
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_accounts_clinic]
GO
ALTER TABLE [dbo].[Visit]  WITH CHECK ADD  CONSTRAINT [FK_Visit_Reservation_clinic] FOREIGN KEY([visit_reservation_id])
REFERENCES [dbo].[Reservation_clinic] ([reservation_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Visit] CHECK CONSTRAINT [FK_Visit_Reservation_clinic]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'account_id and reservation_patient_id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation_clinic', @level2type=N'CONSTRAINT',@level2name=N'FK_Reservation_clinic_accounts_clinic1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'reservation_id and visit_reservation_id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Visit', @level2type=N'CONSTRAINT',@level2name=N'FK_Visit_Reservation_clinic'
GO
USE [master]
GO
ALTER DATABASE [ClinicSystem] SET  READ_WRITE 
GO
