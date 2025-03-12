**Scenario**:
In the `Inventory.FlightRoute` table, the combination of `DepartureCity` and `ArrivalCity` should always be unique, but currently, there is no enforcement of this rule.

**Objective**:
- Add a unique constraint to ensure no duplicate routes (same `DepartureCity` and `ArrivalCity`) exist.

**Hints**:
- Use the `ALTER TABLE` statement to add a unique constraint.
- Test the constraint by attempting to insert duplicate routes.
