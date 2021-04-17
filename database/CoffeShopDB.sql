USE [master]
GO
/****** Object:  Database [CoffeeShopDB]    Script Date: 3/30/2021 12:42:53 PM ******/
CREATE DATABASE [CoffeeShopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CoffeeShopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CoffeeShopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CoffeeShopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\CoffeeShopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CoffeeShopDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CoffeeShopDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CoffeeShopDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CoffeeShopDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CoffeeShopDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CoffeeShopDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CoffeeShopDB] SET  MULTI_USER 
GO
ALTER DATABASE [CoffeeShopDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CoffeeShopDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CoffeeShopDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CoffeeShopDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CoffeeShopDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CoffeeShopDB] SET QUERY_STORE = OFF
GO
USE [CoffeeShopDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Productos_Bebidas_Costo_Sum]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Calcula el costo de bebidas por su cantidad segun la factura y id
-- =============================================
CREATE FUNCTION [dbo].[fn_Productos_Bebidas_Costo_Sum] 
(
	-- Add the parameters for the function here
	@FacturaID int,
	@ProductID int
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result money

	-- Add the T-SQL statements to compute the return value here

SELECT   @Result  =  SUM(FacturacionesProductos.Cantidad * ISNULL(Bebidas.Costo, 0))
FROM            FacturacionesProductos INNER JOIN
                         Productos ON FacturacionesProductos.FKProductoID = Productos.ProductoID INNER JOIN
                         Bebidas ON Productos.ProductoID = Bebidas.PFProductoID
WHERE FacturacionesProductos.FKFacturacionID = @FacturaID AND FacturacionesProductos.FKProductoID = @ProductID

RETURN ISNULL(@Result, 0.00)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Productos_Comidas_Costo_Sum]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Calcula el costo de un producto multiplicandolo por la cantidad
-- =============================================
CREATE FUNCTION [dbo].[fn_Productos_Comidas_Costo_Sum] 
(
	-- Add the parameters for the function here
	@FacturaID int,
	@ProductID int
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result money

	-- Add the T-SQL statements to compute the return value here

SELECT   @Result  =  SUM(FacturacionesProductos.Cantidad * Comidas.Costo) 
FROM            FacturacionesProductos INNER JOIN
                         Productos ON FacturacionesProductos.FKProductoID = Productos.ProductoID INNER JOIN
                         Comidas ON Productos.ProductoID = Comidas.PFProductoID 
WHERE FacturacionesProductos.FKFacturacionID = @FacturaID AND FacturacionesProductos.FKProductoID = @ProductID

	-- Return the result of the function
	RETURN ISNULL(@Result, 0.00)

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_Productos_Costo_Sum]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Realiza la suma total de la factura por cada producto
-- =============================================
CREATE FUNCTION [dbo].[fn_Productos_Costo_Sum] 
(
	-- Add the parameters for the function here
	@FacturaID int,
	@ProductID int
)
RETURNS money
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result money

	SELECT @Result = SUM([dbo].[fn_Productos_Comidas_Costo_Sum](@FacturaID, @ProductID) + [dbo].[fn_Productos_Bebidas_Costo_Sum](@FacturaID, @ProductID))

	-- Return the result of the function
	RETURN @Result

