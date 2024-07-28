echo Install startet.
echo Script by Troels Lund

echo "Apple develper kit"

xcode-select --install

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

brew install git

git config --global user.name "Troels Lund"
git config --global user.email "trolund@gmail.com"

# brew cask install avast-security

brew install python3

brew install adoptopenjdk8

brew install java

brew install java8

brew cask install docker

brew cask install vlc

brew cask install slack

brew cask install firefox

# brew cask install webtorrent

brew cask install ngrok

brew cask install google-chrome

brew cask install macs-fan-control

brew cask install onedrive

brew cask install dotnet

brew cask install dotnet-sdk

brew cask install visual-studio

brew cask install visual-studio-code

brew install --cask rider

# brew cask install phpstorm

brew cask install intellij-idea

# brew cask install webstorm

brew cask install postman

brew cask install transmit

brew cask install private-internet-access

brew cask install spectacle

brew cask install sequel-pro

brew cask install pycharm

brew install --cask iterm2

# brew cask install betterzip

# brew cask install arduino

# brew cask install dash

brew cask install go2shell

brew install htop

brew install node

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

## zsh plugins (see https://dev.to/khairunnaharnowrin/how-to-setup-zsh-on-mac-terminal-37dj and https://gist.github.com/n1snt/454b879b8f0b7995740ae04c5fb5b7df)

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

p10k configure

echo installation done!!
