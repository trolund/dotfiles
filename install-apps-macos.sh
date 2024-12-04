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
# Install Command Line Tools
# =============================

# Install Git
check_and_install_brew_package git

# Install Python 3
check_and_install_brew_package python3

# Install Java
check_and_install_brew_package install java
check_and_install_brew_package install openjdk # Install the latest Java version
check_and_install_brew_package install maven

# Install Node.js
check_and_install_brew_package node
check_and_install_brew_package npm
check_and_install_brew_package nvm

# Script to Install System Utilities

# Install fzf (Command-line fuzzy finder)
check_and_install_brew_package fzf

# Install htop (System monitoring tool)
check_and_install_brew_package htop

# Install wget (Network utility to retrieve files)
check_and_install_brew_package wget

# Install curl (Command-line tool for transferring data with URL syntax)
check_and_install_brew_package curl

# Install tmux (Terminal multiplexer)
check_and_install_brew_package tmux

# Install neofetch (Command-line system information tool)
check_and_install_brew_package neofetch

# Install bat (Cat clone with syntax highlighting)
check_and_install_brew_package bat

# Install jq (Command-line JSON processor)
check_and_install_brew_package jq

# Install tree (Directory listing command)
check_and_install_brew_package tree

# Install watch (Execute a program periodically)
check_and_install_brew_package watch

# Install tldr (Simplified and community-driven man pages)
check_and_install_brew_package tldr

# Install the Azure CLI
check_and_install_brew_package azure-cli

echo "All system utilities have been checked and installed if not already present."

# Install Docker and Docker Compose
if ! brew list --cask docker &>/dev/null; then
    echo "Installing Docker and Docker Compose..."
    brew install --cask docker
    brew install docker-compose
fi

# =============================
# Install GUI Applications with Homebrew Cask
# =============================

# Define an array of applications to install
apps=(
    vlc
    slack
    firefox
    ngrok
    google-chrome
    macs-fan-control
    onedrive
    dotnet
    dotnet-sdk
    visual-studio
    visual-studio-code
    rider
    intellij-idea
    postman
    transmit
    private-internet-access
    spectacle
    # sequel-pro
    # pycharm
    iterm2
    # notion
    go2shell
    microsoft-teams
    jetbrains-toolbox
    font-fira-code
    devtoys
    onyx
)

# Install each application
for app in "${apps[@]}"; do
    if ! brew list --cask "$app" &>/dev/null; then
        echo "Installing $app..."
        brew install --cask "$app"
    else
        echo "$app is already installed."
    fi
done

source ~/.zshrc

# Install .NET tools
# dotnet tool install csharpier -g

echo "Installation done!"
