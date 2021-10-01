USE HotelDB;
GO

-- 1 Write a query that returns a list of reservations that end in July 2023, including the name of the guest, the room number(s), and the reservation dates.
SELECT [Reservations].Reservation_ID, [ReservationsRooms].Room_ID, [Date_Start], [Date_End], [Guests].FirstName + ' ' + [Guests].LastName AS 'Guest Name'
	FROM [ReservationsRooms]
		JOIN [Reservations]
			ON [Reservations].Reservation_ID = [ReservationsRooms].Reservation_ID
		JOIN [Guests]
			ON [Guests].Guest_ID = [Reservations].Guest_ID
		WHERE MONTH(Date_End) = 7 AND YEAR(Date_End) = '2023';			

/*	RESULTS
Reservation_ID	Room_ID	Date_Start	Date_End	Guest Name
15				205		2023-06-28	2023-07-02	Craig Johnson
16				204		2023-07-13	2023-07-14	Walter Holaway
17				401		2023-07-18	2023-07-21	Wilfred Vise
18				303		2023-07-28	2023-07-29	Bettyann Seery
*/

-- 2 Write a query that returns a list of all reservations for rooms with a jacuzzi, displaying the guest's name, the room number, and the dates of the reservation.
SELECT [ReservationsRooms].Reservation_ID, [ReservationsRooms].Room_ID, [Guests].FirstName + ' ' + [Guests].LastName AS 'Guest Name', [Date_Start], [Date_End]  
	FROM [ReservationsRooms]
		JOIN [Reservations]
			ON [Reservations].Reservation_ID = [ReservationsRooms].Reservation_ID
		JOIN [Guests]
			ON [Guests].Guest_ID = [Reservations].Guest_ID
		JOIN [Rooms]
			ON [ReservationsRooms].Room_ID = [Rooms].Room_ID
		JOIN [RoomsAmenity]
			ON [Rooms].Room_ID = [RoomsAmenity].Room_ID
		WHERE Amenity_ID = 3;

/*	RESULTS
Reservation_ID	Room_ID	Guest Name		Date_Start	Date_End
2				203		Bettyann Seery	2023-02-05	2023-02-10
3				305		Duane Cullison	2023-02-22	2023-02-24
4				201		Karie Yang		2023-03-06	2023-03-07
5				307		Craig Johnson	2023-03-18	2023-03-23
9				301		Walter Holaway	2023-04-09	2023-04-13
10				207		Wilfred Vise	2023-04-23	2023-04-24
15				205		Craig Johnson	2023-06-28	2023-07-02
18				303		Bettyann Seery	2023-07-28	2023-07-29
19				305		Bettyann Seery	2023-08-30	2023-09-01
21				203		Karie Yang		2023-09-13	2023-09-15
24				301		Mack Simmer		2023-11-22	2023-11-25
*/

-- 3 Write a query that returns all the rooms reserved for a specific guest, including the guest's name, the room(s) reserved, the starting date of the reservation, and how many people were included in the reservation. (Choose a guest's name from the existing data.)
SELECT [Guests].FirstName + ' ' + [Guests].LastName AS 'Guest Name', [Reservations].Reservation_ID, [Room_ID], [Date_Start], [Date_End], [Occ_Children] + [Occ_Adults] AS 'Occupants'
	FROM [ReservationsRooms]
		JOIN [Reservations]
			ON [ReservationsRooms].Reservation_ID = [Reservations].Reservation_ID
		JOIN [Guests]
			ON [Guests].Guest_ID = [Reservations].Guest_ID
		WHERE [Reservations].Guest_ID = (SELECT Guest_ID FROM [Guests] x WHERE (x.FirstName = 'Mack' AND x.LastName =  'Simmer'));

/* RESULTS
Guest Name	Reservation_ID	Room_ID	Date_Start	Date_End	Occupants
Mack Simmer	1				308		2023-02-02	2023-02-04	1
Mack Simmer	20				208		2023-09-16	2023-09-17	2
Mack Simmer	23				206		2023-11-22	2023-11-25	2
Mack Simmer	24				301		2023-11-22	2023-11-25	4
*/


