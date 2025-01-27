-- Drop the existing foreign key if exists
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[Sales].[FK_OrderAuditLog_Order]','F'))
ALTER TABLE Sales.OrderAuditLog
DROP CONSTRAINT FK_OrderAuditLog_Order;

-- Recreate the foreign key with ON DELETE CASCADE
ALTER TABLE Sales.OrderAuditLog
ADD CONSTRAINT FK_OrderAuditLog_Order
FOREIGN KEY (OrderID) REFERENCES Sales.Orders(OrderID)
ON DELETE CASCADE;

