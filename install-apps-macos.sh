#!/bin/bash

# Script to install applications on macOS using Homebrew
# Author: Troels Lund

source "$(dirname "$0")/utils.sh"

# =============================
# Update macOS
# =============================

# Ask the user if they want to update the OS
read -p "Do you want to update the macOS? (y/n): " response

# Handle the user's response
case "$response" in
y | Y | yes | YES | Yes)
    echo "Updating macOS..."
    sudo softwareupdate -i -a
    echo "macOS updated successfully."
    ;;
n | N | no | NO | No)
    echo "macOS update canceled."
    ;;
*)
    echo "Invalid input. Please enter y or n."
    ;;
esac

# =============================

echo "Installation started..."

# =============================
# Install Xcode Command Line Tools
# =============================

echo "Installing Xcode Developer Kit..."
xcode-select --install &>/dev/null

# For apple silicon
echo "Installing Rosetta..."
softwareupdate --install-rosetta --agree-to-license

# =============================
# Install Homebrew
# =============================

# Check if Homebrew is installed; install if not
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed. Updating Homebrew..."
    brew update
    brew upgrade
fi

# Clean up old versions of installed packages
brew cleanup

# =============================
# Install Homebrew packages
# =============================
echo "Installing Homebrew packages..."

# Install Homebrew packages
brew bundle

# reload the ~/.zshrc file
source ~/.zshrc

# Install .NET tools
echo "Installing .NET tools..."
dotnet tool install dotnet-format -g
dotnet tool install dotnet-ef -g
dotnet tool install dotnet-outdated -g
dotnet tool install dotnet-script -g
dotnet tool install dotnet-watch -g
dotnet tool install coverlet.console -g
dotnet tool install Microsoft.dotnet-httprepl -g
dotnet tool install csharpier -g
dotnet tool install try-convert -g
dotnet tool install dotnet-dump -g
dotnet tool install dotnet-serve -g
dotnet tool install NuKeeper -g

echo "Installation done!"
