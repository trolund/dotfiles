# macOS Setup Scripts 👨‍💻

This repository contains a collection of Bash scripts designed to automate the setup and configuration of macOS to my preferences. Each script handles a specific aspect of the setup process, including system settings, application installations, and shell environment configuration.

## Overview 🤘

1. **`main.sh`**: Orchestrates the complete macOS setup process by invoking other scripts for system settings, application installations, and shell configuration.

2. **`settings-macos.sh`**: Configures macOS system settings to enhance productivity and user experience. This includes setting preferences for the appearance, dock, mission control, keyboard, trackpad, finder, and other system options.

3. **`shell-setup.sh`**: Sets up the *Zsh* shell environment. It installs and configures *Oh-My-Zsh*, the Powerlevel10k theme, and various *Zsh* plugins to improve shell usability and functionality.

4. **`install-apps-macos.sh`**: Manages the installation of essential applications and tools using Homebrew. This script installs command-line tools, system utilities, and GUI applications. The package manager *Homebrew* are used for installing various applications and command-line tools.

5. **`utils.sh`**: script provides utility functions used by the other scripts.

6. **`Manual-steps`**: contain a small guid to manual steps that could not be automated or is not automated yet.

## Usage 🛠

1. **Clone the Repository**

   Clone this repository to your local machine:

   ```bash
   git clone https://github.com/trolund/macos-setup-scripts.git
   cd macos-setup-scripts
   ```

2. **Run the Setup Script**

   Execute the main setup script to start the entire setup process:

   ```bash
   ./setup-macos.sh
   ```

   This script will:
   - Configure macOS settings using `settings-macos.sh`
   - Install applications using `install-apps-macos.sh`
   - Set up the Zsh shell environment using `shell-setup.sh`

3. **Review Individual Scripts**

   - **`settings-macos.sh`**: Customizes macOS system preferences.
   - **`install-apps-macos.sh`**: Installs necessary applications and command-line tools via Homebrew.
   - **`shell-setup.sh`**: Configures Zsh, including themes and plugins.

## Notes 🗒️

- Some changes made by `settings-macos.sh` may require a logout or restart to take effect.
- Ensure you have an active internet connection for downloading and installing applications.
- Modify the scripts as needed to fit your specific requirements or preferences.

## Contributing 💪

Feel free to fork the repository and modify it to your own preferences.
