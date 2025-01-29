**Scenario**:
Queries on the `Inventory.Flight` table often calculate the flight duration (`ArrivalTime - DepartureTime`). To optimize performance, a computed column should be added for this value, with an index to support frequent lookups.

**Objective**:
- Add a computed column `FlightDuration` to the `Inventory.Flight` table that calculates the duration in minutes.
- Create an index on the `FlightDuration` column to optimize queries.

**Hints**:
- Use `ALTER TABLE` to add the computed column.
- Use `CREATE INDEX` to index the computed column.
- Test the new column and index by querying for flights with specific durations.
