#!/bin/bash
clear
rm -rf upsc.sh
rm -rf upsc.sh.1
rm -rf upsc.sh.2
rm -rf /root/upsc.sh
rm -rf /root/upsc.sh.1
rm -rf /root/upsc.sh.2
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
clear
echo -e "   \e[41;97;1mUPDATE SCRIPT NEW VERSION\e[0m"
echo -e ""
# // Delete data Lama
cd /usr/bin
rm -rf menu
rm -rf dashboard
rm -rf menu-backup
rm -rf menu-ssh
rm -rf menu-trojan
rm -rf menu-vlesss
rm -rf menu-vmess
rm -rf menu-noobzvpns
rm -rf menu-ss
rm -rf menu-ipsec
rm -rf menu-udp
rm -rf menu-theme
rm -rf menu-udp
rm -rf addssh
rm -rf add-udp
rm -rf setting
rm -rf restart
rm -rf running
rm -rf system
rm -rf about
rm -rf upsc
rm -rf running
rm -rf menu-bot
rm -rf addhost
rm -rf mbackup
rm -rf mstrt
rm -rf usernew
rm -rf add-udp
rm -rf addhost
rm -rf genssl
rm -rf trial-generator
# // Download Data Baru
# // menu
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/dashboard.sh" && chmod +x /usr/bin/dashboard
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-ssh.sh" &&  chmod +x /usr/bin/menu-ssh
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/menu-ss "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/menu-noobzvpns "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-noobzvpns.sh" && chmod +x /usr/bin/menu-noobzvpns
wget -q -O /usr/bin/menu-udp "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-udp.sh" && chmod +x /usr/bin/menu-udp
wget -q -O /usr/bin/mbackup "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/backup/backup.sh" && chmod +x /usr/bin/mbackup
wget -q -O /usr/bin/menu-bot "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-bot.sh" && chmod +x /usr/bin/menu-bot
wget -q -O /usr/bin/trial-generator "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-generator.sh" && chmod +x /usr/bin/trial-generator
wget -q -O /usr/bin/menu-ipsec "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/ipsec/menu-ipsec.sh" && chmod +x /usr/bin/menu-ipsec
wget -q -O /usr/bin/system "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/system.sh" && chmod +x /usr/bin/system
wget -q -O /usr/bin/about "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/about.sh" &&  chmod +x /usr/bin/about
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/setting "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/setting.sh" && chmod +x /usr/bin/setting
wget -q -O /usr/bin/upsc "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/upsc.sh" && chmod +x /usr/bin/upsc
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/addhost  "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/addhost.sh" && chmod +x /usr/bin/addhost
wget -q -O /usr/bin/menu-theme "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/thema.sh" && chmod +x /usr/bin/menu-theme

wget -q -O /usr/bin/trial-generator "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-generator.sh" && chmod +x /usr/bin/trial-generator
wget -q -O /usr/bin/add-udp "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/add-udp.sh" && chmod +x /usr/bin/add-udp
wget -q -O /usr/bin/mstrt "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/backup/strt.sh" && chmod +x /usr/bin/mstrt
#wget -q -O /usr/bin/menu-udp "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-udp.sh" && chmod +x /usr/bin/menu-udp
#wget -q -O /usr/bin/menu-bot "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-bot.sh" && chmod +x /usr/bin/menu-bot
wget -q -O /usr/bin/genssl  "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/genssl.sh" && chmod +x /usr/bin/genssl
#wget -q -O /usr/bin/addhost "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/addhost.sh" && chmod +x /usr/bin/addhost
echo -e "sleep 3 "





echo -e "sleep 3 "
clear
echo -e "\e[32;1mSuccessfully\e[0m"
sleep 2
clear
dashboard
