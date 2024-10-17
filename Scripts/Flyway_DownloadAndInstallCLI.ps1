$ErrorActionPreference = "Stop"

# Flyway Version to Use (Check for latest version: https://documentation.red-gate.com/fd/command-line-184127404.html)
if ($null -ne ${env:FLYWAY_VERSION}) {
  # Environment Variables - Use these if set as a variable - Target Database Connection Details
  Write-Output "Using Environment Variables for Flyway CLI Version Number"
  $flywayVersion = "${env:FLYWAY_VERSION}"
  } else {
  Write-Output "Using Local Variables for Flyway CLI Version Number"
  # Local Variables - If Env Variables Not Set - Target Database Connection Details
  $flywayVersion = '10.20.0'
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

Write-Host "Using Flyway CLI version $flywayVersion"

# Flyway URL to download CLI
$Url = "https://download.red-gate.com/maven/release/org/flywaydb/enterprise/flyway-commandline/$flywayVersion/flyway-commandline-$flywayVersion-windows-x64.zip"

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
    
    if ($b[3] -eq $flywayVersion) {
        Write-Output "$($b) is already installed."
        Exit
    } else {
        Write-Host "A different version of Flyway is installed. Updating to version $flywayVersion."

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

        Write-Host "Environtment Variables - Get Updated Values"
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")

         # Add Flyway to the PATH if not already added (one-time setup)
        if (-Not $Env:Path.Contains("C:\FlywayCLI")) {
            [System.Environment]::SetEnvironmentVariable('Path', "C:\FlywayCLI;$([System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User))", [System.EnvironmentVariableTarget]::User)
            Write-Host "Updated Local Path Variable"
            $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
            Write-Host "Flyway CLI added to Environment Variable PATH."
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

    # Add Flyway to the PATH if not already added (one-time setup)
    if (-Not $Env:Path.Contains("C:\FlywayCLI")) {
        [System.Environment]::SetEnvironmentVariable('Path', "C:\FlywayCLI;$([System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User))", [System.EnvironmentVariableTarget]::User)
        Write-Host "Updated Local Path Variable"
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","User") + ";" + [System.Environment]::GetEnvironmentVariable("Path","Machine")
        Write-Host "Flyway CLI added to Environment Variable PATH."
    }
    Write-Host "Flyway CLI Download and Install Complete"
    Exit
}
