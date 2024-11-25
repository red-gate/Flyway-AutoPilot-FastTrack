#!/bin/bash

# Check if FLYWAY_VERSION is set as an environment variable
if [ -z "$FLYWAY_VERSION" ]; then
  # If not set, assign a default value to a local variable
  FLYWAY_VERSION="Latest"
  echo "FLYWAY_VERSION is not set. Using default local variable value of '$FLYWAY_VERSION'."
else
  # If set, echo the environment variable and its value
  echo "FLYWAY_VERSION is set. Current value is: $FLYWAY_VERSION"
fi

# Function to get the currently installed Flyway version
get_installed_version() {
  if command -v flyway >/dev/null 2>&1; then
    flyway --version | grep -Eo 'Flyway (Community|Pro|Enterprise|Teams) Edition [0-9]+\.[0-9]+\.[0-9]+' | awk '{print $4}'
  else
    echo "none" # Indicate no version is installed
  fi
}

# Function to get the latest version from the website
get_latest_version_from_website() {
  # Fetch the webpage content
  content=$(curl -s https://documentation.red-gate.com/fd/command-line-184127404.html)

  # Extract version number using regex
  latest_version=$(echo "$content" | grep -oP 'flyway-commandline-\K\d+\.\d+\.\d+(?=-windows-x64.zip)' | head -n 1)

  echo "$latest_version"
}

# Get the currently installed Flyway version
CURRENT_VERSION=$(get_installed_version)
echo "Current Flyway Version Is: $CURRENT_VERSION"

# Check if FLYWAY_VERSION required is 'Latest'
if [ "$FLYWAY_VERSION" = "latest" ] || [ "$FLYWAY_VERSION" = "Latest" ]; then
  LATEST_VERSION=$(get_latest_version_from_website)
  if [ -z "$LATEST_VERSION" ]; then
    echo "Could not retrieve the latest version from the website. Exiting."
    exit 1
  fi
  echo "Latest Flyway Version Is: $LATEST_VERSION"
  echo "Setting Flyway Version to be installed to: $LATEST_VERSION"
  FLYWAY_VERSION=$LATEST_VERSION
fi



# Check if the current version matches the latest version
if [ "$CURRENT_VERSION" = "$FLYWAY_VERSION" ]; then
  echo "Flyway $CURRENT_VERSION is already installed and up-to-date. No action needed."
  exit 0
else
  echo "Current version ($CURRENT_VERSION) does not match the required version ($FLYWAY_VERSION). Installing the required version."
fi

# Proceed with the installation of the latest version
INSTALL_DIR="$HOME/flyway-$FLYWAY_VERSION" # Install directory in the user's home folder

# Download and install Flyway
echo "Downloading and installing Flyway version $FLYWAY_VERSION..."
wget -qO- https://download.red-gate.com/maven/release/com/redgate/flyway/flyway-commandline/$FLYWAY_VERSION/flyway-commandline-$FLYWAY_VERSION-linux-x64.tar.gz | tar -xvz

# Check if the download and extraction were successful
if [[ $? -ne 0 ]]; then
  echo "Error: Download failed. Please check that FLYWAY_VERSION '${FLYWAY_VERSION}' is correct and available for download."
  exit 1
fi

# Move the Flyway folder to the install directory
mv "flyway-$FLYWAY_VERSION" "$INSTALL_DIR"

# Overwrite or create symbolic link to the Flyway executable
sudo ln -sf "$INSTALL_DIR/flyway" /usr/local/bin/flyway

echo "Flyway version $FLYWAY_VERSION is downloaded and installed."

echo "Updating PATH Variable"
export PATH="/usr/local/bin/flyway-$FLYWAY_VERSION/:$PATH"

# Validate Flyway installation
if flyway --version; then
  echo "Flyway is successfully installed and running version $(flyway --version | grep -Eo 'Flyway (Community|Pro|Enterprise|Teams) Edition [0-9]+\.[0-9]+\.[0-9]+' | awk '{print $4}')."
else
  echo "Flyway installation failed. Please check for issues."
  exit 1  # Exit with failure status (non-zero) if Flyway isn't working
fi
