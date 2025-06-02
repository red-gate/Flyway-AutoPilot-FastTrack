-- Step 1: Create the initial table. 

CREATE TABLE Operation.FlightHistory
(
    SourceLocation NVARCHAR(24),
	Destination NVARCHAR(24),
	Airport NVARCHAR(24),
	Terminal NVARCHAR(24),
	Active BIT,
	FlightID INT,
	PRIMARY KEY (FlightID)
)

-- Step 2: Insert initial data into the table.

BEGIN
INSERT INTO Operation.FlightHistory (FlightID, SourceLocation, Destination, Airport, Terminal, Active)
VALUES
(1, 'London', 'Dubai', 'LHR', 'T3', 1),
(2, 'Paris', 'Tokyo', 'CDG', 'T2E', 1),
(3, 'Frankfurt', 'Singapore', 'FRA', 'T1', 1),
(4, 'Istanbul', 'Bangkok', 'IST', 'T1', 1),
(5, 'Madrid', 'Doha', 'MAD', 'T4S', 0),
(6, 'Rome', 'Kuala Lumpur', 'FCO', 'T3', 1),
(7, 'Barcelona', 'Seoul', 'BCN', 'T1', 1),
(8, 'Amsterdam', 'Jakarta', 'AMS', 'T2', 0),
(9, 'Zurich', 'Hong Kong', 'ZRH', 'T1', 1),
(10, 'Copenhagen', 'Manila', 'CPH', 'T3', 1),
(11, 'Dublin', 'Sydney', 'DUB', 'T2', 1),
(12, 'Oslo', 'Melbourne', 'OSL', 'T1', 0),
(13, 'Stockholm', 'Auckland', 'ARN', 'T5', 1),
(14, 'Vienna', 'Cape Town', 'VIE', 'T3', 1),
(15, 'Brussels', 'Johannesburg', 'BRU', 'T2', 0),
(16, 'Warsaw', 'Cairo', 'WAW', 'T1', 1),
(17, 'Lisbon', 'Mumbai', 'LIS', 'T1', 1),
(18, 'Prague', 'Delhi', 'PRG', 'T2', 0),
(19, 'Budapest', 'Chennai', 'BUD', 'T2B', 1),
(20, 'Athens', 'Bangalore', 'ATH', 'T1', 1),
(21, 'Helsinki', 'Beijing', 'HEL', 'T2', 0),
(22, 'Reykjavik', 'Shanghai', 'KEF', 'T1', 1),
(23, 'Nice', 'Hanoi', 'NCE', 'T1', 1),
(24, 'Geneva', 'Ho Chi Minh City', 'GVA', 'T1', 0),
(25, 'Munich', 'Istanbul', 'MUC', 'T2', 1),
(26, 'Milan', 'Tokyo', 'MXP', 'T1', 1),
(27, 'Edinburgh', 'Seoul', 'EDI', 'T1', 0),
(28, 'Bucharest', 'Bangkok', 'OTP', 'T1', 1),
(29, 'Sofia', 'Doha', 'SOF', 'T2', 1),
(30, 'Ljubljana', 'Dubai', 'LJU', 'T1', 0);