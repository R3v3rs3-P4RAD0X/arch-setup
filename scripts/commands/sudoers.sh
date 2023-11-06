#!/bin/bash

###############################################
# Sudoers                                     #
# - Sudoers Add User                          #
# - Sudoers Initialise                        #
###############################################

sudoers_initialise()
{
    # This function will initialise the sudoers file.
    # Cleans the sudoers file and adds the new configuration.

    # Check if the sudoers.d directory exists
    if [ -d "/etc/sudoers.d" ]; then
        # If the sudoers.d directory exists, remove the directory
        sudo rm -rf /etc/sudoers.d
    fi

    # Sleep 1 second
    sleep 1

    # Create the sudoers.d directory
    sudo mkdir /etc/sudoers.d

    # Create the sudoers file and add the header
    echo "####################" > /etc/sudoers
    echo "# Script Generated #" >> /etc/sudoers
    echo "####################" >> /etc/sudoers

    # Add a new line
    echo "" >> /etc/sudoers
    
    # Include the sudoers.d directory
    echo "# Include sudoers.d" >> /etc/sudoers
    echo "#includedir /etc/sudoers.d" >> /etc/sudoers
    echo "" >> /etc/sudoers

    # Add a smaller header for groups
    echo "# Groups" >> /etc/sudoers

    # Add the default groups 
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
    echo "%sudo ALL=(ALL) ALL" >> /etc/sudoers

    # Add a new line
    echo "" >> /etc/sudoers

    # Add a smaller header for users
    echo "# Users" >> /etc/sudoers

    # Add the root user
    sudoers_add_user "root" "ALL=(ALL)" "true" "false"
    sleep 1

    # Return 0
    return 0
}

sudoers_add_user()
{
    # $1 = username
    # $2 = permissions
    # $3 = override
    # $4 = nopasswd

    # This function will add a user to the sudoers file.

    # Check if the user is already in the sudoers file
    if sudo grep -q "$1" /etc/sudoers; then
        # Check if override is true
        if [ "$3" = "true" ]; then
            # If override is true, remove the user from the sudoers file
            sudo sed -i "/$1/d" /etc/sudoers
        else
            # If override is false, return 1
            return 1
        fi
    fi

    # Check if nopasswd is true
    if [ "$4" = "true" ]; then
        # If nopasswd is true, add the user to the sudoers file without a password
        echo "$1 $2 NOPASSWD: ALL" >> /etc/sudoers
    else
        # If nopasswd is false, add the user to the sudoers file with a password
        echo "$1 $2 ALL" >> /etc/sudoers
    fi

    # If verbose is true, print a success message
    if [ "$3" = "true" ]; then
        print "✅ $1 added to sudoers successfully" "green"
    fi

    # Return 0
    return 0
}

