#!/bin/bash
# Directory organizer
# Author : Parsa Saadat

# Prompt the user for the directory path
read -p "Please enter the path to the directory you want to organize: " directory

# Check if the provided path is a valid directory
if [ ! -d "$directory" ]; then
    echo "The provided path is not a valid directory."
    exit 1
fi

# Counting the Files in the Directory
count=$(find "$directory" -type f | wc -l)
echo "You Have $count Files in this Directory"

# Create a function to organize files by extension
organize_files() {
    for file in "$directory"/*; do
        if [[ -f "$file" ]]; then
            extension="${file##*.}"
            if [[ ! -d "$directory/$extension" ]]; then
                mkdir -m 755 "$directory/$extension"  # Create with permissions 755
            fi
            mv "$file" "$directory/$extension/"
        fi
    done
}

# Create a function to deorganize files (move them back to the original directory)
deorganize_files() {
    for subdir in "$directory"/*; do
        if [[ -d "$subdir" ]]; then
            for file in "$subdir"/*; do
                mv "$file" "$directory/"
            done
            rmdir "$subdir"
        fi
    done
}

# Run the function to organize files
organize_files

# Ask for user confirmation
read -p "Are you sure you want to keep the files like this? [y/n]: " answer

if [[ "$answer" == [nN] ]]; then
    deorganize_files
    echo "Files have been moved back to the original directory."
else
    echo "Files have been organized by their extensions."
fi
