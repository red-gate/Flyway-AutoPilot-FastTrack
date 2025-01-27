**Scenario**:
The `Inventory.MaintenanceLog` table is growing rapidly. To improve query performance and manageability, partition the table by year based on the `MaintenanceDate` column.

**Objective**:
- Create a partition function to split data by year.
- Create a partition scheme for the function.
- Recreate the `Inventory.MaintenanceLog` table to use the partition scheme.

**Hints**:
- Use `CREATE PARTITION FUNCTION` and `CREATE PARTITION SCHEME`.
- Recreate the table with the partitioned structure.
- Test the partitioning by querying data for specific years.
