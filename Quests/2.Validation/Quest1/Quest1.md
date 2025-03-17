# Quest 2: Validating a Production Deployment  

## Scenario  
Before deploying database changes to Production, all modifications must be validated to prevent errors. Flyway's check reports provide insight into potential risks before applying changes.
It is also very important to make sure that the environment you are deploying too contains any drift (objects that have not been created and released from Development)
Your task is to trigger a Flyway pipeline, review the report, and decide whether to proceed or make adjustments.

## Objective  
- Navigate to **Azure DevOps** and locate the Flyway pipeline.  
- Start a Flyway deployment, generating a **Check Report**.  
- Analyze the report for issues such as missing dependencies or invalid objects.  
- Choose whether to continue with deployment or make corrections.

## Steps  
1. Open Azure DevOps and go to **Pipelines**.  
2. Run the Flyway pipeline to trigger the check process.  
3. Review the generated **Check Report** for any warnings or errors.  
4. If the report contains any unexpected changes or unsynched changes, you can decide to stop the deployment before anything is released.
5. Decide whether to release

## Hints  
- You will recieve one change report PER environment. This is because Test and Prod maybe in different states, and may recieve different changes.
- Check the release stages for any **Artifacts** that have been uploaded.

## Success Criteria  
- The Flyway check report is generated and reviewed.  
- The migration script is validated and ready for deployment.  
- Any issues are resolved before deployment is finalized.  

