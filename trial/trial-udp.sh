#!/bin/bash

# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
export ungu='\033[0;35m'

# izin
MYIP=$(wget -qO- ipinfo.io/ip)
echo "Memeriksa VPS Anda..."
sleep 0.5

CEKEXPIRED () {
    today=$(date +%Y-%m-%d)  # Fixed the date format
    Exp1=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep "$MYIP" | awk '{print $3}')
    
    if [[ "$today" < "$Exp1" ]]; then
        echo "Status script aktif.."
    else
        echo "SCRIPT ANDA EXPIRED"
        exit 0
    fi
}

IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep "$MYIP")
if [ "$MYIP" = "$IZIN" ]; then
    echo "IZIN DI TERIMA!!"
    CEKEXPIRED
else
    echo "Akses ditolak!! Benget sia hurung!!"
    exit 0
fi

clear

# Getting info for creating the trial account
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                 ⇱ CREATE TRIAL UDP  ⇲            \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "Akumulasi masa aktif minimal 15 menit, (min = 15)"
read -p "Masukkan angka (menit): " mm

# Validasi input untuk memastikan angka yang dimasukkan adalah angka dan minimal 15 menit
if ! [[ "$mm" =~ ^[0-9]+$ ]] || [ "$mm" -lt 15 ]; then
    echo "Masa aktif minimal 15 menit. Mengatur ke 15 menit."
    mm=15
fi

Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
masaaktif=$mm
Pass="1"
max="2"
domain=$(cat /etc/xray/domain)
sldomain=$(cat /root/nsdomain)
cdndomain=$(cat /root/awscdndomain)
slkey=$(cat /etc/slowdns/server.pub)
clear

echo "Script AutoCreate Akun SSH dan OpenVPN By GretongersVPN"
sleep 3
echo "Ping Host"
echo "Cek Hak Akses..."
sleep 0.5
echo "Permission Accepted"
clear
sleep 0.5
echo "Membuat Akun: $Login"
sleep 0.5
echo "Setting Password: $Pass"
sleep 0.5
IP=$(wget -qO- ipinfo.io/ip)
ws="$(cat ~/log-install.txt | grep -w "Websocket TLS" | cut -d: -f2 | sed 's/ //g')"
ws2="$(cat ~/log-install.txt | grep -w "Websocket None TLS" | cut -d: -f2 | sed 's/ //g')"
ssl="$(cat ~/log-install.txt | grep -w "Stunnel5" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
clear

# Restart services and enable
systemctl stop client-sldns
systemctl stop server-sldns
pkill sldns-server
pkill sldns-client
systemctl enable client-sldns
systemctl enable server-sldns
systemctl start client-sldns
systemctl start server-sldns
systemctl restart client-sldns
systemctl restart server-sldns
systemctl restart ssh-ohp
systemctl restart rc-local
systemctl restart dropbear-ohp
systemctl restart openvpn-ohp

# Create user account with proper expiration time based on minutes
useradd -e $(date -d "$masaaktif minutes" +"%Y-%m-%d %H:%M:%S") -s /bin/false -M "$Login"
expi=$(chage -l "$Login" | grep "Account expires" | awk -F": " '{print $2}')
echo -e "$Pass\n$Pass\n" | passwd "$Login" &> /dev/null
hariini=$(date -d "0 hours" +"%H:%M:%S")
expi=$(date -d "$masaaktif minutes" +"%H:%M:%S")

clear
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m                 ⇱ TRIAL AKUN SSH UDP ⇲            \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${LIGHT}"
echo -e "IP/Host: $IP"
echo -e "Domain SSH: $domain"
echo -e "Username: $Login"
echo -e "Password: $Pass"
echo -e "Port UDP: 1-2288"
echo -e "Created: Jam $hariini"
echo -e "Expired: Jam $expi"

echo -e "${LIGHT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}     Terimakasih sudah menggunakan" 
echo -e "${CYAN}        script Rifqi Tunneling "
echo -e "${LIGHT}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
