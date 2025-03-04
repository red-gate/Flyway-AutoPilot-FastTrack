**Scenario**:
You need a stored procedure to retrieve all upcoming flights within a specific date range, given `@StartDate` and `@EndDate` parameters.

**Objective**:
- Write a stored procedure named `GetUpcomingFlights` in the `Inventory` schema.
- The procedure should return flights where `DepartureTime` falls within the date range.

**Hints**:
- Use the `CREATE PROCEDURE` statement.
- Test by executing the procedure with various date ranges.

Verify the output includes only flights within the specified range.
