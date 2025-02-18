#!/bin/bash
# Skrip Status VPN TUNNELING - Versi Dirapikan

clear

# Hapus file upsc lama (jika ada) dari direktori saat ini dan /root
rm -rf upsc.sh upsc.sh.1 upsc.sh.2 /root/upsc.sh /root/upsc.sh.1 /root/upsc.sh.2

# Ambil tanggal dari server (Google) dan simpan ke variabel 'biji'
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=$(date +"%Y-%m-%d" -d "$dateFromServer")

########### WARNA (opsional) ############
NC='\033[0m'
# Warna lain dapat didefinisikan jika diperlukan

# Set bahasa ke UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# Hitung jumlah user dan data konfigurasi dari /etc/xray/config.json
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
vla=$(( vlx / 2 ))
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
vma=$(( vmc / 2 ))
trx=$(grep -c -E "^#! " "/etc/xray/config.json")
tra=$(( trx / 2 ))
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
ssa=$(( ssx / 2 ))

# Hitung jumlah user SSH (uid>=1000) dari /etc/passwd
ssh1=$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)

# Hitung data NOOBZVPN
nob=$(noobzvpns --info-all-user | grep -i "username" | wc -l)
noob=$(grep -c "#nob#" /etc/noobzvpns/.noobzvpns.db)

clear

# Ambil IP VPS
MYIP=$(wget -qO- ipinfo.io/ip)

# Fungsi untuk memeriksa masa aktif script
CEKEXPIRED() {
    # Ambil tanggal besok
    today=$(date -d "+1 day" +"%Y-%m-%d")
    # Ambil tanggal kadaluarsa dari URL registrasi (sesuaikan dengan format data)
    Exp1=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep "$MYIP" | awk '{print $3}')
    if [[ "$today" < "$Exp1" ]]; then
        clear
    else
        echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m"
        exit 0
    fi
}

# Buat direktori sementara jika belum ada
for dir in /tmp/trojan /tmp/vmess /tmp/vless; do
    [ ! -d "$dir" ] && mkdir -p "$dir"
done

# Periksa izin/script aktif berdasarkan IP
IZIN=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | awk '{print $4}' | grep "$MYIP")
if [ "$MYIP" = "$IZIN" ]; then
    CEKEXPIRED
else
    echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m"
    exit 0
fi

clear

# Hitung sisa masa aktif sertifikat
today=$(date -d "0 days" +"%Y-%m-%d")
Exp2=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep "$MYIP" | awk '{print $3}')
if [ "$Exp2" == "lifetime" ]; then
    Exp2="2099-12-09"
fi
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
left=$(( (d1 - d2) / 86400 ))

# Restart fail2ban
systemctl restart fail2ban

# Pastikan skrip dijalankan sebagai root
if [ "${EUID}" -ne 0 ]; then
    echo -e "Silakan jalankan skrip ini sebagai root!"
    exit 1
fi

# Ekspor ulang IP (opsional)
export MYIP=$(curl -s https://ipinfo.io/ip/)
Name=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep "$MYIP" | awk '{print $2}')
Exp=$(curl -sS https://raw.githubusercontent.com/tanilink/REGISTER/main/IPVPS | grep "$MYIP" | awk '{print $3}')
clear

# Cek status layanan NGINX
nginx_status=$(systemctl status nginx | grep Active | awk '{print $3}' | tr -d '()')
if [[ $nginx_status == "running" ]]; then
    status_nginx="\e[92;1mONLINE\e[0m"
else
    status_nginx="\e[91;1mOFFLINE\e[0m"
fi

# Cek status layanan XRAY
xray_status=$(systemctl status xray | grep Active | awk '{print $3}' | tr -d '()')
if [[ $xray_status == "running" ]]; then
    status_xray="\e[92;1mONLINE\e[0m"
else
    status_xray="\e[91;1mOFFLINE\e[0m"
fi

# Cek status SSH (Websocket Proxy)
ssh_status=$(/etc/init.d/ssh status | grep -i "Active" | awk '{print $3}' | tr -d '()')
if [[ $ssh_status == "running" ]]; then
    status_ssh="\e[92;1mONLINE\e[0m"
else
    status_ssh="\e[91;1mOFFLINE\e[0m"
fi

# Cek status layanan Fail2Ban
fail2ban_status=$(systemctl status fail2ban | grep Active | awk '{print $3}' | tr -d '()')
if [[ $fail2ban_status == "running" ]]; then
    status_fail2ban="\e[92;1mONLINE\e[0m"
else
    status_fail2ban="\e[91;1mOFFLINE\e[0m"
fi

# Cek status layanan Netfilter
netfilter_status=$(systemctl status netfilter-persistent | grep Active | awk '{print $3}' | tr -d '()')
if [[ $netfilter_status == "exited" ]]; then
    status_net="\e[92;1mONLINE\e[0m"
else
    status_net="\e[91;1mOFFLINE\e[0m"
fi

clear

# Tampilan header
echo -e "\e[33;1m███████████████████████████████████████████████\e[0m"
echo -e "\e[33;1m█           \e[44;37;1m VPN TUNNELING STATUS \e[0m           █\e[0m"
echo -e "\e[33;1m███████████████████████████████████████████████\e[0m"

# Tampilkan sisa hari masa aktif (sertifikat)
echo -e "\e[33;1m                     \e[37;1m ${left} Hari Tersisa\e[0m"

# Tampilan status sistem dan jaringan
echo -e "\e[33;1m┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\e[0m"
echo -e "\e[33;1m┃       \e[44;37;1m SYSTEM & NETWORK STATUS \e[0m       \e[33;1m┃\e[0m"
echo -e "\e[33;1m┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\e[0m"
echo -e "\e[33;1m┃ 🔄 Uptime   : \e[32;1m$(uptime -p | cut -d ' ' -f2-)\e[0m"
echo -e "\e[33;1m┃ 🕒 Waktu    : \e[32;1m$(date -d '0 days' +"%d-%m-%Y | %X")\e[0m"
echo -e "\e[33;1m┃ 🌐 Domain   : \e[32;1m$(cat /etc/xray/domain)\e[0m"
echo -e "\e[33;1m┃ 🔗 NS Domain: \e[32;1m$(cat /root/nsdomain)\e[0m"
echo -e "\e[33;1m┃ 📡 IP VPS   : \e[32;1m$MYIP\e[0m"
echo -e "\e[33;1m┃ 🏢 ISP      : \e[32;1m$(curl -s ipinfo.io/org | cut -d ' ' -f2-10)\e[0m"
echo -e "\e[33;1m┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\e[0m"

# Tampilan status layanan
echo -e "\e[33;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│\e[34;1m SSH   : ${status_ssh}   XRAY  : ${status_xray}   NGINX : ${status_nginx} \e[33;1m│\e[0m"
echo -e "\e[33;1m└──────────────────────────────────────────────────┘\e[0m"

# Tampilan informasi jumlah user dan protokol
echo -e "\e[33;1m   \e[37mSSHOPENVPN: $ssh1   SHADOWSOCKS: $ssa   NOOBZVPN: $noob\e[0m"
echo -e "\e[33;1m           \e[37mVMESS: $vma   VLESS: $vla   TROJAN: $tra\e[0m"

# Tampilan petunjuk penggunaan menu
echo -e "\e[33;1m┌──────────────────────────────────────────────────┐\e[0m"
echo -e "\e[33;1m│              \e[4;37mAccess Use Menu Command\e[0m              \e[33;1m│\e[0m"
echo -e "\e[33;1m└──────────────────────────────────────────────────┘\e[0m"

# Set warna akhir (opsional)
echo -e "\e[35;1m"
