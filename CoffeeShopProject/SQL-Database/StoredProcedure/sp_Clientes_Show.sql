USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Clientes_Show]    Script Date: 3/29/2021 1:16:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Francisco Madrid
-- Create date: 
-- Description:	Muestra los datos de la tabla cliente
-- =============================================
CREATE PROCEDURE [dbo].[sp_Clientes_Show] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT    ClienteID AS ID, 
			  PrimerNombre AS 'Primer Nombre', 
			  UltimoNombre AS 'Ultimo Nombre', 
			  CASE 
				WHEN Estado = 0 THEN 'Desactivado' 
				ELSE 'Activado' END AS 'Estado de Cliente'
FROM            Clientes
ORDER BY 'Estado de Cliente'
END
GO

