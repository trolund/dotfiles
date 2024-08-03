#!/bin/bash

# Script utilities 
# Author: Troels Lund

# Function to add a string to ~/.zshrc
add_to_zshrc() {
    local string="$1"
    local zshrc_path="$HOME/.zshrc"
    
    # Check if the .zshrc file exists
    if [ ! -f "$zshrc_path" ]; then
        echo ".zshrc file not found. Creating a new one..."
        touch "$zshrc_path"
    fi
    
    # Backup the existing .zshrc file
    echo "Backing up existing .zshrc to .zshrc.backup..."
    cp "$zshrc_path" "$zshrc_path.backup.$(date +%F_%T)"

    # Check if the string already exists in .zshrc
    if grep -Fxq "$string" "$zshrc_path"; then
        echo "The string is already present in .zshrc."
    else
        # Add the string to the end of the .zshrc file
        echo "$string" >> "$zshrc_path"
        echo "The string has been added to .zshrc."
    fi
}

reset_ohmyzsh() {
    # Path to the .zshrc file
    ZSHRC_PATH="$HOME/.zshrc"

    # Backup the existing .zshrc file
    if [ -f "$ZSHRC_PATH" ]; then
    echo "Backing up existing .zshrc to .zshrc.backup..."
    cp "$ZSHRC_PATH" "$ZSHRC_PATH.backup.$(date +%F_%T)"
    fi

    # Delete the existing .zshrc file
    rm -f "$ZSHRC_PATH"

    # Recreate an empty .zshrc file
    touch "$ZSHRC_PATH"

    # Verify the file is empty and exists
    if [ -f "$ZSHRC_PATH" ] && [ ! -s "$ZSHRC_PATH" ]; then
    echo ".zshrc file cleared and recreated successfully."
    else
    echo "Failed to recreate .zshrc file."
    fi
}

backup_zshrc() {
    # Path to the .zshrc file
    ZSHRC_PATH="$HOME/.zshrc"

    # Backup the existing .zshrc file
    if [ -f "$ZSHRC_PATH" ]; then
    echo "Backing up existing .zshrc to .zshrc.backup..."
    cp "$ZSHRC_PATH" "$ZSHRC_PATH.backup.$(date +%F_%T)"
    else
    echo ".zshrc file not found. No backup created."
    fi
}

# Function to add a single string to ~/.zshrc
add_to_zshrc() {
    local string="$1"
    local zshrc_path="$HOME/.zshrc"
    
    # Check if the .zshrc file exists
    if [ ! -f "$zshrc_path" ]; then
        echo ".zshrc file not found. Creating a new one..."
        touch "$zshrc_path"
    fi

    # Check if the string already exists in .zshrc
    if grep -Fxq "$string" "$zshrc_path"; then
        echo "The string is already present in .zshrc."
    else
        # Add the string to the end of the .zshrc file
        echo "$string" >> "$zshrc_path"
        echo "The string ($string) has been added to .zshrc."
    fi
}

# Function to add multiple lines to ~/.zshrc
add_lines_to_zshrc() {
    local lines=("$@")  # Array of strings to add
    local zshrc_path="$HOME/.zshrc"

    # Check if the .zshrc file exists
    if [ ! -f "$zshrc_path" ]; then
        echo ".zshrc file not found. Creating a new one..."
        touch "$zshrc_path"
    fi

    # Backup the existing .zshrc file
    echo "Backing up existing .zshrc to .zshrc.backup..."
    cp "$zshrc_path" "$zshrc_path.backup.$(date +%F_%T)"

    # Add each line if not already present
    for line in "${lines[@]}"; do
        if grep -Fxq "$line" "$zshrc_path"; then
            echo "The line '$line' is already present in .zshrc."
        else
            echo "$line" >> "$zshrc_path"
            echo "The line '$line' has been added to .zshrc."
        fi
    done
}

# Function to clear the contents of ~/.zshrc
clear_zshrc() {
    local zshrc_path="$HOME/.zshrc"

    # Check if the .zshrc file exists
    if [ ! -f "$zshrc_path" ]; then
        echo ".zshrc file not found."
        return 1
    fi

    # Backup the existing .zshrc file
    echo "Backing up existing .zshrc to .zshrc.backup..."
    cp "$zshrc_path" "$zshrc_path.backup.$(date +%F_%T)"

    # Clear the contents of the .zshrc file
    > "$zshrc_path"

    # Verify the file is cleared
    if [ ! -s "$zshrc_path" ]; then
        echo ".zshrc file cleared successfully."
    else
        echo "Failed to clear .zshrc file."
        return 1
    fi
}

# Function to check if a specific string exists in ~/.zshrc
string_exists_in_zshrc() {
    local string="$1"
    local zshrc_path="$HOME/.zshrc"

    # Check if the .zshrc file exists
    if [ ! -f "$zshrc_path" ]; then
        echo ".zshrc file not found."
        return 1
    fi

    # Check if the string exists in .zshrc
    if grep -Fxq "$string" "$zshrc_path"; then
        echo "The string '$string' is present in .zshrc."
        return 0
    else
        echo "The string '$string' is not present in .zshrc."
        return 1
    fi
}

# Function to clone specific plugins from the Oh-My-Zsh repository using sparse checkout
clone_ohmyzsh_plugin() {
  local plugin_name=$1
  local plugin_path=$2
  local plugin_dir="$ZSH_CUSTOM/plugins/$plugin_name"

  if [ ! -d "$plugin_dir" ]; then
    echo "Installing $plugin_name plugin..."
    git clone --depth 1 --filter=blob:none --sparse https://github.com/ohmyzsh/ohmyzsh.git "$plugin_dir"
    cd "$plugin_dir" || exit
    git sparse-checkout set "$plugin_path"
    mv "$plugin_path"/* . && rm -rf "$plugin_path"
    echo "$plugin_name plugin installed successfully."
  else
    echo "$plugin_name plugin already installed."
  fi
}

check_and_install_brew_package() {
    local package_name=$1
    if ! brew list "$package_name" &>/dev/null; then
        echo "Installing $package_name..."
        brew install "$package_name"
    else
        echo "$package_name is already installed."
    fi
}