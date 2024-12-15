#!/bin/bash

# Script set up the MacOS settings
# Author: Troels Lund

# Load variables from the .env file
if [ -f .env ]; then
  source .env
else
  echo ".env file not found!"
  exit 1
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# =============================
# Create the Code directory
# =============================

# Check if the directory exists
if [ ! -d "$CODE_DIRECTORY" ]; then
  echo "Directory does not exist. Creating $CODE_DIRECTORY..."
  mkdir -p "$CODE_DIRECTORY"
  echo "Code directory created successfully."
else
  echo "Code directory already exists."
fi

# =============================
# Configure MacOS Defaults
# =============================

# Set computer name (as done via System Preferences → Sharing)
scutil --set ComputerName $MACHINE_NAME
sudo scutil --set HostName $MACHINE_NAME
sudo scutil --set LocalHostName $MACHINE_NAME
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $MACHINE_NAME

# System Preferences > General > Appearance
defaults write -globalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# System Preferences > General > Click in the scrollbar to: Jump to the spot that's clicked
defaults write -globalDomain AppleScrollerPagingBehavior -bool true

# System Preferences > General > Sidebar icon size: Medium
defaults write -globalDomain NSTableViewDefaultSizeMode -int 2

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Desktop & Screen Saver > Start after: Never
defaults -currentHost write com.apple.screensaver idleTime -int 0

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Dock > Size:
defaults write com.apple.dock tilesize -int $DOCK_SIZE

# System Preferences > Dock > Size (magnified):
defaults write com.apple.dock largesize -int $DOCK_SIZE

# System Preferences > Dock > Magnification:
defaults write com.apple.dock magnification -bool false

# System Preferences > Dock > Minimize windows using: Scale effect
defaults write com.apple.dock mineffect -string "genie"

# System Preferences > Dock > Minimize windows into application icon
defaults write com.apple.dock minimize-to-application -bool true

# System Preferences > Dock > Automatically hide and show the Dock:
defaults write com.apple.dock autohide -bool true

# System Preferences > Dock > Automatically hide and show the Dock (duration)
defaults write com.apple.dock autohide-time-modifier -float 0.1

# System Preferences > Dock > Automatically hide and show the Dock (delay)
defaults write com.apple.dock autohide-delay -float 0.05

# System Preferences > Dock > Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Mission Controll > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# System Preferences > Mission Controll > Dashboard
defaults write com.apple.dock dashboard-in-overlay -bool true

# Clear existing Dock apps
# Never use the dock to launch apps, use spotlight instead
defaults write com.apple.dock persistent-apps -array

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Keyboard >
defaults write NSGlobalDomain KeyRepeat -int 2

# System Preferences > Keyboard >
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Trackpad > Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# System Preferences > Accessibility > Mouse & Trackpad > Trackpad Potions
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool false

# System Preferences > Accessibility > Mouse & Trackpad > Trackpad Potions

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Finder > Preferences > Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder > Preferences > Show wraning before changing an extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Show wraning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Finder > View > As List
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder > View > Show Path Bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Hide desktop icons
defaults write com.apple.finder CreateDesktop -bool false

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Keep folders on top when sorting by name
# defaults write com.apple.finder _FXSortFoldersFirst -bool true

# backup the current sidebar
defaults export com.apple.sidebarlists ~/Desktop/sidebarlists_backup.plist

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Remove all tags from the Finder sidebar
defaults write com.apple.finder ShowRecentTags -bool false
defaults write com.apple.finder SidebarTagsSctionDisclosedState -bool false

# Remove all default tags
defaults write com.apple.finder FavoriteTags -array

# Disable tags in open/save dialogs
defaults write NSGlobalDomain NSTagPickerDisclosedState -bool false

# defaults delete com.apple.sidebarlists.plist favoritesitems

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Others:

# Completely Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# Kill affected apps
for app in "Dock" "Finder"; do
  killall "${app}" >/dev/null 2>&1
done

# Done
echo "Done. Note that some of these changes require a logout/restart to take effect."
