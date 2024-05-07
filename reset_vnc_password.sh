#!/bin/bash
#
# Helper script to reset the VNC server password

# Get the original username if the script is ran using sudo
current_user=${SUDO_USER:-$USER}

# Identify the current user and set the home directory location depending on who is running it
# Check if the current user is the actual root account
if [ $(id -u $current_user) -eq 0 ]; then
    # Current user is root
    home_directory='/'$current_user
else
    # current user is not root
    home_directory='/home/'$current_user
fi

# Generate a random 8 character password
vnc_password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c 8)

# Set VNC password
vncpasswd -f <<< $vnc_password > "$home_directory/.vnc/passwd"

# Output everything
echo -e "\n\n\nYour VNC password is: $vnc_password\n\n"
echo -e "Do not lose this password, as this is what you will use to connect to your VNC server\n"