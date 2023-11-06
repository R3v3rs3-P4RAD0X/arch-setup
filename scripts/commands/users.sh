#!/bin/bash

# Import the commands
source ./commands/print.sh


###############################################
# Users                                       #
# - User Add                                  #
#                                             #
# Usage:                                      #
#   users_add "username" "passwd" "verbose"   #
###############################################

users_add()
{
    # $1 = Username
    # $2 = Passwordless
    # $3 = Verbose

    # Check if the username is empty
    if [ -z "$1" ]; then
        # If verbose is true, print an error
        if [ "$3" = "true" ]; then
            print "❌ Username cannot be empty" "red"
        fi

        # If the username is empty, return 1
        return 1
    fi

    # Check if the user already exists
    if id "$1" >/dev/null 2>&1; then
        # If verbose is true, print an error
        if [ "$3" = "true" ]; then
            print "❌ User already exists" "red"
        fi

        # If the user already exists, return 1
        return 1
    fi

    # Check if passwordless is true
    if [ "$2" = "true" ]; then
        # If passwordless is true, create the user without a password
        useradd -m -s /usr/bin/nologin "$1"
    else
        # If passwordless is false, create the user with a password
        useradd -m -s /usr/bin/nologin "$1"
        passwd "$1"
    fi

    # If verbose is true, print a success message
    if [ "$3" = "true" ]; then
        print "✅ User created successfully" "green"
    fi

    # Return 0
    return 0
}