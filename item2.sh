#!/bin/bash

# === CONFIG ===
PROFILE_NAME="CoolDark"
PROFILE_DIR="$HOME/dotfiles/iterm2"
PLIST_FILE="$PROFILE_DIR/com.googlecode.iterm2.plist"
COLOR_SCHEME_URL="https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/Dracula.itermcolors"

mkdir -p "$PROFILE_DIR"

# === STEP 1: Download and import a color scheme ===
echo "🎨 Downloading Dracula color scheme..."
curl -fsSL "$COLOR_SCHEME_URL" -o "$PROFILE_DIR/Dracula.itermcolors"

echo "📦 Opening color scheme to trigger import..."
open "$PROFILE_DIR/Dracula.itermcolors"
sleep 1

# === STEP 2: Create and load custom settings directory ===
echo "⚙️ Configuring iTerm2 to load from $PROFILE_DIR..."
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$PROFILE_DIR"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

# === STEP 3: Update preferences (example tweaks) ===
echo "🧑‍🎨 Applying appearance tweaks..."

defaults write com.googlecode.iterm2 "New Bookmarks" -array-add '
{
  "Guid" = "12345678-1234-1234-1234-1234567890ab";
  "Name" = "'"$PROFILE_NAME"'";
  "Custom Color Presets" = ("Dracula");
  "Use Custom Font" = 1;
  "Normal Font" = "FiraCode-Regular 13";
  "Use Transparency" = 1;
  "Transparency" = 0.1;
  "Use Blurred Background" = 1;
  "Blur Radius" = 15;
}'

# === STEP 4: Set default profile ===
defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "12345678-1234-1234-1234-1234567890ab"

echo "✅ iTerm2 configured. Please restart iTerm2 to apply all changes."
