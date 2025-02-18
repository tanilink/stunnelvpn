#!/bin/bash

dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")
colornow=$(cat /etc/ssnvpn/theme/color.conf)
NC="\e[0m"
RED='\e[1;32m'
COLOR1='\033[0;35m'

BURIQ() {
    curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS > /root/tmp
    data=( $(cat /root/tmp | grep -E "^### " | awk '{print $2}') )
    for user in "${data[@]}"
    do
        exp=$(grep -E "^### $user" "/root/tmp" | awk '{print $3}')
        d1=$(date -d "$exp" +%s)
        d2=$(date -d "$biji" +%s)
        exp2=$(( (d1 - d2) / 86400 ))
        if [[ "$exp2" -le "0" ]]; then
            echo $user > /etc/.$user.ini
        else
            rm -f /etc/.$user.ini > /dev/null 2>&1
        fi
    done
    rm -f /root/tmp
}

MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman() {
    if [ -f "/etc/.$Name.ini" ]; then
        CekTwo=$(cat /etc/.$Name.ini)
        if [ "$CekOne" = "$CekTwo" ]; then
            res="Expired"
        fi
    else
        res="Permission Accepted..."
    fi
}

PERMISSION() {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
        Bloman
    else
        res="Permission Denied!"
    fi
    BURIQ
}

red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'

green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

function con() {
    local -i bytes=$1
    if [[ $bytes -lt 1024 ]]; then
        echo "${bytes}B"
    elif [[ $bytes -lt 1048576 ]]; then
        echo "$(( (bytes + 1023)/1024 ))KB"
    elif [[ $bytes -lt 1073741824 ]]; then
        echo "$(( (bytes + 1048575)/1048576 ))MB"
    else
        echo "$(( (bytes + 1073741823)/1073741824 ))GB"
    fi
}

function cektrojan() {
    clear
    echo -n > /tmp/other.txt
    data=( $(cat /etc/xray/config.json | grep '^#!' | cut -d ' ' -f 2 | sort | uniq) )
    echo -e " ────────────────────────────────────────────────"
    echo -e "   user  | usage | quota | limit | login | waktu "
    echo -e " ────────────────────────────────────────────────"
    for akun in "${data[@]}"; do
        if [[ -z "$akun" ]]; then
            akun="tidakada"
        fi
        echo -n > /tmp/iptrojan.txt
        data2=( $(cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq) )
        for ip in "${data2[@]}"; do
            jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
            if [[ "$jum" = "$ip" ]]; then
                echo "$jum" >> /tmp/iptrojan.txt
            else
                echo "$ip" >> /tmp/other.txt
            fi
            jum2=$(cat /tmp/iptrojan.txt)
            sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
        done
        jum=$(cat /tmp/iptrojan.txt)
        if [[ -z "$jum" ]]; then
            echo > /dev/null
        else
            iplimit=$(cat /etc/cybervpn/limit/trojan/ip/${akun})
            jum2=$(cat /tmp/iptrojan.txt | wc -l)
            byte=$(cat /etc/trojan/${akun})
            lim=$(con ${byte})
            wey=$(cat /etc/limit/trojan/${akun})
            gb=$(con ${wey})
            lastlogin=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 2 | tail -1)
            printf "  %-13s %-7s %-8s %2s\n" "$akun" "$gb" "$lim" "$iplimit" "$jum2" "$lastlogin"
        fi
        rm -rf /tmp/iptrojan.txt
    done
    rm -rf /tmp/other.txt
    echo -e "\e[33m└─────────────────────────────────────────────────┘${NC}"
    echo ""
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

