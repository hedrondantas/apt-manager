#!/bin/bash

# Checks if 'dialog' is installed
if ! command -v dialog &> /dev/null; then
    echo "'dialog' is not installed. Install it with: sudo apt install dialog"
    exit 1
fi

# Functions that will be called by the menu options
update() {
    sudo apt update
    if [ $? -eq 0 ]; then
        dialog --msgbox "Update completed successfully!" 6 40
    else
        dialog --msgbox "Update failed!" 6 40
    fi
}

upgrade() {
   sudo apt upgrade
    if [ $? -eq 0 ]; then
        dialog --msgbox "Upgrade completed successfully!" 6 40
    else
        dialog --msgbox "Upgrade failed!" 6 40
    fi
}

fix_missing() {
    sudo apt --fix-broken install
    if [ $? -eq 0 ]; then
        dialog --msgbox "Fix missing dependencies completed successfully!" 6 40
    else
        dialog --msgbox "Fix missing dependencies failed!" 6 40
    fi
}

install() {
    package_name=$(dialog --inputbox "Enter the package name to install:" 8 40 3>&1 1>&2 2>&3 3>&-)
    if [ $? -eq 0 ]; then
        sudo apt install "$package_name"
        if [ $? -eq 0 ]; then
            dialog --msgbox "Installation of $package_name completed successfully!" 6 40
        else
            dialog --msgbox "Installation of $package_name failed!" 6 40
        fi
    else
        dialog --msgbox "Installation canceled!" 6 40
    fi
}

remove() {
    package_name=$(dialog --inputbox "Enter the package name to remove:" 8 40 3>&1 1>&2 2>&3 3>&-)
    if [ $? -eq 0 ]; then
        sudo apt remove "$package_name"
        if [ $? -eq 0 ]; then
            dialog --msgbox "Removal of $package_name completed successfully!" 6 40
        else
            dialog --msgbox "Removal of $package_name failed!" 6 40
        fi
    else
        dialog --msgbox "Removal canceled!" 6 40
    fi
}

clean() {
    sudo apt clean
    if [ $? -eq 0 ]; then
        dialog --msgbox "Clean completed successfully!" 6 40
    else
        dialog --msgbox "Clean failed!" 6 40
    fi
}

search() {
    package_name=$(dialog --inputbox "Enter the package name to search:" 8 40 3>&1 1>&2 2>&3 3>&-)
    if [ $? -eq 0 ]; then
        search_result=$(apt search "$package_name" 2>/dev/null)
        dialog --msgbox "Search results:\n\n$search_result" 20 70
    else
        dialog --msgbox "Search canceled!" 6 40
    fi
}

# Main menu loop
while true; do
    choice=$(dialog --clear --stdout --title "Main Menu" \
        --menu "Choose an option:" 20 50 10 \
        1 "Check Status" \
        2 "Start Service" \
        3 "Stop Service" \
        4 "Install" \
        5 "Remove" \
        6 "Clean" \
        7 "Search" \
        8 "Exit")

    case $choice in
        1) update ;;
        2) upgrade ;;
        3) fix_missing ;;
        4) install ;;
        5) remove ;;
        6) clean ;;
        7) search ;;
        8) clear; echo "Exiting..."; break ;;
        *) break ;;
    esac
done