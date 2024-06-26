USE [ClinicSystem]
GO
/****** Object:  Table [dbo].[accounts_clinic]    Script Date: 1/21/2024 12:19:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[accounts_clinic](
	[account_id] [int] IDENTITY(1,1) NOT NULL,
	[account_user_id] [int] NOT NULL,
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
ALTER TABLE [dbo].[accounts_clinic]  WITH CHECK ADD  CONSTRAINT [FK_accounts_clinic_User] FOREIGN KEY([account_user_id])
REFERENCES [dbo].[User] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[accounts_clinic] CHECK CONSTRAINT [FK_accounts_clinic_User]
GO