END
GO
/****** Object:  Table [dbo].[Bebidas]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bebidas](
	[PFProductoID] [int] NOT NULL,
	[Ingredientes] [varchar](200) NULL,
	[FKBebidaTamanoID] [int] NULL,
	[Costo] [money] NOT NULL,
 CONSTRAINT [PK_Bebidas] PRIMARY KEY CLUSTERED 
(
	[PFProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BebidasTamano]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BebidasTamano](
	[BebidaTamanoID] [int] IDENTITY(1,1) NOT NULL,
	[BebidaTamano] [varchar](50) NOT NULL,
 CONSTRAINT [PK_BebidasTamano] PRIMARY KEY CLUSTERED 
(
	[BebidaTamanoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargos]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargos](
	[CargoID] [int] IDENTITY(1,1) NOT NULL,
	[CargoDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Cargos] PRIMARY KEY CLUSTERED 
(
	[CargoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[CategoriaID] [int] IDENTITY(1,1) NOT NULL,
	[CategoriaDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Categorias] PRIMARY KEY CLUSTERED 
(
	[CategoriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[PrimerNombre] [varchar](50) NOT NULL,
	[UltimoNombre] [varchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Clientes] PRIMARY KEY CLUSTERED 
(
	[ClienteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comidas]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comidas](
	[PFProductoID] [int] NOT NULL,
	[Ingredientes] [varchar](200) NULL,
	[Costo] [money] NOT NULL,
 CONSTRAINT [PK_Comidas] PRIMARY KEY CLUSTERED 
(
	[PFProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empleados](
	[EmpleadoID] [int] IDENTITY(1,1) NOT NULL,
	[PrimerNombre] [varchar](70) NOT NULL,
	[UltimoNombre] [varchar](70) NOT NULL,
	[Correo] [varchar](150) NULL,
	[Direccion] [varchar](150) NOT NULL,
	[FKCargoID] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_Empleados] PRIMARY KEY CLUSTERED 
(
	[EmpleadoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpleadosUsuarios]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmpleadosUsuarios](
	[EmpleadoUsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[FKEmpleadoID] [int] NOT NULL,
	[FKTipoUsuario] [int] NOT NULL,
	[Usuario] [varchar](50) NOT NULL,
	[Contrasena] [varchar](50) NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_EmpleadosUsuarios] PRIMARY KEY CLUSTERED 
(
	[EmpleadoUsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturaciones]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facturaciones](
	[FacturacionID] [int] IDENTITY(1,1) NOT NULL,
	[FKClienteID] [int] NOT NULL,
	[FKEmpleadoUsuarioID] [int] NOT NULL,
	[FKFormasPagoID] [int] NOT NULL,
	[RTN] [varchar](15) NULL,
	[FechaEmitida] [datetime] NOT NULL,
	[SubTotal] [money] NOT NULL,
 CONSTRAINT [PK_Facturaciones] PRIMARY KEY CLUSTERED 
(
	[FacturacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturacionesProductos]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FacturacionesProductos](
	[FKFacturacionID] [int] NOT NULL,
	[FKProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
 CONSTRAINT [PK_FacturacionesProductos] PRIMARY KEY CLUSTERED 
(
	[FKFacturacionID] ASC,
	[FKProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormasPago]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormasPago](
	[FormaPagoID] [int] IDENTITY(1,1) NOT NULL,
	[FormaPagoDesc] [varchar](30) NOT NULL,
 CONSTRAINT [PK_FormasPago] PRIMARY KEY CLUSTERED 
(
	[FormaPagoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[InventarioID] [int] IDENTITY(1,1) NOT NULL,
	[FKProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Precio] [money] NOT NULL,
	[FechaInicial] [date] NOT NULL,
 CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED 
(
	[InventarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Productos](
	[ProductoID] [int] IDENTITY(1,1) NOT NULL,
	[ProductoNombre] [varchar](100) NOT NULL,
	[ProductoDesc] [varchar](150) NOT NULL,
	[FKCategoriaID] [int] NOT NULL,
 CONSTRAINT [PK_Productos] PRIMARY KEY CLUSTERED 
(
	[ProductoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoUsuarios]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoUsuarios](
	[TipoUsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[TipoUsuarioDesc] [varchar](50) NOT NULL,
 CONSTRAINT [PK_TipoUsuarios] PRIMARY KEY CLUSTERED 
(
	[TipoUsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bebidas]  WITH CHECK ADD  CONSTRAINT [FK_Bebidas_BebidasTamano] FOREIGN KEY([FKBebidaTamanoID])
REFERENCES [dbo].[BebidasTamano] ([BebidaTamanoID])
GO
ALTER TABLE [dbo].[Bebidas] CHECK CONSTRAINT [FK_Bebidas_BebidasTamano]
GO
ALTER TABLE [dbo].[Bebidas]  WITH CHECK ADD  CONSTRAINT [FK_Bebidas_Productos] FOREIGN KEY([PFProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[Bebidas] CHECK CONSTRAINT [FK_Bebidas_Productos]
GO
ALTER TABLE [dbo].[Comidas]  WITH CHECK ADD  CONSTRAINT [FK_Comidas_Productos] FOREIGN KEY([PFProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[Comidas] CHECK CONSTRAINT [FK_Comidas_Productos]
GO
ALTER TABLE [dbo].[Empleados]  WITH CHECK ADD  CONSTRAINT [FK_Empleados_Cargos] FOREIGN KEY([FKCargoID])
REFERENCES [dbo].[Cargos] ([CargoID])
GO
ALTER TABLE [dbo].[Empleados] CHECK CONSTRAINT [FK_Empleados_Cargos]
GO
ALTER TABLE [dbo].[EmpleadosUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_EmpleadosUsuarios_Empleados] FOREIGN KEY([FKEmpleadoID])
REFERENCES [dbo].[Empleados] ([EmpleadoID])
GO
ALTER TABLE [dbo].[EmpleadosUsuarios] CHECK CONSTRAINT [FK_EmpleadosUsuarios_Empleados]
GO
ALTER TABLE [dbo].[EmpleadosUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_EmpleadosUsuarios_TipoUsuarios] FOREIGN KEY([FKTipoUsuario])
REFERENCES [dbo].[TipoUsuarios] ([TipoUsuarioID])
GO
ALTER TABLE [dbo].[EmpleadosUsuarios] CHECK CONSTRAINT [FK_EmpleadosUsuarios_TipoUsuarios]
GO
ALTER TABLE [dbo].[Facturaciones]  WITH CHECK ADD  CONSTRAINT [FK_Facturaciones_Clientes] FOREIGN KEY([FKClienteID])
REFERENCES [dbo].[Clientes] ([ClienteID])
GO
ALTER TABLE [dbo].[Facturaciones] CHECK CONSTRAINT [FK_Facturaciones_Clientes]
GO
ALTER TABLE [dbo].[Facturaciones]  WITH CHECK ADD  CONSTRAINT [FK_Facturaciones_EmpleadosUsuarios] FOREIGN KEY([FKEmpleadoUsuarioID])
REFERENCES [dbo].[EmpleadosUsuarios] ([EmpleadoUsuarioID])
GO
ALTER TABLE [dbo].[Facturaciones] CHECK CONSTRAINT [FK_Facturaciones_EmpleadosUsuarios]
GO
ALTER TABLE [dbo].[Facturaciones]  WITH CHECK ADD  CONSTRAINT [FK_Facturaciones_FormasPago] FOREIGN KEY([FKFormasPagoID])
REFERENCES [dbo].[FormasPago] ([FormaPagoID])
GO
ALTER TABLE [dbo].[Facturaciones] CHECK CONSTRAINT [FK_Facturaciones_FormasPago]
GO
ALTER TABLE [dbo].[FacturacionesProductos]  WITH CHECK ADD  CONSTRAINT [FK_FacturacionesProductos_Facturaciones] FOREIGN KEY([FKFacturacionID])
REFERENCES [dbo].[Facturaciones] ([FacturacionID])
GO
ALTER TABLE [dbo].[FacturacionesProductos] CHECK CONSTRAINT [FK_FacturacionesProductos_Facturaciones]
GO
ALTER TABLE [dbo].[FacturacionesProductos]  WITH CHECK ADD  CONSTRAINT [FK_FacturacionesProductos_Productos] FOREIGN KEY([FKProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[FacturacionesProductos] CHECK CONSTRAINT [FK_FacturacionesProductos_Productos]
GO
ALTER TABLE [dbo].[Inventario]  WITH CHECK ADD  CONSTRAINT [FK_Inventario_Productos] FOREIGN KEY([FKProductoID])
REFERENCES [dbo].[Productos] ([ProductoID])
GO
ALTER TABLE [dbo].[Inventario] CHECK CONSTRAINT [FK_Inventario_Productos]
GO
ALTER TABLE [dbo].[Productos]  WITH CHECK ADD  CONSTRAINT [FK_Productos_Categorias] FOREIGN KEY([FKCategoriaID])
REFERENCES [dbo].[Categorias] ([CategoriaID])
GO
ALTER TABLE [dbo].[Productos] CHECK CONSTRAINT [FK_Productos_Categorias]
GO
/****** Object:  StoredProcedure [dbo].[sp_Clientes_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta informacion del cliente en la tabla Clientes
-- =============================================
CREATE PROCEDURE [dbo].[sp_Clientes_Insert] 
	-- Add the parameters for the stored procedure here
	@PrimerNombre varchar (50),
	@UltimoNombre varchar (50),
	@Estado int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[Clientes]
           ([PrimerNombre]
           ,[UltimoNombre]
           ,[Estado])
     VALUES
           (@PrimerNombre,
		    @UltimoNombre,
			 @Estado)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Clientes_Search]    Script Date: 3/30/2021 12:42:54 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Clientes_Show]    Script Date: 3/30/2021 12:42:54 PM ******/
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
/****** Object:  StoredProcedure [dbo].[sp_Clientes_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos de un cliente
-- =============================================
CREATE PROCEDURE [dbo].[sp_Clientes_Update] 
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
/****** Object:  StoredProcedure [dbo].[sp_Empleados_EmpleadosUsuarios_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[sp_Empleados_EmpleadosUsuarios_Insert] 
	-- Add the parameters for the stored procedure here
	@PrimerNombre Varchar(70),
	@UltimoNombre varchar(70),
	@Correo varchar(150),
	@Direccion varchar(150),
	@FKCargo int,

	@FKTipoUsuario int,
	@Usuario varchar(50),
	@Contrasena varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @EmpleadoID int

	EXECUTE @EmpleadoID = sp_Empleados_Insert @PrimerNombre, @UltimoNombre, @Correo, @Direccion, @FKCargo

	INSERT INTO [dbo].[EmpleadosUsuarios]
           ([FKEmpleadoID]
           ,[FKTipoUsuario]
           ,[Usuario]
           ,[Contrasena]
           ,[Estado])
     VALUES
           (@EmpleadoID,
		    @FKTipoUsuario,
			@Usuario,
			@Contrasena,
			1)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Empleados_EmpleadosUsuarios_Show]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra los datos de los Empleados y lo ordena segun el estado de la cuenta
-- =============================================
CREATE PROCEDURE [dbo].[sp_Empleados_EmpleadosUsuarios_Show] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT        CONCAT(Empleados.PrimerNombre, ' ', Empleados.UltimoNombre) AS Nombre, 
              Empleados.Correo, 
			  CASE WHEN Empleados.Estado = 1 THEN 'Activo' ELSE 'Desactivado' END AS 'Estado de Empleado',
			  Cargos.CargoDesc AS Cargo, 
			  TipoUsuarios.TipoUsuarioDesc AS 'Tipo de Usuario', 
              CASE WHEN EmpleadosUsuarios.Estado = 1 THEN 'Activo' ELSE 'Desactivado' END AS 'Estado de Cuenta'
FROM            Cargos INNER JOIN
                         Empleados ON Cargos.CargoID = Empleados.FKCargoID LEFT JOIN
                         EmpleadosUsuarios ON Empleados.EmpleadoID = EmpleadosUsuarios.FKEmpleadoID LEFT JOIN
                         TipoUsuarios ON EmpleadosUsuarios.FKTipoUsuario = TipoUsuarios.TipoUsuarioID

ORDER BY 'Estado de Cuenta'

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Empleados_EmpleadosUsuarios_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los campos de la tabla Empleado y empleadosUsuarios
-- =============================================
CREATE PROCEDURE [dbo].[sp_Empleados_EmpleadosUsuarios_Update] 
	-- Add the parameters for the stored procedure here
	@EmpleadoID int,
	@PrimerNombre varchar(70) = NULL,
	@UltimoNombre varchar(70) = NULL,
	@Correo varchar(150) = NULL,
	@Direccion varchar(150) = NULL,
	@FKCargoID int = NULL,
	@Estado int = NULL,

	@FKTipoUsuario int = NULL,
	@Usuario varchar(50) = NULL,
	@Contrasena varchar(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 EXECUTE sp_Empleados_Update @EmpleadoID, @PrimerNombre, @UltimoNombre, @Correo, @Direccion, @FKCargoID, @Estado

 UPDATE [dbo].[EmpleadosUsuarios]
   SET [FKTipoUsuario] = ISNULL(@FKTipoUsuario, FKTipoUsuario)
      ,[Usuario] = ISNULL(@Usuario, Usuario)
      ,[Contrasena] = ISNULL(@Contrasena, Contrasena)
      ,[Estado] = ISNULL(@Estado, Estado)
 WHERE [FKEmpleadoID] = @EmpleadoID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Empleados_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos en la tabla empleado
-- =============================================
CREATE PROCEDURE [dbo].[sp_Empleados_Insert] 
	-- Add the parameters for the stored procedure here
	@PrimerNombre varchar (70),
	@UltimoNombre varchar (70),
	@Correo varchar (150),
	@Direccion varchar (150),
	@FKCargoID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Empleados]
           ([PrimerNombre]
           ,[UltimoNombre]
           ,[Correo]
           ,[Direccion]
           ,[FKCargoID]
           ,[Estado])
     VALUES
           (@PrimerNombre,
			@UltimoNombre,
			@Correo,
			@Direccion,
			@FKCargoID,
			1)
	RETURN @@IDENTITY
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Empleados_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos en la tabla Empleados
-- =============================================
CREATE PROCEDURE [dbo].[sp_Empleados_Update] 
	@EmpleadoID int,
	@PrimerNombre varchar(70) = NULL,
	@UltimoNombre varchar(70) = NULL,
	@Correo varchar(150) = NULL,
	@Direccion varchar(150) = NULL,
	@FKCargoID int = NULL,
	@Estado int = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[Empleados]
   SET [PrimerNombre] = ISNULL(@PrimerNombre, PrimerNombre)
      ,[UltimoNombre] = ISNULL(@UltimoNombre, UltimoNombre)
      ,[Correo] = ISNULL(@Correo, Correo)
      ,[Direccion] = ISNULL(@Direccion,Direccion)
      ,[FKCargoID] = ISNULL(@FKCargoID, FKCargoID)
      ,[Estado] = ISNULL(@Estado, Estado)
 WHERE @EmpleadoID = [EmpleadoID]

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Facturaciones_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos a la tabla de Facturaciones
-- =============================================
CREATE PROCEDURE [dbo].[sp_Facturaciones_Insert] 
	-- Add the parameters for the stored procedure here
	@FKClienteID int,
	@FKEmpleadoUsuario int,
	@FKFormaPagoID int,
	@FechaEmitida date,
	@RTN varchar (15),
	@Subtotal money
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
INSERT INTO [dbo].[Facturaciones]
           ([FKClienteID]
           ,[FKEmpleadoUsuarioID]
           ,[FKFormasPagoID]
           ,[RTN]
           ,[FechaEmitida]
           ,[SubTotal])
     VALUES
           (@FKClienteID
           ,@FKEmpleadoUsuario
           ,@FKFormaPagoID
           ,@RTN
           ,@FechaEmitida
           ,@Subtotal)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Facturaciones_Sum]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Realiza la suma del cada producto segun la cantidad en la tabla de FacturacionProductos
-- =============================================
CREATE PROCEDURE [dbo].[sp_Facturaciones_Sum] 
	-- Add the parameters for the stored procedure here
	@FacturacionID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT    Facturaciones.FechaEmitida AS Fecha, Productos.ProductoNombre AS 'Nombre del Producto', 
			  FacturacionesProductos_1.Cantidad AS Cantidad, 
			  [dbo].[fn_Productos_Costo_Sum](@FacturacionID, FacturacionesProductos.FKProductoID) AS Total
FROM            FacturacionesProductos INNER JOIN
                         Facturaciones ON FacturacionesProductos.FKFacturacionID = Facturaciones.FacturacionID INNER JOIN
                         FacturacionesProductos AS FacturacionesProductos_1 ON Facturaciones.FacturacionID = FacturacionesProductos_1.FKFacturacionID INNER JOIN
                         Productos ON FacturacionesProductos.FKProductoID = Productos.ProductoID AND FacturacionesProductos_1.FKProductoID = Productos.ProductoID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_FacturacionesProductos_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos en la tabla FacturacionesProductos
-- =============================================
CREATE PROCEDURE [dbo].[sp_FacturacionesProductos_Insert] 
	-- Add the parameters for the stored procedure here
	@FKFacturacionID int,
	@FKProductoID int,
	@Cantidad int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[FacturacionesProductos]
           ([FKFacturacionID]
           ,[FKProductoID]
           ,[Cantidad])
     VALUES
           (@FKFacturacionID
           ,@FKProductoID
           ,@Cantidad)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Inventario_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos en la tabla de Inventario
-- =============================================
CREATE PROCEDURE [dbo].[sp_Inventario_Insert] 
	-- Add the parameters for the stored procedure here
	@FKProductoID int,
	@Cantidad int,
	@Precio money,
	@FechaInicial date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[Inventario]
           ([FKProductoID]
           ,[Cantidad]
           ,[Precio]
           ,[FechaInicial])
     VALUES
           (@FKProductoID, @Cantidad, @Precio, @FechaInicial)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Inventario_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos en la tabla Inventario
-- =============================================
CREATE PROCEDURE [dbo].[sp_Inventario_Update] 
	-- Add the parameters for the stored procedure here
	@InventarioID int,
	@FKProductoID int,
	@Cantidad int,
	@Precio money,
	@FechaInicial date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE [dbo].[Inventario]
   SET [Cantidad] = @Cantidad
      ,[Precio] = @Precio
      ,[FechaInicial] = @FechaInicial
 WHERE Inventario.InventarioID = @InventarioID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Bebidas_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta un nuevo producto en la tabla Productos y  se ingresa los detalles en la  tabla bebidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Bebidas_Insert] 
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
/****** Object:  StoredProcedure [dbo].[sp_Productos_Bebidas_Show]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra todo los productos de Bebidas en la BDD
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Bebidas_Show] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
              Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  BebidasTamano.BebidaTamano AS 'Tamaño de bebida', 
              Bebidas.Costo
FROM            Productos INNER JOIN
                         Bebidas ON Productos.ProductoID = Bebidas.PFProductoID INNER JOIN
                         BebidasTamano ON Bebidas.FKBebidaTamanoID = BebidasTamano.BebidaTamanoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Bebidas_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los campos en la tabla Productos y Bebidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Bebidas_Update] 
	-- Add the parameters for the stored procedure here
	@ProductoID int,
	@ProductoNombre varchar (100) = NULL,
	@ProductoDesc varchar (150) = NULL,
	@FKCategoriaID int = NULL,

	@Ingredientes varchar(200) = NULL,
	@FKBebidaTamanoID int = NULL,
	@Costo money = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	EXECUTE sp_Productos_Update @ProductoID, @ProductoNombre, @ProductoDesc, @FKCategoriaID

	UPDATE [dbo].[Bebidas]
    SET [Ingredientes] = ISNULL(@Ingredientes, Ingredientes)
       ,[FKBebidaTamanoID] = ISNULL(@FKBebidaTamanoID, FKBebidaTamanoID)
       ,[Costo] = ISNULL(@Costo, Costo)
    WHERE [PFProductoID] = @ProductoID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Comidas_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta nuevos productos en la tabla Productos y lo ingresa en la tabla Comidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Comidas_Insert] 
	-- Add the parameters for the stored procedure here
	@ProductoNombre varchar(100),
	@ProductoDesc varchar(150),
	@FKCategoriaID int,
	@Ingredientes varchar (200) = NULL,
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


	INSERT INTO [dbo].[Comidas]
           ([PFProductoID]
           ,[Ingredientes]
           ,[Costo])
     VALUES
           (@ProductoID,
		    @Ingredientes,
			@Costo)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Comidas_Show]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra los productos relacionados a comidas en la BDD
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Comidas_Show] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
			  Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  Comidas.Costo
FROM            Productos INNER JOIN
                         Comidas ON Productos.ProductoID = Comidas.PFProductoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Comidas_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los campos de la tabla Productos y Comidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Comidas_Update] 
	-- Add the parameters for the stored procedure here
	@ProductoID int,
	@ProductoNombre varchar (100) = NULL,
	@ProductoDesc varchar (150) = NULL,
	@FKCategoriaID int = NULL,

	@Ingredientes varchar (200) = NULL,
	@Costo money = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	EXECUTE sp_Productos_Update @ProductoID, @ProductoNombre, @ProductoDesc, @FKCategoriaID

	UPDATE [dbo].[Comidas]
    SET [Ingredientes] = ISNULL(@Ingredientes, Ingredientes)
       ,[Costo] = ISNULL(@Costo, Costo)
    WHERE [PFProductoID] = @ProductoID

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Insert]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos en la tabla Productos
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Insert] 
	-- Add the parameters for the stored procedure here
	@ProductoNombre varchar(100),
	@ProductoDesc varchar(150),
	@FKCategoria int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO [dbo].[Productos]
           ([ProductoNombre]
           ,[ProductoDesc]
           ,[FKCategoriaID])
     VALUES
           (@ProductoNombre, @ProductoDesc, @FKCategoria)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Show]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Muestra la totalida de t odos los productos incluyendo Comidas y Bebidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Show] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT        Productos.ProductoID, Productos.ProductoNombre AS 'Nombre de Producto', 
		      Productos.ProductoDesc AS Descripcion, 
			  Categorias.CategoriaDesc AS Categoria, 
			  Bebidas.Costo AS Costo
FROM            Productos INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID INNER JOIN
                         Bebidas ON Productos.ProductoID = Bebidas.PFProductoID
UNION
(SELECT        Comidas.PFProductoID, Productos.ProductoNombre, Productos.ProductoDesc, Categorias.CategoriaDesc, Comidas.Costo
FROM            Comidas INNER JOIN
                         Productos ON Comidas.PFProductoID = Productos.ProductoID INNER JOIN
                         Categorias ON Productos.FKCategoriaID = Categorias.CategoriaID)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Productos_Update]    Script Date: 3/30/2021 12:42:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos en la tabla Productos
-- =============================================
CREATE PROCEDURE [dbo].[sp_Productos_Update] 
	-- Add the parameters for the stored procedure here
	@ProductoID int,
	@ProductoNombre varchar (100) = NULL,
	@ProductoDesc varchar (150) = NULL,
	@FKCategoriaID int = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		--ISNULL() se utiliza para el evento en que el valor ingresado haya sido null que simplemente lo ingrese lo que ya esta en la tabla
		   UPDATE [dbo].[Productos]
		   SET [ProductoNombre] = ISNULL(@ProductoNombre, ProductoNombre)
			  ,[ProductoDesc] = ISNULL(@ProductoDesc, ProductoDesc)
			  ,[FKCategoriaID] = ISNULL(@FKCategoriaID,FKCategoriaID)
		   WHERE [ProductoID] = @ProductoID
END
GO
USE [master]
GO
ALTER DATABASE [CoffeeShopDB] SET  READ_WRITE 
GO
