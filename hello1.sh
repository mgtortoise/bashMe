printf "%s\n" "Started SSH installer"
apt install dropbear -y
apt install cmake -y
apt install unzip -y
apt install screen -y
apt install wget -y
wget https://github.com/ambrop72/badvpn/archive/master.zip
unzip master.zip
cd badvpn-master
mkdir build
cd build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=1 -DBUILD_UDPGW=1;make install;
wget https://raw.githubusercontent.com/mgtortoise/bashMe/main/dropbear
rm -rf /etc/default/dropbear
mv dropbear /etc/default/dropbear
/etc/init.d/dropbear restart
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
netstat -tulpn