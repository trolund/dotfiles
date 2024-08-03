#!/bin/bash

# Script set up the shell (zsh)
# Author: Troels Lund

# =============================
# Configure Zsh
# =============================

echo Setting up shell...

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
    '# Set the default user to the current user'
    'export DEFAULT_USER=$USER'
)

# Add the configuration lines to .zshrc
add_lines_to_zshrc "${config_lines[@]}"

add_to_zshrc "# Load Powerlevel10k Theme"

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

add_to_zshrc "# Add plugins"

# Install standalone zsh plugins repositories
PLUGINS=(
    "zsh-users/zsh-autosuggestions"
    "zsh-users/zsh-syntax-highlighting"
    "zdharma-continuum/fast-syntax-highlighting"
    "marlonrichert/zsh-autocomplete"
    "zsh-users/zsh-completions"
    "zsh-users/zsh-history-substring-search"
)

# list with standalone plugin names
PLUGINS_EXSTRA=()
for plugin in "${PLUGINS[@]}"; do
    repository_name="${plugin##*/}"
    PLUGINS_EXSTRA+=("$repository_name")
done

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
    "iterm2"
    "macos"
    "npm"
    "aliases"
    "cp"
    "z"
)

# list with all plugin names
ALL_PLUGINS=("${PLUGINS_TO_ADD[@]}" "${PLUGINS_EXSTRA[@]}")

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
        sed -i '' "s/^plugins=(.*)$/plugins=(${ALL_PLUGINS[*]})/" "$ZSHRC_PATH"
    else
        echo "Adding plugins to $ZSHRC_PATH..."
        echo "plugins=(${ALL_PLUGINS[*]})" >>"$ZSHRC_PATH"
    fi
}

# Call the function to update .zshrc
update_zshrc_plugins

# configure aliases
add_to_zshrc "# Add custom aliases \n"

# Add aliases to .zshrc
add_to_zshrc "alias zshconfig='code ~/.zshrc'"
add_to_zshrc "alias ohmyzsh='code ~/.oh-my-zsh'"
add_to_zshrc "alias zshreload='source ~/.zshrc'"
add_to_zshrc "alias zshupdate='upgrade_ohmyzsh'"
add_to_zshrc "alias zshplugins='code $ZSH_CUSTOM/plugins'"
add_to_zshrc "alias zshthemes='code $ZSH_CUSTOM/themes'"

# Add custom aliases 

# Go to code folder
add_to_zshrc "alias cf='cd /Users/troelslund/Documents/Code'"

# Clear the terminal screen
add_to_zshrc "alias c='clear'"

# Show detailed directory listing
add_to_zshrc "alias ll='ls -la'"

# List files with human-readable sizes
add_to_zshrc "alias lh='ls -lh'"

# Show hidden files
add_to_zshrc "alias la='ls -A'"

# Shortcut to navigate to the home directory
add_to_zshrc "alias home='cd ~'"

# Change to parent directory
add_to_zshrc "alias b='cd ..'"
add_to_zshrc "alias bb='cd ../..'"
add_to_zshrc "alias ='cd ../../..'"

# Go back to the previous directory
add_to_zshrc "alias back='cd ..'"

# Open current directory in Finder
add_to_zshrc "alias finder='open .'"

# Open the current directory in VSCode
add_to_zshrc "alias code='code .'"

# List all open ports
add_to_zshrc "alias ports='sudo lsof -i -P -n | grep LISTEN'"

# View disk usage in human-readable format
add_to_zshrc "alias duh='du -h -d 1 | sort -hr'"

# Show all available disk space
add_to_zshrc "alias dfh='df -h'"

# Show the top 10 largest files in the current directory
add_to_zshrc "alias largest='find . -type f -exec du -h {} + | sort -rh | head -n 10'"

# Show current IP address
add_to_zshrc "alias myip=\"curl -s http://ipinfo.io/ip\""

# Flush DNS cache
add_to_zshrc "alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'"

