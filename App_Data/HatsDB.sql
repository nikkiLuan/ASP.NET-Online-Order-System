USE [master]
GO
/****** Object:  Database [HatsDB]    Script Date: 10/06/2015 13:03:10 ******/
CREATE DATABASE [HatsDB] ON  PRIMARY 
( NAME = N'HatsDB', FILENAME = N'D:\Software\SqlServer2008\MSSQL10_50.MYSQL\MSSQL\DATA\HatsDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HatsDB_log', FILENAME = N'D:\Software\SqlServer2008\MSSQL10_50.MYSQL\MSSQL\DATA\HatsDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HatsDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HatsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HatsDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [HatsDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [HatsDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [HatsDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [HatsDB] SET ARITHABORT OFF
GO
ALTER DATABASE [HatsDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [HatsDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [HatsDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [HatsDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [HatsDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [HatsDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [HatsDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [HatsDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [HatsDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [HatsDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [HatsDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [HatsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [HatsDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [HatsDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [HatsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [HatsDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [HatsDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [HatsDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [HatsDB] SET  READ_WRITE
GO
ALTER DATABASE [HatsDB] SET RECOVERY FULL
GO
ALTER DATABASE [HatsDB] SET  MULTI_USER
GO
ALTER DATABASE [HatsDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [HatsDB] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'HatsDB', N'ON'
GO
USE [HatsDB]
GO
/****** Object:  Table [dbo].[ProductOrder]    Script Date: 10/06/2015 13:03:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductOrder](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[Amount] [int] NULL,
	[IsSend] [bit] NOT NULL,
	[HatsFee] [float] NOT NULL,
	[GstFee] [float] NOT NULL,
	[TotalPrice] [float] NOT NULL,
	[ReceiverName] [nvarchar](50) NOT NULL,
	[ReceiverPhone] [nvarchar](20) NOT NULL,
	[ReceiverPostCode] [nvarchar](50) NOT NULL,
	[ReceiverAddress] [nvarchar](200) NOT NULL,
	[ReceiverEmail] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ProductOrder] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_SearchBar]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_SearchBar]
(
@keywords varchar(50)
)
as
declare
@sql nvarchar(1024)
set @sql='select * from Products b, Category c 
          where b.CategoryID=c.CategoryID 
          and 
			(ProductID like ''%'+CONVERT(NVARCHAR(50),@keywords)+'%'' 
			or HatName like ''%'+CONVERT(NVARCHAR(50),@keywords)+'%'' 
			or CategoryName like''%'+CONVERT(NVARCHAR(50),@keywords)+'%''
			or Colour like''%'+CONVERT(NVARCHAR(50),@keywords)+'%''
			or Price like''%'+CONVERT(NVARCHAR(50),@keywords)+'%'')'
			
exec(@sql)
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](20) NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[UserName] [nvarchar](20) NOT NULL,
	[Email] [nvarchar](30) NOT NULL,
	[Password] [nvarchar](15) NOT NULL,
	[Address] [nvarchar](max) NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[HomePhone] [nvarchar](50) NULL,
	[WorkPhone] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](50) NOT NULL,
	[HomePhone] [nvarchar](50) NULL,
	[WorkPhone] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Colour]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colour](
	[ColourID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Colour] PRIMARY KEY CLUSTERED 
(
	[ColourID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category1]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category1](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category_1] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[RealName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Admin] PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_AddOrder]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_AddOrder]
(
@HatsFee float,
@GstFee float,
@TotalNum int,
@Name varchar(50),
@Phone varchar(20),
@PostCode nvarchar(50),
@Address varchar(200),
@Email varchar(50),
@OrderID int output
)
as
Insert into ProductOrder
(HatsFee,GstFee,TotalPrice,Amount,ReceiverName,ReceiverPhone,ReceiverPostCode,ReceiverAddress,ReceiverEmail)
values
(@HatsFee,@GstFee,(@HatsFee+@GstFee),@TotalNum,@Name,@Phone,@PostCode,@Address,@Email)
select @OrderID=@@identity
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[DetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Number] [int] NOT NULL,
	[HatsFee] [float] NOT NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[DetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_AddUser]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_AddUser]
(
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@Mobile nvarchar(20),
	@HomePhone char(20),
	@WorkPhone char(20),
	@Email nvarchar(50),
	@Address nvarchar(200)
)
as
if Exists(select * from UserInfo where UserName=@UserName)
	return -100
else
	begin
		Insert UserInfo(FirstName,LastName,UserName,Password,Mobile,HomePhone,WorkPhone,Email,Address)
		values(@FirstName,@LastName,@UserName,@Password,@Mobile,@HomePhone,@WorkPhone,@Email,@Address)
		return 100
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_GetCategory]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_GetCategory]
(
	@CategoryID int
)
as
if exists(select * from Category where CategoryID=@CategoryID)
	begin
		select CategoryName from Category 
		where CategoryID=@CategoryID
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_GetColour]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_GetColour]
(
	@ColourID int
)
as
if exists(select * from Colour where ColourID=@ColourID)
	begin
		select Name from Colour 
		where ColourID=@ColourID
	end
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[HatName] [nvarchar](max) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Price] [float] NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ColourID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[IsHot] [bit] NULL,
	[LoadDate] [datetime] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[proc_GetUser]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_GetUser]
(
	@UserID int 
)
as
if exists(select * from UserInfo where UserID=@UserID)
	begin
		select * from UserInfo 
		where  UserID=@UserID
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_UserLogin]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_UserLogin]
(
	@UserName varchar(50),
	@Password varchar(50)
)
as
if exists(select * from UserInfo where UserName=@UserName and Password=@Password)
	begin
		select * from UserInfo 
		where UserName=@UserName and Password=@Password
	end
GO
/****** Object:  StoredProcedure [dbo].[Proc_UploadImage]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc  [dbo].[Proc_UploadImage]
(
@Path nvarchar(255),
@ProductID int
)
as
begin
	update  Products 
	 set  Path=@Path 
	where ProductID=@ProductID
end
GO
/****** Object:  StoredProcedure [dbo].[proc_NewHats]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[proc_NewHats]
as
select * from Products
where DATEDIFF(day, LoadDate, getdate()) < 7
GO
/****** Object:  StoredProcedure [dbo].[proc_GetPrice]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_GetPrice]
(
	@ProductID int
)
as
if exists(select * from Products where ProductID=@ProductID)
	begin
		select Price from Products 
		where ProductID=@ProductID
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_GetCategoryList]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_GetCategoryList]
(
	@CategoryID int
)
as

	begin
		select * from Products
		where CategoryID=@CategoryID
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_DisplayHat]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[proc_DisplayHat]
(
	@Display int
)
as
if(@Display=1)-- hot sale
	begin
		 select top 6 * from Products
		 where IsHot=1 
	end
GO
/****** Object:  StoredProcedure [dbo].[proc_AddOrderDetail]    Script Date: 10/06/2015 13:03:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[proc_AddOrderDetail]
(
@ProductID int,
@Num int,
@OrderID int,
@HatsFee float
)
as
Insert into OrderDetail
(ProductID,Number,OrderID,HatsFee)
values
(@ProductID,@Num,@OrderID,@HatsFee)
GO
/****** Object:  Default [DF_ProductOrder_OrderDate]    Script Date: 10/06/2015 13:03:12 ******/
ALTER TABLE [dbo].[ProductOrder] ADD  CONSTRAINT [DF_ProductOrder_OrderDate]  DEFAULT (getdate()) FOR [OrderDate]
GO
/****** Object:  Default [DF_ProductOrder_IsSend]    Script Date: 10/06/2015 13:03:12 ******/
ALTER TABLE [dbo].[ProductOrder] ADD  CONSTRAINT [DF_ProductOrder_IsSend]  DEFAULT ((0)) FOR [IsSend]
GO
/****** Object:  Default [DF_Products_IsHot]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsHot]  DEFAULT ((1)) FOR [IsHot]
GO
/****** Object:  Default [DF_Products_LoadDate]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_LoadDate]  DEFAULT (getdate()) FOR [LoadDate]
GO
/****** Object:  ForeignKey [FK_OrderDetail_ProductOrder]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_ProductOrder] FOREIGN KEY([OrderID])
REFERENCES [dbo].[ProductOrder] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_ProductOrder]
GO
/****** Object:  ForeignKey [FK_Products_Category]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category1] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category]
GO
/****** Object:  ForeignKey [FK_Products_Category1]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Category1] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Category1]
GO
/****** Object:  ForeignKey [FK_Products_Colour]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Colour] FOREIGN KEY([ColourID])
REFERENCES [dbo].[Colour] ([ColourID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Colour]
GO
/****** Object:  ForeignKey [FK_Products_Supplier]    Script Date: 10/06/2015 13:03:15 ******/
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Supplier] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Supplier]
GO
