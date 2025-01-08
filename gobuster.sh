#!/bin/bash

# Function to explain a parameter
function explain() {
    echo -e "\033[1;34m$1\033[0m"
}

# Function to prompt the user for input with a default value
function prompt() {
    read -p "$1 [$2]: " input
    echo "${input:-$2}"
}

# Check if Gobuster is installed
if ! command -v gobuster &>/dev/null; then
    echo "Gobuster is not installed. Install it with 'sudo apt install gobuster' or download it from its GitHub repository."
    exit 1
fi

# Ask for the target URL or IP
explain "Target URL or IP"
echo "The target is the URL or IP address where Gobuster will perform its scan."
TARGET=$(prompt "Enter the target URL or IP" "http://example.com")

# Ask for the wordlist
explain "Wordlist"
echo "The wordlist file contains directories or file names to test against the target."
WORDLIST=$(prompt "Enter the path to the wordlist" "/usr/share/wordlists/dirb/common.txt")

# Ask for the scan mode
explain "Scan Mode"
echo "Choose the scan mode. Examples:
1. dir: Scan for directories and files.
2. dns: Enumerate subdomains.
3. vhost: Enumerate virtual hosts."
MODE=$(prompt "Enter the scan mode (dir, dns, vhost)" "dir")

# Ask for the number of threads
explain "Threads"
echo "The number of concurrent threads to use for the scan. More threads make the scan faster but increase server load."
THREADS=$(prompt "Enter the number of threads" "10")

# Ask for the output file
explain "Save Output"
echo "Save the results of the scan to a file in the current directory."
OUTPUT_FILE=$(prompt "Enter the output file name" "gobuster_output.txt")

# Optional extensions for `dir` mode
EXTENSIONS=""
if [[ "$MODE" == "dir" ]]; then
    explain "Extensions"
    echo "Specify file extensions to include in the scan (e.g., php, txt, html). Use commas to separate multiple extensions."
    EXTENSIONS=$(prompt "Enter file extensions to scan (leave blank for none)" "")
    [[ -n "$EXTENSIONS" ]] && EXTENSIONS="-x $EXTENSIONS"
fi

# Optional DNS server for `dns` mode
DNS_SERVER=""
if [[ "$MODE" == "dns" ]]; then
    explain "DNS Server"
    echo "Specify a DNS server to use for subdomain enumeration (e.g., 8.8.8.8)."
    DNS_SERVER=$(prompt "Enter DNS server (leave blank to use default)" "")
    [[ -n "$DNS_SERVER" ]] && DNS_SERVER="-r $DNS_SERVER"
fi

# Show the constructed command
GOBUSTER_CMD="gobuster $MODE -u $TARGET -w $WORDLIST -t $THREADS $EXTENSIONS $DNS_SERVER -o $OUTPUT_FILE"

explain "Constructed Gobuster Command"
echo "$GOBUSTER_CMD"

# Ask for confirmation to run
read -p "Run this command? (y/n): " CONFIRM
if [[ "$CONFIRM" == "y" ]]; then
    # Run Gobuster and save output to the file
    echo "Running Gobuster..."
    eval "$GOBUSTER_CMD"
    echo "Gobuster scan completed. Output saved to $PWD/$OUTPUT_FILE."
else
    echo "Gobuster command not executed. Modify the parameters and try again."
fi
