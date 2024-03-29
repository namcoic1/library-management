USE [master]
GO
/****** Object:  Database [LMS]    Script Date: 7/24/2022 9:15:19 AM ******/
CREATE DATABASE [LMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\LMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [LMS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [LMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LMS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LMS] SET RECOVERY FULL 
GO
ALTER DATABASE [LMS] SET  MULTI_USER 
GO
ALTER DATABASE [LMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LMS', N'ON'
GO
ALTER DATABASE [LMS] SET QUERY_STORE = OFF
GO
USE [LMS]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[b_id] [int] IDENTITY(1,1) NOT NULL,
	[b_name] [nvarchar](50) NULL,
	[b_img] [nvarchar](max) NULL,
	[b_stock] [int] NULL,
	[b_price] [money] NULL,
	[b_desc] [nvarchar](max) NULL,
	[b_cate_id] [nvarchar](50) NULL,
	[u_id] [int] NULL,
	[b_status] [bit] NULL,
	[b_lastupdated] [datetime] NULL,
	[b_num_borrow] [int] NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[b_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book_Category]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book_Category](
	[b_cate_id] [nvarchar](50) NOT NULL,
	[b_cate_name] [nvarchar](50) NOT NULL,
	[b_cate_img] [nvarchar](max) NOT NULL,
	[b_cate_des] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Book_Category] PRIMARY KEY CLUSTERED 
(
	[b_cate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrow]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow](
	[br_id] [int] IDENTITY(1,1) NOT NULL,
	[u_id] [int] NULL,
	[br_date] [datetime] NULL,
	[br_resend] [datetime] NULL,
	[sh_id] [int] NULL,
 CONSTRAINT [PK_Borrow] PRIMARY KEY CLUSTERED 
(
	[br_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Borrow_Detail]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Borrow_Detail](
	[b_id] [int] NOT NULL,
	[br_id] [int] NOT NULL,
	[quantity] [int] NULL,
	[price] [money] NULL,
	[total] [money] NULL,
	[brd_status] [bit] NULL,
 CONSTRAINT [PK_Borrow_Detail] PRIMARY KEY CLUSTERED 
(
	[b_id] ASC,
	[br_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[r_id] [int] IDENTITY(1,1) NOT NULL,
	[r_name] [nvarchar](50) NOT NULL,
	[r_desc] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[r_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Shipper]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipper](
	[sh_id] [int] IDENTITY(1,1) NOT NULL,
	[sh_name] [nvarchar](50) NULL,
	[sh_gender] [bit] NULL,
	[sh_email] [nvarchar](max) NULL,
	[sh_phone] [nvarchar](50) NULL,
	[sh_address] [nvarchar](max) NULL,
	[u_id] [int] NULL,
	[sh_status] [bit] NULL,
 CONSTRAINT [PK_Shipper] PRIMARY KEY CLUSTERED 
(
	[sh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/24/2022 9:15:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[u_id] [int] IDENTITY(1,1) NOT NULL,
	[u_email] [nvarchar](50) NOT NULL,
	[u_password] [nvarchar](max) NOT NULL,
	[u_phone] [nvarchar](50) NULL,
	[u_address] [nvarchar](max) NULL,
	[r_id] [int] NULL,
	[u_wallet] [nvarchar](50) NULL,
	[u_username] [nvarchar](50) NULL,
	[u_status] [bit] NULL,
	[u_gender] [bit] NULL,
	[u_dob] [datetime] NULL,
	[u_managed] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[u_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Book] ON 

INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (1, N'Draw Kolams', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=kalai29_1302099633.2484359741', 29, 20.0000, N'From ancient times, Tamil women poetically expressed their minds through drawing kolams at the door step. The creative minds reflect the patterns of kolam drawn with ease.  Kolams benefit both the person who draws them and the people living at home with specific boons of life.', N'AR', 4, 1, CAST(N'2022-07-24T08:39:01.430' AS DateTime), 3)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (2, N'Soul Paintings', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=renatekaufmannarts_1240162159.1844160557', 28, 20.0000, N'In diesem Buch sind ausschliesslich Pastell Malereien von mir zu sehen, wobei die allermeisten rein intuitiv entstanden sind. Ich habe diese zudem mit kurzen inspirierenden Gedanken versehen. Eine deutsche Version ist in Arbeit...', N'AR', 4, 1, CAST(N'2022-07-01T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (3, N'My Art', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=wl559d7e0cdf715_1373730601.4805850983', 28, 20.0000, N'Just some random art pieces of mine so ya. enjoy. please leave me some feedback. yes I drew all of theses. thanks for reading this blurb. I couldn''t figure out how to put my pictures right side up. so all of them are upside down...sorry...', N'AR', 4, 1, CAST(N'2022-07-02T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (4, N'Cook Book', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=melodymw_1355957778.3686380386', 40, 10.0000, N'This is a cooking book I made for my cooking class. This book includes: 2 Appetizers, 2 Beans / Rice / Grains, 2 Beverages, 3 Desserts, 6 Main Dishes, 1 Soup, 2 Vegtables 1 Sauce, 2 Salads, 2 Family Favorites, 3 Kid Friendly.', N'CO', 4, 1, CAST(N'2022-07-03T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (5, N'Spicy Pasta', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=mia.tchoukour_1312372472.5778729916', 40, 10.0000, N'Ok, so I love to cook and thought I''d share my favorite recipe!

This is a recipe that should be quick and easy and don''t take much prep time at all.', N'CO', 4, 1, CAST(N'2022-07-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (6, N'Ultimate Cooking', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=tac5345c47483e5_1589988547.4896869659', 40, 10.0000, N'All About Cooking! We include a large number of links to more information recipes and credits.  You will enjoy this fun guide with several chapters on many cooking topics.', N'CO', 4, 1, CAST(N'2022-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (7, N'
Minecraft Combat ', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=hke45b8e2019a65_1453934434.5764451027', 20, 25.0000, N'Minecraft, you''re never alone and the threat of attack is constant. How will you survive? The Official Combat Handbook will teach you everything you need to know to defend yourself from hostile monsters and enemy players. You can learn how to build a fort.', N'GA', 4, 1, CAST(N'2022-07-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (8, N'Warcraft Legends', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=jinjuro_1310080578.7184879780', 20, 25.0000, N'This book is based on the hit sensation MMO World of Warcraft. As an avid player I have decided to write long and short stories. This book will be a series and hopefully I can add a lot more to it in the future. Enjoy!', N'GA', 4, 1, CAST(N'2022-07-06T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (9, N'Skyrim Shorts', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=iqe1bf3dfe3f425_1380925428.1963260174', 20, 25.0000, N'These shorts are about a Dragonborn/Dovakiin named Myrth. Other mini short stories are based off my original character Maria. I''ve always loved Skyrim and I hope to write more soon :3', N'GA', 4, 1, CAST(N'2022-07-07T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (10, N'Shawn Mendes', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=xh71d93bd4c3d45_1448985371.9673709869', 35, 35.0000, N'Funny Facts about Shawn Mendes. I know it''s not everything about him but it''s all I found about him. You May like it or then again you may not like it but Please comment if you like and want me to add something that I may have forgotten.', N'MU', 8, 1, CAST(N'2022-07-08T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (11, N'This is us', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=pg9868a4361c715_1367098391.8943150043', 35, 35.0000, N'This book includes Jokes, Quotes and Insider of our five singing Idiot: ONE DIRECTION

Enjoy it!We do NOT want to endamage One Direction with this and we do NOT own this sentences and (unfortunately) One Direction!', N'MU', 8, 1, CAST(N'2022-07-09T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (12, N'Anime Lyrics', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=micki22_1351795965.2261691093', 35, 35.0000, N'This is just a book containing english lyrics to vocaloid and anime songs. if there are any songs youd like me to add please comment below. ill add them in due time.', N'MU', 8, 1, CAST(N'2022-07-10T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (13, N'Da Lmer De', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=afzalshauq.books_1264758292.3909420967', 50, 15.0000, N'it''s Afzal Shauq''s third travelogue containing on trips to Europe', N'TR', 8, 1, CAST(N'2022-07-11T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (14, N'4 Weeks, 4 Countries', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=ilkaeve_1327016285.2904789448', 50, 15.0000, N'An account of our travel adventures and misadventures in Germany, the Czech Republic, Spain and Portugal over four weeks in the summer of 2010.', N'TR', 8, 1, CAST(N'2022-07-12T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Book] ([b_id], [b_name], [b_img], [b_stock], [b_price], [b_desc], [b_cate_id], [u_id], [b_status], [b_lastupdated], [b_num_borrow]) VALUES (15, N'Elephants and Enfields', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=daisy.dcat_1270834762.5523009300', 50, 15.0000, N'''Funnier than Clarkson'',..... ''Wittier than Bryson'',.......Just two of the endorsements unlikely to grace the meanderings of a cheerful cynic in India''s hippy paradise, Goa.', N'TR', 8, 1, CAST(N'2022-07-13T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Book] OFF
GO
INSERT [dbo].[Book_Category] ([b_cate_id], [b_cate_name], [b_cate_img], [b_cate_des]) VALUES (N'AR', N'Art', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=funeasyart_1289188771.6836090088', N'Encaustic painting done with iron and stylus for the beginner. When you come here, you''ll be exhibiting many collections of the arts.')
INSERT [dbo].[Book_Category] ([b_cate_id], [b_cate_name], [b_cate_img], [b_cate_des]) VALUES (N'CO', N'Cooking', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=andrea3_1267997378.1141479015', N'All About Cooking! We include a large number of links to more information recipes and credits.  You will enjoy this fun guide with several chapters on many cooking topics.')
INSERT [dbo].[Book_Category] ([b_cate_id], [b_cate_name], [b_cate_img], [b_cate_des]) VALUES (N'GA', N'Games', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=sie57f3e902e045_1415381935.6778140068', N'The mystery of one''s own existence is forced upon you. It is surely possible to negate it. However, that does not help to solve it. Let''s try it.')
INSERT [dbo].[Book_Category] ([b_cate_id], [b_cate_name], [b_cate_img], [b_cate_des]) VALUES (N'MU', N'Music', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=thesirenrose_1329803315.8086309433', N'My band hit it big, I have everything I could of asked for, a huge tour, amazing band mates, and a wonderful fiance back home waiting for me.')
INSERT [dbo].[Book_Category] ([b_cate_id], [b_cate_name], [b_cate_img], [b_cate_des]) VALUES (N'TR', N'Travel', N'https://www.bookrix.com/image/coverpic3d.php?art=book&size=l&p=mcastle_1259101871.7886190414', N'I had been traveling for weeks and never seen the problem with the food in India. Personally I thought it was great. Even the meat and food from the rickshaws. What could go wrong? I had come to the conclusion my steady diet of Imodium had made me immune to anything Indian food could throw at me.')
GO
SET IDENTITY_INSERT [dbo].[Borrow] ON 

INSERT [dbo].[Borrow] ([br_id], [u_id], [br_date], [br_resend], [sh_id]) VALUES (1, 2, CAST(N'2022-07-16T00:00:00.000' AS DateTime), CAST(N'2022-07-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Borrow] ([br_id], [u_id], [br_date], [br_resend], [sh_id]) VALUES (3, 9, CAST(N'2022-07-24T01:14:36.707' AS DateTime), CAST(N'2022-07-27T01:14:36.707' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Borrow] OFF
GO
INSERT [dbo].[Borrow_Detail] ([b_id], [br_id], [quantity], [price], [total], [brd_status]) VALUES (1, 1, 1, 24.0000, 24.0000, 1)
INSERT [dbo].[Borrow_Detail] ([b_id], [br_id], [quantity], [price], [total], [brd_status]) VALUES (2, 1, 1, 24.0000, 24.0000, 1)
INSERT [dbo].[Borrow_Detail] ([b_id], [br_id], [quantity], [price], [total], [brd_status]) VALUES (2, 3, 1, 24.0000, 24.0000, 1)
INSERT [dbo].[Borrow_Detail] ([b_id], [br_id], [quantity], [price], [total], [brd_status]) VALUES (3, 3, 1, 24.0000, 24.0000, 1)
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([r_id], [r_name], [r_desc]) VALUES (1, N'Admin', N'The role who can manage, edit the author or reader.')
INSERT [dbo].[Role] ([r_id], [r_name], [r_desc]) VALUES (2, N'Reader', N'The role who join, view, and borrow book in the system.')
INSERT [dbo].[Role] ([r_id], [r_name], [r_desc]) VALUES (4, N'Author', N'The role who can manage, edit the book.')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Shipper] ON 

INSERT [dbo].[Shipper] ([sh_id], [sh_name], [sh_gender], [sh_email], [sh_phone], [sh_address], [u_id], [sh_status]) VALUES (1, N'Van Ba', 1, N'vanba97@gmail.com', N'0123987456', N'Ha Noi', 1, 1)
SET IDENTITY_INSERT [dbo].[Shipper] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (1, N'chieundhe151294@gmail.com', N'anhchieu', N'0123789654', N'Hung Yen', 1, NULL, N'Danh Chieu', 1, 1, CAST(N'2001-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (2, N'namnhhe151296@gmail.com', N'he151296', N'0321456987', N'Ha Noi', 2, N'9447', N'Hoai Nam', 1, 1, CAST(N'2001-09-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (4, N'thanhpnhe151285@gmail.com', N'thanhthai', N'0123654789', N'Hai Phong', 4, NULL, N'Nhat Thanh', 1, 1, CAST(N'2001-05-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (7, N'datndhe153003@gmail.com', N'dat<3anh', N'0321456987', N'Nam Dinh', 2, N'9999', N'Duy Dat', 1, 1, CAST(N'2001-01-16T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (8, N'daotvhe151293@gmail.com', N'daoon', N'0123654789', N'Nam Dinh', 4, NULL, N'Van Dao', 1, 1, CAST(N'2001-06-18T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[User] ([u_id], [u_email], [u_password], [u_phone], [u_address], [r_id], [u_wallet], [u_username], [u_status], [u_gender], [u_dob], [u_managed]) VALUES (9, N'thuyttthe153005@gmail.com', N'thuytran', N'0123456987', N'Thai Nguyen', 2, N'9687', N'Thuy Tran', 1, 0, CAST(N'2022-07-24T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Book_Category] FOREIGN KEY([b_cate_id])
REFERENCES [dbo].[Book_Category] ([b_cate_id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Book_Category]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_User] FOREIGN KEY([u_id])
REFERENCES [dbo].[User] ([u_id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_User]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Shipper] FOREIGN KEY([sh_id])
REFERENCES [dbo].[Shipper] ([sh_id])
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_Shipper]
GO
ALTER TABLE [dbo].[Borrow]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_User] FOREIGN KEY([u_id])
REFERENCES [dbo].[User] ([u_id])
GO
ALTER TABLE [dbo].[Borrow] CHECK CONSTRAINT [FK_Borrow_User]
GO
ALTER TABLE [dbo].[Borrow_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Detail_Book] FOREIGN KEY([b_id])
REFERENCES [dbo].[Book] ([b_id])
GO
ALTER TABLE [dbo].[Borrow_Detail] CHECK CONSTRAINT [FK_Borrow_Detail_Book]
GO
ALTER TABLE [dbo].[Borrow_Detail]  WITH CHECK ADD  CONSTRAINT [FK_Borrow_Detail_Borrow] FOREIGN KEY([br_id])
REFERENCES [dbo].[Borrow] ([br_id])
GO
ALTER TABLE [dbo].[Borrow_Detail] CHECK CONSTRAINT [FK_Borrow_Detail_Borrow]
GO
ALTER TABLE [dbo].[Shipper]  WITH CHECK ADD  CONSTRAINT [FK_Shipper_User] FOREIGN KEY([u_id])
REFERENCES [dbo].[User] ([u_id])
GO
ALTER TABLE [dbo].[Shipper] CHECK CONSTRAINT [FK_Shipper_User]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([r_id])
REFERENCES [dbo].[Role] ([r_id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [LMS] SET  READ_WRITE 
GO
