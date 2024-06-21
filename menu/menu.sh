#!/bin/bash
# // Exporting Language to UTF-8

# status
#rm -rf /root/status
#wget -q -O /root/status "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/statushariini"


clear
echo -e "\e[33;1m┌───────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m              • PROTOCOL MANAGER •             \e[0m\e[33;1m│"             
echo -e "\e[33;1m└───────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m[01]• MENU SSH WEBSOCKET"
echo -e "\e[37;1m[02]• MENU SSH UDP"
echo -e "\e[37;1m[03]• MENU XRAY VMESS"
echo -e "\e[37;1m[04]• MENU XRAY VLESS"
echo -e "\e[37;1m[05]• MENU SHADOWSOCKS"
echo -e "\e[37;1m[06]• MENU TROJAN"
echo -e "\e[37;1m[07]• MENU NOOBZVPNS \e[0m"
echo -e "\e[37;1m[08]• MENU PPTP & L2TP"
echo -e "\e[37;1m[09]• MENU TRIALL"
echo -e "\e[37;1m[10]• MENU BACKUP VPS"
echo -e "\e[33;1m┌───────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m              • BOT TELEGRAM FTR •             \e[0m\e[33;1m│"             
echo -e "\e[33;1m└───────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m[11]• BOT TELE"
echo -e "\e[37;1m[12]• BOT CHANGE"
echo -e "\e[33;1m┌───────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m             • FEATURES VPS SRVC •             \e[0m\e[33;1m│"             
echo -e "\e[33;1m└───────────────────────────────────────────────┘\e[0m"
echo -e "\e[37;1m[13]• FIX UDP CSTM \e[0m"
echo -e "\e[37;1m[14]• RUNNING SRVC \e[0m"
echo -e "\e[37;1m[15]• RESTART SRVC \e[0m"
echo -e "\e[37;1m[16]• UBAH TAMPILAN MENU \e[0m"
echo -e "\e[33;1m┌───────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m         • FEATURES ABOUT TERMINAL •           \e[0m\e[33;1m│"             
echo -e "\e[33;1m└───────────────────────────────────────────────┘\e[0m"
echo -e "\e[31;1m[xx]• GO BACK  \e[0m"
echo -e "\e[31;1m[00]• ABOUT    \e[0m"
echo -e "\e[31;1m[77]• SETTINGS \e[0m"
echo -e "\e[31;1m[88]• UPDATE SC\e[0m"
echo -e "\e[33;1m┌───────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[44;97;1m      •  TaniLink  •         \e[0m\e[33;1m│"             
echo -e "\e[33;1m└───────────────────────────────────────────────┘\e[0m"
echo -e ""
read -p " Just Input : " opt
echo -e ""
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; menu-udp ;;
03 | 3) clear ; menu-vmess ;;
04 | 4) clear ; menu-vless ;;
05 | 5) clear ; menu-ss ;;
06 | 6) clear ; menu-trojan ;;
07 | 7) clear ; menu-noobzvpns ;;
08 | 8) clear ; menu-ipsec ;;
09 | 9) clear ; menu-trial ;;
10) clear ; menu-backup ;;
11) clear ; menu-bot ;;
12) clear ; bash /root/chat ;; # ganti chatid tele
13) clear ; curl "https://raw.githubusercontent.com/Azigaming404/Autoscript-by-azi/main/udp/udp-custom.sh" | bash ;;
14) clear ; running ;;
15) clear ; restart ;;
16) clear ; menu-theme ;;
00) clear ; about ;;
77) clear ; setting ;;
88) clear ; upsc ;;
*) clear ; dashboard ;;
esac

