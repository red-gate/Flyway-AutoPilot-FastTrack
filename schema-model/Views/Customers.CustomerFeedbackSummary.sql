SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [Customers].[CustomerFeedbackSummary] AS
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    AVG(f.Rating) AS AverageRating,
    COUNT(f.FeedbackID) AS FeedbackCount
FROM Customers.Customer c
LEFT JOIN Customers.CustomerFeedback f ON c.CustomerID = f.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
GO
