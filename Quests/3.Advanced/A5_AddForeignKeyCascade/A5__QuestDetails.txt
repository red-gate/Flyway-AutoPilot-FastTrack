**Scenario**:
The `Sales.OrderAuditLog` table references `Sales.Orders`, but when an order is deleted, its associated audit logs remain, causing data inconsistencies. To prevent this, a cascading delete should be implemented.

**Objective**:
- Add a foreign key to the `Sales.OrderAuditLog` table with `ON DELETE CASCADE` behavior for `OrderID`.

**Hints**:
- Drop and re-add the foreign key with the `ON DELETE CASCADE` option.
- Test the behavior by deleting an order and verifying that its audit logs are also removed.
