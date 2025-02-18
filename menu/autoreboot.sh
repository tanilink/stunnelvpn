#!/bin/bash

# ==========================================
# Color Definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
NC='\e[0m'  # No Color

# Banner Status Information
EROR="[${RED} ERROR ${NC}]"
INFO="[${YELLOW} INFO ${NC}]"
OKEY="[${GREEN} OKEY ${NC}]"
PENDING="[${YELLOW} PENDING ${NC}]"
SEND="[${YELLOW} SEND ${NC}]"
RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# Align Information
BOLD="\e[1m"
WARNING="${RED}\e[5m"
UNDERLINE="\e[4m"

# Get public IP
MYIP=$(wget -qO- icanhazip.com)

# Checking VPS
echo "Checking VPS"
clear

# Creating reboot script if not exists
if [ ! -e /usr/bin/reboot ]; then
    echo '#!/bin/bash' > /usr/bin/reboot
    echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/bin/reboot
    echo 'waktu=$(date +"%T")' >> /usr/bin/reboot
    echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu." >> /root/log-reboot.txt' >> /usr/bin/reboot
    echo '/sbin/shutdown -r now' >> /usr/bin/reboot
    chmod +x /usr/bin/reboot
fi

# Menu
echo -e ""
echo -e "------------------------------------" | lolcat
echo -e "             AUTO REBOOT"
echo -e "------------------------------------" | lolcat
echo -e ""
echo -e "    1)  Auto Reboot 30 Minutes"
echo -e "    2)  Auto Reboot 1 Hour"
echo -e "    3)  Auto Reboot 12 Hours"
echo -e "    4)  Auto Reboot 24 Hours"
echo -e "    5)  Auto Reboot 1 Week"
echo -e "    6)  Auto Reboot 1 Month"
echo -e "    7)  Turn Off Auto Reboot"
echo -e ""
echo -e "------------------------------------" | lolcat
echo -e "    x)   MENU"
echo -e "------------------------------------" | lolcat
echo -e ""

# Validate input
while true; do
    read -p "     Please Input Number [1-7 or x] :  " autoreboot
    if [[ "$autoreboot" =~ ^[1-7x]$ ]]; then
        break
    else
        echo -e "${EROR} Please enter a valid number."
    fi
done

case $autoreboot in
1)
    echo "*/30 * * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 30 Minutes"
    ;;
2)
    echo "0 * * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 1 Hour"
    ;;
3)
    echo "0 */12 * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 12 Hours"
    ;;
4)
    echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 24 Hours"
    ;;
5)
    echo "0 0 */7 * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 1 Week"
    ;;
6)
    echo "0 0 1 * * root /usr/bin/reboot" > /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot : On\nAutoReboot Every : 1 Month"
    ;;
7)
    rm -f /etc/cron.d/auto_reboot
    echo "" > /root/log-reboot.txt
    echo -e "AutoReboot Turned Off"
    ;;
x)
    menu
    ;;
*)
    echo -e "${EROR} Invalid option."
    ;;
esac

# Restart cron service to apply changes
service cron reload >/dev/null 2>&1
service cron restart >/dev/null 2>&1

# Pause and go back to menu
read -n 1 -s -r -p "Press any key to return to menu"

menu