-- 4 Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation. The results should include all rooms, whether or not there is a reservation associated with the room.
-- I OPTED TO ALTER THIS PROMPT -- I have no idea what this prompt is asking of me. I have instead written a query that will:
-- Write a query that returns a list of all rooms, showing the total number of reservations for that room, the total cost of all reservations for that room and the average cost per reservation made for that room. The query should allow for room with no reservations without error.

SELECT [ReservationsRooms].Room_ID, COUNT([ReservationsRooms].Reservation_ID) AS 'Total Reservations', SUM([Reservations].Price_Total) AS 'Total Reservation Costs', NULLIF(SUM([Reservations].Price_Total) / COUNT([ReservationsRooms].Reservation_ID), 0) AS 'Avg Cost Per Reservation'
	FROM [ReservationsRooms]
		JOIN [Reservations]
			ON [ReservationsRooms].Reservation_ID = [Reservations].Reservation_ID
	GROUP BY [ReservationsRooms].Room_ID
	ORDER BY 'Total Reservation Costs' DESC

/* RESULTS
Room_ID			Total Reservations	Total Reservation Costs		Avg Cost Per Reservation
401				3					3659.91						1219.970000
302				2					1624.91						812.455000
301				2					1399.93						699.965000
203				2					1399.93						699.965000
206				2					1049.93						524.965000
307				1					924.95						924.950000
208				2					749.95						374.975000
205				1					699.96						699.960000
305				2					699.96						349.980000
202				1					349.98						349.980000
308				1					299.98						299.980000
303				1					199.99						199.990000
201				1					199.99						199.990000
204				1					184.99						184.990000
304				1					184.99						184.990000
207				1					174.99						174.990000
*/

-- 5 Write a query that returns all the rooms accommodating at least three guests and that are reserved on any date in April 2023.
SELECT [ReservationsRooms].Room_ID, [Date_Start], [Date_End], [Occ_Children] + [Occ_Adults] AS 'Occupants', [ReservationsRooms].Reservation_ID
	FROM [ReservationsRooms]
		JOIN [Rooms]
			ON [ReservationsRooms].Room_ID = [Rooms].Room_ID
		JOIN [Reservations]
			ON [ReservationsRooms].Reservation_ID = [Reservations].Reservation_ID
		WHERE [Occ_Adults] + [Occ_Children] > 2
			AND ((MONTH(Date_Start) = 4 AND YEAR(Date_Start) = 2023) 
			OR (MONTH(Date_End) = 4 AND YEAR(Date_End) = 2023) 
			OR (Date_Start < '04/01/2023' AND Date_End > '04/30/2023'));

/* RESULTS
Room_ID	Date_Start	Date_End	Occupants	Reservation_ID
[None]
*/


-- 6 Write a query that returns a list of all guest names and the number of reservations per guest, sorted starting with the guest with the most reservations and then by the guest's last name.
SELECT [Guests].FirstName + ' ' + [Guests].LastName AS 'Guest Name', COUNT([ReservationsRooms].Reservation_ID) AS 'Reservations'
	FROM [ReservationsRooms]
		JOIN [Reservations]
			ON [ReservationsRooms].Reservation_ID = [Reservations].Reservation_ID
		JOIN [Guests] 
			ON [Reservations].Guest_ID = [Guests].Guest_ID
	GROUP BY [Guests].Guest_ID, [Guests].LastName, [Guests].FirstName
	ORDER BY 'Reservations' DESC, [Guests].LastName;

/* RESULTS
Guest Name			Reservations
Mack Simmer			4
Bettyann Seery		3
Duane Cullison		2
Walter Holaway		2
Craig Johnson		2
Aurore Lipton		2
Maritza Tilton		2
Joleen Tison		2
Wilfred Vise		2
Karie Yang			2
Zachery Luechtefeld	1
*/


-- 7 Write a query that displays the name, address, and phone number of a guest based on their phone number. (Choose a phone number from the existing data.)
SELECT	FirstName + ' ' + LastName AS 'Guest Name', 
		Street + ', ' + City + ', ' + [Abbreviation] + Zip AS 'Address',
		Phone
	FROM [Guests]
		JOIN [State_LUT]
			ON [Guests].State_ID = [State_LUT].State_ID
	WHERE Phone = '2147300298';

/* RESULTS
Guest Name	Address											Phone
Karie Yang	9378 W. Augusta Ave., West Deptford, NJ8096 	2147300298
*/
