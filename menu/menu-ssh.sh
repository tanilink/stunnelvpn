#!/bin/bash
# DEFINISI WARNA
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # Underlined White
On_IPurple='\033[0;105m'  

On_IRed='\033[0;101m'
IBlack='\033[0;90m'
IRed='\033[0;91m'
IGreen='\033[0;92m'
IYellow='\033[0;93m'
IBlue='\033[0;94m'
IPurple='\033[0;95m'
ICyan='\033[0;96m'
IWhite='\033[0;97m'
NC='\e[0m'

# Fungsi output berwarna
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red()   { echo -e "\\033[31;1m${*}\\033[0m"; }

# EXPORT WARNA UNTUK CEPAT
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# KONFIGURASI SERVER
export Server_URL="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/"
export Server1_URL="https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/"
export Server_Port="443"
export Server_IP="undefined"
export Script_Mode="Stable"
export Auther=".geovpn"

# UNDUH SCRIPT LOCK/UNLOCK
wget -q -O /usr/bin/lock "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/user-lock.sh" && chmod 777 /usr/bin/lock
wget -q -O /usr/bin/unlock "https://raw.githubusercontent.com/tanilink/stunnelvpn/momok/limit/user-unlock.sh" && chmod 777 /usr/bin/unlock

# CEK HAK AKSES ROOT
if [ "${EUID}" -ne 0 ]; then
    echo -e "${EROR} Please run this script as root user!"
    exit 1
fi

