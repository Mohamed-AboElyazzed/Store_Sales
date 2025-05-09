USE [master]
GO
/****** Object:  Database [Finel-Project]    Script Date: 27/02/2025 06:50:29 م ******/
CREATE DATABASE [Finel-Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Finel-Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEPI\MSSQL\DATA\Finel-Project.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Finel-Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.DEPI\MSSQL\DATA\Finel-Project_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Finel-Project] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Finel-Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Finel-Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Finel-Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Finel-Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Finel-Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Finel-Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [Finel-Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Finel-Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Finel-Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Finel-Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Finel-Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Finel-Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Finel-Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Finel-Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Finel-Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Finel-Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Finel-Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Finel-Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Finel-Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Finel-Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Finel-Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Finel-Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Finel-Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Finel-Project] SET RECOVERY FULL 
GO
ALTER DATABASE [Finel-Project] SET  MULTI_USER 
GO
ALTER DATABASE [Finel-Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Finel-Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Finel-Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Finel-Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Finel-Project] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Finel-Project', N'ON'
GO
ALTER DATABASE [Finel-Project] SET QUERY_STORE = OFF
GO
USE [Finel-Project]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 27/02/2025 06:50:29 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Customer_ID] [nvarchar](20) NOT NULL,
	[Customer_Name] [nvarchar](100) NULL,
	[Segment] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Customer_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 27/02/2025 06:50:29 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Order_ID] [nvarchar](20) NOT NULL,
	[Order_Date] [date] NULL,
	[Ship_Date] [date] NULL,
	[Sales] [decimal](10, 4) NULL,
	[Customer_ID] [nvarchar](20) NULL,
	[Store_Branch_ID] [int] NULL,
	[Ship_Mode_ID] [int] NULL,
	[Product_ID] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Order_ID] ASC,
	[Product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 27/02/2025 06:50:29 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Product_ID] [nvarchar](20) NOT NULL,
	[Category] [nvarchar](50) NULL,
	[Sub_Category] [nvarchar](50) NULL,
	[Product_Name] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[Product_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ship_Modes]    Script Date: 27/02/2025 06:50:29 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ship_Modes](
	[Ship_Mode_ID] [int] IDENTITY(1,1) NOT NULL,
	[Ship_Mode_Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Ship_Mode_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Store_Branches]    Script Date: 27/02/2025 06:50:29 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Store_Branches](
	[Store_Branch_ID] [int] IDENTITY(1,1) NOT NULL,
	[City] [nvarchar](100) NULL,
	[State] [nvarchar](50) NULL,
	[Postal_Code] [nvarchar](20) NULL,
	[Region] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Store_Branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Customer_ID])
REFERENCES [dbo].[Customers] ([Customer_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Product_ID])
REFERENCES [dbo].[Products] ([Product_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Ship_Mode_ID])
REFERENCES [dbo].[Ship_Modes] ([Ship_Mode_ID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([Store_Branch_ID])
REFERENCES [dbo].[Store_Branches] ([Store_Branch_ID])
GO
USE [master]
GO
ALTER DATABASE [Finel-Project] SET  READ_WRITE 
GO
