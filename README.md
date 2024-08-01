# Cls-Alias

A Bash script to add a cls alias for clearing the terminal screen in Debian-based Linux distributions. This script checks if the alias already exists, adds it if necessary, and provides options to manage the alias in both normal user and root modes.

## Features
- Adds an alias cls to clear the terminal screen.
- Checks if the alias already exists in `.bashrc` to avoid duplication.
- Differentiates between root and normal user modes.
- Prompts the user to add the alias for root mode if not initially executed as root.
- Reloads the shell after updating `.bashrc.`
- Displays messages and waits before clearing the screen.
- Uses a counter to keep track of function calls.

## Warnings
- This script is designed to run only on Debian-based Linux distributions.
- To revert the changes, edit the `.bashrc` file and remove the cls alias.

## Prerequisites
- Ensure you have [Git](https://git-scm.com/) installed.
- Ensure you have [Bash](https://www.gnu.org/software/bash/) installed (commonly available on Unix-like systems).

## Installation

1. **Clone the Repository**:
  Open a terminal and run the following command to clone the repository to your local machine:  
  git clone https://github.com/yourusername/cls-alias.git

2. **Navigate to the Project Directory**:
  cd cls-alias

## Usage
1. **Make the Script Executable**:
  chmod +x cls-alias.sh

2. **Run the Script**:
  ./cls-alias.sh

## Notice
When you run the script, it will check if the cls alias is already present in your `.bashrc` file:

- Normal User Mode:
If the alias is not present, it will add it and reload the shell.
It will then prompt you to add the alias for root mode as well.

- Root Mode:
If the alias is not present, it will add it and reload the shell.
If the alias is already present, it will notify you.
