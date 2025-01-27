**Scenario**:
Your team has identified that the `Customers.LoyaltyProgram` table contains static configuration data that must be versioned and deployed alongside schema changes. To ensure consistency across environments, this static data will be captured using Flyway Desktop.

**Objective**:
1. Use Flyway Desktop to capture the `Customers.LoyaltyProgram` table's data.
2. Save the captured data into source control.
3. Generate a migration script for this data capture to be deployed to Test and Prod environments.
4. Prevent deployment of the migration script's contents to environments where the static data already exists (Optional)

**Steps**:
1. Navigate to the **Schema Model** tab in Flyway Desktop.
2. In the top left corner, open the **Static data & comparisons** pop-up.
3. Select the `Customers.LoyaltyProgram` table from the dropdown menu.
4. Click the **+ Track selected tables** button.
5. Save the changes to trigger the initial capture of the table's DML (data).
6. Commit and push the changes to source control.
7. Create a migration script for this static data change.

**Tip**:
When deploying to environments like Test or Prod, the static data captured in Dev is likely already present in these environments. Deploying the migration script as-is might cause errors due to duplicate data. 

To avoid this:
- Use the `flyway.skipExecutingMigrations` setting to ensure the script is tracked by Flyway but its contents are not executed in these environments.
- For more details, visit the official Flyway documentation here:  
  https://documentation.red-gate.com/flyway/reference/configuration/flyway-namespace/flyway-skip-executing-migrations-setting

This approach is particularly useful for initial static data captures, hotfixes, and other ad-hoc tasks.

**Success Criteria**:
- The `Customers.LoyaltyProgram` table's static data is successfully captured and versioned in source control.
