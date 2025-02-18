#!/bin/bash
# // Menyeting Warna & Informasi
export MERAH='\033[0;31m'
export HIJAU='\033[0;32m'
export KUNING='\033[0;33m'
export BIRU='\033[0;34m'
export UNGU='\033[0;35m'
export CYAN='\033[0;36m'
export TERANG='\033[0;37m'
export NC='\033[0m'

# // Menyeting Banner Status
export EROR="[${MERAH} EROR ${NC}]"
export INFO="[${KUNING} INFO ${NC}]"
export OKEY="[${HIJAU} OKEY ${NC}]"
export PENDING="[${KUNING} PENDING ${NC}]"
export SEND="[${KUNING} SEND ${NC}]"
export RECEIVE="[${KUNING} RECEIVE ${NC}]"

# // Menyeting Format Teks
export TEBAL="\e[1m"
export PERINGATAN="${MERAH}\e[5m"
export GARIS_BAWAH="\e[4m"

mkdir /user/curent > /dev/null 2>&1
touch /user/current
clear
echo "IP=$domain" > /var/lib/scrz-prem/ipvps.conf

if [[ "$IP" = "" ]]; then
  domain=$(cat /etc/xray/domain)
else
  domain=$IP
fi

echo -e "[ ${HIJAU}INFO${NC} ] Memeriksa... "
sleep 1
echo -e "[ ${HIJAU}INFO${NC} ] Menyetel ntpdate"
sleep 1
domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate -y

# Setel waktu
ntpdate -u pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta

# Install Curl dan tool lainnya
apt install curl pwgen openssl netcat cron -y

# Buat Folder & Log XRay & Log Trojan
rm -fr /var/log/xray
rm -fr /var/log/trojan
rm -fr /home/vps/public_html
mkdir -p /var/log/xray
mkdir -p /var/log/trojan
mkdir -p /home/vps/public_html
chown www-data.www-data /var/log/xray
chown www-data.www-data /etc/xray
chmod +x /var/log/xray
chmod +x /var/log/trojan
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /var/log/xray/access2.log
touch /var/log/xray/error2.log

# Buat Log Autokill & Log Autoreboot
rm -fr /root/log-limit.txt
rm -fr /root/log-reboot.txt
touch /root/log-limit.txt
touch /root/log-reboot.txt
touch /home/limit
echo "" > /root/log-limit.txt
echo "" > /root/log-reboot.txt

# Install Wondershaper
cd /root/
apt install wondershaper -y
git clone https://github.com/magnific0/wondershaper.git >/dev/null 2>&1
cd wondershaper
make install
cd
rm -fr /root/wondershaper
echo > /home/limit

# Nginx dan SSL
install_ssl(){
    if [ -f "/usr/bin/apt-get" ]; then
        isDebian=`cat /etc/issue|grep Debian`
        if [ "$isDebian" != "" ]; then
            apt-get install -y nginx certbot
            apt install -y nginx certbot
            sleep 3s
        else
            apt-get install -y nginx certbot
            apt install -y nginx certbot
            sleep 3s
        fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ]; then
        isDebian=`cat /etc/issue|grep Debian`
        if [ "$isDebian" != "" ]; then
            echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
            sleep 3s
        else
            echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
            sleep 3s
        fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi
}

# Install Nginx
mkdir -p /home/vps/public_html
wget -q -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/vps.conf.txt"
sleep 1
wget -q -O xraymode.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/xraymode.sh && chmod +x xraymode.sh && ./xraymode.sh
sleep 1
wget -q -O /etc/xray/config.json "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/configuration/config.json"
chmod +x /etc/xray/config.json
sleep 1
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/configuration/xray.conf"
chmod +x /etc/nginx/conf.d/xray.conf

# Menginstall Xray Service
rm -fr /etc/systemd/system/xray.service.d
rm -fr /etc/systemd/system/xray.service
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

echo -e "[ ${HIJAU}OK${NC} ] Menyeting & Memulai Xray"
systemctl daemon-reload >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1

echo -e "[ ${HIJAU}OK${NC} ] Menyeting & Memulai Nginx"
systemctl daemon-reload >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1

# Restart Semua Service
echo -e "[ ${HIJAU}OK${NC} ] Merestart Semua Service"
chown -R www-data:www-data /home/vps/public_html

# Restart Xray & Nginx
echo -e "[ ${HIJAU}OK${NC} ] Merestart Xray & Nginx"
systemctl daemon-reload >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1

# Atur batas kuota
wget -q -O /usr/local/sbin/quota "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/quota.sh"
chmod +x /usr/local/sbin/quota
sed -i 's/\r//' /usr/local/sbin/quota

# Service Kuota VMESS
cat >/etc/systemd/system/qmv.service << EOF
[Unit]
Description=Kuota VMESS
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vmess
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmv
systemctl enable qmv

# Service Kuota VLESS
cat >/etc/systemd/system/qmvl.service << EOF
[Unit]
Description=Kuota VLESS
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vless00
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmvl
systemctl enable qmvl

# Service Kuota TROJAN
cat >/etc/systemd/system/qmtr.service << EOF
[Unit]
Description=Kuota TROJAN
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota trojan
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmtr
systemctl enable qmtr

# Mengatur iptables
ETH=$(ip -o $ETH -4 route show to default | awk '{print $5}')
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT

# Simpan konfigurasi iptables
iptables-save > /etc/iptables/rules.v4
iptables-save > /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
systemctl restart netfilter-persistent
