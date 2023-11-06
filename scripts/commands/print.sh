#!/bin/bash

###############################################
# Print                                       #
# - Print                                     #
#                                             #
# Usage:                                      #
# - print "text" "color"                      #
###############################################


# A function that prints the given text in the given color
# Usage: print "text" "color"
print() {
    # $1 = text
    # $2 = color

    # Check if the color is valid
    if [ "$2" = "red" ]; then
        echo -e "\e[31m$1\e[0m"
    elif [ "$2" = "green" ]; then
        echo -e "\e[32m$1\e[0m"
    elif [ "$2" = "yellow" ]; then
        echo -e "\e[33m$1\e[0m"
    elif [ "$2" = "blue" ]; then
        echo -e "\e[34m$1\e[0m"
    elif [ "$2" = "magenta" ]; then
        echo -e "\e[35m$1\e[0m"
    elif [ "$2" = "cyan" ]; then
        echo -e "\e[36m$1\e[0m"
    elif [ "$2" = "white" ]; then
        echo -e "\e[37m$1\e[0m"
    else
        echo -e "\e[0m$1\e[0m"
    fi

    # Return 0
    return 0
}

print_bold()
{
    # $1 = text
    # $2 = color

    # Check if the color is valid
    if [ "$2" = "red" ]; then
        echo -e "\e[1;31m$1\e[0m"
    elif [ "$2" = "green" ]; then
        echo -e "\e[1;32m$1\e[0m"
    elif [ "$2" = "yellow" ]; then
        echo -e "\e[1;33m$1\e[0m"
    elif [ "$2" = "blue" ]; then
        echo -e "\e[1;34m$1\e[0m"
    elif [ "$2" = "magenta" ]; then
        echo -e "\e[1;35m$1\e[0m"
    elif [ "$2" = "cyan" ]; then
        echo -e "\e[1;36m$1\e[0m"
    elif [ "$2" = "white" ]; then
        echo -e "\e[1;37m$1\e[0m"
    else
        echo -e "\e[1m$1\e[0m"
    fi

    # Return 0
    return 0
}