USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Clientes_Search]    Script Date: 3/29/2021 1:16:24 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Busca el cliente en base al tipo de busqueda selecionada.
-- Id = 0, PrimerNombre = 1, UltimoNombre = 2, Estado = 3
-- =============================================
CREATE PROCEDURE [dbo].[sp_Clientes_Search] 
	-- Add the parameters for the stored procedure here
	@TipoBusquedad int,
	@ClienteID int = NULL,
	@PrimerNombre varchar(50) = NULL,
	@UltimoNombre varchar(50) = NULL,
	@Estado int = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @TipoBusquedad = 0
	BEGIN
		SELECT  ClienteID AS ID, 
				PrimerNombre AS 'Primer Nombre', 
				UltimoNombre AS 'Ultimo Nombre', 
				CASE WHEN Estado = 0 THEN 'Desactivado'
				ELSE 'Activado' END AS 'Estado de Cliente'
		FROM            Clientes

		WHERE ClienteID = @ClienteID
	  END

	IF @TipoBusquedad = 1
	BEGIN
		SELECT  ClienteID AS ID, 
				PrimerNombre AS 'Primer Nombre', 
				UltimoNombre AS 'Ultimo Nombre', 
				CASE WHEN Estado = 0 THEN 'Desactivado'
				ELSE 'Activado' END AS 'Estado de Cliente'
		FROM            Clientes

		WHERE PrimerNombre LIKE (@PrimerNombre + '%')
	END

	IF @TipoBusquedad = 2
	BEGIN
		SELECT  ClienteID AS ID, 
				PrimerNombre AS 'Primer Nombre', 
				UltimoNombre AS 'Ultimo Nombre', 
				CASE WHEN Estado = 0 THEN 'Desactivado'
				ELSE 'Activado' END AS 'Estado de Cliente'
		FROM            Clientes

		WHERE UltimoNombre LIKE (@UltimoNombre + '%')
	END

		IF @TipoBusquedad = 3
	BEGIN
		SELECT  ClienteID AS ID, 
				PrimerNombre AS 'Primer Nombre', 
				UltimoNombre AS 'Ultimo Nombre', 
				CASE WHEN Estado = 0 THEN 'Desactivado'
				ELSE 'Activado' END AS 'Estado de Cliente'
		FROM            Clientes

		WHERE Estado = @Estado
	END

END
GO

