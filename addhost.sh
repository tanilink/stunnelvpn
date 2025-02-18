#!/bin/bash
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""

# Cek apakah host kosong
if [[ -z "$host" ]]; then
    echo "Host tidak boleh kosong!"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    read -n 1 -s -r -p "Tekan tombol apa saja untuk kembali ke menu"
    menu
else
    # Pastikan direktori ada sebelum menghapus file
    mkdir -p /etc/xray
    rm -f /etc/xray/domain
    
    # Simpan domain baru
    echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
    echo "$host" > /etc/xray/domain
    
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo "Jangan lupa untuk memperbarui sertifikat dengan genssl."
    echo ""
    
    read -n 1 -s -r -p "Tekan tombol apa saja untuk melanjutkan"
    
    # Cek apakah genssl tersedia sebelum dieksekusi
    if command -v genssl &> /dev/null; then
        genssl
    else
        echo "Perintah genssl tidak ditemukan! Pastikan sudah terinstal."
    fi
fi
