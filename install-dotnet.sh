#!/bin/bash
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
if [ "$EUID" -ne 0 ]
then echo "Please run as root => sudo su "
exit
fi
sudo apt update -y
sudo apt install curl -y
sudo apt install dos2unix -y
sudo apt-get install apache2 -y
sudo apt install zip unzip -y
#install dotnet 
sudo apt update && \
sudo apt install apt-transport-https 
sudo apt update

sudo a2enmod proxy proxy_http proxy_html proxy_wstunnel
sudo a2enmod rewrite

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
echo 'install dotnet-sdk-7.0 ...'
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-7.0
echo 'install aspnetcore-runtime-7.0'
sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-7.0
echo 'install dotnet-runtime-7.0'
if command -v apt-get >/dev/null; then
apt update -y
apt-get install build-essential libncurses5-dev libpcap-dev make zip unzip wget -y
elif command -v yum >/dev/null; then
yum update -y
yum install gcc-c++ libpcap-devel.x86_64 libpcap.x86_64 "ncurses*"
fi
sudo wget -O /root/nethogs.zip https://github.com/Alirezad07/Nethogs-Json-main/archive/refs/heads/master.zip
unzip /root/nethogs.zip
mv -f /root/Nethogs-Json-main-master /root/nethogs
cd /root/nethogs/
chmod 744 /root/nethogs/determineVersion.sh
sudo make install
hash -r
cp /usr/local/sbin/nethogs /usr/sbin/nethogs -f
rm -fr /root/nethogs /root/nethogs.zip
sudo setcap "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe" /usr/local/sbin/nethogs
#sudo nano /etc/apache2/conf-enabled/netcore.conf
echo   -e "{GREEN}Enter Your Domain:(www.Example.com)"
echo   -e "${RED} *** Entering www is required **** "
read domain
echo "Enter Port Number : "
read  port
tee -a 	 <<EOF
<VirtualHost *:$port>
   ServerName  $domain
   ProxyPreserveHost On
   ProxyPass / http://127.0.0.1:5000/
   ProxyPassReverse / http://127.0.0.1:5000/
   RewriteEngine on
   RewriteCond %{HTTP:UPGRADE} ^WebSocket$ [NC]
   RewriteCond %{HTTP:CONNECTION} Upgrade$ [NC]
   RewriteRule /(.*) ws://127.0.0.1:5000/$1 [P]
   ErrorLog /var/log/apache2/netcore-error.log
   CustomLog /var/log/apache2/netcore-access.log common
</VirtualHost>
EOF
sudo service apache2 restart
sudo apachectl configtest
#sudo nano /etc/systemd/system/zpanel.service
tee -a /etc/systemd/system/zpanel.service <<EOF
[Unit]
Description=zpanel
[Service]
WorkingDirectory=/var/netcore/Zpanel-main/app
ExecStart=/usr/bin/dotnet /var/netcore/zpanel-main/app/Zpanel.dll
Restart=always
RestartSec=10
SyslogIdentifier=netcore-demo
User=www-data
Environment=ASPNETCORE_ENVIRONMENT=Production
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
#install mongodb -----
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
sudo apt-get install gnupg
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo apt-get install -y mongodb-org=6.0.1 mongodb-org-database=6.0.1 mongodb-org-server=6.0.1 mongodb-mongosh=6.0.1 mongodb-org-mongos=6.0.1 mongodb-org-tools=6.0.1
[ ! -d "/var/netcore/" ]  &&  mkdir /var/netcore
cd /var/netcore/
#git clone panel ....
wget https://github.com/proxyvpn1919/zpanel/archive/refs/heads/main.zip
#unzip panel.zip 
unzip main.zip
rm main.zip
chmod +x  /var/netcore/zpanel-main/app/wwwroot/command/*.*
dos2unix  /var/netcore/zpanel-main/app/wwwroot/command/*.*

sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config

sudo sed -i '/www-data/d' /etc/sudoers &
wait
sudo sed -i '/apache/d' /etc/sudoers &
wait

#if command -v apt-get >/dev/null; then

sudo NEETRESTART_MODE=a apt-get update --yes
sudo apt-get -y install software-properties-common
apt-get install apache2 zip unzip net-tools curl -y

apt-get install npm -y
sudo apt-get install coreutils
wait

echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells

wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/adduser' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/userdel' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/passwd' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/curl' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/kill' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/killall' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/lsof' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/lsof' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/sed' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/rm' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/crontab' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/mysqldump' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/pgrep' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/sbin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/local/sbin/nethogs' | sudo EDITOR='tee -a' visudo &
wait
echo 'www-data ALL=(ALL:ALL) NOPASSWD:/usr/bin/netstat' | sudo EDITOR='tee -a' visudo &
wait
sudo a2enmod rewrite
wait
sudo service apache2 restart
wait
sudo systemctl restart apache2
wait
sudo service apache2 restart
wait
sudo sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf &
wait
sudo service apache2 restart
wait
clear
sudo systemctl daemon-reload
sudo systemctl start mongod
sudo service mongod start
sudo systemctl enable zpanel.service
sudo systemctl start zpanel.service
sudo systemctl daemon-reload
setcap "cap_net_admin,cap_net_raw=ep" /usr/sbin/nethogs
clear
echo -e "\t\twell come to zpanel."
echo -e "\t\tDear user !"
echo -e "\t\tTo use this panel, please enter your desired port and username and password."
echo  -e "If the panel does not run, please enter the following commands in order."
echo -e "sudo systemctl daemon-reload"
echo -e "sudo systemctl start mongod "
echo -e "sudo service mongod start"
echo -e "sudo systemctl enable zpanel.service "
echo -e "sudo systemctl start zpanel.service "
echo -e "sudo systemctl daemon-reload "
echo  -e "${GREEN} Pleas Enter UserName Form AdminPanel : "
read UseraName
echo -e "${GREEN} Pleas Enter Password Form AdminPanel : "
read Password
curl -d "username=$UserName&password=$Password"   $domain:$port/InintUser
echo  "address:$domain:$port/Login" 
echo "Username $UserName"
echo "Password $Password"