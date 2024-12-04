#!/bin/bash

# Script set up the macOS settings and install applications
# Author: Troels Lund

echo "admin password required for some tasks"

# Ask for the administrator password upfront
sudo -v

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

# Set up Git
echo "🐙 Setting up Git..."
./git-setup.sh
echo "🐙 Git setup complete."

# Set up shell (zsh)
echo "🐚 Setting up shell..."
./shell-setup.sh
echo "🐚 Shell setup complete."

echo "✅ macOS setup complete."
