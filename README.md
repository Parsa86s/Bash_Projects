# Hash Cracker

## Author: Parsa Saadat

Welcome to the Hash Cracker project ! This script allows you to crack hashed passwords using Hashcat. 

### Features

- **Input a Wordlist**: Enter the path to your wordlist file , with up to 5 attempts to find a valid file .
  
- **Select Hash Type**: Choose from MD5 , SHA256 , or SHA512 , or let the script automatically detect the type.
  
- **Crack Passwords**: Utilizes Hashcat to attempt to find the original password , displaying results directly in the terminal.
  
- **Automatic Cleanup**: If the password is not found , the output file is automatically deleted without prompting.

### Usage

1. Clone the repository or download the script directly.
2. Ensure you have Hashcat installed on your machine.


### Making the Script Executable

Before running the script, ensure it is executable by using the following command in your terminal :

```bash
chmod +x hash_cracker.sh
```

### Run the script in your terminal
   ```bash
   bash hash_cracker.sh