# Get current Wi-Fi network name
add_to_zshrc "alias wifi='networksetup -getairportnetwork en0'"

# Display macOS version
add_to_zshrc "alias macversion='sw_vers'"

# Sleep Mac
add_to_zshrc "alias sleepmac='pmset sleepnow'"

# Fast shutdown
add_to_zshrc "alias shutdown='sudo shutdown -h now'"

# Restart Mac
add_to_zshrc "alias restart='sudo shutdown -r now'"

# Show battery status
add_to_zshrc "alias battery='pmset -g batt'"

# Show temperature sensors data
add_to_zshrc "alias temp=\"sudo powermetrics --samplers smc | grep -i 'CPU die temperature'\""

# Open Activity Monitor
add_to_zshrc "alias activity='open -a \"Activity Monitor\"'"

# Show memory usage
add_to_zshrc "alias meminfo='vm_stat'"

# Show current date and time
add_to_zshrc "alias now='date \"+%Y-%m-%d %H:%M:%S\"'"

# Copy last command to clipboard
add_to_zshrc "alias clast='fc -ln -1 | pbcopy'"

# Make a directory and navigate into it
add_to_zshrc "alias mkcd='foo() { mkdir -p \"\$1\" && cd \"\$1\"; }; foo'"

# Copy to clipboard
add_to_zshrc "alias copy='pbcopy'"

# Paste from clipboard
add_to_zshrc "alias paste='pbpaste'"

# Quick HTTP server (Python 3.x)
add_to_zshrc "alias serve='python3 -m http.server 8000'"

# Finder alias to open a specific directory
add_to_zshrc "alias desktop='cd ~/Desktop && open .'"

# Open a file with the default application
add_to_zshrc "alias openf='open'"

# Open system preferences
add_to_zshrc "alias prefs='open /System/Library/PreferencePanes/'"

# View detailed process information
add_to_zshrc "alias psaux='ps aux | less'"

# System profiler for hardware info
add_to_zshrc "alias hwinfo='system_profiler SPHardwareDataType'"

# Show list of installed applications
add_to_zshrc "alias apps='ls /Applications/'"

# Open system logs
add_to_zshrc "alias syslogs='open /var/log/system.log'"

# List all running services
add_to_zshrc "alias services='launchctl list'"

# Display calendar for current month
add_to_zshrc "alias cal='cal -h'"

# Show public IP
add_to_zshrc "alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'"

# Enable AirDrop over Ethernet and on unsupported Macs
add_to_zshrc "alias airdrop='defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1'"

# Show network statistics
add_to_zshrc "alias netstat='netstat -s'"

# Flush RAM (requires sudo password)
add_to_zshrc "alias flushram='sudo purge'"

# Rebuild Spotlight index
add_to_zshrc "alias reindex='sudo mdutil -E /'"

# Disable system sleep
add_to_zshrc "alias nosleep='caffeinate'"

# Open iTerm
add_to_zshrc "alias iterm='open -a iTerm'"

# Open Terminal
add_to_zshrc "alias term='open -a Terminal'"

# Clipboard history 
add_to_zshrc "alias cliphist='pbpaste > ~/clipboard-history.txt'"

# Change audio output to internal speakers
add_to_zshrc "alias audiomode='SwitchAudioSource -s \"Internal Speakers\"'"

# Check Bluetooth status
add_to_zshrc "alias btstatus='system_profiler SPBluetoothDataType | grep \"State\"'"

# Enable dark mode
add_to_zshrc "alias darkmode='osascript -e \"tell application \\\"System Events\\\" to tell appearance preferences to set dark mode to not dark mode\"'"

# Show CPU usage
add_to_zshrc "alias cpuinfo='top -l 1 -s 0 | grep \"CPU usage\"'"

# Show top processes by CPU usage
add_to_zshrc "alias topcpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'"

# Show top processes by memory usage
add_to_zshrc "alias topmem='ps -eo pmem,pid,user,args | sort -k 1 -r | head -10'"

