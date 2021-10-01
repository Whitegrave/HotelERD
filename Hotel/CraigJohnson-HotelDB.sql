-- Context of master DB so not executing within a DB we may be trying to delete
USE [master];
GO

-- Delete if existing
if exists (select * FROM sys.databases WHERE name = N'HotelDB')
begin
	EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'HotelDB';
	ALTER DATABASE HotelDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE HotelDB;
end

-- Create
CREATE DATABASE HotelDB;
GO

-- Switch context to newly created DB
USE [HotelDB];
GO

-- Build primary tables
CREATE TABLE [State_LUT] (
	[State_ID] SMALLINT PRIMARY KEY IDENTITY (1, 1),
	[Abbreviation] CHAR(2) NOT NULL,
	[State_Full] CHAR(14) NOT NULL);

CREATE TABLE [Room_Type_LUT] (
	[Type_ID] SMALLINT PRIMARY KEY IDENTITY (1, 1),
	[Type_Name] CHAR(6) NOT NULL);

CREATE TABLE [Amenity_LUT] (
	[Amenity_ID] SMALLINT PRIMARY KEY IDENTITY (1, 1),
	[Amenity_Name] CHAR(12) NOT NULL);


-- Build related tables
CREATE TABLE [Guests] (
	[Guest_ID] INT PRIMARY KEY IDENTITY (1, 1),
	[FirstName] NVARCHAR(30) NOT NULL,
	[LastName] NVARCHAR(30) NOT NULL,
	[Street] NVARCHAR(50) NOT NULL,
	[City] NVARCHAR(30) NOT NULL,
	[State_ID] SMALLINT NOT NULL,
	CONSTRAINT FK_State_To_Guest
		FOREIGN KEY ([State_ID])
		REFERENCES [State_LUT]([State_ID]),
	[Zip] CHAR(5) NOT NULL,
	[Phone] VARCHAR(15) NOT NULL);

CREATE TABLE [Rooms] (
	[Room_ID] SMALLINT PRIMARY KEY,
	[Type_ID] SMALLINT NOT NULL,
	CONSTRAINT FK_Type_ID_To_Rooms
		FOREIGN KEY ([Type_ID])
		REFERENCES [Room_Type_LUT]([Type_ID]),
	[Occupancy_Min] SMALLINT NOT NULL,
	[Occupancy_Max] SMALLINT NOT NULL,
	[Price_Base] DECIMAL(13,4) NOT NULL,
	[Price_Extra_Adult] DECIMAL(13,4) NOT NULL);

CREATE TABLE [RoomsAmenity] (
	[Room_ID] SMALLINT NOT NULL,
		CONSTRAINT FK_Room_ID_To_RoomAmenity
			FOREIGN KEY ([Room_ID])
			REFERENCES [Rooms]([Room_ID]),
	[Amenity_ID] SMALLINT NOT NULL,
		CONSTRAINT FK_Amenity_ID_To_RoomAmenity 
			FOREIGN KEY ([Amenity_ID])
			REFERENCES [Amenity_LUT]([Amenity_ID]),
	CONSTRAINT CK_Composite_RoomAmenity
		UNIQUE ([Room_ID], [Amenity_ID]));

CREATE TABLE [Reservations] (
	[Reservation_ID] INT PRIMARY KEY IDENTITY (1, 1),
	[Guest_ID] INT NOT NULL,
	CONSTRAINT FK_Guest_To_Reservation 
		FOREIGN KEY ([Guest_ID])
		REFERENCES [Guests]([Guest_ID]),
	[Date_Start] DATE NOT NULL,
	[Date_End] DATE NOT NULL,
	[Occ_Adults] SMALLINT NOT NULL,
	[Occ_Children] SMALLINT NOT NULL,
	[Price_Total] DECIMAL(13,2) NOT NULL);

CREATE TABLE [ReservationsRooms] (
	[Reservation_ID] INT NOT NULL,
	CONSTRAINT FK_Reservation_To_ReservationsRooms
		FOREIGN KEY ([Reservation_ID])
		REFERENCES [Reservations]([Reservation_ID]),
	[Room_ID] SMALLINT NOT NULL,
	CONSTRAINT FK_Room_ID_To_ReservationsRooms
		FOREIGN KEY ([Room_ID])
		REFERENCES [Rooms]([Room_ID]),
	CONSTRAINT CK_Composite
		PRIMARY KEY ([Reservation_ID], [Room_ID]));