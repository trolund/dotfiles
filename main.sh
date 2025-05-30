#!/bin/bash

# Script set up the macOS settings and install applications
# Author: Troels Lund

echo "👨🏻‍🚀 Admin password required for some tasks doing the setup."

# Ask for the administrator password upfront
sudo -v

# Make scripts executable
chmod +x install-apps-macos.sh
chmod +x settings-macos.sh
chmod +x shell-setup.sh
chmod +x git-setup.sh
chmod +x hammerspoon/hammerspoon.sh

echo "🏃 Running macOS bootstrap script..."

echo "🚀 Setting up macOS..."

# Install applications
echo "📲 Installing applications..."
./install-apps-macos.sh
echo "📲 Applications installed."

# Set settings for macOS
echo "🛠 Setting up macOS settings..."
./settings-macos.sh
echo "🛠 macOS settings complete."

# Set up shell (zsh)
echo "🐚 Setting up shell (zsh)..."
./shell-setup.sh
echo "🐚 Shell setup complete."

# Set up Git
echo "🐙 Setting up Git..."
./git-setup.sh
echo "🐙 Git setup complete."

# Set up Hammerspoon
echo "🛠 Setting up Hammerspoon..."
./hammerspoon/hammerspoon.sh
echo "🛠 Hammerspoon setup complete."

echo "✅ macOS setup complete."
