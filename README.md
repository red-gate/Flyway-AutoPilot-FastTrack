This example Flyway project allows you to get hands on experience with the end-to-end database development and deployment process.  

**You will:**
1. Use Flyway Desktop to capture the DDL for each database object so you can understand how each object has changed over time
2. Use Flyway Desktop to prepare for deployments by generating _Versioned Migration Scripts_ for safe deployments that are also captured in version control
3. Use Flyway Desktop to commit all these changes to version control
4. See how the database changes you made flow through the pipeline to the downstream environments  

**This example uses:**
1. SQL Server as the database to develop and deploy
2. GitHub for version controlling database changes
3. GitHub Actions for the CI/CD pipeline to deploy database changes to downstream environments (e.g., Test > Staging > Prod)

Flyway supports over 20 database systems and any version control or CI/CD system.  You can learn more about Flyway at www.redgate.com/flyway. 

**To use this example:**
**Setup**
1. Download and install Flyway Enterprise from https://www.red-gate.com/products/flyway/enterprise/trial.
2. Fork this GitHub repository and clone it to your machine.
3. In a local or test SQL Server instance, execute the CreateWidgetDatabases.sql to create the databases (WidgetDev, WidgetTest, etc.) used for this example.


**Development Experience**
1. Open Flyway Desktop from the Start Menu.
2. In Flyway Desktop, **Open project...** from disk.
3. Navigate to the flyway settings file in your local repo you just cloned (either flyway.toml, or flyway-dev.json or flyway.conf)
4. Start making changes to the WidgetDev database in the IDE of your choice (SSMS, VS Code).  Eg:
CREATE TABLE dbo.MyFirstTable
(
    ID	     INT PRIMARY KEY,
	  Column1  NVARCHAR(50)
)

5. In Flyway Desktop, click on the Schema Model tab to see all the changes that have been made to your development database that aren't captured on disk yet.
6. Select the changes you want and click **Save**.
7. Click **Generate migrations**
8. Select the changes that are ready for deployment and click **Generate scripts**.
9. Review the generated script.  The version number has automatically been incremented from your existing scripts.  You may want to update the name of the script to be more descriptive.  If you need to make any updates to the script, or handle data changes, edit the scripts contents. You can review the UNDO script too.
10. Click **Save**.
11. Click **Commit changes**, which brings you to the Version Control tab.
12. Select the changes that you're ready to commit, enter a message, and click **Commit and Push**.

**Deployment Experience**
1. See how the GitHub pipeline has started.
2. Check the WidgetTest database to see if your changes have been applied. 