function deltrojan(){
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;97;1m          DELETE TROJAN             \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        echo -e "\e[96;1m   NO USER FOUND! \e[0m"
        echo -e ""
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu-trojan
        return
    fi

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m           DELETE TROJAN             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
    
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
    
    read -rp "  Just Input Username : " user
    if [ -z "$user" ]; then
        menu-trojan
        return
    fi
    
    exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    
    # Remove user from xray config and trojan database
    sed -i "/^#! $user $exp/,/^},{/d" /etc/xray/config.json
    sed -i "/$user/d" /etc/trojan/.trojan.db
    
    systemctl restart xray > /dev/null 2>&1

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m        SUCCESSFULLY DELETED         \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[32;1m   • Successfully"
    echo -e "\e[96;1m   • Client Name : $user"
    echo -e "\e[96;1m   • Expired On  : $exp"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    tanilink
    echo ""
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu
}

function unlock(){
    # Remove "UNLOCKED" status from the trojan database
    sed -i 's/ UNLOCKED//g' /etc/trojan/.trojan.db
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m         UNLOCKED TROJAN             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""
    
    # Prompt user for the account to unlock
    read -rp "  Just Input User To Unlock :  " user
    
    # If no user input, return to menu
    if [ -z "$user" ]; then
        menu-trojan
        return
    fi
    
    # Retrieve the UUID and expiration date for the user
    uuid=$(grep "$user" /etc/trojan/.trojan.db | awk '{print $4}')
    exp=$(grep "$user" /etc/trojan/.trojan.db | awk '{print $3}')
    
    # If UUID is missing, create a new one
    if [ -z "$uuid" ]; then
        echo "Oh tidak, UUID-mu terhapus."
        echo "Membuat UUID baru..."
        uuid=$(cat /proc/sys/kernel/random/uuid)
    else
        echo "UUID tersedia: $uuid"
    fi
    
    # Update the user's details in the xray config file
    sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'"$uuid"'"'","email": "'"$user"'"}' /etc/xray/config.json
    sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
"},{"password": "'"$uuid"'"'","email": "'"$user"'"}' /etc/xray/config.json
    
    # Restart xray service
    systemctl restart xray > /dev/null 2>&1

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m         UNLOCK SUCCESFULLY         \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[32;1m  • Successfully unlocked"
    echo -e "\e[96;1m  • Client Name : $user"
    echo -e "\e[96;1m  • Expired On  : $exp"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    tanilink
    echo ""
    
    # Return to the main menu after keypress
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu
}

function recovery(){
    # Remove "UNLOCKED" status from the trojan database
    sed -i 's/ UNLOCKED//g' /etc/trojan/.trojan.db
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m          RECOVERY TROJAN            \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""

    current_date=$(date +%s)
    
    # Retrieve users from the trojan database
    data=( $(grep -E "^#! " "/etc/trojan/.trojan.db" | cut -d ' ' -f 2 | column -t | sort | uniq ) )
    
    # Check if users are expired or still active
    for user in "${data[@]}"
    do
        expiration_date=$(grep -E "^#! $user" "/etc/trojan/.trojan.db" | cut -d ' ' -f 3 | column -t | sort | uniq)
        expiration_date=$(echo "$expiration_date" | sed -E 's/Jan/01/;s/Feb/02/;s/Mar/03/;s/Apr/04/;s/May/05/;s/Jun/06/;s/Jul/07/;s/Aug/08/;s/Sep/09/;s/Oct/10/;s/Nov/11/;s/Dec/12/')
        expiration_timestamp=$(date -d "$expiration_date" +%s 2>/dev/null)
        
        # Check if the user is expired
        if [ -n "$expiration_timestamp" ] && [ "$current_date" -le "$expiration_timestamp" ]; then
            echo "$user masih aktif"
        else
            echo "• $user expired"
        fi
    done
    
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    
    # Prompt user to input username to recover
    read -rp "   Just Input User To Recover: " user
    if [ -z "$user" ]; then
        menu-trojan
        return
    fi

    echo "reset Quota usage"
    rm -f /etc/limit/trojan/$user
    
    # Retrieve UUID and expiration for the user
    uuid=$(grep "$user" /etc/trojan/.trojan.db | awk '{print $4}')
    exp=$(grep "$user" /etc/trojan/.trojan.db | awk '{print $3}')
    
    # If UUID is missing, create a new one
    if [ -z "$uuid" ]; then
        echo "Oh tidak, UUID-mu terhapus."
        sleep 1
        echo "Membuat UUID baru..."
        uuid=$(cat /proc/sys/kernel/random/uuid)
    else
        echo "UUID tersedia: $uuid"
    fi

    # Remove old entries and add new ones to the config
    sed -i "/$user/d" /etc/trojan/.trojan.db
    sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'"$uuid"'"'","email": "'"$user"'"}' /etc/xray/config.json
    sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
