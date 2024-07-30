#!/bin/bash

# Source the functions from zshrc_utils.sh
source "$(dirname "$0")/utils.sh"

# Define the path to the .zshrc file
ZSHRC_PATH="$HOME/.zshrc"

# Define ZSH_PATH if not set by Oh-My-Zsh
ZSH_PATH="${ZSH_PATH:-$HOME/.oh-my-zsh}"

# Check if the ZSHRC_PATH exists
if [ ! -f "$ZSHRC_PATH" ]; then
    echo "Creating $ZSHRC_PATH..."
    touch "$ZSHRC_PATH"
fi

# Define ZSH_CUSTOM if not set by Oh-My-Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo Setting up shell

# Make sure the script is run with bash
if [ -z "$BASH_VERSION" ]; then
    echo "Please run this script with Bash."
    exit 1
fi

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-My-Zsh already installed."
fi

# Reset Oh-My-Zsh to default settings
reset_ohmyzsh

# Configuration to be added to .zshrc
config_lines=(
    'export DEFAULT_USER=$USER'
)

# Add the configuration lines to .zshrc
add_lines_to_zshrc "${config_lines[@]}"

echo "ZSH_CUSTOM set to $ZSH_CUSTOM"

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
else
    echo "Powerlevel10k is already installed."
fi

# Add Powerlevel10k theme to .zshrc
add_lines_to_zshrc \
    '# Load Powerlevel10k Theme' \
    'ZSH_THEME="powerlevel10k/powerlevel10k"' \
    "source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme"

# Install standalone zsh plugins
PLUGINS=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zdharma-continuum/fast-syntax-highlighting"
    "marlonrichert/zsh-autocomplete"
    "zsh-users/zsh-completions"
    "zsh-users/zsh-history-substring-search"
)

for plugin in "${PLUGINS[@]}"; do
    plugin_name=$(basename "$plugin")
    if [ ! -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
        echo "Installing $plugin_name..."
        echo "Clone from https://github.com/$plugin.git"
        git clone https://github.com/"$plugin".git "$ZSH_CUSTOM/plugins/$plugin_name"
    else
        echo "$plugin_name already installed."

        # Add the plugin source line to .zshrc
        add_to_zshrc "source $ZSH_CUSTOM/plugins/$plugin_name/$plugin_name.plugin.zsh"

    fi
done

## Add standard plugins to .zshrc
# Add plugins to .zshrc
# Define plugins to add to the .zshrc file
PLUGINS_TO_ADD=(
    "dotnet"
    "docker-compose"
    "history"
)

# Function to update plugins in .zshrc
update_zshrc_plugins() {
    for plugin in "${PLUGINS_TO_ADD[@]}"; do
        # Add the plugin source line to .zshrc
        plugin_name=$(basename "$plugin")
        add_to_zshrc "source $ZSH_PATH/plugins/$plugin_name/$plugin_name.plugin.zsh"
    done

    # Check if plugins line exists and update it
    if grep -q "^plugins=" "$ZSHRC_PATH"; then
        echo "Updating plugins line in $ZSHRC_PATH..."
        sed -i '' "s/^plugins=(.*)$/plugins=(${PLUGINS_TO_ADD[*]})/" "$ZSHRC_PATH"
    else
        echo "Adding plugins to $ZSHRC_PATH..."
        echo "plugins=(${PLUGINS_TO_ADD[*]})" >>"$ZSHRC_PATH"
    fi
}

# Call the function to update .zshrc
update_zshrc_plugins

echo "Zsh plugins updated in .zshrc."

exit 0
# restart zsh and run 'p10k configure'
