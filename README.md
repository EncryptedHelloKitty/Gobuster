# Gobuster Tool - README

This script simplifies the use of `Gobuster` by providing an interactive interface to configure options like target URL, wordlist, scan mode, threads, and more. It dynamically constructs and executes the appropriate Gobuster command.

## Features

1. **Interactive Parameter Input**: Prompts for Gobuster options such as target URL, wordlist path, scan mode, and threads.
2. **Support for Different Modes**: Configures scans for directories (`dir`), subdomains (`dns`), or virtual hosts (`vhost`).
3. **Customizable Extensions and DNS Server**: Allows adding file extensions for `dir` mode or specifying DNS servers for `dns` mode.
4. **Output File Management**: Saves the results to a user-defined file.

## Prerequisites

Ensure Gobuster is installed on your system. To install Gobuster:
```bash
sudo apt update
sudo apt install gobuster
