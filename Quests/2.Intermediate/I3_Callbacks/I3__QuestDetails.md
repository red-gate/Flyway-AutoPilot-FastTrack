**Scenario**:
You need Flyway to perform an additional operation AFTER the clean command is finished during the Build stage.

**Objective**:
- Utilize a callback script to run after the CLEAN verb is complete
- The script should ensure all objects have been deleted, so the subsequent migrate command can run successfully

**Hints**:
- Read the Callbacks documentation and create a new file in the migrations folder
- Test the change by re-running the pipeline and validating that the callback script did indeed run and succeed


