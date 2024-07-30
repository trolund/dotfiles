#!/bin/bash

echo Setting up macOS

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

# Define ZSH_CUSTOM if not set by Oh-My-Zsh
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "ZSH_CUSTOM set to $ZSH_CUSTOM"

# Install Zap
if command -v zap &> /dev/null; then
  echo "Zap is already installed."
else
  echo "Installing Zap..."
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1
fi

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
else
  echo "Powerlevel10k is already installed."
fi

# Install zsh plugins
PLUGINS=(
  "zsh-users/zsh-autosuggestions"
  "zsh-users/zsh-syntax-highlighting"
  "zdharma-continuum/fast-syntax-highlighting"
  "marlonrichert/zsh-autocomplete"
  "zsh-users/zsh-completions"
  "zsh-users/zsh-history-substring-search"    
)

for plugin in "${PLUGINS[@]}"; do
  plugin_name=$(basename $plugin)
  if [ ! -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
    echo "Installing $plugin_name..."
    echo "Clone from https://github.com/$plugin.git"
    git clone https://github.com/$plugin.git $ZSH_CUSTOM/plugins/$plugin_name
  else
    echo "$plugin_name already installed."
  fi
done

# Install dotnet plugin from Oh-My-Zsh repository
DOTNET_PLUGIN_DIR="$ZSH_CUSTOM/plugins/dotnet"
if [ ! -d "$DOTNET_PLUGIN_DIR" ]; then
  echo "Installing dotnet plugin..."
  git clone --depth 1 --filter=blob:none --sparse https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_CUSTOM/plugins/dotnet"
  cd "$DOTNET_PLUGIN_DIR" || exit
  git sparse-checkout set plugins/dotnet
  mv plugins/dotnet/* . && rm -rf plugins
  echo "dotnet plugin installed successfully."
else
  echo "dotnet plugin already installed."
fi

# Ensure the zap plugin manager is used in .zshrc
if ! grep -q "source ~/.zap/zap.zsh" ~/.zshrc; then
  echo "Configuring Zap in .zshrc..."
  echo 'source ~/.zap/zap.zsh' >> ~/.zshrc
fi

# Add Powerlevel10k and plugins to .zshrc
cat <<EOL >> ~/.zshrc

# Load Powerlevel10k Theme
source $ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme

# Zsh Plugins
plug "$ZSH_CUSTOM/themes/powerlevel10k"
plug "zap-zsh/supercharge"
plug "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
plug "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
plug "$ZSH_CUSTOM/plugins/fast-syntax-highlighting"
plug "$ZSH_CUSTOM/plugins/zsh-autocomplete"
plug "$ZSH_CUSTOM/plugins/dotnet"
EOL

# Run Zap update command
echo "Updating Zap plugins..."

# Ensure Powerlevel10k config exists
if [ ! -f ~/.p10k.zsh ]; then
  echo "Running Powerlevel10k configuration..."
  echo "Please configure the theme as prompted."
  zsh -c "source ~/.zshrc && p10k configure"
else
  echo "Powerlevel10k is already configured."
fi

echo "Zsh setup complete! Please restart your terminal or run 'exec zsh'."
