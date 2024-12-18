#!/bin/bash

# Author: Parsa Saadat
# Project: Copy Command Script
# Description: A custom Bash script to copy the content of a file to the clipboard using `xclip`.
#
# Features:
# - Installs `xclip` if it's not already installed.
# - Adds the custom 'copy' command to your user's `.bashrc`.
# - Optionally, adds the command to the root user's `.bashrc`.
# - Reloads the shell to apply changes automatically.
#
# Warnings:
# - The script requires root privileges to add the 'copy' command to the root user's `.bashrc`.
# - Ensure that `xclip` is available on your system for the script to function correctly.
# - Be cautious while modifying your `.bashrc` file, as incorrect modifications could affect your shell environment.
#
# License: MIT License

check_xclip() {
    if ! command -v xclip &> /dev/null; then
        echo "xclip is not installed."
        read -p "Would you like to install it? (y/n): " install_xclip
        if [[ "$install_xclip" == "y" || "$install_xclip" == "Y" ]]; then
            sudo apt update && sudo apt install -y xclip
            if [ $? -eq 0 ]; then
                clear
                echo "xclip installed successfully."
            else
                echo "Failed to install xclip. Please install it manually and re-run this script."
                exit 1
            fi
        else
            echo "xclip is required for the 'copy' command. Exiting."
            exit 1
        fi
    fi
}

add_copy_to_bashrc() {
    local bashrc_path=$1

    if grep -Eq "^(function )?copy\(\)" "$bashrc_path"; then
        echo "The 'copy' command is already defined in $bashrc_path. Skipping addition."
        return 1  # Indicate that no addition was made
    fi

    echo "Adding the 'copy' command to $bashrc_path..."
    cat << 'EOF' >> "$bashrc_path"

# Custom 'copy' command to copy file content to clipboard
copy() {
    if [ -f "$1" ]; then
        cat "$1" | xclip -sel clip
        echo "Content of '$1' copied to clipboard."
    else
        echo "File '$1' does not exist."
    fi
}
EOF

    echo "The 'copy' command has been added to $bashrc_path."
    return 0  # Indicate that addition was made
}

check_xclip
add_copy_to_bashrc "$HOME/.bashrc"

if [[ "$EUID" -ne 0 ]]; then
    read -p "Would you like to add the 'copy' command to the root user's .bashrc as well? [y/n]: " add_to_root
    if [[ "$add_to_root" == "y" || "$add_to_root" == "Y" ]]; then
        # Add the 'copy' command to the root user's .bashrc without printing any message
        sudo bash -c "$(declare -f add_copy_to_bashrc); add_copy_to_bashrc /root/.bashrc"
    else
        echo "Skipping addition to the root user's .bashrc."
    fi
fi

echo "Reloading your shell to apply changes..."
exec bash

