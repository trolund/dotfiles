export TERM="xterm-256color"
# Set the default user to the current user
export DEFAULT_USER=$USER

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Powerlevel10k Theme
ZSH_THEME="powerlevel10k/powerlevel10k"
source $HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
# Add plugins
source <(fzf --zsh)
source $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-completions/zsh-completions.plugin.zsh
source $HOME/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source $HOME/.oh-my-zsh/plugins/dotnet/dotnet.plugin.zsh
source $HOME/.oh-my-zsh/plugins/docker-compose/docker-compose.plugin.zsh
source $HOME/.oh-my-zsh/plugins/history/history.plugin.zsh
source $HOME/.oh-my-zsh/plugins/iterm2/iterm2.plugin.zsh
source $HOME/.oh-my-zsh/plugins/macos/macos.plugin.zsh
source $HOME/.oh-my-zsh/plugins/npm/npm.plugin.zsh
source $HOME/.oh-my-zsh/plugins/aliases/aliases.plugin.zsh
source $HOME/.oh-my-zsh/plugins/cp/cp.plugin.zsh
source $HOME/.oh-my-zsh/plugins/z/z.plugin.zsh
source $HOME/.oh-my-zsh/plugins/fzf/fzf.plugin.zsh

plugins=(dotnet docker-compose history iterm2 macos npm aliases cp z fzf zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete zsh-completions zsh-history-substring-search)

# Add custom aliases
alias zshconfig='code ~/.zshrc'
alias ohmyzsh='code ~/.oh-my-zsh'
alias zshreload='source ~/.zshrc'
alias zshupdate='upgrade_ohmyzsh'
alias zshplugins='code $HOME/.oh-my-zsh/custom/plugins'
alias zshthemes='code $HOME/.oh-my-zsh/custom/themes'
alias sn='nvim $(fzf -m --preview "bat --color=always {}")'
alias sc='code $(fzf -m --preview "bat --color=always {}")'
alias cf='cd $HOME/Documents/Code'
alias c='clear'
alias ll='ls -la'
alias lh='ls -lh'
alias la='ls -A'
alias home='cd ~'
alias b='cd ..'
alias bb='cd ../..'
alias bbb='cd ../../..'
alias back='cd ..'
alias finder='open .'
alias code='code .'
alias ports='sudo lsof -i -P -n | grep LISTEN'
alias duh='du -h -d 1 | sort -hr'
alias dfh='df -h'
alias largest='find . -type f -exec du -h {} + | sort -rh | head -n 10'
alias myip="curl -s http://ipinfo.io/ip"
alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias wifi='networksetup -getairportnetwork en0'
alias macversion='sw_vers'
alias sleepmac='pmset sleepnow'
alias shutdown='sudo shutdown -h now'
alias restart='sudo shutdown -r now'
alias battery='pmset -g batt'
alias temp="sudo powermetrics --samplers smc | grep -i 'CPU die temperature'"
alias activity='open -a "Activity Monitor"'
alias meminfo='vm_stat'
alias now='date "+%Y-%m-%d %H:%M:%S"'
alias clast='fc -ln -1 | pbcopy'
alias mkcd='foo() { mkdir -p "$1" && cd "$1"; }; foo'
alias copy='pbcopy'
alias paste='pbpaste'
alias serve='python3 -m http.server 8000'
alias desktop='cd ~/Desktop && open .'
alias openf='open'
alias prefs='open /System/Library/PreferencePanes/'
alias psaux='ps aux | less'
alias hwinfo='system_profiler SPHardwareDataType'
alias apps='ls /Applications/'
alias syslogs='open /var/log/system.log'
alias services='launchctl list'
alias cal='cal -h'
alias pubip='dig +short myip.opendns.com @resolver1.opendns.com'
alias airdrop='defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1'
alias netstat='netstat -s'
alias flushram='sudo purge'
alias reindex='sudo mdutil -E /'
alias nosleep='caffeinate'
alias iterm='open -a iTerm'
alias term='open -a Terminal'
alias cliphist='pbpaste > ~/clipboard-history.txt'
alias audiomode='SwitchAudioSource -s "Internal Speakers"'
alias btstatus='system_profiler SPBluetoothDataType | grep "State"'
alias darkmode='osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"'
alias cpuinfo='top -l 1 -s 0 | grep "CPU usage"'
alias topcpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias topmem='ps -eo pmem,pid,user,args | sort -k 1 -r | head -10'
alias speedtest='curl -o /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip'
alias wget='curl -O'
alias count='ls | wc -l'
alias copyssh='pbcopy < ~/.ssh/id_rsa.pub'
alias trash='open ~/.Trash'
alias emptytrash='rm -rf ~/.Trash/*'
alias showfiles='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
alias togglehidden='defaults write com.apple.finder AppleShowAllFiles -bool !$(defaults read com.apple.finder AppleShowAllFiles) && killall Finder'
alias curlh='curl -I'
alias diskspace='df -h'
alias restartfinder='killall Finder'
alias restartdock='killall Dock'
alias restarttouchbar='pkill "Touch Bar agent"'
alias console='open -a Console'
alias quitfinder='osascript -e "tell application \"Finder\" to quit"'
alias restartspotlight='killall mds'
alias diskutility='open -a "Disk Utility"'
alias kernellogs='dmesg | tail -50'
alias cleardns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias runningapps='ps -eo comm | grep -vE "^\[" | sort | uniq'
alias launchpad='open -a Launchpad'
alias refreshlaunchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'
alias safari='open -a Safari'
alias chrome='open -a "Google Chrome"'
alias firefox='open -a Firefox'
alias audioin='SwitchAudioSource -a -t input'
alias audioout='SwitchAudioSource -a -t output'
alias ejectall='drutil eject'
alias restartaudio='sudo killall coreaudiod'
alias textedit='open -a TextEdit'
alias contacts='open -a Contacts'
alias calendar='open -a Calendar'
alias messages='open -a Messages'
alias extip='curl ipinfo.io/ip'
alias dnslookup='dig +short'
alias netinfo='ifconfig -a'
alias sysinfo='system_profiler SPSoftwareDataType'
alias syswatch='tail -f /var/log/system.log'
alias rider='open -a /Applications/Rider.app'

PATH=~/.console-ninja/.bin:$PATH
PATH="$PATH:$HOME/.dotnet/tools"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
