USE [CoffeeShopDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_Empleados_EmpleadosUsuarios_Checker]    Script Date: 4/16/2021 9:04:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Revisa si el record existe segun el usuario y la contraseña sino devuelve 0
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_Empleados_EmpleadosUsuarios_Checker] 
	-- Add the parameters for the stored procedure here
	@Usuario VARCHAR(50),
	@Contrasena VARCHAR(50),
	@EmpleadoId INT OUTPUT,
	@EmpleadoNombre VARCHAR(70) OUTPUT,
	@EmpleadoApellido VARCHAR(70) OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
IF EXISTS (SELECT        FKEmpleadoID, FKTipoUsuario, Usuario, Contrasena, Estado
FROM            EmpleadosUsuarios
WHERE Usuario = @Usuario COLLATE Latin1_General_CS_AS AND Contrasena COLLATE Latin1_General_CS_AS = @Contrasena AND Estado = 1)
BEGIN
(
SELECT        @EmpleadoId = EmpleadosUsuarios.FKEmpleadoID, @EmpleadoNombre = Empleados.PrimerNombre, @EmpleadoApellido = Empleados.UltimoNombre
FROM            Empleados INNER JOIN
                         EmpleadosUsuarios ON Empleados.EmpleadoID = EmpleadosUsuarios.FKEmpleadoID
WHERE Usuario = @Usuario COLLATE Latin1_General_CS_AS AND Contrasena COLLATE Latin1_General_CS_AS = @Contrasena AND EmpleadosUsuarios.Estado = 1)
END
ELSE
BEGIN
(
SELECT @EmpleadoId = 0
)
END
END
GO

