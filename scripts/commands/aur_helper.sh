#!/bin/bash

###############################################
# AUR Helper                                  #
# - AUR Helper Install                        #
#                                             #
# Usage:                                      #
#   aur_helper_install "helper" "verbose"     #
###############################################

aur_helper_install()
{
    # $1 = User to install the helper
    # $2 = Verbose

    # Check if the user is empty
    if [ -z "$1" ]; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ User cannot be empty" "red"
        fi

        # If the user is empty, return 1
        return 1
    fi

    # Check if the user is root
    if [ "$1" = "root" ]; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ User cannot be root" "red"
        fi

        # If the user is root, return 1
        return 1
    fi

    # Check if the user exists
    if ! id "$1" >/dev/null 2>&1; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ User does not exist" "red"
        fi

        # If the user does not exist, return 1
        return 1
    fi

    # Check if the helper is already installed
    if command -v paru &> /dev/null; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ Paru is already installed" "red"
        fi

        # If the helper is already installed, return 1
        return 1
    fi

    # Use the tmp directory and create a subdir for the user to install the helper
    cd /tmp

    # Clone the helper repository
    git clone https://aur.archlinux.org/paru.git

    # Change the directory to the helper repository
    cd paru

    # Change permissions for the user
    chown -R "$1":"$1" .

    # Build the helper
    sudo -u "$1" makepkg -si

    # Change the directory back to the tmp directory
    cd /tmp

    # Remove the helper repository
    rm -rf paru

    # If verbose is true, print a success message
    if [ "$2" = "true" ]; then
        print "✅ Helper installed successfully" "green"
    fi
}