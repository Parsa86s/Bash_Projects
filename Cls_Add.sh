

# Features:
# - Adds an alias 'cls' to clear the terminal screen
# - Checks if the alias already exists to avoid duplication
# - Handles both root and normal user modes
# - Prompts the user to add the alias for root mode if not running as root
# - Reloads the shell after updating .bashrc
# - Displays messages and waits before clearing the screen
# - Uses a counter to keep track of function calls

# Warnings:
# - This Code Will be executed in only Deb-baced Linux Distributions
# - If you decide to return the changes , Go To Bashrc File and remove the Cls alias

#!/bin/bash

# Author: Parsa Saadat
Root=$(id -un)
Counter=0

add_cls_alias() {
    echo "alias cls='clear'" >> ~/.bashrc
    source ~/.bashrc
}

check_cls_alias() {
    grep -q "alias cls='clear'" ~/.bashrc
}

Root_Func() {
    Counter=$((Counter+1))
    
    if check_cls_alias; then
        echo -e "You already have < cls > command to clear the screen in Root Mode ."
    else
        add_cls_alias
        echo -e "Cls added to bashrc file to clear the screen in Root Mode ."
        exec bash
    fi
}

Norm_Func() {
    if check_cls_alias; then
        echo "You already have < cls > command to clear the screen in Normal User Mode ."
    else
        add_cls_alias
        echo -e "Cls added to bashrc file to clear the screen in Normal Mode ."
        sleep 4
        clear
    fi

    if [ $Counter -eq 0 ]; then
        read -p "Do you want to add cls command in Root Mode too? [Y/n] " Same
        if [[ $Same == "y" || $Same == "Y" ]]; then
            sleep 2
            clear
            echo "Run the program again in Root"
            sudo su
        else
            echo "Goodbye :)"
        fi
    else
        echo "Goodbye :)"
    fi
}

if [[ "$Root" == "root" ]]; then
    Root_Func
else
    Norm_Func
    exec bash
fi  