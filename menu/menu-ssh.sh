# Color variables
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White Underline

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

# Functions to display colored text
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# Export variables for message formatting
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
export EROR="[${RED} ERROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# Server information
export Server_URL="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/"
export Server1_URL="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/"
export Server_Port="443"
export Server_IP="undefined"
export Script_Mode="Stable"
export Author=".geovpn"

# Download scripts and set permissions
wget -q -O /usr/bin/lock "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/user-lock.sh" && chmod 777 /usr/bin/lock
wget -q -O /usr/bin/unlock "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/user-unlock.sh" && chmod 777 /usr/bin/unlock

# Check for root privileges
if [ "${EUID}" -ne 0 ]; then
  echo -e "${EROR} Please Run This Script As Root User!"
  exit 1
fi

# Get public IP and network interface
export IP=$( curl -s https://ipinfo.io/ip/ )
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"
clear

# Function to delete SSH account
function del() {
  clear
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\e[44;97;1m        DELETE SSH ACCOUNT          \e[0m"
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  read -p "Just Input Username To Delete: " Pengguna

  if getent passwd $Pengguna > /dev/null 2>&1; then
    userdel $Pengguna > /dev/null 2>&1
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m        TANILINK TUNNELING           \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[96;1m Username   : $Pengguna"
    echo -e "\e[96;1m Status     : REVOKE !!"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  else
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m         FAILURE IS DATA           \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[96;1m Username : $Pengguna"
    echo -e "\e[96;1m Status   : FAILURE!!"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  fi
  read -n 1 -s -r -p "Press any key to back on menu"
  menu
}

# Other functions can be similarly cleaned up

