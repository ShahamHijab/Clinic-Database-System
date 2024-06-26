USE [ClinicSystem]
GO
/****** Object:  Table [dbo].[Visit]    Script Date: 1/21/2024 12:19:04 PM ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'reservation_id and visit_reservation_id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Visit', @level2type=N'CONSTRAINT',@level2name=N'FK_Visit_Reservation_clinic'
GO
