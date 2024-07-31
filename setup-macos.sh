#!/bin/bash

# Script set up the macOS settings and install applications
# Author: Troels Lund

# Set settings for macOS
echo "🚀 Setting up macOS..."
echo "🛠 Setting up macOS settings..."
./settings-macos.sh
echo "🛠 macOS settings complete."
echo "📲 Setting up applications..."
# Install applications
./install-apps-macos.sh
echo "📲 Applications installed."
echo "🐚 Setting up shell..."
# Set up shell (zsh)
./shell-setup.sh
echo "🐚 Shell setup complete."

echo "✅ macOS setup complete."