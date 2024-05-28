#!/bin/bash
clear
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"


GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
# Getting
# IP Validation
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

MYIP=$(curl -sS ipinfo.io/ip)

red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
clear

# GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID

# VPS ISP INFORMATION
#ITAM='\033[0;30m'
echo -e "$ITAM"
REGION=$( curl -s ipinfo.io/region )
#clear
#COUNTRY=$( curl -s ipinfo.io/country )
#clear
#WAKTU=$( curl -s ipinfo.ip/timezone )
#clear
CITY=$( curl -s ipinfo.io/city )
#clear
#REGION=$( curl -s ipinfo.io/region )
#clear

# CHEK STATUS 
#openvpn_service="$(systemctl show openvpn.service --no-page)"
#oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)

status_tor=$(systemctl status tor | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)



status_ddos=$(systemctl status ddos | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)


status_openvpn=$(systemctl status openvpn | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)


status_udpcustom=$(systemctl status udp-custom | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)


status_bot=$(systemctl status cybervpn | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)


status_noob=$(systemctl status noobzvpns | grep active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)


#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"

#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)

#sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 

#ssh_status=$(systemctl status shadowsocks-libev-server@http | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status="$(systemctl show shadowsocks-libev.service --no-page)"
#status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#trojangfw_server=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel4 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
squid_service=$(systemctl status squid | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wg="$(systemctl show wg-quick@wg0.service --no-page)"
#swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
trgo="$(systemctl show trojan-go.service --no-page)"                                      
strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  
#sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

wstls=$(systemctl status ws-stunnel.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

wsdrop=$(systemctl status ws-dropbear.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

#wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsopen=$(systemctl status ws-openssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE OPENVPN
if [[ $status_openvpn == "exited" ]]; then
  status_vpn=" ${GREEN}[ON]"
else
  status_vpn="${RED}[OF]"
fi



# STATUS SERVICE TOR
if [[ $status_tor == "exited" ]]; then
  status_tor=" ${GREEN}[ON]"
else
  status_tor="${RED}[OF]"
fi



# STATUS SERVICE ANTI DDOS
if [[ $status_ddos == "running" ]]; then
  status_ddos=" ${GREEN}[ON]"
else
  status_ddos="${RED}[OF]"
fi




# STATUS SERVICE UDP
if [[ $status_udpcustom == "running" ]]; then
  status_udpcustom=" ${GREEN}[ON]"
else
  status_udpcustom="${RED}[OF]"
fi



# STATUS SERVICE BOT PANEL
if [[ $status_bot == "running" ]]; then
  status_bot=" ${GREEN}[ON]"
else
  status_bot="${RED}[OF]"
fi



# STATUS SERVICE noobzvpns
if [[ $status_noob == "running" ]]; then
  status_noob=" ${GREEN}[ON]"
else
  status_noob="${RED}[OF]"
fi




# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}[ON]"
else
   status_ssh="${RED}[OF]"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}[ON]"
else
   status_squid="${RED}[OF]"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${GREEN}[ON]"
else
   status_vnstat="${RED}[OF]"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}[ON]"
else
   status_cron="${RED}[OF]"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${GREEN}[ON]"
else
   status_fail2ban="${RED}[OF]"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray=" ${GREEN}[ON]\e[0m"
else
   status_tls_v2ray="${RED}[OF]\e[0m"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   status_nontls_v2ray=" ${GREEN}[ON]${NC}"
else
   status_nontls_v2ray="${RED}[OF]${NC}"
fi

# STATUS SERVICE VLESS HTTPS
if [[ $vless_tls_v2ray_status == "running" ]]; then
  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_vless="${RED}[OF]${NC}"
fi

# STATUS SERVICE VLESS HTTP
if [[ $vless_nontls_v2ray_status == "running" ]]; then
  status_nontls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_nontls_vless="${RED}[OF]${NC}"
fi
# STATUS SERVICE TROJAN
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan=" ${GREEN}[ON]${NC}"
else
   status_virus_trojan="${RED}[OF]${NC}"
fi
# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trgo=" ${GREEN}[ON]${NC}"
else
  status_trgo="${RED}[OF]${NC}"
fi
# STATUS SERVICE TROJAN GFW
if [[ $trojangfw_server == "running" ]]; then 
   status_virus_trojangfw=" ${GREEN}[ON]${NC}"
else
   status_virus_trojangfw="${RED}[OF]${NC}"
fi
# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${GREEN}[ON]${NC}"
else
   status_beruangjatuh="${RED}[OF]${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel=" ${GREEN}[ON]${NC}"
else
   status_stunnel="${RED}[OF]${NC}"
fi
# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   shdroptls=" ${GREEN}[ON]${NC}"
else
   shdroptls="${RED}[OF]${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   shdrophttp=" ${GREEN}[ON]${NC}"
else
   dropbear_status="${RED}[OF]${NC}"
fi

# TOTAL RAM
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))

# KERNEL TERBARU
kernelku=$(uname -r)
Domen="$(cat /etc/xray/domain)"
# // Loading Animasi
# // jalankan perintah sleep 0.8 & loading $!
loading() {
  local pid=$1
  local delay=0.1
  local spin='-\|/'

  while ps -p $pid > /dev/null; do
    local temp=${spin#?}
    printf "[%c] " "$spin"
    local spin=$temp${spin%"$temp"}
    sleep $delay
    printf "\b\b\b\b\b\b"
  done

  printf "    \b\b\b\b"
}

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "🌎 \e[37;1mSSH             : $status_ssh"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mXRAY            : $status_tls_v2ray"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mNOOBZVPNS       : $status_noob"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mUDP CUSTOM      : $status_udpcustom"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mOpenVPN         : $status_vpn"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mSLOWDNS         : $shdrophttp"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mDropbear        : $status_beruangjatuh"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mStunnel4        : $status_stunnel"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mSquid           : $status_squid"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mFail2Ban        : $status_fail2ban"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mCrons           : $status_cron"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mVnstat          : $status_vnstat"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mANTI DDOS       : $status_ddos"
sleep 0.8 & loading $!
echo -e "🌎 \e[37;1mBOT PANEL       : $status_bot"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

menu
