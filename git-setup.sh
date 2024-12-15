#!/bin/bash

# Load variables from the .env file
if [ -f .env ]; then
    source .env
else
    echo ".env file not found!"
    exit 1
fi

# Configure Git
echo "Configuring Git..."
git config --global user.name $GIT_USER_NAME
git config --global user.email $GIT_USER_EMAIL

## Set up SSH key for GitHub

# ask if the user wants to set up an SSH key for GitHub
read -p "Do you want to set up an SSH key for GitHub? (y/n): " response

# Handle the user's response
case "$response" in
y | Y | yes | YES | Yes)
    echo "Setting up SSH key for GitHub..."

    # create a new SSH key for GitHub
    echo "Generating a new SSH key for GitHub..."

    # Generating a new SSH key
    # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key
    ssh-keygen -t ed25519 -C $1 -f ~/.ssh/id_ed25519

    # Adding your SSH key to the ssh-agent
    # https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent
    eval "$(ssh-agent -s)"

    touch ~/.ssh/config
    echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config

    ssh-add -K ~/.ssh/id_ed25519

    # Adding your SSH key to your GitHub account
    # https://docs.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account
    pbcopy <~/.ssh/id_ed25519.pub

    echo "ssh key is in clipboard paste that into GitHub"

    # wait for user to add the SSH key to GitHub
    read -p "Press enter to continue after adding the SSH key to GitHub..."
    ;;
n | N | no | NO | No)
    echo "Skipping SSH key setup for GitHub."
    exit 0
    ;;
*)
    echo "Invalid input. Please enter y or n."
    ;;
esac
