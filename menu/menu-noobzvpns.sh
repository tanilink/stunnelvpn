# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

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
export ERROR="[${RED} ERROR ${NC}]"
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
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="undefined"
export Script_Mode="Stable"
export Author="XdrgVPN"

# status
rm -rf /root/status
wget -q -O /root/status "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/statushariini"

function create(){
  clear
  echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
  echo -e "\e[33;1m│\e[44;97;1m        • CREATE TITLE NOOBZVPNS •            \e[0m"
  echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
  echo ""
  read -p "  Username  : " user
  echo ""
  read -p "  Password  : " pass
  echo ""
  read -p "  Expiry in : " exp
  echo ""
  read -p "  Limit ip  : " ip

  if [ ! -e /etc/cybervpn/limit/noobs/ip/ ]; then
    mkdir -p /etc/cybervpn/limit/noobs/ip/
  fi
  echo "$ip" > /etc/cybervpn/limit/noobs/ip/$user

  noobzvpns --add-user $user $pass --expired-user $user $exp

  clear
  echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
  echo -e "\e[33;1m│\e[44;97;1m            • NOOBZVPNS ACCOUNT •              \e[0m"
  echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
  echo -e " DOMAIN      : $( cat /etc/xray/domain )"
  echo -e " USERNAME    : $user"
  echo -e " PASSWORD    : $pass"
  echo -e " IP LIMIT    : $ip"
  echo -e " EXP DAYS    : $exp DAYS"
  echo -e " tcp_std port:  8080"
  echo -e " tcp_ssl port: 8443"
  echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
  echo -e "\e[35;1m PORT 8080 \e[0m"
  echo -e "Encrypted key (Port 8080): <some key>"
  echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
}

function remove(){
  clear
  echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
  echo -e "\e[33;1m│\e[44;97;1m            • REMOVE NOOBZ USER •             \e[0m"
  echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
  
  read -p "Apakah Anda ingin menghapus semua user? (Y/N): " choice
  case $choice in
    [Yy]*)
      echo "MENGHAPUS SEMUA USER!"
      noobzvpns --remove-all-user
      ;;
    [Nn]*)
      echo "Membatalkan penghapusan."
      menu-noobzvpns
      ;;
    *)
      echo "Pilihan tidak valid."
      ;;
  esac
  clear
  echo -e "\e[33;1m┌─────────────────────────────────────────────────┐\e[0m"
  echo -e "\e[33;1m│\e[44;97;1m         • SUCCESFULLY REMOVED •             \e[0m"
  echo -e "\e[33;1m└─────────────────────────────────────────────────┘\e[0m"
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
  echo -e "\e[44;97;1m              TANILINK             \e[0m"
  echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
}

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m           NOOBZ LIBEV             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • ADDEDD NOOBZVPNS \e[0m"
echo -e "\e[37;1m [02] • DELETE NO0BZVPNS \e[0m"
echo -e "\e[37;1m [03] • RENEWS NOOBZVPNS \e[0m"
echo -e "\e[37;1m [04] • LOCKED NOOBZVPNS \e[0m"
echo -e "\e[37;1m [05] • UNLOCK NO0BZVPNS \e[0m"
echo -e "\e[37;1m [06] • SHOWED NOOBZVPNS \e[0m"
echo -e "\e[37;1m [07] • REMOVE NOOBZVPNS \e[0m"
echo -e "\e[31;1m [00] • GO BACK          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -p " Just Input :  "  opt
case $opt in
  01 | 1) create ;;
  02 | 2) delete ;;
  03 | 3) renew ;;
  04 | 4) lock ;;
  05 | 5) unlock ;;
  06 | 6) show ;;
  07 | 7) remove ;;
  00 | 0) menu ;;
  *) dashboard ;;
esac
