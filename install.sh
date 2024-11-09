#!/usr/bin/env bash

# ====================================================================================
# cli-tips Installation Script
# ====================================================================================
#
# This script installs the cli-tips utility and its translations from GitHub.
#
# Installation Process:
#   1. Creates a temporary directory for installation
#   2. Downloads the main executable from GitHub
#   3. Downloads translation files from GitHub repository
#   4. Installs the executable to $PREFIX/usr/bin
#   5. Installs translations to $PREFIX/usr/share/cli-tips/translations
#   6. Cleans up temporary files
#
# Note:
#   - Requires write permissions to $PREFIX directory
#   - Script will exit on first error (set -e)
# ====================================================================================

# shellcheck disable=SC2236

# Exit on any error
set -e

if [[ ! -n "$PREFIX" ]]; then
    prefix="/usr"
else
    prefix="$PREFIX"
fi

# Define installation directories and repository information
# PREFIX is expected to be set in the environment
TEMP="$PREFIX/tmp"
TEMP_DIR="$TEMP/cli-tips-installer"

# GitHub repository path
REPO="cli-stuff/cli-tips"

sudo="sudo"

# shellcheck disable=SC2143,SC2034
# sudo is not required on Android or MSYS
if echo "$OSTYPE" | grep -qE '^(linux-android|msys).*'; then
    sudo=""
fi

# Create temporary directory for installation files
[[ ! -d "$TEMP_DIR" ]] && mkdir "$TEMP_DIR"
cd "$TEMP_DIR"

echo "Downloading cli-tips executable..."

# Download the main executable script from GitHub repository
curl -LOs "https://raw.githubusercontent.com/$REPO/refs/heads/main/cli-tips.sh"

# Create translations directory and download all translation files
# Uses GitHub API to get list of files, then downloads each one
mkdir -p translations
echo "Downloading translation files..."
curl -s "https://api.github.com/repos/$REPO/contents/translations" | grep "download_url" | cut -d '"' -f 4 | while read -r url; do
    lang=$(echo "$url" | grep -o 'tips_[a-z]\+\.txt' | cut -d'_' -f2 | cut -d'.' -f1)

    echo "- Downloading $lang translation..."
    curl -LOs -C - --output-dir translations "$url"
done

echo ""

echo "Installing..."
# Install the main executable to system bin directory
$sudo mv cli-tips.sh "$prefix/bin/cli-tips"
# Set executable permissions
chmod +x "$prefix/bin/cli-tips"

$sudo mkdir -p "$prefix/share/cli-tips/"

# Install translation files to system share directory
$sudo mv translations/* "$prefix/share/cli-tips/"

# Clean up temporary installation files
rm -rf "$TEMP_DIR"

# Print success message in green color
echo -e "\n\e[1;32mDone!\e[0m"
