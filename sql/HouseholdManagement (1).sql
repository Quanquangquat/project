USE [master]
GO

/*USE master;  
ALTER DATABASE HouseholdManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;  
DROP DATABASE HouseholdManagement;*/
/****** Object:  Database [HouseholdManagement]    Script Date: 23/03/2025 8:06:28 CH ******/
CREATE DATABASE [HouseholdManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HouseholdManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATAHouseholdManagement.mdf' , SIZE = 139264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HouseholdManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\HouseholdManagement_log.ldf' , SIZE = 204800KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HouseholdManagement] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HouseholdManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HouseholdManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HouseholdManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HouseholdManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HouseholdManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HouseholdManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [HouseholdManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HouseholdManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HouseholdManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HouseholdManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HouseholdManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HouseholdManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HouseholdManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HouseholdManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HouseholdManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HouseholdManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HouseholdManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HouseholdManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HouseholdManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HouseholdManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HouseholdManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HouseholdManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HouseholdManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HouseholdManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [HouseholdManagement] SET  MULTI_USER 
GO
ALTER DATABASE [HouseholdManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HouseholdManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HouseholdManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HouseholdManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HouseholdManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HouseholdManagement] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HouseholdManagement', N'ON'
GO
ALTER DATABASE [HouseholdManagement] SET QUERY_STORE = ON
GO
ALTER DATABASE [HouseholdManagement] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HouseholdManagement]
GO
/****** Object:  Table [dbo].[AddMemberRegistrations]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AddMemberRegistrations](
	[AddMemberRegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[DateOfBirth] [date] NULL,
	[Gender] [varchar](10) NULL,
	[IdNumber] [varchar](20) NULL,
	[PhoneNumber] [varchar](20) NULL,
	[Relationship] [nvarchar](50) NOT NULL,
	[ReasonForAddition] [nvarchar](500) NOT NULL,
	[PreviousHouseholdID] [int] NULL,
	[HeadOfHouseholdConsent] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddMemberRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Areas]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Areas](
	[AreaID] [int] IDENTITY(1,1) NOT NULL,
	[ProvinceName] [nvarchar](50) NOT NULL,
	[DistrictName] [nvarchar](50) NOT NULL,
	[WardName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Areas] PRIMARY KEY CLUSTERED 
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HouseholdMembers]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseholdMembers](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[HouseholdID] [int] NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Relationship] [nvarchar](50) NOT NULL,
	[DateOfBirth] [datetime] NULL,
	[Gender] [nvarchar](10) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[CCCD] [nvarchar](20) NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Households]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Households](
	[HouseholdID] [int] IDENTITY(1,1) NOT NULL,
	[HeadOfHouseholdID] [int] NULL,
	[Address] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[AreaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[HouseholdID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationDocuments]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationDocuments](
	[DocumentID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[DocumentType] [nvarchar](50) NOT NULL,
	[FilePath] [nvarchar](255) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[FileSize] [int] NOT NULL,
	[ContentType] [nvarchar](100) NOT NULL,
	[UploadDate] [datetime] NOT NULL,
	[Description] [nvarchar](255) NULL,
	[FileData] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Registrations]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Registrations](
	[RegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[HouseholdID] [int] NULL,
	[RegistrationTypeID] [int] NULL,
	[SentDate] [date] NOT NULL,
	[Reason] [nvarchar](500) NULL,
	[RegistrationStatusID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, A LLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationStatuses]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationStatuses](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](20) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationTypes]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationTypes](
	[RegistrationTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](100) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[RegistrationTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RegistrationVerifications]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RegistrationVerifications](
	[VerificationID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[VerificationUserID] [int] NULL,
	[VerificationDate] [date] NULL,
	[VerifierComments] [nvarchar](500) NULL,
	[VerificationStatusID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VerificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](20) NOT NULL,
	[Description] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SplitMembers]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SplitMembers](
	[SplitRegistrationID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
 CONSTRAINT [PK_SplitMembers] PRIMARY KEY CLUSTERED 
(
	[SplitRegistrationID] ASC,
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SplitRegistrations]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SplitRegistrations](
	[SplitRegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[ReasonForSplit] [nvarchar](500) NOT NULL,
	[NewAddress] [nvarchar](255) NOT NULL,
	[PreviousAddress] [nvarchar](255) NULL,
	[MoveDate] [date] NULL,
	[HeadOfHousehold] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SplitRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferRegistrations]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferRegistrations](
	[TransferRegistrationID] [int] IDENTITY(1,1) NOT NULL,
	[RegistrationID] [int] NOT NULL,
	[NewAddress] [nvarchar](255) NOT NULL,
	[PreviousAddress] [nvarchar](255) NULL,
	[ReasonForTransfer] [nvarchar](500) NOT NULL,
	[MoveDate] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TransferRegistrationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAvatars]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAvatars](
	[AvatarID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[AvatarPath] [varchar](255) NOT NULL,
	[UploadDate] [datetime] NOT NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AvatarID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 23/03/2025 8:06:29 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[RoleID] [int] NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[CCCD] [varchar](12) NOT NULL,
	[remember_me_token] [varchar](255) NULL,
	[HouseholdID] [int] NULL,
	[Gender] [nvarchar](10) NULL,
	[PhoneNumber] [varchar](15) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Areas] ON 

INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (9, N'Huế', N'Hương Thủy', N'Thủy Dương')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (10, N'Thành phố Hà Nội', N'Huyện Đông Anh', N'Xã Dục Tú')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (11, N'Tỉnh Điện Biên', N'Huyện Điện Biên', N'Xã Thanh Yên')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (12, N'Thành phố Đà Nẵng', N'Huyện Hoàng Sa', N'')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (13, N'Thành phố Đà Nẵng', N'Quận Cẩm Lệ', N'Phường Hòa Phát')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (14, N'Thành phố Đà Nẵng', N'Quận Thanh Khê', N'Phường Thanh Khê Đông')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (15, N'Tỉnh Vĩnh Phúc', N'Thành phố Phúc Yên', N'Phường Đồng Xuân')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (16, N'Tỉnh Quảng Ninh', N'Huyện Tiên Yên', N'Xã Điền Xá')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (17, N'Tỉnh Phú Thọ', N'Huyện Tam Nông', N'Xã Tề Lễ')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (18, N'Tỉnh Phú Thọ', N'Huyện Lâm Thao', N'Xã Cao Xá')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (19, N'Tỉnh Lạng Sơn', N'Huyện Tràng Định', N'Xã Kháng Chiến')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (20, N'Tỉnh Sóc Trăng', N'Thị xã Vĩnh Châu', N'Xã Vĩnh Hải')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (21, N'Tỉnh Bình Dương', N'Thành phố Dĩ An', N'Phường Tân Đông Hiệp')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (22, N'Tỉnh Đắk Nông', N'Huyện Đăk Glong', N'Xã Quảng Khê')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (23, N'Tỉnh Thanh Hóa', N'Huyện Hậu Lộc', N'Thị trấn Hậu Lộc')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (24, N'Tỉnh Cà Mau', N'Huyện Đầm Dơi', N'Xã Tân Tiến')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (25, N'Tỉnh Thanh Hóa', N'Huyện Hậu Lộc', N'Xã Lộc Sơn')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (26, N'Tỉnh Điện Biên', N'Thị Xã Mường Lay', N'Phường Sông Đà')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (27, N'Tỉnh Hà Nam', N'Thị xã Kim Bảng', N'Phường Lê Hồ')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (28, N'Thành phố Hà Nội', N'Quận Ba Đình', N'Phường Phúc Xá')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (29, N'Tỉnh Hà Giang', N'Thành phố Hà Giang', N'Phường Quang Trung')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (30, N'Thành phố Hà Nội', N'Quận Ba Đình', N'Phường Trúc Bạch')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (31, N'Thành phố Hà Nội', N'Huyện Chương Mỹ', N'Thị trấn Xuân Mai')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (32, N'Tỉnh Cao Bằng', N'Thành phố Cao Bằng', N'Phường Sông Hiến')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (33, N'Thành phố Hà Nội', N'Quận Hoàn Kiếm', N'Phường Hàng Gai')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (34, N'Tỉnh Điện Biên', N'Huyện Mường Nhé', N'Xã Leng Su Sìn')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (35, N'Tỉnh Bình Định', N'Huyện Tây Sơn', N'Xã Tây Giang')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (36, N'Tỉnh Quảng Ngãi', N'Huyện Trà Bồng', N'Xã Trà Hiệp')
INSERT [dbo].[Areas] ([AreaID], [ProvinceName], [DistrictName], [WardName]) VALUES (37, N'Tỉnh Sơn La', N'Huyện Quỳnh Nhai', N'Xã Mường Sại')
SET IDENTITY_INSERT [dbo].[Areas] OFF
GO
SET IDENTITY_INSERT [dbo].[HouseholdMembers] ON 

INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (11, 23, N'Jenette Nunez', N'Child', CAST(N'1978-05-08T00:00:00.000' AS DateTime), N'Female', N'0570618999', N'nyzovyyco@mailinator.com', N'003456789312', CAST(N'2025-03-19T05:54:40.613' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (12, 23, N'George Pitts', N'Parent', CAST(N'1982-06-06T00:00:00.000' AS DateTime), N'Male', N'0706090099', N'jynezo@mailinator.com', N'077203000470', CAST(N'2025-03-19T05:56:13.307' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (13, 23, N'Ruby Hunt', N'Child', CAST(N'2021-09-27T00:00:00.000' AS DateTime), N'Female', N'0015486377', N'mygitin@mailinator.com', N'003456789314', CAST(N'2025-03-19T10:20:40.627' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (14, 30, N'Xaviera Rosa', N'Spouse', CAST(N'2000-03-02T00:00:00.000' AS DateTime), N'Female', N'0707450375', N'kycagik@mailinator.com', N'003453789311', CAST(N'2025-03-20T15:00:10.093' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (15, 41, N'Lacy Porter', N'Relative', CAST(N'2020-02-12T00:00:00.000' AS DateTime), N'Female', N'0300362302', N'jopacufese@mailinator.com', N'003456789331', CAST(N'2025-03-21T16:22:35.040' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (16, 41, N'Emerson Suarez', N'Relative', CAST(N'2016-10-25T00:00:00.000' AS DateTime), N'Male', N'0725249971', N'kaxuce@mailinator.com', N'003456789313', CAST(N'2025-03-21T18:14:25.940' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (18, 40, N'Tamekah Townsend', N'Grandchild', CAST(N'1983-04-01T00:00:00.000' AS DateTime), N'Male', N'0650962047', N'vini@mailinator.com', N'077203001476', CAST(N'2025-03-23T10:24:36.023' AS DateTime))
INSERT [dbo].[HouseholdMembers] ([MemberID], [HouseholdID], [FullName], [Relationship], [DateOfBirth], [Gender], [PhoneNumber], [Email], [CCCD], [CreatedDate]) VALUES (20, 46, N'Marny Harrington', N'Relative', CAST(N'2016-07-15T00:00:00.000' AS DateTime), N'Female', N'0639914196', N'fuludebez@mailinator.com', N'077203111470', CAST(N'2025-03-23T15:23:06.267' AS DateTime))
SET IDENTITY_INSERT [dbo].[HouseholdMembers] OFF
GO
SET IDENTITY_INSERT [dbo].[Households] ON 

INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (23, 52, N'777, Xã Kháng Chiến, Huyện Tràng Định, Tỉnh Lạng Sơn', CAST(N'2025-03-19T05:23:12.283' AS DateTime), 19)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (24, 53, N'837, Xã Vĩnh Hải, Thị xã Vĩnh Châu, Tỉnh Sóc Trăng', CAST(N'2025-03-19T13:31:30.643' AS DateTime), 20)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (25, 54, N'17, Phường Tân Đông Hiệp, Thành phố Dĩ An, Tỉnh Bình Dương', CAST(N'2025-03-19T13:35:31.593' AS DateTime), 21)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (26, 55, N'364, Xã Quảng Khê, Huyện Đăk Glong, Tỉnh Đắk Nông', CAST(N'2025-03-19T13:36:15.493' AS DateTime), 22)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (27, 56, N'956, Xã Kháng Chiến, Huyện Tràng Định, Tỉnh Lạng Sơn', CAST(N'2025-03-19T21:47:43.623' AS DateTime), 19)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (28, 57, N'286, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', CAST(N'2025-03-20T08:19:22.923' AS DateTime), 23)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (29, 58, N'99, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', CAST(N'2025-03-20T00:00:00.000' AS DateTime), 23)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (30, 59, N'664, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', CAST(N'2025-03-20T08:43:12.853' AS DateTime), 23)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (31, 60, N'58, Xã Lộc Sơn, Huyện Hậu Lộc, Tỉnh Thanh Hóa', CAST(N'2025-03-20T08:57:11.740' AS DateTime), 25)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (32, 61, N'653, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', CAST(N'2025-03-20T12:36:02.623' AS DateTime), 26)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (33, 62, N'944, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', CAST(N'2025-03-20T12:39:13.193' AS DateTime), 26)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (34, 63, N'428, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', CAST(N'2025-03-20T13:30:35.517' AS DateTime), 26)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (35, 64, N'36, Xã Tân Tiến, Huyện Đầm Dơi, Tỉnh Cà Mau', CAST(N'2025-03-21T06:47:03.277' AS DateTime), 24)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (36, 65, N'394, Phường Lê Hồ, Thị xã Kim Bảng, Tỉnh Hà Nam', CAST(N'2025-03-21T07:46:03.607' AS DateTime), 27)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (37, 66, N'5, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', CAST(N'2025-03-21T15:16:02.897' AS DateTime), 28)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (38, 67, N'66, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', CAST(N'2025-03-21T15:23:39.907' AS DateTime), 28)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (39, 68, N'984, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', CAST(N'2025-03-21T15:25:50.903' AS DateTime), 29)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (40, 69, N'101, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', CAST(N'2025-03-23T10:29:30.087' AS DateTime), 29)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (41, 70, N'777, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', CAST(N'2025-03-21T20:21:45.130' AS DateTime), 29)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (42, 71, N'267, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', CAST(N'2025-03-23T10:28:49.837' AS DateTime), 29)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (43, 72, N'759, Xã Mường Sại, Huyện Quỳnh Nhai, Tỉnh Sơn La', CAST(N'2025-03-23T10:50:25.337' AS DateTime), 37)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (44, 73, N'66, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', CAST(N'2025-03-23T15:56:06.300' AS DateTime), 29)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (45, 74, N'831, Phường Sông Hiến, Thành phố Cao Bằng, Tỉnh Cao Bằng', CAST(N'2025-03-23T16:10:44.700' AS DateTime), 32)
INSERT [dbo].[Households] ([HouseholdID], [HeadOfHouseholdID], [Address], [CreatedDate], [AreaID]) VALUES (46, 75, N'666, Phường Sông Hiến, Thành phố Cao Bằng, Tỉnh Cao Bằng', CAST(N'2025-03-23T16:12:19.860' AS DateTime), 32)
SET IDENTITY_INSERT [dbo].[Households] OFF
GO
SET IDENTITY_INSERT [dbo].[RegistrationStatuses] ON 

INSERT [dbo].[RegistrationStatuses] ([StatusID], [StatusName], [Description]) VALUES (1, N'Pending', N'Awaiting approval')
INSERT [dbo].[RegistrationStatuses] ([StatusID], [StatusName], [Description]) VALUES (2, N'Approved', N'Registration approved')
INSERT [dbo].[RegistrationStatuses] ([StatusID], [StatusName], [Description]) VALUES (3, N'Rejected', N'Registration rejected')
INSERT [dbo].[RegistrationStatuses] ([StatusID], [StatusName], [Description]) VALUES (4, N'Partially Approved', N'Registration partially approved by police')
SET IDENTITY_INSERT [dbo].[RegistrationStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[RegistrationTypes] ON 

INSERT [dbo].[RegistrationTypes] ([RegistrationTypeID], [TypeName], [Description]) VALUES (1, N'Transfer Household Registration', N'Moving household registration to a new location')
INSERT [dbo].[RegistrationTypes] ([RegistrationTypeID], [TypeName], [Description]) VALUES (2, N'Split Household Registration', N'Splitting household registration for independent residency')
INSERT [dbo].[RegistrationTypes] ([RegistrationTypeID], [TypeName], [Description]) VALUES (3, N'Register Into Household', N'Adding a new member to an existing household registration')
SET IDENTITY_INSERT [dbo].[RegistrationTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (1, N'Citizen', N'Citizen registering household')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (2, N'AreaLeader', N'Area leader managing residents')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (3, N'Police', N'Police officer overseeing area')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (4, N'Admin', N'System administrator')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[UserAvatars] ON 

INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (30, 54, N'https://th.bing.com/th/id/OIP.SikfvBc5jo-EiiOiUuQKzAHaD4?rs=1&pid=ImgDetMain', CAST(N'2025-03-19T13:39:59.153' AS DateTime), 1)
INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (31, 52, N'https://th.bing.com/th/id/OIP.SikfvBc5jo-EiiOiUuQKzAHaD4?rs=1&pid=ImgDetMain', CAST(N'2025-03-19T13:41:54.540' AS DateTime), 1)
INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (32, 63, N'https://th.bing.com/th/id/OIP.tcD3MszVeLsFFvbL4keBmAHaEo?rs=1&pid=ImgDetMain', CAST(N'2025-03-20T14:52:36.643' AS DateTime), 1)
INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (33, 65, N'https://th.bing.com/th/id/OIP.SikfvBc5jo-EiiOiUuQKzAHaD4?rs=1&pid=ImgDetMain', CAST(N'2025-03-21T07:49:02.883' AS DateTime), 1)
INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (34, 66, N'https://th.bing.com/th/id/OIP.SikfvBc5jo-EiiOiUuQKzAHaD4?rs=1&pid=ImgDetMain', CAST(N'2025-03-21T15:36:28.607' AS DateTime), 1)
INSERT [dbo].[UserAvatars] ([AvatarID], [UserID], [AvatarPath], [UploadDate], [IsActive]) VALUES (35, 72, N'https://th.bing.com/th/id/OIP.tcD3MszVeLsFFvbL4keBmAHaEo?rs=1&pid=ImgDetMain', CAST(N'2025-03-23T11:23:42.383' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[UserAvatars] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (52, N'Stephen Khoa', N'fuvitel@mailinator.com', N'$2a$10$AHwn0GnPAZXca0s246hoRe.TQ8pVIoCAsHt9SntGlVXEtNgoTJ8jC', 1, N'777, Xã Kháng Chiến, Huyện Tràng Định, Tỉnh Lạng Sơn', N'003456789311', NULL, 23, N'Female', N'0169996105')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (53, N'Bevis Stuart', N'fesozu@mailinator.com', N'$2a$10$KoIqY.ifx5sgAqNAtO6zFOcu6LQygMAa3zXP0jUiXrwbI0sby8dJK', 4, N'837, Xã Vĩnh Hải, Thị xã Vĩnh Châu, Tỉnh Sóc Trăng', N'003456789333', NULL, 24, N'Male', N'0577586222')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (54, N'Rana Gray', N'rigerisijy@mailinator.com', N'$2a$10$9jlu6EKxnOBUmTFHE7zcnujnJU9K836nE.Yl0OUjIV6c622DqeUqm', 3, N'17, Phường Tân Đông Hiệp, Thành phố Dĩ An, Tỉnh Bình Dương', N'003456789319', NULL, 25, N'Male', N'0521284655')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (55, N'Kibo Estrada', N'dyxe@mailinator.com', N'$2a$10$2th8mTp13ZplQ1V.NV9YyuoKhpzPG5TOjG5pt4NPaFhMsyAYtI/I2', 2, N'364, Xã Quảng Khê, Huyện Đăk Glong, Tỉnh Đắk Nông', N'003456789316', NULL, 26, N'Male', N'0717538185')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (56, N'Janna Jennings', N'ciduwofa@mailinator.com', N'$2a$10$dzaUTJGnnGl/vcllsRrvHellgTl5iiBB9CW4fkUqfMB4l0mcI8s9q', 3, N'956, Xã Kháng Chiến, Huyện Tràng Định, Tỉnh Lạng Sơn', N'077203000478', NULL, 27, N'Female', N'0200269012')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (57, N'Keely Mckinney', N'fipuw@mailinator.com', N'$2a$10$.1kvTynV7sieHqM3c6mRY.EzZ5LM7Mrw3KpgmLD6posczJQivfXZi', 3, N'286, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', N'077203000471', NULL, 28, N'Male', N'0378023293')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (58, N'Aspen Price', N'wobukufoma@mailinator.com', N'$2a$10$ViDAHtPdf1IkdsckvVAUZuMioGR2XMKggqg2oVjABFd4tKGFFb7zW', 1, N'99, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', N'003456789392', NULL, 29, N'Male', N'0801513550')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (59, N'Shelly Gardner', N'pavijysin@mailinator.com', N'$2a$10$gp16UJiQ4233CCXwgB0CN.A4.sQfm1qEsx5xcG6kkIB8lVxkS/Ype', 1, N'664, Thị trấn Hậu Lộc, Huyện Hậu Lộc, Tỉnh Thanh Hóa', N'077203000474', NULL, 30, N'Male', N'0033628046')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (60, N'Violet Malone', N'ralonotel@mailinator.com', N'$2a$10$9GUS3D96Su9C5aIgessgoO137vioCK4Rgp86T0xTxIRUHYFmoay5q', 3, N'58, Xã Lộc Sơn, Huyện Hậu Lộc, Tỉnh Thanh Hóa', N'003456789390', NULL, 31, N'Female', N'0697788976')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (61, N'Jada Kinney', N'hefawi@mailinator.com', N'$2a$10$tSepm4SzVeuy10ko7gDW6ePjZX9IdyU9.gj99s1H0/w7k3r1xWvY6', 3, N'653, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', N'077203000476', NULL, 32, N'Male', N'0412575477')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (62, N'Jonas Petty', N'kutiwig@mailinator.com', N'$2a$10$sjXKhfSl85zfjbptB.X/Jem7b.tDmxJKqP1ynafvg1vw13DLdDoQi', 1, N'944, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', N'003456789396', NULL, 33, N'Male', N'0602612891')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (63, N'Fleur Stokes', N'hapery@mailinator.com', N'$2a$10$1n.KweBoGsZyiZNcUIhe.u8.6dASoKbc16u9.Rh90O1.2P3Y8I4pO', 2, N'428, Phường Sông Đà, Thị Xã Mường Lay, Tỉnh Điện Biên', N'077203000473', NULL, 34, N'Male', N'0809850853')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (64, N'Reuben Wilder', N'nazijologa@mailinator.com', N'$2a$10$ssXzugAd6ebdlHYPx5ZPyuzV0DNHqbJFsD2HQs/hLhyaWlDNWBRsa', 3, N'36, Xã Tân Tiến, Huyện Đầm Dơi, Tỉnh Cà Mau', N'077203000475', NULL, 35, N'Other', N'0882605447')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (65, N'Felix Garrett', N'tusah@mailinator.com', N'$2a$10$7CpRhiqdndlKh6413n8m1eyTfFn5gI8DrOU/8ZOjk.v1dmTyCdkkG', 4, N'759, Xã Mường Sại, Huyện Quỳnh Nhai, Tỉnh Sơn La', N'077203010470', NULL, 36, N'Female', N'0814342252')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (66, N'Piper Brown', N'sagacoviwo@mailinator.com', N'$2a$10$LU0wDj.SfaWlL69b.GaCIuOHXQCWnM6ZU0K8wQ8ume.aJLlDcoS2e', 1, N'5, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'013456789392', NULL, 37, N'Male', N'0804412339')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (67, N'Germane Mclaughlin', N'daco@mailinator.com', N'$2a$10$8fiaRRicfL.LuKVI.RBOYecOvxkwfHwdEmeAwq6gDeGDYZ5hl.ckW', 3, N'66, Phường Phúc Xá, Quận Ba Đình, Thành phố Hà Nội', N'003406789392', NULL, 38, N'Male', N'0475131155')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (68, N'Faith Lopez', N'vava@mailinator.com', N'$2a$10$ul4vZveCJ/HNJVGfAq6gUO1kHKn1meSI7y7pxyVLjt14p.zpbUk.G', 2, N'984, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', N'003456089312', NULL, 39, N'Male', N'0260542963')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (69, N'Reece Scott', N'myrodaqi@mailinator.com', N'$2a$10$jsB3CJzdt62vMT14VGcOhuK5QtAZujDTH1/MVy/0v6TkUE4B4O7Wu', 1, N'101, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', N'077203001478', NULL, 40, N'Male', N'0234487905')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (70, N'Caryn Riggs', N'wuxoz@mailinator.com', N'$2a$10$AjST5.qU8TTkZ4UqpPuBseQ5H6MDXTrfySQQkjtiLB0wkMnJ1ck6.', 1, N'777, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', N'003456789317', NULL, 41, N'Female', N'0878674783')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (71, N'Lydia Harvey', N'bozelexiza@mailinator.com', N'$2a$10$0TYedSdR8IQGZ2h9eKXm8eBzEJuqdc92uCBJYzrMqVAKwAbvRc1vS', 3, N'267, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', N'077203510470', NULL, 42, N'Female', N'0875777429')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (72, N'Thieu Quang Khoa', N'quangkhoa5112@gmail.com', N'$2a$10$RY5PczR.T2hZZvNyZAFSbeSjvJX.zNPLCGaMhhCQSpSzVxRnO8zUa', 1, N'759, Xã Mường Sại, Huyện Quỳnh Nhai, Tỉnh Sơn La', N'043456789012', NULL, 43, N'Female', N'0399830018')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (73, N'Barrett Harding', N'pycid@mailinator.com', N'$2a$10$bXAT03EQieOfKo0Py6MLcuvK3P/9ybPYkCF.FiiU4g3CqfCVoc/Ue', 1, N'66, Phường Quang Trung, Thành phố Hà Giang, Tỉnh Hà Giang', N'077203000477', NULL, 44, N'Male', N'0311789472')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (74, N'Jayme Stewart', N'fahuwej@mailinator.com', N'$2a$10$ej1l82n.y.PXXYoWsvo7geDLQXm9ROTes2JyYaJ6HGz0Bj1FFp9NC', 2, N'831, Phường Sông Hiến, Thành phố Cao Bằng, Tỉnh Cao Bằng', N'003456789512', NULL, 45, N'Male', N'0040573558')
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [RoleID], [Address], [CCCD], [remember_me_token], [HouseholdID], [Gender], [PhoneNumber]) VALUES (75, N'Allegra Lawrence', N'tugimidet@mailinator.com', N'$2a$10$p9BcDkDZcN7S1L1WGQol4..p2zG55ZLRguVv6qCN8urmGHJO9aEMG', 1, N'666, Phường Sông Hiến, Thành phố Cao Bằng, Tỉnh Cao Bằng', N'003456789322', NULL, 46, N'Male', N'0454391982')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Areas_DistrictCode]    Script Date: 23/03/2025 8:06:29 CH ******/
CREATE NONCLUSTERED INDEX [IX_Areas_DistrictCode] ON [dbo].[Areas]
(
	[DistrictName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Areas_ProvinceCode]    Script Date: 23/03/2025 8:06:29 CH ******/
CREATE NONCLUSTERED INDEX [IX_Areas_ProvinceCode] ON [dbo].[Areas]
(
	[ProvinceName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Areas_WardCode]    Script Date: 23/03/2025 8:06:29 CH ******/
CREATE NONCLUSTERED INDEX [IX_Areas_WardCode] ON [dbo].[Areas]
(
	[WardName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Households_AreaID]    Script Date: 23/03/2025 8:06:29 CH ******/
CREATE NONCLUSTERED INDEX [IX_Households_AreaID] ON [dbo].[Households]
(
	[AreaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Registra__05E7698A157BBE6D]    Script Date: 23/03/2025 8:06:29 CH ******/
ALTER TABLE [dbo].[RegistrationStatuses] ADD UNIQUE NONCLUSTERED 
(
	[StatusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Registra__D4E7DFA86DD46B2B]    Script Date: 23/03/2025 8:06:29 CH ******/
ALTER TABLE [dbo].[RegistrationTypes] ADD UNIQUE NONCLUSTERED 
(
	[TypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Roles__8A2B6160081FFBA7]    Script Date: 23/03/2025 8:06:29 CH ******/
ALTER TABLE [dbo].[Roles] ADD UNIQUE NONCLUSTERED 
(
	[RoleName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A955A0AA2F4ADB97]    Script Date: 23/03/2025 8:06:29 CH ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[CCCD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D1053474F3FC51]    Script Date: 23/03/2025 8:06:29 CH ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AddMemberRegistrations] ADD  DEFAULT ((0)) FOR [HeadOfHouseholdConsent]
GO
ALTER TABLE [dbo].[HouseholdMembers] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Households] ADD  CONSTRAINT [DF_Households_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[RegistrationDocuments] ADD  DEFAULT (getdate()) FOR [UploadDate]
GO
ALTER TABLE [dbo].[Registrations] ADD  DEFAULT ((1)) FOR [RegistrationStatusID]
GO
ALTER TABLE [dbo].[RegistrationVerifications] ADD  DEFAULT ((1)) FOR [VerificationStatusID]
GO
ALTER TABLE [dbo].[UserAvatars] ADD  DEFAULT (getdate()) FOR [UploadDate]
GO
ALTER TABLE [dbo].[UserAvatars] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[AddMemberRegistrations]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HouseholdMembers]  WITH CHECK ADD  CONSTRAINT [HouseholdMembers_Households__fk_2] FOREIGN KEY([HouseholdID])
REFERENCES [dbo].[Households] ([HouseholdID])
GO
ALTER TABLE [dbo].[HouseholdMembers] CHECK CONSTRAINT [HouseholdMembers_Households__fk_2]
GO
ALTER TABLE [dbo].[Households]  WITH CHECK ADD  CONSTRAINT [Households_Areas__fk] FOREIGN KEY([AreaID])
REFERENCES [dbo].[Areas] ([AreaID])
GO
ALTER TABLE [dbo].[Households] CHECK CONSTRAINT [Households_Areas__fk]
GO
ALTER TABLE [dbo].[Households]  WITH CHECK ADD  CONSTRAINT [Households_Users__fk] FOREIGN KEY([HeadOfHouseholdID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Households] CHECK CONSTRAINT [Households_Users__fk]
GO
ALTER TABLE [dbo].[RegistrationDocuments]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD FOREIGN KEY([RegistrationTypeID])
REFERENCES [dbo].[RegistrationTypes] ([RegistrationTypeID])
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD  CONSTRAINT [FK_Registrat_House_4A8B1AF0] FOREIGN KEY([HouseholdID])
REFERENCES [dbo].[Households] ([HouseholdID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [FK_Registrat_House_4A8B1AF0]
GO
ALTER TABLE [dbo].[Registrations]  WITH CHECK ADD  CONSTRAINT [Registrations_Users__fk] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Registrations] CHECK CONSTRAINT [Registrations_Users__fk]
GO
ALTER TABLE [dbo].[RegistrationVerifications]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RegistrationVerifications]  WITH CHECK ADD FOREIGN KEY([VerificationStatusID])
REFERENCES [dbo].[RegistrationStatuses] ([StatusID])
GO
ALTER TABLE [dbo].[RegistrationVerifications]  WITH CHECK ADD  CONSTRAINT [RegistrationVerifications_Users__fk] FOREIGN KEY([VerificationUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[RegistrationVerifications] CHECK CONSTRAINT [RegistrationVerifications_Users__fk]
GO
ALTER TABLE [dbo].[SplitMembers]  WITH CHECK ADD  CONSTRAINT [SplitMembers_HouseholdMembers__fk] FOREIGN KEY([MemberID])
REFERENCES [dbo].[HouseholdMembers] ([MemberID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SplitMembers] CHECK CONSTRAINT [SplitMembers_HouseholdMembers__fk]
GO
ALTER TABLE [dbo].[SplitMembers]  WITH CHECK ADD  CONSTRAINT [SplitMembers_SplitRegistrations__fk] FOREIGN KEY([SplitRegistrationID])
REFERENCES [dbo].[SplitRegistrations] ([SplitRegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SplitMembers] CHECK CONSTRAINT [SplitMembers_SplitRegistrations__fk]
GO
ALTER TABLE [dbo].[SplitRegistrations]  WITH CHECK ADD  CONSTRAINT [SplitRegistrations_HouseholdMembers__fk] FOREIGN KEY([HeadOfHousehold])
REFERENCES [dbo].[HouseholdMembers] ([MemberID])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[SplitRegistrations] CHECK CONSTRAINT [SplitRegistrations_HouseholdMembers__fk]
GO
ALTER TABLE [dbo].[SplitRegistrations]  WITH CHECK ADD  CONSTRAINT [SplitRegistrations_Registrations__fk] FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SplitRegistrations] CHECK CONSTRAINT [SplitRegistrations_Registrations__fk]
GO
ALTER TABLE [dbo].[TransferRegistrations]  WITH CHECK ADD FOREIGN KEY([RegistrationID])
REFERENCES [dbo].[Registrations] ([RegistrationID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserAvatars]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [CK_Users_Gender] CHECK  (([Gender]='Other' OR [Gender]='Female' OR [Gender]='Male'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [CK_Users_Gender]
GO
/****** Object:  Trigger [dbo].[sync_address] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[sync_address]
ON [dbo].[Households]
AFTER UPDATE
AS
BEGIN
    UPDATE Users
    SET Users.Address = inserted.Address
    FROM Users
    INNER JOIN inserted ON Users.HouseholdID = inserted.HeadOfHouseholdID;
END;
GO
ALTER TABLE [dbo].[Households] ENABLE TRIGGER [sync_address]
GO
/****** Object:  Trigger [dbo].[sync_user_address]   ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[sync_user_address]
ON [dbo].[Households]
AFTER UPDATE
AS
BEGIN
    -- Kiểm tra xem cột Address có được cập nhật hay không
    IF UPDATE(Address)
    BEGIN
        -- Cập nhật Address trong bảng Users dựa trên HouseholdID
        UPDATE u
        SET u.Address = i.Address
        FROM [dbo].[Users] u
        INNER JOIN inserted i ON u.HouseholdID = i.HouseholdID
        INNER JOIN deleted d ON i.HouseholdID = d.HouseholdID
        WHERE i.Address != d.Address; -- Chỉ cập nhật nếu Address thực sự thay đổi
    END
END;

GO
ALTER TABLE [dbo].[Households] ENABLE TRIGGER [sync_user_address]
GO
/****** Object:  Trigger [dbo].[trg_DeleteRegistrationCascade] */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_DeleteRegistrationCascade]
ON [dbo].[Registrations]
AFTER DELETE
AS
BEGIN
    -- Delete related records in TransferRegistrations
    DELETE FROM TransferRegistrations 
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);
    
    -- Delete related records in SplitRegistrationMembers
    DELETE FROM SplitRegistrations
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);
    
    -- Delete related records in RegistrationDocuments
    DELETE FROM RegistrationDocuments 
    WHERE RegistrationID IN (SELECT RegistrationID FROM deleted);
END;

GO
ALTER TABLE [dbo].[Registrations] ENABLE TRIGGER [trg_DeleteRegistrationCascade]
GO
/****** Object:  Trigger [dbo].[trg_UpdateRegistrationStatus]    Script Date: 23/03/2025 8:06:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_UpdateRegistrationStatus]
    ON [dbo].[RegistrationVerifications]
    AFTER INSERT, UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Get the RegistrationIDs affected by the insert/update
    WITH AffectedRegistrations AS (
        SELECT DISTINCT RegistrationID
        FROM inserted
    )
    -- Update RegistrationStatusID based on verification states
    UPDATE r
    SET RegistrationStatusID =
            CASE
                -- Check if there are exactly 2 verifications from AreaLeader (2) and Police (3)
                WHEN (SELECT COUNT(DISTINCT v.VerificationUserID)
                      FROM dbo.RegistrationVerifications v
                               JOIN dbo.Users u ON v.VerificationUserID = u.UserID
                      WHERE v.RegistrationID = r.RegistrationID
                        AND u.RoleID IN (2, 3)) = 2 THEN
                    CASE
                        -- If any verification is Rejected (StatusID = 3), set to Rejected (3)
                        WHEN EXISTS (
                            SELECT 1
                            FROM dbo.RegistrationVerifications v
                                     JOIN dbo.Users u ON v.VerificationUserID = u.UserID
                            WHERE v.RegistrationID = r.RegistrationID
                              AND u.RoleID IN (2, 3)
                              AND v.VerificationStatusID = 3
                        ) THEN 3
                        -- If both verifications are Approved (StatusID = 2), set to Approved (2)
                        WHEN (SELECT COUNT(*)
                              FROM dbo.RegistrationVerifications v
                                       JOIN dbo.Users u ON v.VerificationUserID = u.UserID
                              WHERE v.RegistrationID = r.RegistrationID
                                AND u.RoleID IN (2, 3)
                                AND v.VerificationStatusID = 2) = 2 THEN 2
                        -- Otherwise, stay Pending (1)
                        ELSE 1
                        END
                -- If fewer than 2 verifications from AreaLeader and Police, stay Pending (1)
                ELSE 1
                END
    FROM dbo.Registrations r
    WHERE r.RegistrationID IN (SELECT RegistrationID FROM AffectedRegistrations);
END;
GO
ALTER TABLE [dbo].[RegistrationVerifications] ENABLE TRIGGER [trg_UpdateRegistrationStatus]
GO
/****** Object:  Trigger [dbo].[trg_ValidateVerifierRole]    Script Date: 23/03/2025 8:06:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_ValidateVerifierRole]
    ON [dbo].[RegistrationVerifications]
    AFTER INSERT, UPDATE
    AS
BEGIN
    SET NOCOUNT ON;

    -- Check if any VerificationUserID corresponds to a user with RoleID not in (2, 3)
    IF EXISTS (
        SELECT 1
        FROM inserted i
                 JOIN dbo.Users u ON i.VerificationUserID = u.UserID
        WHERE u.RoleID NOT IN (2, 3)
    )
        BEGIN
            RAISERROR ('Only AreaLeader (RoleID = 2) and Police (RoleID = 3) can verify registrations.', 16, 1);
            ROLLBACK TRANSACTION;
        END
END;
GO
ALTER TABLE [dbo].[RegistrationVerifications] ENABLE TRIGGER [trg_ValidateVerifierRole]
GO
/****** Object:  Trigger [dbo].[trg_DeleteUserRegistrations]    Script Date: 23/03/2025 8:06:30 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_DeleteUserRegistrations]
    ON [dbo].[Users]
    AFTER DELETE
    AS
BEGIN
    -- Xóa các bản ghi trong Registrations có UserID trùng với UserID vừa bị xóa
    DELETE FROM dbo.Registrations
    WHERE UserID IN (SELECT UserID FROM deleted);
END;
GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [trg_DeleteUserRegistrations]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User gender (Male, Female, Other)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'User phone number' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Users', @level2type=N'COLUMN',@level2name=N'PhoneNumber'
GO
USE [master]
GO
ALTER DATABASE [HouseholdManagement] SET  READ_WRITE 
GO