"},{"password": "'"$uuid"'"'","email": "'"$user"'"}' /etc/xray/config.json
    
    # Append the updated details back to the trojan database
    echo "#& ${user} ${exp} ${uuid}" >> /etc/trojan/.trojan.db
    
    # Restart xray service to apply changes
    systemctl restart xray > /dev/null 2>&1
    
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m           RECOVER TROJAN             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[32;1m   • Successfully"
    echo -e "\e[96;1m   • Client Name : $user"
    echo -e "\e[96;1m   • Expired On  : $exp"
    echo -e "\e[96;1m   • uuid        : $uuid"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    tanilink
    echo ""
    
    # Wait for user input before returning to the menu
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu
}

function renewtrojan(){
    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;91;1m        RENEW TROJAN USER          \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")
    
    # If no clients found
    if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
        echo -e "\e[31;1m • You have no existing clients!"
        tanilink
        echo ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu
        return
    fi

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m          RENEW TROJAN             \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    # Display existing users
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    
    # User input
    read -rp " Just Input Username : " user
    if [ -z "$user" ]; then
        menu-trojan
        return
    fi

    # Remove old limits and files
    rm -f /etc/cybervpn/limit/trojan/ip/${user}
    rm -f /etc/trojan/$user
    echo
    
    # Get new data
    read -p "  Expiry in   : " masaaktif
    echo
    read -p "  Limit Quota : " Quota
    echo
    read -p "  Limit ip    : " iplim
    
    # Get existing expiration date from config
    exp=$(grep -wE "^#! $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    
    # Create directories if not exists
    mkdir -p /etc/cybervpn/limit/trojan/ip
    
    # Set IP limit
    echo $iplim > /etc/cybervpn/limit/trojan/ip/${user}
    
    # Create /etc/trojan if not exists
    if [ ! -e /etc/trojan ]; then
        mkdir -p /etc/trojan
    fi
    
    # Set default quota if empty
    if [ -z "${Quota}" ]; then
        Quota="0"
    fi
    
    # Convert quota to bytes and save
    c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
    d=$((${c} * 1024 * 1024 * 1024))
    if [[ ${c} != "0" ]]; then
        echo "${d}" > /etc/trojan/${user}
    fi
    
    # Calculate new expiration date
    now=$(date +%Y-%m-%d)
    d1=$(date -d "$exp" +%s)
    d2=$(date -d "$now" +%s)
    exp2=$(( (d1 - d2) / 86400 ))
    exp3=$((exp2 + masaaktif))
    exp4=$(date -d "$exp3 days" +"%Y-%m-%d")
    
    # Update the user's expiration date in the config
    sed -i "/#! $user/c\#! $user $exp4" /etc/xray/config.json
    
    # Restart xray service to apply changes
    systemctl restart xray > /dev/null 2>&1

    clear
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m       SUCCESSFULLY RENEWED        \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[32;1m   Successfully"
    echo -e "\e[96;1m   Client Name : $user"
    echo -e "\e[96;1m   Days Added  : $masaaktif Days"
    echo -e "\e[96;1m   Limit ip    : $iplim IP"
    echo -e "\e[96;1m   Limit Quota : $Quota GB"
    echo -e "\e[96;1m   Expired On  : $exp4"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    
    tanilink
    echo ""
    
    read -n 1 -s -r -p "   Press any key to back on menu"
    menu
}

function con() {
    local -i bytes=$1

    # Handle negative bytes input
    if (( bytes < 0 )); then
        echo "Invalid input: bytes cannot be negative"
        return 1
    fi

    # Convert bytes to human-readable format
    case $bytes in
        [0-9] | [1-9]*)
            if (( bytes < 1024 )); then
                echo "${bytes}B"
            elif (( bytes < 1048576 )); then
                echo "$(( (bytes + 1023) / 1024 ))KB"
            elif (( bytes < 1073741824 )); then
                echo "$(( (bytes + 1048575) / 1048576 ))MB"
            else
                echo "$(( (bytes + 1073741823) / 1073741824 ))GB"
            fi
            ;;
        *)
            echo "Invalid input: non-numeric value"
            return 1
            ;;
    esac
}

