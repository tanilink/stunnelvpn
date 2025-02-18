#!/bin/bash
# SL
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
# Getting
MYIP=$(wget -qO- ipinfo.io/ip)
echo "Checking VPS"
IZIN=$(curl -s ipinfo.io/ip | grep -q $MYIP)
if [ $? -eq 0 ]; then
    echo -e "\e[0m${GREEN}Permission Accepted...\e[0m"
else
    echo -e "\e[0m${RED}Permission Denied!\e[0m"
    echo -e "\e[0m${LIGHT}Access denied!"
    exit 0
fi

clear

NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
    echo ""
    echo "You have no existing clients!"
    exit 1
fi

clear
echo ""
echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m            • DELETED XRAY USER •             \e[0m"
echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
echo ""
echo "     No  Expired   User"
grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '

# Input client selection
until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
    if [[ ${CLIENT_NUMBER} == '1' ]]; then
        read -rp "Select one client [1]: " CLIENT_NUMBER
    else
        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
    fi
done

# Get the user and expiration details
user=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)

# Remove the user from config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json

# Remove the user's specific config files
rm -f /etc/xray/vmess-$user-tls.json /etc/xray/vmess-$user-nontls.json

# Restart xray service
systemctl restart xray.service

clear
echo ""
echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m           • DELETED XRAY USER •             \e[0m"
echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
echo -e ""
echo -e "\e[96;1m Username  : $user  \e[0m"
echo -e "\e[96;1m Expired   : $exp   \e[0m"
echo -e ""
echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m                • TANILINK •                 \e[0m"
echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
