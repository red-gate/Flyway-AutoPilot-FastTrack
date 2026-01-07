# Set Flyway parameters
$flywayPath = "path\to\flyway" # Replace with the Flyway executable path
$sourceEnvironment = "Production" # The environment to check for drift
$targetMigrationDirectory = "path\to\migrations" # Replace with your migrations directory
$buildEnvironment = "shadow" # Temporary environment for build (shadow database)

# Perform drift detection and generate a migration script
Write-Output "Checking for drift and generating migration script..."

# Step 1: Perform a diff between the target database and the current migrations
$diffResult = & $flywayPath diff -source="$sourceEnvironment" -target=migrations -buildEnvironment="$buildEnvironment"

if ($diffResult -match "No changes detected") {
    Write-Output "No drift detected. No migration script generated."
} else {
    Write-Output "Drift detected. Generating migration script..."

    # Step 2: Generate the migration script using `diff generate`
    $generateResult = & $flywayPath diff generate -source="$sourceEnvironment" -target=migrations -buildEnvironment="$buildEnvironment" -outputType=json

    # Parse the output to find the generated migration file path
    $generateOutput = $generateResult | ConvertFrom-Json
    $newMigrationScriptPath = $generateOutput.output[0].location

    Write-Output "Migration script generated: $newMigrationScriptPath"
    Write-Output "Apply this migration to other environments to align them with the source."
}