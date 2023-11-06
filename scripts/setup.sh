#!/bin/bash

# Import the commands
source ./commands/packages.sh
source ./commands/print.sh
source ./commands/sudoers.sh
source ./commands/users.sh
source ./commands/aur_helper.sh
source ./commands/dotfiles.sh

# Create a list of packages to install
package_list=(
    "git"
    "base-devel"
    "neovim"
    "lolcat"
    "neofetch"
    "htop"
    "fish"
    "linux-headers"
    "linux"
    "wget"
    "unzip"
)

# Clear the screen
clear

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    # If the script is not being run as root, print an error
    print "❌ Please run this script as root" "red"

    # Exit with code 1
    exit 1
fi

# Run the package_install function for each package in the list
print_bold "🚀 Installing packages..." "yellow"
for package in "${package_list[@]}"; do
    package_install "$package" "upgrade" "true"
done
print "" "white"

# Run the sudoers_initialise function
print_bold "🚀 Initialising sudoers..." "yellow"
sudoers_initialise
print "" "white"

# Create a helper user with nologin that has full access to sudo no passwd
print_bold "🚀 Creating helper user..." "yellow"
users_add "helper" "true" "true"
sudoers_add_user "helper" "ALL=(ALL)" "true" "true"
print "" "white"

# Run the aur_helper_install function
print_bold "🚀 Installing aur helper..." "yellow"
aur_helper_install "helper" "true"
print "" "white"

# Run the dotfiles_install function
print_bold "🚀 Installing dotfiles..." "yellow"
dotfiles_install "$USER" "true" "true"
print "" "white"