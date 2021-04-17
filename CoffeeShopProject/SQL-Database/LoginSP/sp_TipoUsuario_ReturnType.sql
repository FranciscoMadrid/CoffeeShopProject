USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_TipoUsuarios_ReturnType]    Script Date: 4/16/2021 9:04:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Busca que tipo de usuario es el empleado y retorna su designacion
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_TipoUsuarios_ReturnType] 
	-- Add the parameters for the stored procedure here
	@EmpleadoId INT,
	@TipoUsuarioID INT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        @TipoUsuarioID = TipoUsuarios.TipoUsuarioID
FROM            EmpleadosUsuarios INNER JOIN
                         TipoUsuarios ON EmpleadosUsuarios.FKTipoUsuario = TipoUsuarios.TipoUsuarioID
WHERE EmpleadosUsuarios.FKEmpleadoID = @EmpleadoId
END
GO

