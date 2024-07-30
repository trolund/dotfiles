#!/bin/bash

echo "Setting up macOS..."

# Set settings for macOS
./settings-macos.sh
# Install applications
./install-apps-macos.sh
# Set up shell (zsh)
./shell-setup.sh

echo "macOS setup complete."