#!/bin/bash
clear

# Define colors
red='\e[1;31m'
green='\e[1;32m'
yell='\e[1;33m'
NC='\e[0m'

green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }

# Check OS
if [[ -e /etc/debian_version ]]; then
    source /etc/os-release
    OS=$ID # debian or ubuntu
elif [[ -e /etc/centos-release ]]; then
    source /etc/os-release
    OS=centos
fi

echo "Tools install...!"
echo "Progress..."
sleep 2

# Update system
apt update -y
apt-get remove --purge ufw firewalld exim4 apache2 -y

# Install necessary packages
apt install -y screen curl jq bzip2 gzip coreutils rsyslog iftop \
    htop zip unzip net-tools sed gnupg gnupg2 \
    bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch screenfetch git lsof \
    openssl fail2ban tmux \
    stunnel4 vnstat squid3 \
    dropbear libsqlite3-dev \
    socat cron bash-completion ntpdate xz-utils \
    dnsutils lsb-release chrony

# Install Node.js (optional)
curl -sSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs

# Configure vnstat
NET=$(ip -o -4 route show to default | awk '{print $5}' | head -n 1) # Get the default network interface
/etc/init.d/vnstat restart
wget -q https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc >/dev/null 2>&1 && make >/dev/null 2>&1 && make install >/dev/null 2>&1
cd
vnstat -u -i $NET
sed -i 's/Interface "'"eth0"'"/Interface "'"$NET"'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz >/dev/null 2>&1
rm -rf /root/vnstat-2.6 >/dev/null 2>&1

# Install additional packages
apt install -y libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev xl2tpd pptpd

yellow "Dependencies successfully installed..."
sleep 3
clear
