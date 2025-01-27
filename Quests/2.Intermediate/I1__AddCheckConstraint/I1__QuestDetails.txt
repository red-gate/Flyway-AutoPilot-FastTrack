**Scenario**:
Ensure all flights in the `Inventory.Flight` table have a positive number of `AvailableSeats`.

**Objective**:
Add a check constraint to enforce that `AvailableSeats` must be greater than 0.

**Hints**:
- Use the `ALTER TABLE` statement to add constraints.
- Test the constraint by attempting to insert invalid data.

Confirm the constraint is working by running `INSERT` statements that violate the rule.
