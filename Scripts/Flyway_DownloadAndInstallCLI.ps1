# ===========================
# Script Name: Flyway_DownloadAndInstallCLI.ps1
# Version: 1.0.0
# Author: Chris Hawkins (Redgate Software Ltd)
# Last Updated: 2025-03-17
# Description: Automated Flyway CLI Installation Script
# ===========================

$ScriptVersion = "1.0.0"

Write-Host "Running Flyway Installer Script - Version $ScriptVersion"

$ErrorActionPreference = "Stop"

# Flyway Version to Use (Check for latest version: https://documentation.red-gate.com/flyway/reference/usage/command-line)
if (-not [string]::IsNullOrWhiteSpace($env:FLYWAY_VERSION)) {
    # Environment Variables - Use these if set as a variable - Target Database Connection Details
    $flywayVersion = "${env:FLYWAY_VERSION}"
    Write-Output "Using Environment Variable '$flywayVersion' for Flyway CLI Version Number"
    } else {
    # Local Variables - If Env Variables Not Set - Target Database Connection Details
    $flywayVersion = 'Latest'
    Write-Output "Using Local Variable '$flywayVersion' for Flyway CLI Version Number"
  }
  
  # Flyway Download Location Check
  if (-not [string]::IsNullOrWhiteSpace($env:FLYWAY_INSTALL_DIRECTORY)) {
      # Environment Variables - Use these if set as a variable - Target Database Connection Details
      $flywayInstallDirectory = "${env:FLYWAY_INSTALL_DIRECTORY}".TrimEnd('\')
      Write-Output "Using Environment Variable '$flywayInstallDirectory' for Flyway CLI Install Directory"
      } else {
      # Local Variables - If Env Variables Not Set - Flyway Download Location
      $flywayInstallDirectory = 'C:\FlywayCLI'
      Write-Output "Using Local Variable '$flywayInstallDirectory' for Flyway CLI Install Directory"
  }

# Flyway PATH Location Check
if (-not [string]::IsNullOrWhiteSpace($env:FLYWAY_PATH_LOCATION)) {
    # Environment Variables - Use these if set as a variable - PATH Location (User or Machine)
    # Using Machine will require administrative permissions to the server
    Write-Output "Using Environment Variables for Flyway CLI PATH Location"
    $flywayPathLocation = "${env:FLYWAY_PATH_LOCATION}"
    } else {
    # Local Variables - If Env Variables Not Set - PATH Location (Defaulting to User)
    $flywayPathLocation = 'Machine'
        Write-Output "Using Local Variable '$flywayPathLocation' for Flyway CLI PATH Location"
}

# Refresh PATH values for current session
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "Machine")

# Fetch the content of the web page
Write-Output "Analysing https://documentation.red-gate.com/flyway/reference/usage/command-line for Latest Version Number"
# Check if $flywayVersion is 'latest' (case-insensitive)
if ($flywayVersion -ieq "latest") {
    # Fetch the content of the web page
    try {
        # Define the URL to fetch and fetch page content
        $url = "https://documentation.red-gate.com/flyway/reference/usage/command-line"
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing
        $content = $response.Content

        # Define the regex pattern to extract the version number
        # This looks for 'flyway-commandline-' followed by a version pattern
        $pattern = 'flyway-commandline-(\d+\.\d+\.\d+)-windows-x64\.zip'

        # Perform the regex match
        if ($content -match $pattern) {
            # Extract the version number from the match group
            $flywayLatestVersion = $matches[1]
            Write-Output "Flyway Latest Version Number: $flywayLatestVersion"
            $flywayVersion = $flywayLatestVersion
        } else {
            Write-Output "Version string not found in the webpage content."
        }

    } catch {
        Write-Error "Failed to retrieve or process the webpage. Error: $_"
    }
} else {
    Write-Output "Flyway Version Number Variable is not 'latest', Current Version to Install: $flywayVersion"
}

# Check if Flyway is already installed
if (Get-Command flyway -ErrorAction SilentlyContinue) {
    Write-Host "Flyway Already Installed - Checking Current Version Number"
    # Get the current Flyway version
    # Extract version information
    $a = & "flyway" --version 2>&1 | Select-String 'Edition'
    $b = $a -split ' '
    $currentVersion = $b[3]
    Write-Host "$($b) Currently Installed."
    
    if ($currentVersion -eq $flywayVersion) {
        Write-Output "Desired version of '$flywayVersion' already installed. No Changes Required - Exiting Gracefully."
        Exit
    }
} else {
    Write-Host "Flyway is not installed. Proceeding with installation of Flyway version: $flywayVersion"
}

# Stop Running Flyway Processes Before Installation
Get-Process -Name "flyway" -ErrorAction SilentlyContinue | Stop-Process -Force

# Download Flyway
$Url = "https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/$flywayVersion/flyway-commandline-$flywayVersion-windows-x64.zip"
$TempExtractPath = "$flywayInstallDirectory-temp"
$DownloadZipFile = "$flywayInstallDirectory-temp\\flyway-$flywayVersion.zip"
$ExtractPath = "$flywayInstallDirectory"

# Ensure that the Flyway extraction directory exists
if (-Not (Test-Path $ExtractPath)) {
    # Create the directory if it doesn't exist
    New-Item $ExtractPath -ItemType Directory
    Write-Host "Folder Path '$ExtractPath' Created successfully"
} else {
    Write-Host "Folder Path '$ExtractPath' Already Exists"
}

