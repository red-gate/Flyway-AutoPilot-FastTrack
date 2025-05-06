-- This script adds a create a change in Test to simulate Drift in Live environments!

USE AutoPilotTest;
CREATE TABLE iAmDrifted (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
