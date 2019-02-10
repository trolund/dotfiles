echo Install startet.
echo Script by Troels Lund

xcode-select --install

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

brew install python3

brew cask install java8

brew cask install java

brew cask install vlc

brew cask install iterm2

brew cask install slack

brew install git

git config --global user.name "Troels Lund"
git config --global user.email "trolund@mail.com"

brew install zsh

sh -c “$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

brew cask install webtorrent

brew cask install brackets
