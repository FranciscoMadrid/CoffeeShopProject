USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Productos_Comidas_Show]    Script Date: 4/15/2021 12:28:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra los productos relacionados a comidas en la BDD
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Productos_Comidas_Show] 
@NombreProducto VARCHAR(100) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @NombreProducto IS NULL
	BEGIN
	SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
			  Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  ROUND(Comidas.Costo, 2, 1) AS Costo
	FROM            Productos INNER JOIN
                         Comidas ON Productos.ProductoID = Comidas.PFProductoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
	ORDER BY Productos.ProductoNombre
	END
	ELSE
	BEGIN
		SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
						Productos.ProductoDesc AS Descripcion, 
						Categorias.CategoriaDesc AS Categoria, 
						ROUND(Comidas.Costo, 2, 1) AS Costo
		FROM            Productos INNER JOIN
                         Comidas ON Productos.ProductoID = Comidas.PFProductoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
		WHERE Productos.ProductoNombre LIKE (@NombreProducto + '%')

		ORDER BY Productos.ProductoNombre
	END
END
GO

