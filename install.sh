#!/bin/bash

# copy script to /usr/local/bin
sudo cp apt-manager.sh /usr/local/bin/apt-manager

# make script executable
sudo chmod +x /usr/local/bin/apt-manager

# create terminal alias
echo "alias apt-manager='bash /usr/local/bin/apt-manager'" >> ~/.bashrc

echo "Installation complete. Please restart your terminal or run 'source ~/.bashrc' to use the alias."