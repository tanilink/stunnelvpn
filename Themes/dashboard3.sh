#!/bin/bash
# =========================================
clear
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2

nob=$(noobzvpns --info-all-user | grep -i "username" | wc -l)
noob=$(cat /etc/noobzvpns/.noobzvpns.db | grep "#nob#" | wc -l)

clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
#export RED='\033[0;31m'
#export GREEN='\033[0;36m'
#export YELLOW='\033[0;33m'
#export BLUE='\033[0;34m'
#export PURPLE='\033[0;35m'
#export CYAN='\033[0;35m'
#export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
#export EROR="[${RED} EROR \e[0m]"
#export INFO="[\e[34;1m INFO \e[0m]"
#export OKEY="[\e[37;1m OKEY \e[0m]"
#export PENDING="[\e[34;1m PENDING \e[0m]"
#export SEND="[\e[34;1m SEND \e[0m]"
#export RECEIVE="[\e[34;1m RECEIVE \e[0m]"

# // Export Align
#export BOLD="\e[1m"
#export WARNING="${RED}\e[5m"
#export UNDERLINE="\e[4m"

# // Exporting URL Host
#export Server_URL="autosc.me/aio"
#export Server_Port="443"
#export Server_IP="underfined"
#export Script_Mode="Stable"
#export Auther="XdrgVPN"
# Getting
#echo "sedang memverifkasi"
MYIP=$(wget -qO- ipinfo.io/ip);
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
echo -e ""
clear
    else
echo -e "\e[31manda di tolak!\e[0m"
    exit 
fi
}

if [ ! -e /tmp/trojan ]; then
  mkdir -p /tmp/trojan
fi

if [ ! -e /tmp/vmess ]; then
  mkdir -p /tmp/vmess
fi

if [ ! -e /tmp/vless ]; then
  mkdir -p /tmp/vless
fi

IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
#echo "status akun masih aktif"
CEKEXPIRED 
else
echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m"
exit 0
fi
# status
#rm -rf /root/status
#wget -q -O /root/status "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/statushariini" 
clear
today=`date -d "0 days" +"%Y-%m-%d"`
Exp2=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
if [ "$Exp2" == "lifetime" ]; then
    Exp2="2099-12-09"
fi
# CERTIFICATE STATUS
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
left=$(((d1 - d2) / 86400))


 
#rm cybervpn.zip
#rm -rf cybervpn.zip

datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 \e[0m Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}

systemctl restart fail2ban

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi
#tomem="$(free | awk '{print $2}' | head -2 | tail -n 1 )"
#usmem="$(free | awk '{print $3}' | head -2 | tail -n 1 )"
#cpu1="$(mpstat | awk '{print $4}' | head -4 |tail -n 1)"
#cpu2="$(mpstat | awk '{print $6}' | head -4 |tail -n 1)"

#update
#wget -q -O updatsc.sh "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/updateyes.sh" && chmod +x updatsc.sh && ./updatsc.sh 

# // Exporting IP Address
export MYIP=$( curl -s https://ipinfo.io/ip/ )
Name=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $2}')
Exp=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
clear
# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="\e[92;1mONLINE\e[0m"
else
    status_nginx="\e[91;1mOFLINE\e[0m"
fi
# // 
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="\e[92;1mONLINE\e[0m"
else
    status_xray="\e[91;1mOFLINE\e[0m"
fi

# // SSH Websocket Proxy
ssh=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_ssh="\e[92;1mONLINE\e[0m"
else
    status_ssh="\e[91;1mOFLINE\e[0m"
fi

## // ddos
dos=$( systemctl status ddos | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $dos == "running" ]]; then
    status_dos="\e[37;1m[\e[92;1mACTIVATED\e[37;1m]\e[0m"
else
    status_dos="\e[91;1mOFLINE\e[0m"
fi


## // fail2ban
fail2ban=$( systemctl status fail2ban | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $fail2ban == "running" ]]; then
    status_fail2ban="\e[92;1mONLINE\e[0m"
else
    status_fail2ban="\e[91;1mOFLINE\e[0m"
fi


## // net
netfilter=$( systemctl status netfilter-persistent | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $netfilter == "exited" ]]; then
    status_net="\e[92;1mONLINE\e[0m"
else
    status_net="\e[91;1mOFLINE\e[0m"
fi
#ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
#tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
#bot
clear
echo -e "\e[34;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[34;1m│ \E[41;37;1m                  °TANILINK°                    \E[0m \e[34;1m│\e[0m"
echo -e "\e[34;1m└──────────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m                     ${status_dos}                        \e[0m"
echo -e "\e[37;1m                     \e[37;1m $(((d1 - d2) / 86400))\e[35;1m.Left\e[0m"            
echo -e "\e[37;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[37;1m│•\e[31;1m Uptime:\e[32;1m $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "\e[37;1m│•\e[31;1m Time:\e[32;1m $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "\e[37;1m│•\e[31;1m Domain:\e[32;1m $( cat /etc/xray/domain )"
echo -e "\e[37;1m│•\e[31;1m Ns Domain:\e[32;1m $(cat /root/nsdomain)"
echo -e "\e[37;1m│•\e[31;1m Ipvps:\e[32;1m $(wget -qO- ipinfo.io/ip)"
echo -e "\e[37;1m│•\e[31;1m Isp:\e[32;1m $(curl -s ipinfo.io/org | cut -d " " -f 2-10 )\e[0m"
echo -e "\e[37;1m└──────────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[37;1m│\e[34;1m   SSH : ${status_ssh} \e[34;1m  XRAY : ${status_xray} \e[34;1m  NGINX : ${status_nginx}  \e[37;1m│\e[0m"
echo -e "\e[37;1m└──────────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m   \e[37mSSHOPENVPN : $ssh1  \e[37mSHADOWSOCKS : $ssa  \e[37mNOOBZVPN : $noob \e[0m"
echo -e "\e[37;1m           \e[37mVMESS : $vma  \e[37mVLESS : $vla  \e[37mTROJAN : $tra \e[0m"
echo -e "\e[37;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[37;1m│              \e[4;37mAcces\e[0m \e[4;37mUse\e[0m \e[4;32mMenu\e[0m \e[4;37mCommand\e[0m              \e[37;1m│\e[0m"
echo -e "\e[37;1m└──────────────────────────────────────────────────┘\e[0m"
echo -e "\e[35;1m"



