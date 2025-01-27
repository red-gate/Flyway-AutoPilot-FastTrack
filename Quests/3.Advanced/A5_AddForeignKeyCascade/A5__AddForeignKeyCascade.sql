-- Drop the existing foreign key
ALTER TABLE Sales.OrderAuditLog
DROP CONSTRAINT FK_OrderAuditLog_Order;

-- Recreate the foreign key with ON DELETE CASCADE
ALTER TABLE Sales.OrderAuditLog
ADD CONSTRAINT FK_OrderAuditLog_Order
FOREIGN KEY (OrderID) REFERENCES Sales.Orders(OrderID)
ON DELETE CASCADE;

