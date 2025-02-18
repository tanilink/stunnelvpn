#!/bin/bash

# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Banner Status Information
export EROR="[${RED} ERROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
# ==========================================

# Cek file sebelum membaca
if [[ -f /etc/xray/domain ]]; then
    domain=$(cat /etc/xray/domain)
else
    echo -e "${EROR} File /etc/xray/domain tidak ditemukan!"
    exit 1
fi

if [[ -f /root/nsdomain ]]; then
    sldomain=$(cat /root/nsdomain)
else
    sldomain="Tidak ditemukan"
fi

if [[ -f /root/awscdndomain ]]; then
    cdndomain=$(cat /root/awscdndomain)
else
    cdndomain="Tidak ditemukan"
fi

if [[ -f /etc/slowdns/server.pub ]]; then
    slkey=$(cat /etc/slowdns/server.pub)
else
    slkey="Tidak ditemukan"
fi

clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[44;1;39m              ⇱ CREATE UDP ACCOUNT                 \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

read -p "Username : " Login
echo -e ""
read -p "Password : " Pass
echo -e ""

# Pastikan masa aktif adalah angka
while true; do
    read -p "Expired (hari): " masaaktif
    if [[ "$masaaktif" =~ ^[0-9]+$ ]]; then
        break
    else
        echo -e "${EROR} Harap masukkan angka yang valid!"
    fi
done

IP=$(wget -qO- ipinfo.io/ip)

# Cek keberadaan file log-install.txt
if [[ -f ~/log-install.txt ]]; then
    ws=$(grep -w "Websocket TLS" ~/log-install.txt | cut -d: -f2 | sed 's/ //g')
    ws2=$(grep -w "Websocket None TLS" ~/log-install.txt | cut -d: -f2 | sed 's/ //g')
else
    echo -e "${EROR} File log-install.txt tidak ditemukan!"
    exit 1
fi

clear

# Tambahkan user dengan masa aktif tertentu
useradd -e "$(date -d "$masaaktif days" +"%Y-%m-%d")" -s /bin/false -M $Login
echo -e "$Pass\n$Pass\n" | passwd $Login &> /dev/null

hariini=$(date -d "0 days" +"%Y-%m-%d")
expi=$(date -d "$masaaktif days" +"%Y-%m-%d")

echo -e ""
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\e[44;97;1m     INFORMATION UDP CUSTOM        \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e " Domain  : $domain"
echo -e " Username: $Login"
echo -e " Password: $Pass"
echo -e " Created : $hariini"
echo -e " Expired : $expi"
echo -e " Port UDP: 1-2288 , 1-65535 , 1-12345"
echo -e " Copy 1  : $domain:1-65535@$Login:$Pass"
echo -e " Copy 2  : $domain:1-2288@$Login:$Pass"
echo -e " Copy 3  : $domain:1-12345@$Login:$Pass"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\e[44;97;1m        Tanilink TUNNELING          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo
read -p "Enter To Menu"
menu
