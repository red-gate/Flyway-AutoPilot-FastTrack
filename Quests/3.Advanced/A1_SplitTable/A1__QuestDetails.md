**Scenario**:
The `Customers.CustomerFeedback` table is growing too large. Split the `Comments` column into a separate table called `CustomerFeedbackComments`.

**Objective**:
- Create the new `Customers.CustomerFeedbackComments` table.
- Migrate the `Comments` data into the new table.
- Add a foreign key between the two tables.

**Hints**:
- Use the `CREATE TABLE`, `INSERT INTO`, and `ALTER TABLE` statements.
- Test that data was migrated correctly and that relationships between the tables are intact.
