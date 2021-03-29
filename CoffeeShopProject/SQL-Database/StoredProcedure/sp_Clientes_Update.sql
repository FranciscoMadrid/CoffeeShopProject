USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Clientes_Update]    Script Date: 3/29/2021 1:16:41 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos de un cliente
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Clientes_Update] 
	-- Add the parameters for the stored procedure here
	@ClienteID int,
	@PrimerNombre varchar (50),
	@UltimoNombre varchar (50),
	@Estado int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[Clientes]
    SET [PrimerNombre] = ISNULL(@PrimerNombre, Clientes.PrimerNombre)
      ,[UltimoNombre] = ISNULL(@UltimoNombre, Clientes.UltimoNombre)
      ,[Estado] = ISNULL(@Estado, Clientes.Estado)
	WHERE Clientes.ClienteID = @ClienteID

END
GO

