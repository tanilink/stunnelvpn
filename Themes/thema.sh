#!/bin/bash
clear
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
blue='\033[0;34m'
ungu='\033[0;35m'
Green="\033[32m"
Red="\033[31m"
WhiteB="\e[5;37m"
BlueCyan="\e[5;36m"
Green_background="\033[42;37m"
Red_background="\033[41;37m"
Suffix="\033[0m"
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          THEMES FEATURES          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [1]• ( DEFAULT )       \e[0m"
echo -e "\e[37;1m [2]• Red x white x blue\e[0m"
echo -e "\e[37;1m [3]• Dragon x PURPLE   \e[0m"
echo -e "\e[37;1m [4]• White x Red Spark \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m            TANILINK               \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Just input :  " bro


if [ $bro = 1 ] || [ $bro = 1 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/dashboard.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi
if [ $bro = 2 ] || [ $bro = 2 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/dashboard1.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi
if [ $bro = 3 ] || [ $bro = 3 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/dashboard2.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi
if [ $bro = 4 ] || [ $bro = 4 ]
then
rm -rf /usr/bin/dashboard
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/dashboard3.sh" && chmod 777 /usr/bin/dashboard
dashboard
fi