function cekmember() {
    clear
    NUMBER_OF_CLIENTS=$(grep -c -E "^#! " "/etc/xray/config.json")

    if [[ ${NUMBER_OF_CLIENTS} -eq 0 ]]; then
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e "\e[44;97;1m        FAILURE CLIENTS           \e[0m"
        echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
        echo -e ""
        read -n 1 -s -r -p "   Press any key to back on menu"
        menu
        return
    fi

    echo -e " ─────────────────────────────────────────────────"
    echo -e "  user  | usage  |   quota  | limit ip | expired"
    echo -e " ─────────────────────────────────────────────────"
    
    # Get all users from xray config and loop through them
    while read -r user exp; do
        iplimit=$(< "/etc/cybervpn/limit/trojan/ip/${user}")
        byte=$(< "/etc/trojan/${user}")
        lim=$(con "$byte")
        wey=$(< "/etc/limit/trojan/${user}")
        gb=$(con "$wey")
        printf "%-10s %-10s %-10s %-20s\n" "$user" "$gb" "$lim" "$iplimit     $exp"
    done < <(grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2,3)

    echo ""
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e ""
    read -n 1 -s -r -p "  • [NOTE] Press any key to back on menu"
    menu-trojan
}

function cek() {
    clear
    echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1│${NC} ${COLBG1}           • RESULT TROJAN USER •              ${NC} $COLOR1│$NC"
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"

    # Get all users and their expiry dates and display them
    grep -E "^#! " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort -u | nl

    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e ""
    read -rp "   Input Username : " user
    if [ -z "$user" ]; then
        menu-trojan
    else
        cat "/tmp/trojan/$user.txt"
    fi
}

