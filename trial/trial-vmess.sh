#!/bin/bash

# Getting IP
MYIP=$(wget -qO- ipinfo.io/ip)
echo "Memeriksa VPS Anda..."
sleep 0.5

CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
        echo "Status script aktif.."
    else
        echo "SCRIPT ANDA EXPIRED"
        exit 0
    fi
}

IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep $MYIP)
if [ "$MYIP" = "$IZIN" ]; then
    echo "IZIN DI TERIMA!!"
    CEKEXPIRED
else
    echo "Akses ditolak!! Benget sia hurung!!"
    exit 0
fi

clear

source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
    domain=$(cat /etc/xray/domain)
else
    domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2 | sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2 | sed 's/ //g')"

# Memastikan input masa aktif minimal 15 menit
until [[ $hh =~ ^[0-9]+$ && $hh -ge 15 ]]; do
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m         VMESS TRIAL ACCOUNT          \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "Akumulasi masa aktif minimal 15 menit (min = 15)"
    read -p "Masukkan angka (menit): " hh
    if [[ ! $hh =~ ^[0-9]+$ ]] || [[ $hh -lt 15 ]]; then
        echo "Input tidak valid! Masa aktif minimal 15 menit."
    fi
done

# Membuat user trial dan uuid
Login=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
user=$Login
CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

if [[ ${CLIENT_EXISTS} == '1' ]]; then
    clear
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\E[0;41;36m         VMESS ACCOUNT          \E[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "A client with the specified name was already created, please choose another name."
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
fi

uuid=$(cat /proc/sys/kernel/random/uuid)
masaaktif=$hh
exp=`date -d "$masaaktif minutes" +"%Y-%m-%d %H:%M:%S"`

# Menambahkan user ke konfigurasi xray
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

DATADB=$(cat /root/akun/vmess/.vmess.conf | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/vmess/.vmess.conf
fi
echo "### ${user} ${exp} ${uuid}" >>/root/akun/vmess/.vmess.conf

# Menyusun konfigurasi Vmess
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "",
      "tls": "tls"
}
EOF`

# Restart services
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1

# Output file untuk Vmess
cat >/home/vps/public_html/vmess-$user.yaml <<-END
# Format Vmess WS TLS
- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS
- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC
- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc
END

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\\E[0;41;36m      TRIAL  XRAY/Vmess Account        \E[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Remarks          : ${user}" | tee -a /root/akun/vmess/$user.txt
echo -e "Domain           : ${domain}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port TLS         : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port none TLS    : ${none}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port  GRPC       : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "id               : ${uuid}" | tee -a /root/akun/vmess/$user.txt
echo -e "alterId          : 0" | tee -a /root/akun/vmess/$user.txt
echo -e "Security         : auto" | tee -a /root/akun/vmess/$user.txt
echo -e "Network          : ws" | tee -a /root/akun/vmess/$user.txt
echo -e "Path             : /Multi-Path" | tee -a /root/akun/vmess/$user.txt
echo -e "Dynamic          : http://bugmu.com/path" | tee -a /root/akun/vmess/$user.txt
echo -e "ServiceName      : vmess-grpc" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link TLS         : ${vmesslink1}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link none TLS    : ${vmesslink2}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link GRPC        : ${vmesslink3}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Format OpenClash : http://${domain}:81/vmess-$user.yaml" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Expired On       : $exp" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link OpenClash : http://$domain:81/vmess-$user.yaml" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
