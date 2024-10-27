#!/bin/bash

# Author: Parsa Saadat

# Description: This script detects hash types and attempts to crack them using Hashcat.

# Features:
# - Prompts the user for a wordlist file with up to 5 attempts.
# - Automatically detects hash types or allows manual selection.
# - Uses Hashcat to attempt to crack the specified hash.
# - Displays results on the terminal or indicates if the password was not found.
# - Automatically exits with an error code if the wordlist is not found after 5 attempts.

# Hints:
# - If you are not familiar with famous wordlists , you can access them from GitHub with the Example command Below :
#   curl -O [GitHub URL to wordlist]
# - Example: curl -O https:// and so on :)


# Famous Wordlist to Use: 
# 1. Rockyou --> https://github.com/josuamarcelc/common-password-list
# 2. SecLists --> https://github.com/danielmiessler/SecLists


# Function to detect hash type (basic detection)
detect_hash_type() {
    hash_input="$1"
    if [[ ${#hash_input} -eq 32 ]]; then
        echo "0"   # MD5
    elif [[ ${#hash_input} -eq 64 ]]; then
        echo "1400" # SHA256
    elif [[ ${#hash_input} -eq 128 ]]; then
        echo "1700" # SHA512
    else
        echo "unknown"
    fi
}

# Prompt for wordlist with retry mechanism
attempts=0
max_attempts=5
wordlist_path=""

while [[ $attempts -lt $max_attempts ]]; do
    read -p "Please enter the path to your wordlist file: " wordlist_path

    # Check if wordlist exists
    if [[ -f "$wordlist_path" ]]; then
        break  # Exit loop if the file exists
    else
        echo "Wordlist file not found!"
        attempts=$((attempts + 1))  # Increment attempts
        if [[ $attempts -eq $max_attempts ]]; then
            echo "Maximum attempts reached. Exiting."
            exit 1  # Exit with code 1 if max attempts are reached
        fi
    fi
done

# Prompt for hash input
read -p "Please enter the hash you want to crack: " hash_input

# Prompt for hash type selection with auto-detect option
echo "Please select the hash type you want to crack or enter 'auto' to detect:"
echo "[1] MD5"
echo "[2] SHA256"
echo "[3] SHA512"
echo "[auto] Detect automatically"
read -p "Enter choice (1, 2, 3, or 'auto'): " hash_choice

# Determine hash mode based on user choice
if [[ "$hash_choice" == "1" ]]; then
    hash_mode=0
elif [[ "$hash_choice" == "2" ]]; then
    hash_mode=1400
elif [[ "$hash_choice" == "3" ]]; then
    hash_mode=1700
elif [[ "$hash_choice" == "auto" ]]; then
    hash_mode=$(detect_hash_type "$hash_input")
    if [[ "$hash_mode" == "unknown" ]]; then
        echo "Unable to detect hash type. Exiting."
        exit 1
    fi
    echo "Detected hash type: $hash_mode"
else
    echo "Invalid choice! Exiting."
    exit 1
fi

# Run Hashcat command
echo "Starting hash cracking..."
hashcat_output=$(hashcat -m "$hash_mode" -a 0 "$hash_input" "$wordlist_path" --show)

# Display the result
if [[ -n "$hashcat_output" ]]; then
    echo "Cracking results:"
    echo "$hashcat_output"
else
    echo "Password Not Found!"
fi