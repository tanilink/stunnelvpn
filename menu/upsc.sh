#!/bin/bash
clear

# Hapus file upsc lama (di direktori saat ini dan /root)
rm -rf upsc.sh upsc.sh.1 upsc.sh.2 /root/upsc.sh /root/upsc.sh.1 /root/upsc.sh.2

# Ambil tanggal dari server Google (digunakan jika diperlukan)
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

########### WARNA ############
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
export RED GREEN YELLOW BLUE PURPLE CYAN LIGHT NC ungu='\033[0;35m'

# Tampilkan pesan update
clear
echo -e "   \e[41;97;1mUPDATE SCRIPT NEW VERSION\e[0m"
echo -e ""

# Hapus skrip lama di /usr/bin (hapus sekali saja, hindari duplikasi)
cd /usr/bin
rm -rf menu dashboard menu-backup menu-ssh menu-trojan menu-vlesss menu-vmess menu-noobzvpns menu-ss menu-ipsec menu-udp menu-theme addssh add-udp setting restart running system about upsc menu-bot addhost mbackup mstrt usernew genssl trial-generator

# Unduh skrip baru dari repository GitHub
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/dashboard "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/dashboard.sh" && chmod +x /usr/bin/dashboard
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-ssh.sh" && chmod +x /usr/bin/menu-ssh
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
wget -q -O /usr/bin/about "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/about.sh" && chmod +x /usr/bin/about
wget -q -O /usr/bin/running "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/running.sh" && chmod +x /usr/bin/running
wget -q -O /usr/bin/setting "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/setting.sh" && chmod +x /usr/bin/setting
wget -q -O /usr/bin/upsc "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/upsc.sh" && chmod +x /usr/bin/upsc
wget -q -O /usr/bin/restart "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/restart.sh" && chmod +x /usr/bin/restart
wget -q -O /usr/bin/addhost "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/addhost.sh" && chmod +x /usr/bin/addhost
wget -q -O /usr/bin/menu-theme "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/thema.sh" && chmod +x /usr/bin/menu-theme
wget -q -O /usr/bin/genssl "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/genssl.sh" && chmod +x /usr/bin/genssl

# Tampilkan pesan jeda selama 3 detik
echo -e "Menunggu 3 detik..."
sleep 3
clear

echo -e "\e[32;1mUpdate berhasil!\e[0m"
sleep 2
clear

# Jalankan dashboard
dashboard
