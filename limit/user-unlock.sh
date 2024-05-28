#!/bin/bash
# Uban User.
red='\e[31m'
green='\e[32m'
blue='\e[34m'
NC='\e[0m'
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m       UNLOCKED IN SSH ACC         \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " just Input Username To Unlock: " username
egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
# proses mengganti passwordnya
passwd -u $username
clear
  echo " ";
        echo " ";
        echo " ";
        echo " ";
        echo -e " \e[36m※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※
 ※                                 ※
 ※\e[0m   WELCOME MY SYSTEM TANILINK \e[36m※
 ※                                 ※
 ※\e[0m   \e[35mWhatsApp\e[0m    \e[36m:\e[0m \e[33m+6287704622943\e[0m    \e[36m※
 ※\e[0m   \e[35mTelegram\e[0m    \e[36m:\e[0m \e[33m@LunaticTunnel\e[0m      \e[36m※
 ※\e[0m   \e[35mInstagram\e[0m    \e[36m:\e[0m \e[33m@LunaticTunnel[0m      \e[36m※
  ※                                 ※
 ※\e[0m        \e[31m©\e[0m TANILINK™ \e[31m®\e[0m         \e[36m※
 ※                                 ※
 ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※ ※\e[0m";
        echo "
 ◎ Your Account Status ◎";
  echo " "
  echo -e "  \e[34m※\e[0m Username : ${blue}$username${NC}";
  echo -e "  \e[32m※\e[0m Status   : ${green}UNLOCKED${NC}";
  echo " ";
  echo " ★ POWER BY LT BACKEND";
  echo " ";
        echo " ";
        echo " ";
        echo " ";
else
echo "Username ${red}$username${NC} Does Not Exist ..!"
    exit 1
fi