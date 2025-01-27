**Scenario**:
The `Customers.Customer` table stores `Phone` and `Address` information directly, but this data should be normalized into a separate table to support multiple phone numbers and addresses for a single customer.

**Objective**:
- Create two new tables:
  - `Customers.CustomerPhone` with columns `PhoneID` (PK), `CustomerID` (FK), and `Phone`.
  - `Customers.CustomerAddress` with columns `AddressID` (PK), `CustomerID` (FK), and `Address`.
- Populate the new tables with data from the existing `Customers.Customer` table.
- Remove the `Phone` and `Address` columns from the `Customers.Customer` table.

**Hints**:
- Use `CREATE TABLE`, `INSERT INTO ... SELECT`, and `ALTER TABLE` statements.
- Ensure foreign key relationships are maintained.
