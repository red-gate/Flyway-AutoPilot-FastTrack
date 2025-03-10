# Quest 3: Merging Pending Migrations  

## Scenario  
A set of schema changes have been made under the `Marketing` schema, but they are still in the **PendingChanges** branch. Before deployment, these changes must be reviewed and merged into a single migration script.

If you are running this quest outside of an event, execute the provided SQL script to create the pending objects.

However, the **Finance** team has also introduced changes that should not be included in this migration. You must carefully select only the relevant objects from the **Marketing** schema when generating the migration script.

## Objective  
- Switch to the **PendingChanges** branch and review the uncommitted changes.  
- Use Flyway Desktop to generate a **single migration script** for all `Marketing` schema objects.  
- Ensure that **no objects from the `Finance` schema** are included in the migration script.  
- Validate the script using **Flyway's validation feature** to check for correctness.  
- Apply the migration locally to confirm that all objects are created successfully.  
- Commit and push the final migration script to source control.  

## Steps  
1. **If running this during an event**, switch to the **PendingChanges** branch in Flyway Desktop.  
2. **If running this outside of an event**, execute `B3__CreatePendingObjects.sql` to create the pending objects.  
3. Open **Flyway Desktop** and navigate to the **Generate Migration** option.  
4. Carefully select **only objects from the `Marketing` schema**—do not include any `Finance` schema objects.  
5. Run the **Flyway Validate** command to check for errors before applying the migration.  
6. Apply the script locally and confirm that all objects are created successfully.  
7. Commit the merged migration and push it to the repository.  

## Objects That Should Be Included (`Marketing` Schema)  
✔ `Marketing.CustomerFeedback` (Table)  
✔ `Marketing.CampaignAnalytics` (Table)  
✔ `Marketing.GetCustomerFeedback` (Stored Procedure)  
✔ `Marketing.GetAverageCampaignCTR` (Function)  

## Objects That Should NOT Be Included (`Finance` Schema)  
✖ `Finance.BudgetAllocations` (Table)  
✖ `Finance.GetBudgetForDepartment` (Stored Procedure)  

## Hints  
- Use **Flyway Desktop’s schema selection feature** to exclude unwanted objects.  
- Run `SELECT * FROM sys.objects WHERE schema_id = SCHEMA_ID('Marketing')` to list only `Marketing` schema objects.  
- Run **`flyway validate`** before applying changes to catch potential issues early.  
- Verify that no dependencies are broken after merging.  

## Success Criteria  
- All pending **Marketing** schema changes are combined into a single script.  
- The new script applies successfully without errors.  
- The Flyway validation step passes without warnings.  
- The final migration is versioned and pushed to the repository.  

