#!/bin/bash 

# Author: d3fiant
# Purpose: Intended to setup an environment for security work. 
# Scope: Ubuntu 18.04


################## Initiation
userName=d3fiant
echo "Running Commands as " + $userName

################## Dir Setup
echo "Setting Up Directories"
rm -rf /home/$userName/Music
rm -rf /home/$userName/Videos
rm -rf /home/$userName/Templates
mkdir /home/$userName/working


################## Utilities
#apt install 
echo "Installing Utilities"
apt install git
apt install mlocate 
apt install vim
apt install vsftpd


################## Python
echo "Setting Up Python Environment"
virtualenv -p python3 /tmp/MyEnv
apt install python3-pip
pip3 install pwntools
pip3 install impacket
pip3 install scapy
pip3 install beautifulsoup4


################## Web
# Burpsuite
echo "Installing Burpsuite"
cd /tmp
wget "https://portswigger.net/burp/releases/download?product=community&version=2.1.04&type=linux&componentid=100" -O burp_install.sh
chmod +x burp_install.sh
./burp_install.sh

################## Network

# nmap
echo "Installing nmap"
apt install nmap

# Zeek
cd /tmp
echo 'deb http://download.opensuse.org/repositories/security:/zeek/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/security:zeek.list
wget -nv https://download.opensuse.org/repositories/security:zeek/xUbuntu_18.04/Release.key -O Release.key
apt-key add - < Release.key
apt-get update
apt-get install zeek


################## Reversing

# Ghidra
echo "Installing Ghidra"
cd /tmp
apt install openjdk-11-jre
apt install openjdk-11-jdk 
wget "https://ghidra-sre.org/ghidra_9.1-BETA_DEV_20190923.zip" -O ghidra.zip
unzip ghidra.zip -d /opt/
cd /usr/bin
sudo ln -s /opt/ghidra_9.1-BETA_DEV/ghidraRun ghidra

# Peda
echo "Setting Up Peda"
cd /home/$userName
git clone https://github.com/longld/peda.git
echo "source /peda/peda.py" >> /home/$userName/.gdbinit
chown $userName:$userName /home/$userName/.gdbinit


################## Memory
#Volatility
echo "Setting Up Volatility"
pip3 install volatility

#Sleuthkit
apt install sleuthkit



################## Path Setup
echo "export PATH=/home/d3fiant/.local/bin:/opt/ghidra_9.1-BETA_DEV:/opt/zeek/bin:$PATH" >> /home/$userName/.profile
cd /usr/bin
ln -s /opt/BurpSuiteCommunity/BurpSuiteCommunity burp


################## Misc
echo "Finishing Up"

# Resource
source /etc/environment

# Make sure shared drive is working
sudo vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000

echo "Complete. Check For erros"


# Web server python -m http.server 80 