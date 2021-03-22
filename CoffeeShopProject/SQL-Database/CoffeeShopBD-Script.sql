USE [master]
GO
/****** Object:  Database [CoffeeShopDB]    Script Date: 3/21/2021 7:42:10 PM ******/
CREATE DATABASE [CoffeeShopDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CoffeeShopDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CoffeeShopDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CoffeeShopDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\CoffeeShopDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CoffeeShopDB] SET COMPATIBILITY_LEVEL = 150
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
ALTER DATABASE [CoffeeShopDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CoffeeShopDB] SET QUERY_STORE = OFF
GO
USE [CoffeeShopDB]
GO
/****** Object:  Table [dbo].[Bebidas]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BebidasTamano]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargos]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comidas]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empleados]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmpleadosUsuarios]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Facturaciones]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FacturacionesProductos]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FormasPago]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventario]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventario](
	[InventarioID] [int] IDENTITY(1,1) NOT NULL,
	[FKProductoID] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Precio] [float] NOT NULL,
	[FechaInicial] [date] NOT NULL,
 CONSTRAINT [PK_Inventario] PRIMARY KEY CLUSTERED 
(
	[InventarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Productos]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoUsuarios]    Script Date: 3/21/2021 7:42:11 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Clientes]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta informacion del cliente en la tabla Clientes
-- =============================================
CREATE PROCEDURE [dbo].[sp_Insert_Clientes] 
	-- Add the parameters for the stored procedure here
	@PrimerNombre varchar (50),
	@UltimoNombre varchar (50)
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
			 1)

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Empleados]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta datos en la tabla empleado
-- =============================================
CREATE PROCEDURE [dbo].[sp_Insert_Empleados] 
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
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Productos_Bebidas]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta un nuevo producto en la tabla Productos y  se ingresa los detalles en la  tabla bebidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Insert_Productos_Bebidas] 
	-- Add the parameters for the stored procedure here
	@ProductoNombre varchar(100),
	@ProductoDesc varchar(150),
	@FKCategoriaID int,
	@Ingredientes varchar (200),
	@TamanoBebida int,
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Productos_Comidas]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Inserta nuevos productos en la tabla Productos y lo ingresa en la tabla Comidas
-- =============================================
CREATE PROCEDURE [dbo].[sp_Insert_Productos_Comidas] 
	-- Add the parameters for the stored procedure here
	@ProductoNombre varchar(100),
	@ProductoDesc varchar(150),
	@FKCategoriaID int,
	@Ingredientes varchar (200),
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Clientes]    Script Date: 3/21/2021 7:42:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		FranciscoMadrid
-- Create date: 
-- Description:	Actualiza los datos de un cliente
-- =============================================
CREATE PROCEDURE [dbo].[sp_Update_Clientes] 
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

	IF @PrimerNombre IS NOT NULL AND @UltimoNombre IS NULL AND @Estado IS NULL
		
		BEGIN
			UPDATE [dbo].[Clientes]
			SET [PrimerNombre] = @PrimerNombre
			WHERE [dbo].[Clientes].ClienteID = @ClienteID
		END
	
	IF @UltimoNombre IS NOT NULL AND @PrimerNombre IS NULL AND @Estado IS NULL
		BEGIN
			UPDATE [dbo].[Clientes]
			SET [UltimoNombre] = @UltimoNombre
			WHERE [dbo].[Clientes].ClienteID = @ClienteID
		END

	IF @Estado IS NOT NULL AND @PrimerNombre IS NULL AND @UltimoNombre IS NULL
		BEGIN
			UPDATE [dbo].[Clientes]
			SET [Estado] = @Estado
			WHERE [dbo].[Clientes].ClienteID = @ClienteID
		END

	IF @UltimoNombre IS NOT NULL AND @PrimerNombre IS NOT NULL AND @Estado IS NULL
		BEGIN
			UPDATE [dbo].[Clientes]
			SET [PrimerNombre] = @PrimerNombre,
				[UltimoNombre] = @UltimoNombre
			WHERE [dbo].[Clientes].ClienteID = @ClienteID
		END
END
GO
USE [master]
GO
ALTER DATABASE [CoffeeShopDB] SET  READ_WRITE 
GO
