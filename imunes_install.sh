#!/bin/bash
#
# Install IMUNES and VNC onto an Ubuntu machine

# No interaction for apt-get
export DEBIAN_FRONTEND=noninteractive

# Check to see if the script is being run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script using sudo!"
    exit 1
fi

# Get the original username if the script is ran using sudo
current_user=${SUDO_USER:-$USER}

# Identify the current user and set the home directory location depending on who is running it
if [ $(id -u $current_user) -eq 0 ]; then
    # current user is root
    home_directory='/'$current_user
else
    # current user is not root
    home_directory='/home/'$current_user
fi

#######################################
# Install IMUNES required packages
# Clone the IMUNES repository and build
# Setup IMUNES templates
#######################################
apt-get update
apt-get install openvswitch-switch docker.io xterm wireshark make iproute2 imagemagick tk tcllib util-linux xfce4 xfce4-goodies tigervnc-standalone-server --assume-yes
git clone https://github.com/imunes/imunes.git $home_directory/imunes
cd $home_directory/imunes
make install
imunes -p

# Generate a random 8 character password for VNC Server login
vnc_password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c 8)

#######################################
# VNC Server Setup
#######################################
# Create the VNC config directory in the identified home directory
mkdir -p "$home_directory/.vnc"

# Set VNC server password
vncpasswd -f <<< $vnc_password > "$home_directory/.vnc/passwd"

# Create VNC config file
cat <<EOF > $home_directory/.vnc/config
session=xfce4-session
localhost=no
geometry=1920x1080
EOF

# Modify the VNC server users file
sed -i "\$a:1=$current_user" /etc/tigervnc/vncserver.users

# Set permissions on the .vnc directory
chmod 600 -R "$home_directory/.vnc"
chown $current_user:$current_user -R "$home_directory/.vnc"

# Create a systemd service for VNC server
cp /usr/lib/systemd/system/tigervncserver@.service /etc/systemd/system/vncserver@:1.service

# Enable and start the VNC server service
systemctl enable vncserver@:1.service
systemctl start vncserver@:1.service

#######################################
# Display VNC password and other information
#######################################
echo -e "\n\n\nYour VNC password is: $vnc_password\n\n"
echo -e "Do not lose this password, as this is what you will use to connect to your VNC server\n"
exit
