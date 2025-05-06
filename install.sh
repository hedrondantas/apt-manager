#!/bin/bash

# check if dialog is installed
if ! command -v dialog &> /dev/null
then
    echo "dialog could not be found. Installing..."
    # ask for installation confirmation
    read -p "Do you want to install dialog? (y/n) " answer
    if [[ $answer == "y" || $answer == "Y" ]]; then
            sudo apt install dialog -y
    else
        echo "dialog is required for this script to run. Exiting..."
        exit 1
    fi
fi

# copy script to /usr/local/bin
sudo cp apt-manager.sh /usr/local/bin/apt-manager

# make script executable
sudo chmod +x /usr/local/bin/apt-manager

echo "Installation complete. Please restart your terminal."