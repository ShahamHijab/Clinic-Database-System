USE [ClinicSystem]
GO
/****** Object:  Table [dbo].[Reservation_clinic]    Script Date: 1/21/2024 12:19:04 PM ******/
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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'account_id and reservation_patient_id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Reservation_clinic', @level2type=N'CONSTRAINT',@level2name=N'FK_Reservation_clinic_accounts_clinic1'
GO
