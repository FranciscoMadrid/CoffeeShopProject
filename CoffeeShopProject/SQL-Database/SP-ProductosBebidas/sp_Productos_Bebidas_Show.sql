USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Productos_Bebidas_Show]    Script Date: 4/14/2021 9:54:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra todo los productos de Bebidas en la BDD
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Productos_Bebidas_Show] 
	-- Add the parameters for the stored procedure here
	@NombreProducto VARCHAR (100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
IF @NombreProducto IS NULL
	BEGIN
	SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
              Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  BebidasTamano.BebidaTamano AS 'Tamaño de bebida', 
              ROUND(Bebidas.Costo, 2, 1) AS Costo
FROM            Productos INNER JOIN
                         Bebidas ON Productos.ProductoID = Bebidas.PFProductoID LEFT JOIN
                         BebidasTamano ON Bebidas.FKBebidaTamanoID = BebidasTamano.BebidaTamanoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
	END

	IF @NombreProducto IS NOT NULL
	BEGIN
	SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
              Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  BebidasTamano.BebidaTamano AS 'Tamaño de bebida', 
              ROUND(Bebidas.Costo, 2, 1) AS Costo
FROM            Productos INNER JOIN
                         Bebidas ON Productos.ProductoID = Bebidas.PFProductoID LEFT JOIN
                         BebidasTamano ON Bebidas.FKBebidaTamanoID = BebidasTamano.BebidaTamanoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
WHERE Productos.ProductoNombre LIKE (@NombreProducto + '%')
	END
END
GO

