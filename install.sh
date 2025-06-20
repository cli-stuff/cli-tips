#!/usr/bin/env bash

# shellcheck disable=SC2236

# ====================================================================================
# cli-tips Installation Script
# ====================================================================================

# Exit on any error
set -e

# Determine the installation prefix
if [[ ! -n "$PREFIX" ]]; then
    if echo "$OSTYPE" | grep -qE '^darwin.*'; then
        # The `/usr` directory in macOS is read-only
        # so you need to change the prefix to `/usr/local`
        # https://github.com/openstreetmap/mod_tile/issues/349#issuecomment-1784165860
        prefix="/usr/local"
    else
        prefix="/usr"
    fi
else
    prefix="$PREFIX"
fi

# Define installation directories and repository information
# PREFIX is expected to be set in the environment
TEMP="$PREFIX/tmp"
TEMP_DIR="$TEMP/cli-tips-installer"

# GitHub repository path
REPO="cli-stuff/cli-tips"

# Define the sudo command, which may be empty on systems where sudo is not required
sudo="sudo"

# shellcheck disable=SC2143,SC2034
# sudo is not required on Android or MSYS
if echo "$OSTYPE" | grep -qE '^(linux-android|msys).*'; then
    sudo=""
fi

# Create temporary directory for installation files
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR"

# Download the main executable script from GitHub repository
echo "Downloading cli-tips executable..."
curl -sLO "https://raw.githubusercontent.com/$REPO/refs/heads/main/cli-tips.sh" &
pid1=$!

echo "Downloading tips list..."
curl -sLO "https://raw.githubusercontent.com/$REPO/refs/heads/main/tips.txt" &
pid2=$!

wait $pid1
status1=$?
wait $pid2
status2=$?

if [[ $status1 -ne 0 || $status2 -ne 0 ]]; then
    echo "Error: Failed to download required files." >&2
    rm -rf "$TEMP_DIR"
    exit 1
fi

echo

echo "Installing..."
# Install the main executable to system bin directory
$sudo mv cli-tips.sh "$prefix/bin/cli-tips"
# Set executable permissions
chmod +x "$prefix/bin/cli-tips"

$sudo mkdir -p "$prefix/share/cli-tips"
$sudo mv tips.txt "$prefix/share/cli-tips"

# Clean up temporary installation files
rm -rf "$TEMP_DIR"

# Print success message in green color
echo -e "\n\e[1;32mDone!\e[0m"
