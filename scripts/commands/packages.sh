#!/bin/bash

source ./commands/print.sh

#################################################
# Packages                                      #
# - Package Install                             #
# - Package Installed                           #
# - Package Upgradable                          #
#################################################

package_install() 
{
    # $1 = package
    # $2 = upgraded
    # $3 = verbose

    # This function will install the given package.
    # Checks if the package is already installed to skip the installation.
    # Also checks if the package has already been installed and if it should be upgraded.
    # Returns 0 if package is installed
    # Returns 1 if package isn't installed or couldn't be found.

    # Check if the package is already installed
    package_installed "$1"

    # If the package is installed
    if [ $? == 0 ]; then
        # Check if the package should be upgraded
        package_upgradable "$1"

        # If the package should be upgraded
        if [ $? == 0 ]; then
            # If verbose is true, print a message
            if [ "$3" = "true" ]; then
                print "🚀 Upgrading $1..." "yellow"
            fi

            # Upgrade the package
            pacman -S "$1" --noconfirm

            # If verbose is true, print a message
            if [ "$3" = "true" ]; then
                print "✅ $1 upgraded successfully" "green"
            fi
        else
            # If verbose is true, print a message
            if [ "$3" = "true" ]; then
                print "✅ $1 is already installed" "green"
            fi
        fi
    fi

    # If the package is not installed
    if [ $? == 1 ]; then
        # If verbose is true, print a message
        if [ "$3" = "true" ]; then
            print "🚀 Installing $1..." "yellow"
        fi

        # Install the package
        pacman -S "$1" --noconfirm

        # If verbose is true, print a message
        if [ "$3" = "true" ]; then
            print "✅ $1 installed successfully" "green"
        fi
    fi

    # Return 0
    return 0
}

package_installed()
{
    # $1 = package

    # This function will check if the given package is installed.
    # If the package is installed, it will return 0.
    # If the package is not installed, it will return 1.

    # Check if the package is installed
    if pacman -Qi "$1" &> /dev/null; then
        # If the package is installed, return 0
        return 0
    else
        # If the package is not installed, return 1
        return 1
    fi
}

package_upgradable()
{
    # $1 = package

    # This function will check if the given package is installed and upgradable.
    # If the package is upgradable, it will return 0.
    # If the package is not upgradable, it will return 1.

    # Check if the package is installed
    package_installed "$1"

    # If the package is installed, check if it is upgradable
    if [[ $? == 0 ]]; then
        # If the package is installed, check if it is upgradable
        if pacman -Qu "$1" &> /dev/null; then
            # If the package is upgradable, return 0
            return 0
        else
            # If the package is not upgradable, return 1
            return 1
        fi
    else
        # If the package is not installed, return 1
        return 1
    fi
}