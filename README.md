# LAMP Stack Management Script

This Bash script is designed to simplify the installation, uninstallation, and management of a LAMP (Linux, Apache, MySQL, PHP) stack on a Debian-based Linux system. It automates the process of installing Apache, PHP, MySQL Server, and phpMyAdmin, and provides options for uninstalling PHP if needed.

## Features

- Interactive checklist for installation and uninstallation options.
- Automated installation of Apache, PHP, MySQL Server, and phpMyAdmin.
- Configuration of Apache to run phpMyAdmin.
- Securing MySQL root user with a password.

## Prerequisites

- This script is designed for Debian-based Linux distributions.
- Ensure that you have administrative privileges (`sudo` or root access) to execute the script.

## Usage

1. Clone this repository to your local machine or server:

   ```bash
   git clone https://github.com/ravikantchauhan/post_installation.git
   ```
2. Navigate to the directory containing the script:
   ```bash
   cd post_installation
   ```
3. Make the script executable:
   ```bash
   chmod +x lamp.sh
   ```
4. Execute the script with root privileges:
   ```bash
   sudo ./lamp.sh
   ```
5. Follow the on-screen instructions to select your desired options.
## Options
Uninstall PHP: Removes PHP from the system.
Keep Current PHP Version: Retains the existing PHP installation.
Install LAMP Stack: Installs Apache, PHP, MySQL Server, and configures phpMyAdmin.
