printf "%s\n" "Started SSH installer"
apt install dropbear -y
apt install cmake -y
apt install unzip -y
apt install screen -y
apt install wget -y
apt install squid -y
apt install shadowsocks-libev -y
wget https://github.com/ambrop72/badvpn/archive/master.zip
unzip master.zip
cd badvpn-master
mkdir build
cd build
cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=1 -DBUILD_UDPGW=1;make install;
wget https://raw.githubusercontent.com/mgtortoise/bashMe/main/dropbear
wget https://raw.githubusercontent.com/mgtortoise/bashMe/main/squid.conf
wget https://raw.githubusercontent.com/mgtortoise/hellogithub/master/config.json
rm -rf /etc/default/dropbear
mv dropbear /etc/default/dropbear
/etc/init.d/dropbear restart
rm -rf /etc/squid/squid.conf
mv squid.conf /etc/squid/squid.conf
rm -rf /etc/shadowsocks-libev/config.json
mv config.json /etc/shadowsocks-libev/config.json
systemctl restart shadowsocks-libev
systemctl enable shadowsocks-libev
systemctl restart squid
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
netstat -tulpn 
printf "Username = "
read username 
printf "Password = "
read password
useradd $username
(echo $password;echo $password)| passwd $username
ip=$(curl -s https://api.ipify.org)
GREEN="\e[92m"
printf "${GREEN}Ip       : $ip \nUserName : $username \nPassword : $password \nPort  : 444,222\n"