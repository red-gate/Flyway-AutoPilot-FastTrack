#!/bin/bash

# Check if FLYWAY_VERSION is set and matches a version format like "8.0.0"
if [[ -z "${FLYWAY_VERSION}" ]]; then
    echo "Error: FLYWAY_VERSION is not set. Please set it to a valid version (e.g., '10.20.1')."
    exit 1
elif ! [[ "${FLYWAY_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Error: FLYWAY_VERSION is set but does not match the expected version format (e.g., '10.20.1')."
    exit 1
fi

# Check if Flyway is already installed
if flyway --version > /dev/null 2>&1; then
    echo "Flyway Installed and Available"
else 
    echo "Flyway Not Installed - Downloading and Configuring Now"
    
    # Attempt to download the specified Flyway version
    curl -sS https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/${FLYWAY_VERSION}/flyway-commandline-${FLYWAY_VERSION}-linux-x64.tar.gz | tar xz
    
    # Check if the download and extraction were successful
    if [[ $? -ne 0 ]]; then
        echo "Error: Download failed. Please check that FLYWAY_VERSION '${FLYWAY_VERSION}' is correct and available for download."
        exit 1
    fi

   # Create a symbolic link for the Flyway executable
    sudo ln -s "$(pwd)/flyway-${FLYWAY_VERSION}/flyway" /usr/local/bin/flyway

    echo "Flyway Downloaded - Setting PATH"
    export PATH="/usr/local/bin/flyway-$FLYWAY_VERSION/:$PATH"

    echo "Validation Step - Checking if Flyway can run"
    flyway --version
fi