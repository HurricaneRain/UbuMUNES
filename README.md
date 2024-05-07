# UbuMUNES
A bashed based script to install **IMUNES** and a VNC Server onto an **Ubuntu Server 24.04 LTS**.  

## Prerequisities  
1. [Digital Ocean Account](https://www.digitalocean.com/)
2. [SSH Key](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/) 
3. [VNC Client](https://remoteripple.com/)
4. [Cyberduck](https://cyberduck.io/)

## Getting Started Instructions  
1. Create your Digital Ocean Droplet
2. Connect to your Droplet using SSH
3. Clone in this Repository onto your Droplet
    - `git clone https://github.com/HurricaneRain/UbuMUNES`
4. Run the `imunes_install.sh` script  
    - `sudo /path/to/UbuMUNES/imunes_install.sh`
    - Make note of the VNC password once the script is finished
6. Connect using your [VNC Client](https://remoteripple.com/)

## Transfering Files To/From Digital Ocean Droplet
1. Download and Install [Cyberduck](https://cyberduck.io/)
2. Open Cyberduck and Click on **Open Connection**
3. Select **SFTP (SSH File Transfer Protocol)**
4. Enter in your Digital Ocean Droplet's IP.
5. Username: root
6. SSH Private Key - Navigate to your private key and select that here.
7. Click **Connect**

## Troubleshooting  
1. **I forgot my VNC password**
    1. Connect to your Digital Ocean Droplet using SSH 
    2. Run the `reset_vnc_password.sh` script
        - `sudo /path/to/UbuMUNES/reset_vnc_password.sh`

## References
https://github.com/imunes/imunes
