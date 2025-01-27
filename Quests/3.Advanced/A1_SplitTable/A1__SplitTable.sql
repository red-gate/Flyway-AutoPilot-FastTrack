CREATE TABLE Customers.CustomerFeedbackComments (
    CommentID INT PRIMARY KEY IDENTITY,
    FeedbackID INT FOREIGN KEY REFERENCES Customers.CustomerFeedback(FeedbackID),
    Comments NVARCHAR(500)
);

INSERT INTO Customers.CustomerFeedbackComments (FeedbackID, Comments)
SELECT FeedbackID, Comments FROM Customers.CustomerFeedback;

ALTER TABLE Customers.CustomerFeedback
DROP COLUMN Comments;
