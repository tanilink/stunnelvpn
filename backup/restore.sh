#!/bin/bash

# Path folder root yang diinginkan
root_folder="/root/folder"

# Membuat folder jika belum ada
if [ ! -d "$root_folder" ]; then
    mkdir -p "$root_folder"
else
    echo "Folder $root_folder Already available."
fi

# Mengekstrak file ZIP di dalam root folder
if [ -n "$(ls -A "$root_folder"/*.zip 2>/dev/null)" ]; then
    for zip_file in "$root_folder"/*.zip; do
        unzip "$zip_file" -d "$root_folder"
        echo "File ZIP $zip_file berhasil diekstrak."
    done
else
    echo " There Is No Zip File In The Folder $root_folder."
fi

# Menjalankan operasi restore
cd /root/folder/backup

# Menyalin file ke lokasi tujuan mereka
cp -f passwd /etc/
cp -f group /etc/
cp -f shadow /etc/
cp -f gshadow /etc/
cp -rf xray /etc/
cp -f crontab /etc/

# Membersihkan file backup dengan path yang benar
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[44;97;1m         RESTORE SUCCESS           \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
sleep 3
clear
# Opsional: Menghapus backup.zip dan direktori backup
rm -rf /root/backup

# Menghapus file ZIP di dalam folder root/folder
folder="/root/folder"
if [ -d "$folder" ]; then
    if [ -n "$(ls -A "$folder"/*.zip 2>/dev/null)" ]; then
        rm "$folder"/*.zip
        echo "Semua file ZIP di dalam folder $folder telah dihapus."
    else
        echo "Tidak ada file ZIP di dalam folder $folder."
    fi
else
    echo "Folder $folder tidak ditemukan."
fi

# Menghapus folder 'backup' di dalam folder 'folder'
backup_folder="/root/folder/backup"
if [ -d "$backup_folder" ]; then
    rm -rf "$backup_folder"
    echo "Folder 'backup' di dalam 'folder' telah dihapus."
else
    echo "Folder 'backup' di dalam 'folder' tidak ditemukan."
fi


