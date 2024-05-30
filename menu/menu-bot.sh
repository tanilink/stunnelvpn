#!/bin/bash
clear
#nano /root/cybervpn/var.txt
REDDD="\e[91;1m"
GREEN="\e[92;1m"
NC="\e[0m"
# // status Bot Telegram
cybervpn_service=$(systemctl status cybervpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $cybervpn_service == "running" ]]; then 
   status_cybervpn="${GREEN}[ON]${NC}"
else
   status_cybervpn="${REDDD}[OF]${NC}"
fi

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m            BOT LIBEV              \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[95m        STATUS BOT TELEGRAM  :\e[0m ${status_cybervpn}" 
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • CREATE BOT TELEGRAM    \e[0m"
echo -e "\e[37;1m [02] • STOPED BOT TELEGRAM    \e[0m"
echo -e "\e[37;1m [03] • RESTAR BOT TELEGRAM    \e[0m"
echo -e "\e[37;1m [04] • CREATE BOT NOTIFIKASI  \e[0m"
echo -e "\e[31;1m [00] • GO BACK    \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just Input :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; rm -rf bot.sh && wget https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/botssh/bot.sh && chmod 777 bot.sh && ./bot.sh && systemctl restart cybervpn ;;
02 | 2) clear ; systemctl stop cybervpn ;;
03 | 3) clear ; systemctl start cybervpn  ;;
04 | 4) clear ; chatid ;;
00 | 0) clear ; menu ;;
*) clear ; dashboard ;;
esac
