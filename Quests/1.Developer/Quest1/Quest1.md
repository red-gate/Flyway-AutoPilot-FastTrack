# Quest 1: Fixing Broken Dependencies  

## Scenario  
A recent schema update renamed the `Sales.Campaigns` table to `Sales.Orders`, but dependent objects were not updated accordingly. As a result, the stored procedure `Sales.GetActiveCampaigns` is now broken.

Your task is to **find and fix the broken dependency**, ensuring that the stored procedure references the correct table.

## Objective  
- Locate the invalid stored procedure (`Sales.GetActiveCampaigns`).
- Modify it to reference `Sales.Orders` instead of `Sales.Campaigns`.
- Capture the fix in Flyway Desktop and commit the change to source control.

## Steps  
1. Use **SQL Prompt’s "Find Invalid Objects"** feature (or manually check stored procedures).  
2. Open `Sales.GetActiveCampaigns` and update it to use `Sales.Promotions`.  
3. Run Flyway Desktop to capture the schema change.  
4. Commit and push the updated migration script to the repository.  

## Hints  
- Use `sp_helptext 'Sales.GetActiveCampaigns'` to inspect the procedure definition.  
- The `ALTER PROCEDURE` statement can be used to modify an existing stored procedure.  
- After fixing the issue, test by executing `EXEC Sales.GetActiveCampaigns`.  

## Success Criteria  
- The stored procedure executes successfully without errors.  
- The schema change is versioned in Flyway Desktop.  
- The update is committed and pushed to the repository.  
