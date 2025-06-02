#!/bin/bash

set -e

# === CONFIGURATION ===

# Plugin GitHub repo paths
PLUGINS=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zdharma-continuum/fast-syntax-highlighting"
    "marlonrichert/zsh-autocomplete"
    "zsh-users/zsh-completions"
    "zsh-users/zsh-history-substring-search"
)

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
ZSHRC_PATH="$HOME/.zshrc"
P10K_PATH="$HOME/.p10k.zsh"

SOURCE_ZSHRC="shell/.zshrc"
SOURCE_P10K="shell/.p10k.zsh"

echo "Using ZSHRC_PATH directory: $ZSHRC_PATH"

# === INSTALL OH-MY-ZSH ===

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh-My-Zsh..."
    RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh-My-Zsh already installed."
fi

# === COPY CONFIG FILES ===

echo "Copying $SOURCE_ZSHRC to $ZSHRC_PATH..."
cp "$ZSHRC_PATH" "$ZSHRC_PATH.bak" 2>/dev/null
cp "$SOURCE_ZSHRC" "$ZSHRC_PATH"

echo "Copying $SOURCE_P10K to $P10K_PATH..."
cp "$P10K_PATH" "$P10K_PATH.bak" 2>/dev/null || true
cp "$SOURCE_P10K" "$P10K_PATH"

# Add Powerlevel10k source line if not present
if ! grep -qF 'source ~/.p10k.zsh' "$ZSHRC_PATH"; then
    echo "🦚 Appending Powerlevel10k source line to .zshrc..."
    echo -e "\n# Load Powerlevel10k config\n[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh" >>"$ZSHRC_PATH"
fi

# === INSTALL CUSTOM PLUGINS ===

for plugin in "${PLUGINS[@]}"; do
    plugin_name=$(basename "$plugin")
    plugin_dir="$ZSH_CUSTOM/plugins/$plugin_name"

    if [ ! -d "$plugin_dir" ]; then
        git clone https://github.com/"$plugin".git "$plugin_dir"
    else
        echo "✅ $plugin_name already installed."
    fi

    # Add plugin name to plugins=(...) line in .zshrc if not already present
    if ! grep -q "$plugin_name" "$ZSHRC_PATH"; then
        echo "🧠 Adding $plugin_name to plugin list..."
        sed -i.bak "s/^plugins=(\(.*\))/plugins=(\1 $plugin_name)/" "$ZSHRC_PATH"
    else
        echo "✅ $plugin_name already in plugin list."
    fi
done

# === DONE ===

echo -e "\n✅ Zsh setup complete. Restart your terminal or run: exec zsh"

# # =============================
# # Configure tmux
# # =============================

# Path to your custom config file
CUSTOM_CONFIG="shell/.tmux.conf"

# Path to tmux config destination
TARGET="$HOME/.tmux.conf"

# Backup current config if it exists
if [ -f "$TARGET" ]; then
    echo "🎒 Backing up existing ~/.tmux.conf to ~/.tmux.conf.backup"
    cp "$TARGET" "$TARGET.backup"
fi

echo "🔨 Replacing ~/.tmux.conf with $CUSTOM_CONFIG"
cp "$CUSTOM_CONFIG" "$TARGET"

exit 0