function addtrojan() {
    domain=$(< /etc/xray/domain)
    tanilink
    echo ""
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\e[44;97;1m       CREATE TITLE TROJAN         \e[0m"
    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e ""

    tr=$(< ~/log-install.txt grep -w "Trojan WS " | cut -d: -f2 | sed 's/ //g')

    until [[ $user =~ ^[a-zA-Z0-9_]+$ && $user_EXISTS -eq 0 ]]; do
        read -rp "   Input Username : " -e user
        if [ -z "$user" ]; then
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\e[91;1m   [Error] Username cannot be empty \e[0m"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            tanilink
            echo ""
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi

        user_EXISTS=$(grep -w "$user" /etc/xray/config.json | wc -l)
        if [[ $user_EXISTS -eq 1 ]]; then
            clear
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo -e "\e[44;97;1m          FAILURE IS NAME           \e[0m"
            echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            read -n 1 -s -r -p "   Press any key to back on menu"
            menu
        fi
    done

    uuid=$(cat /proc/sys/kernel/random/uuid)
    read -p "   Expired     : " masaaktif
    echo ""
    read -p "   Limit Quota : " Quota
    echo ""
    read -p "   Limit IP    : " iplimit

    folder="/etc/cybervpn/limit/trojan/ip/"
    [ ! -d "$folder" ] && mkdir -p "$folder"

    exp=$(date -d "$masaaktif days" +"%Y-%m-%d")
    sed -i "/#trojanws$/a\#! $user $exp\n},{\"password\": \"$uuid\",\"email\": \"$user\"}" /etc/xray/config.json
    sed -i "/#trojangrpc$/a\#! $user $exp\n},{\"password\": \"$uuid\",\"email\": \"$user\"}" /etc/xray/config.json

    systemctl restart xray

    trojanlink1="trojan://${uuid}@${domain}:${tr}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${domain}#${user}"
    trojanlink="trojan://${uuid}@bug.com:${tr}?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"

    [ ! -e /etc/trojan ] && mkdir -p /etc/trojan

    iplimit="${iplimit:-0}"
    Quota="${Quota:-0}"

    c=$(echo "$Quota" | sed 's/[^0-9]*//g')
    d=$((c * 1024 * 1024 * 1024))

    if [[ $c -ne 0 ]]; then
        echo "$d" > /etc/trojan/$user
        echo "$iplimit" > /etc/cybervpn/limit/trojan/ip/$user
    fi

    DATADB=$(grep -w "^#!" /etc/trojan/.trojan.db | grep -w "$user" | awk '{print $2}')
    if [ -n "$DATADB" ]; then
        sed -i "/\b$user\b/d" /etc/trojan/.trojan.db
    fi

    echo "#& $user $exp $uuid" >> /etc/trojan/.trojan.db

    clear
    cat > /home/vps/public_html/trojan-$user.yaml <<-END
- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
      Host: ${domain}
- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc
END

    echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1│${NC} ${COLBG1}           • DETAIL TROJAN USER •              ${NC} $COLOR1│$NC"
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1 ${NC} Remarks     : ${user}"
    echo -e "$COLOR1 ${NC} Expired On  : $exp"
    echo -e "$COLOR1 ${NC} Host/IP     : ${domain}"
    echo -e "$COLOR1 ${NC} Port        : ${tr}"
    echo -e "$COLOR1 ${NC} Key         : ${uuid}"
    echo -e "$COLOR1 ${NC} Limit Quota : $Quota GB"
    echo -e "$COLOR1 ${NC} Limit IP    : $iplimit IP"
    echo -e "$COLOR1 ${NC} Path        : /trojan-ws"
    echo -e "$COLOR1 ${NC} Path WSS    : wss://bug.com/trojan-ws"
    echo -e "$COLOR1 ${NC} ServiceName : trojan-grpc"
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
    echo -e "$COLOR1 ${NC} Link WS : "
    echo -e "$COLOR1 ${NC} ${trojanlink}"
    echo -e "$COLOR1  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$${NC} "
    echo -e "$COLOR1 ${NC} Link GRPC : "
    echo -e "$COLOR1 ${NC} ${trojanlink1}"
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
    echo -e "$COLOR1 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC} "
    echo -e "Format OpenClash : http://${domain}:81/trojan-$user.yaml"
    echo -e "$COLOR1┌────────────────────── BY ───────────────────────┐${NC}"
    echo -e "$COLOR1│${NC}              •VPN TUNELING•                  $COLOR1│$NC"
    echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"

    cat > /tmp/trojan/$user.txt <<-EOF
-------------------------------------------
Remarks       : ${user}
Expired On    : $exp
Domain        : ${domain}
Port TLS      : ${tr}
id            : ${uuid}
Limit (GB)    : $Quota GB
Limit (IP)    : $iplimit IP
------------------------------------------
Link TLS :
${trojanlink}
-------------------------------------------
Link GRPC :
${trojanlink1}
--------------------------------------------
EOF

    read -n 1 -s -r -p "   Press any key to back on menu"
    menu-trojan
}

clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m          TROJAN LIBEV             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[37;1m [01] • ADD ACCOUNT      \e[0m"
echo -e "\e[37;1m [02] • RENEW ACCOUNT    \e[0m"
echo -e "\e[37;1m [03] • DELETE ACCOUNT   \e[0m"
echo -e "\e[37;1m [04] • ONLINE ACCOUNT   \e[0m"
echo -e "\e[37;1m [05] • MEMBER ACCOUNT   \e[0m"
echo -e "\e[37;1m [06] • HISTORY ACCOUNT  \e[0m"
echo -e "\e[37;1m [07] • UNLOCK ACCOUNT   \e[0m"
echo -e "\e[37;1m [08] • RECOVER ACCOUNT  \e[0m"
echo -e "\e[31;1m [00] • GO BACK          \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m              TANILINK             \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p "Enter your choice: " opt
echo -e ""

case $opt in
  01 | 1) clear ; addtrojan ;;
  02 | 2) clear ; renewtrojan ;;
  03 | 3) clear ; deltrojan ;;
  04 | 4) clear ; cektrojan ;;
  05 | 5) clear ; cekmember ;;
  06 | 6) clear ; cek ;;
  07 | 7) clear ; unlock ;;
  08 | 8) clear ; recovery ;;   # Fixed spelling from 'revovery' to 'recovery'
  00 | 0) clear ; menu ;;
  *) menu ;;
esac
