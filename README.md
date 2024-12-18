# Copy Command Script

This is a simple Bash script that allows you to copy the content of a file to the clipboard using the `xclip` utility. The script adds a custom 'copy' command to your `.bashrc` that you can use to copy the content of any file to your clipboard.

## Features

- Installs `xclip` if it's not installed.
- Adds a custom 'copy' function to your user's `.bashrc`.
- Optionally, adds the 'copy' function to the root user's `.bashrc`.
- Automatically reloads the shell to apply changes.

## Requirements

- `xclip` must be installed to use the `copy` command. The script will prompt you to install `xclip` if it's not present.
- The script requires root privileges if you wish to add the command to the root user's `.bashrc`.

## Usage

1. Clone this repository to your local machine or download the script file.
2. Run the script using the following command:
   ```bash
   bash Home.sh
   ```
3. The script will prompt you to install xclip if it's not already installed.
4. The script will then add the 'copy' function to your .bashrc (and optionally to root's .bashrc).
5. After the script completes, the 'copy' command will be available. You may need to restart your terminal session or run source ` ~/.bashrc.`
## Example Usage
- To copy the content of a file, simply run :
```bash
copy yourfile.txt
```
### This will copy the content of yourfile.txt to the clipboard.
