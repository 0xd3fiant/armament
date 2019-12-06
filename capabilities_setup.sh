#!/bin/bash 


################## Dir Setup
echo "Setting Up Directories"
rm -rf /root/Music
rm -rf /root/Videos
rm -rf /root/Templates
mkdir /root/working
mkdir /repos

################## Utilities
#apt install 
echo "Installing Utilities"
apt install git
apt install mlocate 
apt install vim
apt install vsftpd
apt install powershell
apt install gdb
apt install wordlists


################## Python
echo "Setting Up Python Environment"
apt install python3-pip
pip3 install pwntools
pip3 install impacket
pip3 install scapy
pip3 install beautifulsoup4


################## Web
echo "Installing Web Tools"
apt install burpsuite
apt install nikto

################## Network
echo "Installing Network Tools"
apt install nmap
apt install wireshark

# Zeek
cd /tmp
echo 'deb http://download.opensuse.org/repositories/security:/zeek/Debian_10/ /' > /etc/apt/sources.list.d/security:zeek.list
wget -nv https://download.opensuse.org/repositories/security:zeek/Debian_10/Release.key -O Release.key
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
cd /home/repos
git clone https://github.com/longld/peda.git
echo "source /root/repos/peda/peda.py" >> /root/.gdbinit



################## Memory
#Volatility
echo "Setting Up Volatility"
pip3 install volatility

#Sleuthkit
apt install sleuthkit



################## Path Setup
echo "export PATH=/repos/ghidra9:$PATH" >> /root/.profile


################## Misc
echo "Finishing Up"

# Resource
source /etc/environment

# Make sure shared drive is working
vmhgfs-fuse .host:/ /mnt/ -o allow_other -o uid=1000

echo "Complete. Check For erros"


# Web server python -m http.server 80 