USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Inventario_Show]    Script Date: 9/4/2021 20:18:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


--Store procedure para visualizarlo en la tabla
CREATE procedure [dbo].[sp_Inventario_Show] 		
as 
begin

	Select Inventario.InventarioID AS INVENTARIO_ID,
			Inventario.FKProductoID AS ProductoID,
			Inventario.Cantidad,
		    Inventario.Precio, Inventario.FechaInicial	AS FechaIngreso
			
	from Inventario


end
GO

