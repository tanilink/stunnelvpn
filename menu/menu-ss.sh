#!/bin/bash

# Get the date from the server
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

# Color code definitions
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

# Function to check and clean expired users
BURIQ () {
    curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS > /root/tmp
    data=( $(cat /root/tmp | grep -E "^### " | awk '{print $2}') )
    
    for user in "${data[@]}"; do
        exp=$(grep -E "^### $user" "/root/tmp" | awk '{print $3}')
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$biji" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        
        if [[ "$exp2" -le "0" ]]; then
            echo $user > /etc/.$user.ini
        else
            rm -f /etc/.$user.ini > /dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

# Checking IP and permission
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
    
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}

# Functions for adding, renewing, and deleting users
addssws(){
    clear
    domain=$(cat /etc/xray/domain)

    echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$GREEN│${NC}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
    echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
    echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"

    tls=$(grep -w "Sodosok WS/GRPC" ~/log-install.txt | cut -d: -f2 | sed 's/ //g')

    until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
        read -rp "   Input Username : " -e user
        if [ -z $user ]; then
            echo -e "$GREEN│${NC} [Error] Username cannot be empty "
            echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
            echo
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
        CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

        if [[ ${CLIENT_EXISTS} == '1' ]]; then
            clear
            echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
            echo -e "$GREEN│${NC}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
            echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
            echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
            echo -e "$GREEN│${NC} Please choose another name."
            echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
            echo
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu-ss
        fi
    done

    cipher="aes-128-gcm"
    uuid=$(cat /proc/sys/kernel/random/uuid)
    read -p "   Expired (days): " masaaktif
    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")

    # Add user to config
    sed -i '/#ssws$/a\## '"$user $exp"'\
    },{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json
    sed -i '/#ssgrpc$/a\## '"$user $exp"'\
    },{"password": "'""$uuid""'","method": "'""$cipher""'","email": "'""$user""'"' /etc/xray/config.json

    # Restart services and clear temp files
    systemctl restart xray
    rm -rf /tmp/log /tmp/log1

    # Generate links and config files
    shadowsocks_base64=$(cat /tmp/log)
    shadowsocks_base64e=$(cat /tmp/log1)
    shadowsockslink="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;path=/ss-ws;host=$domain;tls#${user}"
    shadowsockslink1="ss://${shadowsocks_base64e}@$domain:$tls?plugin=xray-plugin;mux=0;serviceName=ss-grpc;host=$domain;tls#${user}"

    # Output user info
    cat > /home/vps/public_html/ss-ws/ss-$user.txt <<-END
    # sodosok ws
    {
    "dns": {
       "servers": [
         "8.8.8.8",
         "8.8.4.4"
       ]
     },
     ...
    }

    # SODOSOK grpc
    {
    "dns": {
       "servers": [
         "8.8.8.8",
         "8.8.4.4"
       ]
     },
     ...
    }
    END
    systemctl restart xray > /dev/null 2>&1
    service cron restart > /dev/null 2>&1
    clear
    echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$GREEN│${NC}             • CREATE SSWS USER •              ${NC} $COLOR1│$NC"
    echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
    echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1 ${NC} Remarks     : ${user}"
    echo -e "$COLOR1 ${NC} Expired On  : $exp"
    echo -e "$COLOR1 ${NC} Domain      : ${domain}"
    echo -e "$COLOR1 ${NC} Port TLS    : ${tls}"
    echo -e "$COLOR1 ${NC} Port  GRPC  : ${tls}"
    echo -e "$COLOR1 ${NC} Password    : ${uuid}"
    echo -e "$COLOR1 ${NC} Cipers      : aes-128-gcm"
    echo -e "$COLOR1 ${NC} Network     : ws/grpc"
    echo -e "$COLOR1 ${NC} Path        : /ss-ws"
    echo -e "$COLOR1 ${NC} ServiceName : ss-grpc"
    echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
    echo -e "$GREEN┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1 ${NC} Link TLS : "
    echo -e "$COLOR1 ${NC} ${shadowsockslink}"
    echo -e "$COLOR1 ${NC} "
    echo -e "$COLOR1 ${NC} Link GRPC : "
    echo -e "$COLOR1 ${NC} ${shadowsockslink1}"
    echo -e "$COLOR1 ${NC} "
    echo -e "$COLOR1 ${NC} Link JSON : http://${domain}:81/ss-ws/ss-$user.txt"
    echo -e "$GREEN└─────────────────────────────────────────────────┘${NC}"
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-ss
}
