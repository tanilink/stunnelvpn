#!/bin/bash

# Define colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Create necessary directories
mkdir -p /root/folder

echo -e "${GREEN}Harap Bersabar Tuan${NC}"

# Download status and version files
wget -q -O /root/status "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/statushariini"
wget -q -O /etc/version "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/versiupdate" && chmod +x /etc/version

# Download and install scripts
declare -A scripts=(
    ["/usr/bin/menu"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu.sh"
    ["/usr/bin/delv2ray"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/delv2ray.sh"
    ["/usr/bin/autoreboot"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/autoreboot.sh"
    ["/usr/bin/restart"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/restart.sh"
    ["/usr/bin/tendang"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/tendang.sh"
    ["/usr/bin/clearlog"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/clearlog.sh"
    ["/usr/bin/running"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/running.sh"
    ["/usr/bin/cek-trafik"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/cek-trafik.sh"
    ["/usr/bin/cek-speed"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/speedtes_cli.py"
    ["/usr/bin/cek-bandwidth"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/cek-bandwidth.sh"
    ["/usr/bin/cek-ram"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/ram.sh"
    ["/usr/bin/limit-speed"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/limit-speed.sh"
    ["/usr/bin/menu-bot"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-bot.sh"
    ["/usr/bin/stopbot"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/stopbot.sh"
    ["/usr/bin/menu-theme"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/thema.sh"
    ["/usr/bin/about"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/about.sh"
    ["/usr/bin/upsc"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/upsc.sh"
    ["/usr/bin/menu-ss"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-ss.sh"
    ["/usr/bin/menu-vless"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-vless.sh"
    ["/usr/bin/menu-vmess"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-vmess.sh"
    ["/usr/bin/menu-trojan"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-trojan.sh"
    ["/usr/bin/menu-ssh"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-ssh.sh"
    ["/usr/bin/menu-bckp"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/menu-bckp-github.sh"
    ["/usr/bin/usernew"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/usernew.sh"
    ["/usr/bin/wbm"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/webmin.sh"
    ["/usr/bin/changer"]="https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/minacantik/changer.sh"
    ["/usr/bin/addhost"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/addhost.sh"
    ["/usr/bin/genssl"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/genssl.sh"
    ["/usr/bin/fix"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/cf.sh"
    ["/etc/cyber.site"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/cyber.site"
    ["/root/versi"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/versiupdate"
    ["/usr/bin/menu-backup"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-backup.sh"
    ["/usr/bin/setting"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Themes/setting.sh"
    ["/usr/bin/menu-ipsec"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/ipsec/menu-ipsec.sh"
    ["/usr/bin/trial"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial.sh"
    ["/usr/bin/trial-vmess"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-vmess.sh"
    ["/usr/bin/trial-trojan"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-trojan.sh"
    ["/usr/bin/trial-udp"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-udp.sh"
    ["/usr/bin/trial-vless"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-vless.sh"
    ["/usr/bin/menu-trial"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/trial/trial-generator.sh"
    ["/usr/bin/addudp"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/addssh.sh"
    ["/usr/bin/menu-udp"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-udp.sh"
    ["/usr/bin/autokill"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/autokill.sh"
    ["/usr/bin/bot"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Finaleuy/bot.sh"
    ["/root/chat"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/Finaleuy/chatid.sh"
    ["/usr/bin/limitvmess"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/limitvmess.sh"
    ["/usr/bin/limitvless"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/limitvless.sh"
    ["/usr/bin/limittrojan"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/limittrojan.sh"
    ["/usr/bin/sistem"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/sistem.sh"
    ["/etc/crontab"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/crontab"
    ["/usr/bin/cftn"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/cftn.sh"
    ["/usr/bin/infosc"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/info.sh"
    ["/usr/bin/limitipxray"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/limitipxray.py"
    ["/usr/bin/menu-noobzvpns"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/menu-noobzvpns.sh"
    ["/usr/bin/service-trial"]="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/menu/service-trial.sh"
)

for script in "${!scripts[@]}"; do
    wget -q -O "$script" "${scripts[$script]}" && chmod +x "$script"
done

# Install necessary packages
apt-get update -y
apt-get install -y curl python3-pip wondershaper squid

# Install speedtest-cli
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
apt-get install -y speedtest

# Install additional Python packages
pip3 install speedtest-cli

# Create necessary directories
mkdir -p /etc/cybervpn/limit/{vmess,vless,trojan,ssh,noobs,shadowsocks}/ip/
mkdir -p /etc/noobzvpns
touch /etc/noobzvpns/.noobzvpns.db
echo "& plughin Account" >> /etc/noobzvpns/.noobzvpns.db

# Set permissions
chmod 777 /root/chat /usr/bin/bot /usr/bin/tendang /usr/bin/autokill /usr/bin/menu-ssh /usr/bin/addudp /usr/bin/udp
chmod +x /usr/bin/{menu,menu-theme,upsc,about,usernew,autoreboot,addhost,genssl,restart,tendang,clearlog,running,cek-trafik,cek-speed,cek-bandwidth,cek-ram,limit-speed,menu-vless,menu-vmess,delvray,menu-ss,updatsc,thema,menu-bot,menu-udp,stopbot,menu-backup,autobackup,upsc,strt,menu-trojan,menu-ssh,menu-bckp,menu,menu1,menu-backup,wbm,xp,changer,fix,setting,menu-ipsec,trial,menu-theme}

# Clean up
rm -f set-br.sh

echo -e "${GREEN}Installation completed successfully!${NC}"
