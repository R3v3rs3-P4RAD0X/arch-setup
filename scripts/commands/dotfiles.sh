#!/bin/bash

source ./commands/print.sh

#################################################
# Dotfiles                                      #
# - Dotfiles Install                            #
#                                               #
# Usage:                                        #
# - dotfiles_install "user" "verbose" "force"   #
#################################################

dotfiles_install()
{
    # $1 = User to install the dotfiles
    # $2 = Verbose
    # $3 = Force

    # Check if the user is empty
    if [ -z "$1" ]; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ User cannot be empty" "red"
        fi

        # If the user is empty, return 1
        return 1
    fi

    # Check if the user exists
    if ! id "$1" >/dev/null 2>&1; then
        # If verbose is true, print an error
        if [ "$2" = "true" ]; then
            print "❌ User $1 does not exist" "red"
        fi

        # If the user does not exist, return 1
        return 1
    fi

    # If verbose is true, print a message
    if [ "$2" = "true" ]; then
        print "🔃 Installing dotfiles for $1" "yellow"
    fi

    # Wget the dotfiles output to /tmp/DillonEllis.zip
    wget https://github.com/StrangeParadox/P4RAD0X/archive/refs/heads/main.zip &> /dev/null

    # Unzip the dotfiles to /tmp/DillonEllis
    unzip -o $(pwd)/main.zip &> /dev/null

    # Create a variable to store the user's home directory
    user_home=$(eval echo "~$1")

    # Delete the zip file
    rm $(pwd)/main.zip

    # Delete the P4RAD0X directory if it exists from the user's home directory
    rm -rf $user_home/P4RAD0X

    # Move the P4RAD0X to the user's home directory
    mv -f $(pwd)/P4RAD0X-main $user_home/P4RAD0X

    # Change directory to the user's home directory
    cd $user_home

    # Change the owner of the P4RAD0X directory to the user
    chown -R $1:$1 $user_home/P4RAD0X

    # Change directory to the P4RAD0X directory
    cd $user_home/P4RAD0X

    # Run the dotfiles configurer script
    ./setup.sh

    # If verbose is true, print a message
    if [ "$2" = "true" ]; then
        print "✅ Dotfiles installed successfully" "green"
    fi

    # Return 0
    return 0
}