#!/bin/bash
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m           L2TP MANAGER            \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [1] Create New account L2TP"
echo -e "\e[37;1m [2] Delete L2TP account"
echo -e "\e[37;1m [3] Renew L2TP account \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m           PPTP MANAGER            \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [4] Create new account PPTP"
echo -e "\e[37;1m [5] Delete PPTP account"
echo -e "\e[37;1m [6] Renew PPTP account \e[0m"
echo -e "\e[31;1m [7] GO BACK \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p    "  Just Input : " bro


if [ $bro = 1 ] || [ $bro = 1 ]
then
addl2tp
fi
if [ $bro = 2 ] || [ $bro = 2 ]
then
clear
dell2tp
fi
if [ $bro = 3 ] || [ $bro = 3 ]
then
clear
renewl2tp
fi
if [ $bro = 4 ] || [ $bro = 4 ]
then
clear
addpptp
fi
if [ $bro = 5 ] || [ $bro = 5 ]
then
clear
delpptp
fi
if [ $bro = 6 ] || [ $bro = 6 ]
then
clear
renewpptp
fi
if [ $bro = 7 ] || [ $bro = 7 ]
then
clear
dashboard
fi
