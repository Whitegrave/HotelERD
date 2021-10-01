USE [HotelDB]
GO

-- Independant Tables
INSERT INTO [State_LUT]
	([Abbreviation], [State_Full])
	VALUES	('AL', 'Alabama'),			('AK', 'Alaska'),		('AZ', 'Arizona'),			('AR', 'Arkansas'),		('CA', 'California'),	('CO', 'Colorado'),		('CT', 'Connecticut'),	('DE', 'Delaware'),			('FL', 'Florida'),			('GA', 'Georgia'),
			('HI', 'Hawaii'),			('ID', 'Idaho'),		('IL', 'Illinois'),			('IN', 'Indiana'),		('IA', 'Iowa'),			('KS', 'Kansas'),		('KY', 'Kentucky'),		('LA', 'Louisiana'),		('ME', 'Maine'),			('MD', 'Maryland'),
			('MA', 'Massachusetts'),	('MI', 'Michigan'),		('MN', 'Minnesota'),		('MS', 'Mississippi'),	('MO', 'Missouri'),		('MT', 'Montana'),		('NE', 'Nebraska'),		('NV', 'Nevada'),			('NH', 'New Hampshire'),	('NJ', 'New Jersey'),
			('NM', 'New Mexico'),		('NY', 'New York'),		('NC', 'North Carolina'),	('ND', 'North Dakota'), ('OH', 'Ohio'),			('OK', 'Oklahoma'),		('OR', 'Oregon'),		('PA', 'Pennsylvania'),		('RI', 'Rhode Island'),		('SC', 'South Carolina'),
			('SD', 'South Dakota'),		('TN', 'Tennessee'),	('TX', 'Texas'),			('UT', 'Utah'),			('VT', 'Vermont'),		('VA', 'Virginia'),		('WA', 'Washington'),	('WV', 'West Virginia'),	('WI', 'Wisconsin'),		('WY', 'Wyoming');	

INSERT INTO [Amenity_LUT]
	([Amenity_Name])
	VALUES	('Microwave'),
			('Refrigerator'),
			('Jacuzzi'),
			('ADA Access'),
			('Stove'),
			('Oven');

INSERT INTO [Room_Type_LUT]
	([Type_Name])
	VALUES	('Single'),
			('Double'),
			('Suite');

-- Relational Tables
INSERT INTO [Guests] 
	([FirstName], [LastName], [Street], [City], [State_ID], [Zip], [Phone]) 
	VALUES	('Craig', 'Johnson', 'Johnston RD', 'Slingerlands', 32, 12159, 5183229859),
			('Mack', 'Simmer', '379 Old Shore Street', 'Council Bluffs', 15, 51501, 2915530508),
			('Bettyann', 'Seery', '750 Wintergreen Dr.', 'Wasilla', 2, 99654, 4782779632),
			('Duane', 'Cullison', '9662 Foxrun Lane', 'Harlingen', 43, 78552, 3084940198),
			('Karie', 'Yang', '9378 W. Augusta Ave.', 'West Deptford', 30, 08096, 2147300298),
			('Aurore', 'Lipton', '762 Wild Rose Street', 'Saginaw', 22, 48601, 3775070974),
			('Zachery', 'Luechtefeld', '7 Poplar Dr.', 'Arvada', 6, 80003, 814852615),
			('Jeremiah', 'Pendergrass', '70 Oakwood St.', 'Zion', 13, 60099, 2794910960),
			('Walter', 'Holaway', '7556 Arrowhead St.', 'Cumberland', 39, 02864, 4463966785),
			('Wilfred', 'Vise', '77 West Surrey Street', 'Oswego', 32, 13126, 8347271001),
			('Maritza', 'Tilton', '939 Linda Rd.', 'Burke', 46, 22015, 4463516860),
			('Joleen', 'Tison', '87 Queen St.', 'Drexel Hill', 38, 19026, 2318932755);


INSERT INTO [Rooms]
	([Room_ID], [Type_ID], [Occupancy_Min], [Occupancy_Max], [Price_Base], [Price_Extra_Adult])
	VALUES	(201, 2, 2, 4, 199.99, 10.00),
			(202, 2, 2, 4, 174.99, 10.00),
			(203, 2, 2, 4, 199.99, 10.00),
			(204, 2, 2, 4, 174.99, 10.00),
			(205, 1, 2, 2, 174.99, 0),
			(206, 1, 2, 2, 149.99, 0),
			(207, 1, 2, 2, 174.99, 0),
			(208, 1, 2, 2, 149.99, 0),
			(301, 2, 2, 4, 199.99, 10.00),
			(302, 2, 2, 4, 174.99, 10.00),
			(303, 2, 2, 4, 199.99, 10.00),
			(304, 2, 2, 4, 174.99, 10.00),
			(305, 1, 2, 2, 174.99, 0),
			(306, 1, 2, 2, 149.99, 0),
			(307, 1, 2, 2, 174.99, 0),
			(308, 1, 2, 2, 149.99, 0),
			(401, 3, 3, 8, 399.99, 20.00),
			(402, 3, 3, 8, 399.99, 20.00);