export IP=$(curl -s https://ipinfo.io/ip/)
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"
clear

# =================== FUNGSI DELETE SSH ===================
function del(){
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m        DELETE SSH ACCOUNT          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -p "Just Input Username To Delete: " Pengguna
    if getent passwd "$Pengguna" > /dev/null 2>&1; then
        userdel "$Pengguna" > /dev/null 2>&1
        clear
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;97;1m        LUNATIC TUNNELING           \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        echo -e "\e[96;1m Username   : $Pengguna "
        echo -e "\e[96;1m Status     : REVOKE !! "
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    else
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;91;1m         FAILURE IS DATA           \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        echo -e "\e[96;1m Username : $Pengguna "
        echo -e "\e[96;1m Status   : FAILURE!! "
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    fi
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI AUTO DELETE USER EXPIRED ===================
function autodel(){
    clear
    hariini=$(date +%d-%m-%Y)
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m               AUTO DELETE                \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "Thank you for removing the EXPIRED USERS"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    cat /etc/shadow | cut -d: -f1,8 | sed '/:$/d' > /tmp/expirelist.txt
    totalaccounts=$(wc -l < /tmp/expirelist.txt)
    for (( i=1; i<=totalaccounts; i++ )); do
        tuserval=$(head -n $i /tmp/expirelist.txt | tail -n 1)
        username=$(echo "$tuserval" | cut -f1 -d:)
        userexp=$(echo "$tuserval" | cut -f2 -d:)
        userexpireinseconds=$(( userexp * 86400 ))
        tglexp=$(date -d @"$userexpireinseconds")
        tgl=$(echo "$tglexp" | awk '{print $3}')
        while [ ${#tgl} -lt 2 ]; do
            tgl="0$tgl"
        done
        while [ ${#username} -lt 15 ]; do
            username="${username} "
        done
        bulantahun=$(echo "$tglexp" | awk '{print $2,$6}')
        echo "echo \"Expired- User : $username Expire at : $tgl $bulantahun\"" >> /usr/local/bin/alluser
        todaystime=$(date +%s)
        if [ "$userexpireinseconds" -ge "$todaystime" ]; then
            :
        else
            echo "echo \"Expired- Username : $username are expired at: $tgl $bulantahun and removed : $hariini\"" >> /usr/local/bin/deleteduser
            echo "Username $username that are expired at $tgl $bulantahun removed from the VPS $hariini"
            userdel "$username"
        fi
    done
    echo " "
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m        LUNATIC TUNNELING          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI CEK MULTILOGIN SSH ===================
function ceklim(){
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m       CHECK MULTILOGIN SSH          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    if [ -e "/root/log-limit.txt" ]; then
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "User Who Violate The Maximum Limit"
        echo "Time - Username - Number of Multilogin"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        cat /root/log-limit.txt
    else
        echo "No user has committed a violation"
        echo ""
        echo "or"
        echo ""
        echo "The user-limit script has not been executed."
    fi
    echo ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI CEK LOGIN SSH (Dropbear & OpenSSH) ===================
function cek(){
    if [ -e "/var/log/auth.log" ]; then
        LOG="/var/log/auth.log"
    elif [ -e "/var/log/secure" ]; then
        LOG="/var/log/secure"
    fi
    data=( $(ps aux | grep -i dropbear | awk '{print $2}') )
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m         Dropbear User Login       \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "ID  |  Username  |  IP Address"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    grep -i "Password auth succeeded" "$LOG" | grep -i dropbear > /tmp/login-db.txt
    for PID in "${data[@]}"; do
        grep "dropbear\[$PID\]" /tmp/login-db.txt > /tmp/login-db-pid.txt
        NUM=$(wc -l < /tmp/login-db-pid.txt)
        USER=$(awk '{print $10}' /tmp/login-db-pid.txt)
        IP=$(awk '{print $12}' /tmp/login-db-pid.txt)
        if [ "$NUM" -eq 1 ]; then
            echo "$PID - $USER - $IP"
        fi
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    done
    echo ""
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m          OpenSSH User Login       \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "ID  |  Username  |  IP Address"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    grep -i "Accepted password for" "$LOG" > /tmp/login-db.txt
    data=( $(ps aux | grep "\[priv\]" | sort -k 72 | awk '{print $2}') )
    for PID in "${data[@]}"; do
        grep "sshd\[$PID\]" /tmp/login-db.txt > /tmp/login-db-pid.txt
        NUM=$(wc -l < /tmp/login-db-pid.txt)
        USER=$(awk '{print $9}' /tmp/login-db-pid.txt)
        IP=$(awk '{print $11}' /tmp/login-db-pid.txt)
        if [ "$NUM" -eq 1 ]; then
            echo "$PID - $USER - $IP"
        fi
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    done
    if [ -f "/etc/openvpn/server/openvpn-tcp.log" ]; then
        echo ""
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[0;41;36m          OpenVPN TCP User Login         \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "Username  |  IP Address  |  Connected Since"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-tcp.log | \
          cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-tcp.txt
        cat /tmp/vpn-login-tcp.txt
    fi
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    if [ -f "/etc/openvpn/server/openvpn-udp.log" ]; then
        echo ""
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\E[0;41;36m          OpenVPN UDP User Login         \E[0m"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo "Username  |  IP Address  |  Connected Since"
        echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        grep -w "^CLIENT_LIST" /etc/openvpn/server/openvpn-udp.log | \
          cut -d ',' -f 2,3,8 | sed -e 's/,/      /g' > /tmp/vpn-login-udp.txt
        cat /tmp/vpn-login-udp.txt
    fi
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    rm -f /tmp/login-db-pid.txt /tmp/login-db.txt /tmp/vpn-login-tcp.txt /tmp/vpn-login-udp.txt
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI LIHAT MEMBER SSH ===================
function member(){
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m       SSH MEMBER ACCOUNT          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "USERNAME          EXP DATE          STATUS"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    while read expired; do
        AKUN=$(echo "$expired" | cut -d: -f1)
        ID=$(echo "$expired" | grep -v nobody | cut -d: -f3)
        exp=$(chage -l "$AKUN" | grep "Account expires" | awk -F": " '{print $2}')
        status=$(passwd -S "$AKUN" | awk '{print $2}')
        if [[ $ID -ge 1000 ]]; then
            if [[ "$status" = "L" ]]; then
                printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp" "LOCKED"
            else
                printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp" "UNLOCKED"
            fi
        fi
    done < /etc/passwd
    JUMLAH=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[35m Total Account : $JUMLAH user"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI PERPANJANG AKUN SSH ===================
function renew(){
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m        RENEW SSH ACCOUNT         \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -p "  Username   : " User
    egrep "^$User" /etc/passwd >/dev/null
    if [ $? -eq 0 ]; then
        echo ""
        read -p "  Day Extend : " Days
        Today=$(date +%s)
        Days_Detailed=$(( Days * 86400 ))
        Expire_On=$(( Today + Days_Detailed ))
        Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
        Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
        passwd -u "$User"
        usermod -e "$Expiration" "$User"
        clear
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;97;1m         SUCCESFULLY RENEW          \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        echo -e "\e[96;1m Username     :  $User"
        echo -e "\e[96;1m Days Added   :  $Days Days"
        echo -e "\e[96;1m Expires on   :  $Expiration_Display"
        echo ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    else
        clear
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;91;1m          USERNAME IS WRONG          \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    fi
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI AUTOKILL SSH ===================
function autokill(){
    clear
    Green_font_prefix="\033[32m"
    Red_font_prefix="\033[31m"
    Green_background_prefix="\033[42;37m"
    Red_background_prefix="\033[41;37m"
    Font_color_suffix="\033[0m"
    Info="${Green_font_prefix}[ON]${Font_color_suffix}"
    Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
    cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
    if [[ "$cek" = "1" ]]; then
        sts="${Info}"
    else
        sts="${Error}"
    fi
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m           AUTOKILLER SSH           \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Status Autokill : $sts        "
    echo ""
    echo -e "\e[37;1m [1]  AutoKill After 5 Minutes"
    echo -e "\e[37;1m [2]  AutoKill After 10 Minutes"
    echo -e "\e[37;1m [3]  AutoKill After 15 Minutes"
    echo -e "\e[37;1m [4]  Turn Off AutoKill/MultiLogin"
    echo -e "\e[31;1m [x]  GO BACK"
    echo ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -p "Just Input 1-4 or x: " AutoKill
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m              TANILINK             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo -e "\e[96;1m Just Input Number \e[0m"
    echo -e "\e[32;1m Format  : Number!! \e[0m"
    echo -e "\e[31;1m Example : 1 = 1 ip \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -p "Just Input Number kill: " max
    echo ""
    case $AutoKill in
        1)
            sleep 1
            clear
            echo > /etc/cron.d/tendang
            echo "# Autokill" > /etc/cron.d/tendang
            echo "*/5 * * * *  root /usr/bin/tendang $max" >> /etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
            echo "" > /root/log-limit.txt
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo "      Allowed MultiLogin : $max"
            echo "      AutoKill Every     : 5 Minutes"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            service cron reload >/dev/null 2>&1
            service cron restart >/dev/null 2>&1
            ;;
        2)
            sleep 1
            clear
            echo > /etc/cron.d/tendang
            echo "# Autokill" > /etc/cron.d/tendang
            echo "*/10 * * * *  root /usr/bin/tendang $max" >> /etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
            echo "" > /root/log-limit.txt
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo "      Allowed MultiLogin : $max"
            echo "      AutoKill Every     : 10 Minutes"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            service cron reload >/dev/null 2>&1
            service cron restart >/dev/null 2>&1
            ;;
        3)
            sleep 1
            clear
            echo > /etc/cron.d/tendang
            echo "# Autokill" > /etc/cron.d/tendang
            echo "*/15 * * * *  root /usr/bin/tendang $max" >> /etc/cron.d/tendang && chmod +x /etc/cron.d/tendang
            echo "" > /root/log-limit.txt
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo "      Allowed MultiLogin : $max"
            echo "      AutoKill Every     : 15 Minutes"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            service cron reload >/dev/null 2>&1
            service cron restart >/dev/null 2>&1
            ;;
        4)
            rm -fr /etc/cron.d/tendang
            echo "" > /root/log-limit.txt
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\e[96;1m      AutoKill MultiLogin Turned Off"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            service cron reload >/dev/null 2>&1
            service cron restart >/dev/null 2>&1
            ;;
        x)
            menu
            ;;
        *)
            echo "Please enter a correct number"
            ;;
    esac
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
}

# =================== FUNGSI RECOVERY USER SSH ===================
function recovery(){
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m            USER EXPIRED            \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "${BIWhite}"
    awk -F'[: ]+' '/Username/ {print $4" expired", $NF}' /usr/local/bin/deleteduser
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -p "${BIWhite} Just Input Username : " Login
    echo ""
    read -p "${BIWhite} Just Input Password : " Pass
    echo ""
    read -p "${BIWhite} Just input Expiry   : " masaaktif
    echo ""
    read -p "${BIWhite} Just Input Limit ip : " max

    if [ "$max" -eq 1 ]; then
        echo "minimal limit ip 2"
        exit 0
    fi

    echo "$max" > /etc/cybervpn/limit/ssh/ip/"$Login"

    useradd -e "$(date -d "$masaaktif days" +"%Y-%m-%d")" -s /bin/false -M "$Login"
    expi=$(chage -l "$Login" | grep "Account expires" | awk -F": " '{print $2}')
    echo -e "$Pass\n$Pass\n" | passwd "$Login" &> /dev/null
    hariini=$(date -d "0 days" +"%Y-%m-%d")
    expi=$(date -d "$masaaktif days" +"%Y-%m-%d")

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m        RECOVERY USER SSH          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[32;1m Succesfully \e[0m"
    echo ""
    echo -e "\e[96;1m Username  : $Login"
    echo -e "\e[96;1m Password  : $Pass"
    echo -e "\e[96;1m Created   : $hariini"
    echo -e "\e[96;1m Expired   : $expi"
    echo -e "\e[96;1m limit ip  : $max"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m              TANILINK             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
}

# =================== FUNGSI CREATE TITLE (ADD SSH) ===================
function Create_Title() {
    clear
    # Variabel warna sudah diekspor di awal sehingga tidak perlu dideklarasikan ulang
    domain=$(cat /etc/xray/domain)
    sldomain=$(cat /root/nsdomain)
    cdndomain=$(cat /root/awscdndomain)
    slkey=$(cat /etc/slowdns/server.pub)
    cftn=$(cat /root/cloudfront)
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m      CREATE TITLE ACCOUNT          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -p "  Username : " Login
    echo ""
    read -p "  Password : " Pass
    echo ""
    read -p "  Expired  : " masaaktif
    echo ""
    read -p "  limit IP : " max
    if [ "$max" -eq 1 ]; then
        echo "minimal limit ip 2"
        exit 0
    fi
    echo "$max" > /etc/cybervpn/limit/ssh/ip/"$Login"
    IP=$(wget -qO- ipinfo.io/ip)
    ws=$(grep -w "Websocket TLS" ~/log-install.txt | cut -d: -f2 | sed 's/ //g')
    ws2=$(grep -w "Websocket None TLS" ~/log-install.txt | cut -d: -f2 | sed 's/ //g')
    ssl=$(grep -w "Stunnel5" ~/log-install.txt | cut -d: -f2)
    sqd=$(grep -w "Squid" ~/log-install.txt | cut -d: -f2)
    ovpn=$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)
    ovpn2=$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)
    clear
    systemctl daemon-reload
    # Baris "systemctl start $login" dihapus karena tidak relevan
    systemctl stop client-sldns
    systemctl stop server-sldns
    pkill sldns-server
    pkill sldns-client
    systemctl enable client-sldns
    systemctl enable server-sldns
    systemctl start client-sldns
    systemctl start server-sldns
    systemctl restart client-sldns
    systemctl restart server-sldns
    systemctl restart ws-tls
    systemctl restart ws-nontls
    systemctl restart ssh-ohp
    systemctl restart rc-local
    systemctl restart dropbear-ohp
    systemctl_restart=openvpn-ohp && systemctl restart openvpn-ohp
    useradd -e "$(date -d "$masaaktif days" +"%Y-%m-%d")" -s /bin/false -M "$Login"
    expi=$(chage -l "$Login" | grep "Account expires" | awk -F": " '{print $2}')
    echo -e "$Pass\n$Pass\n" | passwd "$Login" &> /dev/null
    hariini=$(date -d "0 days" +"%Y-%m-%d")
    expi=$(date -d "$masaaktif days" +"%Y-%m-%d")
    clear
    echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m          DETAILS ACCOUNT           \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Username  : $Login"
    echo -e "Password  : $Pass"
    echo -e "Created   : $hariini"
    echo -e "Expired   : $expi"
    echo -e "limit ip  : $max"
    echo -e "IP/Host   : $IP"
    echo -e "Domain SSH: $domain"
    echo -e "Cloudflare: $domain"
    echo -e "PubKey    : $slkey"
    echo -e "Nameserver: $sldomain"
    echo -e "Cloudfront: $cftn"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m        DETAILS PORT VPN           \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "OpenSSH   : 22"
    echo -e "Dropbear  : 44, 69, 143"
    echo -e "STunnel4  : 442,222,2096"
    echo -e "SlowDNS   : 53,5300,8080"
    echo -e "SSL/TLS   : 443"
    echo -e "Websocket : 80,8080"
    echo -e "Enhanched :  8080,8880"
    echo -e "OPEN VPN  : 1194"
    echo -e "UDPGW     : 7100,7200,7300"
    echo -e "CloudFront: [ON]"
    echo -e "Squid     : [ON]"
    echo -e "OVPN TCP  : http://$IP:81/tcp.ovpn"
    echo -e "OVPN UDP  : http://$IP:81/udp.ovpn"
    echo -e "OVPN SSL  : http://$IP:81/ssl.ovpn"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Payload WS/SSL/TLS"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "GET wss://bug.com/ HTTP/1.1[crlf]Host: [host][crlf]Upgrade: websocket[crlf][crlf]"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Payload Websocket HTTP"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "GET / HTTP/1.1[crlf]Host: [host][crlf]Upgrade: websocket[crlf][crlf]"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Payload enanched"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "PATCH /ssh-lunatic HTTP/1.1[crlf]Host: [host][crlf]Host: ISIBUG[crlf]Upgrade: websocket[crlf]Connection: Upgrade[crlf]User-Agent: [ua][crlf][crlf]"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m              TANILINK             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    read -p "Enter To Back Menu"
    menu
}

# =================== MENU UTAMA ===================
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m            SSH LIBEV              \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • ADD SSH    \e[0m"
echo -e "\e[37;1m [02] • DELETE SSH \e[0m"
echo -e "\e[37;1m [03] • RENEW SSH  \e[0m"
echo -e "\e[37;1m [04] • USER SSH   \e[0m"
echo -e "\e[37;1m [05] • MULOG SSH  \e[0m"
echo -e "\e[37;1m [06] • DELETE XP  \e[0m"
echo -e "\e[37;1m [07] • AUTOKILL SSH\e[0m"
echo -e "\e[37;1m [08] • MEMBER SSH \e[0m"
echo -e "\e[37;1m [09] • TRIALL SSH \e[0m"
echo -e "\e[37;1m [10] • LOCKED SSH \e[0m"
echo -e "\e[37;1m [11] • UNLOCK SSH \e[0m"
echo -e "\e[37;1m [12] • RECOVER SSH\e[0m"
echo -e "\e[31;1m [00] • GO BACK    \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -p "Just Input: " opt
echo ""
case $opt in
    1) clear ; Create_Title ;;
    2) clear ; del ;;
    3) clear ; renew ;;
    4) clear ; cek ;;
    5) clear ; ceklim ;;
    6) clear ; autodel ;;
    7) clear ; autokill ;;
    8) clear ; member ;;
    9) clear ; trial ;;   # Pastikan fungsi trial didefinisikan
    10) clear ; lock ;;    # Pastikan fungsi lock didefinisikan
    11) clear ; unlock ;;  # Pastikan fungsi unlock didefinisikan
    12) clear ; recovery ;;
    0) clear ; menu ;;    # Pastikan fungsi menu didefinisikan
    x) exit ;;
    *) menu ;;
esac