# Network speed test
add_to_zshrc "alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'"

# Download file with progress bar
add_to_zshrc "alias wget='curl -O'"

# Count files in directory
add_to_zshrc "alias count='ls | wc -l'"

# Copy SSH key to clipboard
add_to_zshrc "alias copyssh='pbcopy < ~/.ssh/id_rsa.pub'"

# Open the Trash folder
add_to_zshrc "alias trash='open ~/.Trash'"

# Empty the Trash
add_to_zshrc "alias emptytrash='rm -rf ~/.Trash/*'"

# Show all files in Finder
add_to_zshrc "alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'"

# Hide hidden files in Finder
add_to_zshrc "alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'"

# Toggle Finder hidden files visibility
add_to_zshrc "alias togglehidden='defaults write com.apple.finder AppleShowAllFiles -bool !\$(defaults read com.apple.finder AppleShowAllFiles) && killall Finder'"

# Quick curl request to check headers
add_to_zshrc "alias curlh='curl -I'"

# Check disk space usage
add_to_zshrc "alias diskspace='df -h'"

# Restart Finder
add_to_zshrc "alias restartfinder='killall Finder'"

# Restart Dock
add_to_zshrc "alias restartdock='killall Dock'"

# Restart Touch Bar
add_to_zshrc "alias restarttouchbar='pkill \"Touch Bar agent\"'"

# Launch Console
add_to_zshrc "alias console='open -a Console'"

# Force quit Finder
add_to_zshrc "alias quitfinder='osascript -e \"tell application \\\"Finder\\\" to quit\"'"

# Restart Spotlight
add_to_zshrc "alias restartspotlight='killall mds'"

# Launch Disk Utility
add_to_zshrc "alias diskutility='open -a \"Disk Utility\"'"

# Show recent kernel logs
add_to_zshrc "alias kernellogs='dmesg | tail -50'"

# Clear DNS cache
add_to_zshrc "alias cleardns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'"

# Show all currently running applications
add_to_zshrc "alias runningapps='ps -eo comm | grep -vE \"^\\[\" | sort | uniq'"

# Open Launchpad
add_to_zshrc "alias launchpad='open -a Launchpad'"

# Force refresh of Launchpad icons
add_to_zshrc "alias refreshlaunchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'"

# Launch Safari
add_to_zshrc "alias safari='open -a Safari'"

# Launch Chrome
add_to_zshrc "alias chrome='open -a \"Google Chrome\"'"

# Launch Firefox
add_to_zshrc "alias firefox='open -a Firefox'"

# Show all available audio input devices
add_to_zshrc "alias audioin='SwitchAudioSource -a -t input'"

# Show all available audio output devices
add_to_zshrc "alias audioout='SwitchAudioSource -a -t output'"

# Force eject all mounted drives
add_to_zshrc "alias ejectall='drutil eject'"

# Restart audio services
add_to_zshrc "alias restartaudio='sudo killall coreaudiod'"

# Open TextEdit
add_to_zshrc "alias textedit='open -a TextEdit'"

# Open Contacts
add_to_zshrc "alias contacts='open -a Contacts'"

# Open Calendar
add_to_zshrc "alias calendar='open -a Calendar'"

# Open Messages
add_to_zshrc "alias messages='open -a Messages'"

# Show external IP address
add_to_zshrc "alias extip='curl ipinfo.io/ip'"

# Check DNS records for a domain
add_to_zshrc "alias dnslookup='dig +short'"

# Network interface statistics
add_to_zshrc "alias netinfo='ifconfig -a'"

# System information overview
add_to_zshrc "alias sysinfo='system_profiler SPSoftwareDataType'"

# Watch system logs in real-time
add_to_zshrc "alias syswatch='tail -f /var/log/system.log'"

# open Rider
add_to_zshrc "alias rider='open -a /Applications/Rider.app'"

echo "Zsh installed and configured successfully."

exit 0
# =============================
# restart zsh and run 'p10k configure'
