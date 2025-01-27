-- Create new tables
CREATE TABLE Customers.CustomerPhone (
    PhoneID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customers.Customer(CustomerID),
    Phone NVARCHAR(20)
);

CREATE TABLE Customers.CustomerAddress (
    AddressID INT PRIMARY KEY IDENTITY,
    CustomerID INT FOREIGN KEY REFERENCES Customers.Customer(CustomerID),
    Address NVARCHAR(200)
);

-- Populate new tables
INSERT INTO Customers.CustomerPhone (CustomerID, Phone)
SELECT CustomerID, Phone FROM Customers.Customer WHERE Phone IS NOT NULL;

INSERT INTO Customers.CustomerAddress (CustomerID, Address)
SELECT CustomerID, Address FROM Customers.Customer WHERE Address IS NOT NULL;

-- Drop old columns
ALTER TABLE Customers.Customer
DROP COLUMN Phone, Address;
