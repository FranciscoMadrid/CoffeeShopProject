USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Productos_Bebidas_Insert]    Script Date: 4/14/2021 9:54:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta un nuevo producto en la tabla Productos y  se ingresa los detalles en la  tabla bebidas
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Productos_Bebidas_Insert] 
	-- Add the parameters for the stored procedure here
	@ProductoNombre varchar(100),
	@ProductoDesc varchar(150),
	@FKCategoriaID int,
	@Ingredientes varchar (200) = NULL,
	@TamanoBebida int = NULL,
	@Costo money
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductoID int

	INSERT INTO [dbo].[Productos]
           ([ProductoNombre]
           ,[ProductoDesc]
           ,[FKCategoriaID])
     VALUES
           (@ProductoNombre,
		    @ProductoDesc,
			@FKCategoriaID)

	SELECT @ProductoID = @@IDENTITY


	INSERT INTO [dbo].[Bebidas]
           ([PFProductoID]
           ,[Ingredientes]
           ,[FKBebidaTamanoID]
           ,[Costo])
     VALUES
           (@ProductoID,
		    @Ingredientes,
			@TamanoBebida,
			@Costo)
END
GO