# Ensure that the Flyway Temp extraction directory exists
if (-Not (Test-Path $TempExtractPath)) {
    # Create the directory if it doesn't exist
    New-Item $TempExtractPath -ItemType Directory
    Write-Host "Folder Path '$TempExtractPath' Created successfully"
} else {
    Write-Host "Folder Path '$TempExtractPath' Already Exists"
}

$ProgressPreference = 'SilentlyContinue'
Write-Host "Downloading Flyway Version: $flywayVersion"
Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile -UseBasicParsing
Write-Host "Extracting Flyway files to temporary location"
Expand-Archive -Path $DownloadZipFile -DestinationPath $TempExtractPath -Force

if (-Not (Test-Path "$TempExtractPath\\flyway-$flywayVersion")) {
    Write-Error "Flyway extraction failed."
    Exit 1
}

# Atomic Directory Swap with Fallback
Write-Output "Replacing old Flyway installation..."
$ExtractPathOld = "$ExtractPath-Old"
$renameSucceeded = $false
if (Test-Path $ExtractPath) {
    if (Test-Path $ExtractPathOld) {
        Write-Host "Removing temporary files from '$ExtractPathOld'"
        Remove-Item -Path $ExtractPathOld -Recurse -Force
    }
    try {
        Write-Host "Attempting to rename active Flyway CLI location from '$ExtractPath' to '$ExtractPathOld'"
        Rename-Item -Path $ExtractPath -NewName $ExtractPathOld -Force
        $renameSucceeded = $true
    } catch {
        Write-Warning "Failed to rename $ExtractPath to $ExtractPathOld. Access denied. Attempting to override existing files instead."
    }
}

if ($renameSucceeded) {
    Write-Host "Moving Flyway Version $flywayVersion files to $ExtractPath"
    Move-Item -Path "$TempExtractPath\\flyway-$flywayVersion\\*" -Destination "$ExtractPath" -Force
} else {
    Write-Host "Moving extracted Flyway Version $flywayVersion files to $ExtractPath"
    Get-ChildItem -Path "$TempExtractPath\\flyway-$flywayVersion" -Recurse | ForEach-Object {
        $relativePath = $_.FullName.Substring(("$TempExtractPath\\flyway-$flywayVersion").Length).TrimStart('\')
        $dest = Join-Path $ExtractPath $relativePath

        if (!(Test-Path (Split-Path -Parent $dest))) {
            New-Item -ItemType Directory -Path (Split-Path -Parent $dest) -Force | Out-Null
        }

        if (Test-Path $dest) {
            Remove-Item -Path $dest -Recurse -Force
        }

        Move-Item -Path $_.FullName -Destination $dest -Force
    }
}

# Cleanup
Write-Output "Cleaning up temporary files..."
if (Test-Path $ExtractPathOld) {
    Remove-Item -Path $ExtractPathOld -Recurse -Force
}
Remove-Item -Path "$TempExtractPath" -Recurse -Force

# Update PATH with Flyway CLI Path
Write-Host "Environment Variables - Get Updated Values"
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")

# Define the Update-PathVariable function
function Update-PathVariable {
    param (
        [string]$FlywayInstallDirectory,
        [string]$PreferredTarget = "Machine" # Default target is Machine
    )

    $updateSuccess = $false

    try {
        $currentPath = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::$PreferredTarget)
        if ($null -ne $currentPath) {
            [System.Environment]::SetEnvironmentVariable('Path', "$FlywayInstallDirectory;$currentPath", [System.EnvironmentVariableTarget]::$PreferredTarget)
            $updateSuccess = $true
            Write-Host "Flyway CLI added to $PreferredTarget Environment Variable PATH successfully."
        } else {
            Write-Warning "Unable to retrieve $PreferredTarget PATH. Skipping update."
        }
    } catch {
        Write-Warning "Failed to update $PreferredTarget PATH. Error: $_"
        Write-Warning "Elevate Agent/Runner to local admin to set Machine PATH if required"
    }

    if (-not $updateSuccess) {
        try {
            # Fallback to updating User PATH
            [System.Environment]::SetEnvironmentVariable(
                'Path',
                "$FlywayInstallDirectory;$([System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User))",
                [System.EnvironmentVariableTarget]::User
            )
            $updateSuccess = $true
            Write-Host "Flyway CLI added to User Environment Variable PATH as a fallback."
        } catch {
            Write-Error "Failed to update both Machine and User PATH. Error: $_"
        }
    }

    # Refresh PATH in the current session
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path", "User") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "Machine")

    # Return the status of the update
    return $updateSuccess
}

# Add Flyway to the PATH if not already added (one-time setup)
if (-not $Env:Path.Contains("$flywayInstallDirectory")) {
    Write-Host "Flyway CLI not found in PATH. Attempting to add it..."

    # Call the Update-PathVariable function
    $result = Update-PathVariable -FlywayInstallDirectory $flywayInstallDirectory -PreferredTarget $flywayPathLocation

    if ($result) {
        Write-Host "Flyway CLI successfully added to PATH."
    } else {
        Write-Error "Failed to add Flyway CLI to PATH. Manual intervention may be required."
    }
} else {
    Write-Host "Flyway CLI is already in the PATH. No action needed."
}

Write-Host "Flyway $flywayVersion installed successfully."
flyway -v
Exit 0