INSERT INTO [Reservations]
	([Guest_ID], [Date_Start], [Date_End], [Occ_Adults], [Occ_Children], [Price_Total])
	VALUES	(2,	'2/2/2023',		'2/4/2023',		1,	0,	299.98),
			(3,	'2/5/2023',		'2/10/2023',	2,	1,	999.95),
			(4,	'2/22/2023',	'2/24/2023',	2,	0,	349.98),
			(5,	'3/6/2023',		'3/7/2023',		2,	2,	199.99),
			(1,	'3/18/2023',	'3/23/2023',	1,	1,	924.95),
			(6,	'3/18/2023',	'3/23/2023',	3,	0,	924.95),
			(7,	'3/29/2023',	'3/31/2023',	2,	2,	349.98),
			(8,	'3/31/2023',	'4/5/2023',		2,	0,	874.95),
			(9,	'4/9/2023',		'4/13/2023',	1,	0,	799.96),
			(10, '4/23/2023',	'4/24/2023',	1,	1,	174.99),
			(11, '5/30/2023',	'6/2/2023',		2,	4,	1199.97),
			(12, '6/10/2023',	'6/14/2023',	2,	0,	599.96),
			(12, '6/10/2023',	'6/14/2023',	1,	0,	599.96),
			(6,	'6/17/2023',	'6/18/2023',	3,	0,	184.99),
			(1,	'6/28/2023',	'7/2/2023',		2,	0,	699.96),
			(9,	'7/13/2023',	'7/14/2023',	3,	1,	184.99),
			(10, '7/18/2023',	'7/21/2023',	4,	2,	1259.97),
			(3,	'7/28/2023',	'7/29/2023',	2,	1,	199.99),
			(3,	'8/30/2023',	'9/1/2023',		1,	0,	349.98),
			(2,	'9/16/2023',	'9/17/2023',	2,	0,	149.99),
			(5,	'9/13/2023',	'9/15/2023',	2,	2,	399.98),
			(4,	'11/22/2023',	'11/25/2023',	2,	2,	1199.97),
			(2,	'11/22/2023',	'11/25/2023',	2,	0,	449.97),
			(2,	'11/22/2023',	'11/25/2023',	2,	2,	599.97),
			(11, '12/24/2023',	'12/28/2023',	2,	0,	699.96);

-- Bridge Tables
INSERT INTO [ReservationsRooms]
	([Reservation_ID], [Room_ID])
	VALUES	(1, 308),	(2, 203),	(3, 305),	(4, 201),	(5, 307),
			(6, 302),	(7, 202),	(8, 304),	(9, 301),	(10, 207),
			(11, 401),	(12, 206),	(13, 208),	(14, 304),	(15, 205),
			(16, 204),	(17, 401),	(18, 303),	(19, 305),	(20, 208),
			(21, 203),	(22, 401),	(23, 206),	(24, 301),	(25, 302);

INSERT INTO [RoomsAmenity]
	([Room_ID], [Amenity_ID])
	VALUES	(201, 1),	(201, 3),
			(202, 2),	(202, 4),
			(203, 1),	(203, 3),
			(204, 2),	(204, 4),
			(205, 1),	(205, 2),	(205, 3),
			(206, 1),	(206, 2),	(206, 4),
			(207, 1),	(207, 2),	(207, 3),
			(208, 1),	(208, 2),	(208, 4),
			(301, 1),	(301, 3),
			(302, 2),	(302, 4),
			(303, 1),	(303, 3),
			(304, 2),	(304, 4),
			(305, 1),	(305, 2),	(305, 3),
			(306, 1),	(306, 2),	(306, 4),
			(307, 1),	(307, 2),	(307, 3),
			(308, 1),	(308, 2),	(308, 4),
			(401, 1),	(401, 2),	(401, 4),	(401, 6),
			(402, 1),	(402, 2),	(402, 4),	(402, 6);


			
-- Delete Jeremiah Pendergrass
DELETE 
	FROM [ReservationsRooms]
	WHERE [Reservation_ID] = (
		SELECT [Reservation_ID]
		FROM [Reservations] x
		WHERE x.Guest_ID = (
			SELECT [Guest_ID] 
			FROM [Guests] y
			WHERE y.FirstName = 'Jeremiah' AND y.LastName = 'Pendergrass'));

DELETE FROM [Reservations]
    WHERE [Guest_ID] = (SELECT [Guest_ID] FROM [Guests] x WHERE x.FirstName = 'Jeremiah' AND x.LastName = 'Pendergrass');
DELETE FROM [Guests]
	WHERE FirstName = 'Jeremiah' AND LastName = 'Pendergrass'; 
