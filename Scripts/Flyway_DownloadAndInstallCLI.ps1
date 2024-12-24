$ErrorActionPreference = "Stop"

# Flyway Version to Use (Check for latest version: https://documentation.red-gate.com/fd/command-line-184127404.html)
if ($null -ne ${env:FLYWAY_VERSION}) {
  # Environment Variables - Use these if set as a variable - Target Database Connection Details
  Write-Output "Using Environment Variables for Flyway CLI Version Number"
  $flywayVersion = "${env:FLYWAY_VERSION}"
  } else {
  Write-Output "Using Local Variables for Flyway CLI Version Number"
  # Local Variables - If Env Variables Not Set - Target Database Connection Details
  $flywayVersion = 'Latest'
}

# Flyway Download Location Check
if ($null -ne ${env:FLYWAY_INSTALL_DIRECTORY}) {
    # Environment Variables - Use these if set as a variable - Target Database Connection Details
    Write-Output "Using Environment Variables for Flyway CLI Install Directory"
    $flywayInstallDirectory = "${env:FLYWAY_INSTALL_DIRECTORY}"
    } else {
    Write-Output "Using Local Variables for Flyway CLI Install Directory"
    # Local Variables - If Env Variables Not Set - Flyway Download Location
    $flywayInstallDirectory = 'C:\FlywayCLI\'
}

# Flyway PATH Location Check
if ($null -ne ${env:FLYWAY_PATH_LOCATION}) {
    # Environment Variables - Use these if set as a variable - PATH Location (User or Machine)
    # Using Machine will require administrative permissions to the server
    Write-Output "Using Environment Variables for Flyway CLI PATH Location"
    $flywayPathLocation = "${env:FLYWAY_PATH_LOCATION}"
    } else {
    Write-Output "Using Local Variables for Flyway CLI PATH Location"
    # Local Variables - If Env Variables Not Set - PATH Location (Defaulting to User)
    $flywayPathLocation = 'Machine'
}

# Fetch the content of the web page
Write-Output "Analysing https://documentation.red-gate.com/fd/command-line-184127404.html for Latest Version Number"
# Check if $flywayVersion is 'latest' (case-insensitive)
if ($flywayVersion -ieq "latest") {
    # Fetch the content of the web page
    try {
        # Define the URL to fetch and fetch page content
        $url = "https://documentation.red-gate.com/fd/command-line-184127404.html"
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

Write-Host "Using Flyway CLI version $flywayVersion"

# Flyway URL to download CLI
$Url = "https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/$flywayVersion/flyway-commandline-$flywayVersion-windows-x64.zip"

# Path for downloaded zip file
$DownloadZipFile = "$flywayInstallDirectory" + $(Split-Path -Path $Url -Leaf)

# Path where Flyway will be extracted (no version subfolder)
$ExtractPath = "$flywayInstallDirectory"

# Ensure that the Flyway extraction directory exists
if (-Not (Test-Path $ExtractPath)) {
    # Create the directory if it doesn't exist
    New-Item $ExtractPath -ItemType Directory
    Write-Host "Folder Created successfully"
} else {
    Write-Host "Folder Exists"
}

# Set the progress preference to avoid displaying the progress bar
$ProgressPreference = 'SilentlyContinue'

# Check if Flyway is already installed
if (Get-Command flyway -ErrorAction SilentlyContinue) {
    Write-Host "Flyway Already Installed"

    # Get the current Flyway version
    try {
        $versionOutput = & flyway -v 2>&1
    } catch {
        Write-Output "Failed to execute Flyway. Error: $_"
        exit 1
    }

    # Extract version information
    $a = & "flyway" --version 2>&1 | Select-String 'Edition'
    $b = $a -split ' '
    $currentVersion = $b[3]
    
    if ($currentVersion -eq $flywayVersion) {
        Write-Output "$($b) is already installed. Exiting Gracefully."
        Exit
    } else {
        Write-Host "Version $currentVersion of Flyway is already installed. Updating to version $flywayVersion."

        # Clean up the old Flyway files in the extraction directory
        Remove-Item -Recurse -Force "$ExtractPath*"

        # Download the new Flyway CLI
        Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile

        # Extract the CLI to the desired location
        Expand-Archive -Path $DownloadZipFile -DestinationPath $ExtractPath -Force

        try {
            Write-Host "Moving Flyway CLI to $ExtractPath Root"
            Move-Item $ExtractPath/flyway-$flywayVersion/* $ExtractPath
            Write-Host "Deleting Temporary Files"
            Remove-Item $ExtractPath/flyway-$flywayVersion/ -Force -Recurse
            Remove-Item $ExtractPath/*.zip -Force -Recurse
        }
        catch [System.IO.IOException] {
            Write-Host "Moving Flyway CLI to $ExtractPath Root"
            Move-Item $ExtractPath/flyway-$flywayVersion/* $ExtractPath -Force
            Write-Host "Deleting Temporary Files"
            Remove-Item $ExtractPath/flyway-$flywayVersion/ -Force -Recurse
            Remove-Item $ExtractPath/*.zip -Force -Recurse
        }

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
                # Attempt to update the preferred PATH
                [System.Environment]::SetEnvironmentVariable(
                    'Path',
                    "$FlywayInstallDirectory;$([System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::$PreferredTarget))",
                    [System.EnvironmentVariableTarget]::$PreferredTarget
                )
                $updateSuccess = $true
                Write-Host "Flyway CLI added to $PreferredTarget Environment Variable PATH successfully."
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

        # Verify the new version
        Write-Host "Flyway $flywayVersion is now installed in $ExtractPath."
        flyway -v
        Exit
    }
} else {
    Write-Host "Flyway is not installed. Proceeding with installation."

    # Download the Flyway CLI
    Invoke-WebRequest -Uri $Url -OutFile $DownloadZipFile
    Write-Host "Flyway CLI Successfully Downloaded"

    # Extract the CLI to the desired location
    Expand-Archive -Path $DownloadZipFile -DestinationPath $ExtractPath -Force
    Write-Host "Flyway CLI Successfully Extracted to $ExtractPath"

    try {
        Write-Host "Moving Flyway CLI to $ExtractPath Root"
        Move-Item $ExtractPath/flyway-$flywayVersion/* $ExtractPath
        Write-Host "Deleting Temporary Files"
        Remove-Item $ExtractPath/flyway-$flywayVersion/ -Force -Recurse
        Remove-Item $ExtractPath/*.zip -Force -Recurse
    }
    catch [System.IO.IOException] {
        Write-Host "Moving Flyway CLI to $ExtractPath Root"
        Move-Item $ExtractPath/flyway-$flywayVersion/* $ExtractPath -Force
    }

    # Define the Update-PathVariable function
    function Update-PathVariable {
        param (
            [string]$FlywayInstallDirectory,
            [string]$PreferredTarget = "Machine" # Default target is Machine
        )

        $updateSuccess = $false

        try {
            # Attempt to update the preferred PATH
            [System.Environment]::SetEnvironmentVariable(
                'Path',
                "$FlywayInstallDirectory;$([System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::$PreferredTarget))",
                [System.EnvironmentVariableTarget]::$PreferredTarget
            )
            $updateSuccess = $true
            Write-Host "Flyway CLI added to $PreferredTarget Environment Variable PATH successfully."
        } catch {
            Write-Warning "Failed to update $PreferredTarget PATH. Error: $_"
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
    Write-Host "Flyway CLI Download and Install Complete"
    Exit
}
