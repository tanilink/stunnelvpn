#!/bin/bash

# Define colors
green='\033[0;32m'
yell='\033[33;1m'
NC='\033[0m' # No Color

echo -e "\n"
date
echo ""

# Check if domain file exists
if [[ ! -f /root/domain ]]; then
    echo -e "[ ${red}ERROR${NC} ] File /root/domain not found!"
    exit 1
fi

domain=$(cat /root/domain)
sleep 1
mkdir -p /etc/xray
echo -e "[ ${green}INFO${NC} ] Checking... "

# Install necessary packages
echo -e "[ ${green}INFO${NC} ] Installing required packages..."
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate chrony zip pwgen openssl netcat -y

# Configure time synchronization
echo -e "[ ${green}INFO${NC} ] Setting up time synchronization..."
ntpdate pool.ntp.org
timedatectl set-ntp true
timedatectl set-timezone Asia/Jakarta
systemctl enable chrony
systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v

# Clean and update apt
echo -e "[ ${green}INFO${NC} ] Cleaning and updating apt..."
apt clean all && apt update -y

# Stop nginx
systemctl stop nginx

# Install acme.sh
echo -e "[ ${green}INFO${NC} ] Installing acme.sh..."
mkdir -p /root/.acme.sh
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt

# Issue SSL certificate
echo -e "[ ${green}INFO${NC} ] Issuing SSL certificate..."
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc

# Create SSL renewal script
echo -e "[ ${green}INFO${NC} ] Creating SSL renewal script..."
echo -n '#!/bin/bash
/etc/init.d/nginx stop
"/root/.acme.sh"/acme.sh --cron --home "/root/.acme.sh" &> /root/renew_ssl.log
/etc/init.d/nginx start
/etc/init.d/nginx status
' > /usr/local/bin/ssl_renew.sh
chmod +x /usr/local/bin/ssl_renew.sh

# Add cron job for SSL renewal
if ! grep -q 'ssl_renew.sh' /var/spool/cron/crontabs/root; then
    (crontab -l; echo "15 03 */3 * * /usr/local/bin/ssl_renew.sh") | crontab
fi

# Create public_html directory
mkdir -p /home/vps/public_html

# Configure Nginx
echo -e "[ ${green}INFO${NC} ] Configuring Nginx..."
cat > /etc/nginx/conf.d/xray.conf <<EOF
server {
    listen 80;
    listen [::]:80;
    listen 443 ssl http2 reuseport;
    listen [::]:443 http2 reuseport;
    server_name $domain;
    ssl_certificate /etc/xray/xray.crt;
    ssl_certificate_key /etc/xray/xray.key;
    ssl_ciphers EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+ECDSA+AES128:EECDH+aRSA+AES128:RSA+AES128:EECDH+ECDSA+AES256:EECDH+aRSA+AES256:RSA+AES256:EECDH+ECDSA+3DES:EECDH+aRSA+3DES:RSA+3DES:!MD5;
    ssl_protocols TLSv1.1 TLSv1.2 TLSv1.3;
    root /home/vps/public_html;

    location / {
        proxy_redirect off;
        proxy_pass http://127.0.0.1:700;
        proxy_http_version 1.1;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;
    }
}
EOF

# Restart services
echo -e "[ ${green}INFO${NC} ] Restarting services..."
systemctl daemon-reload
systemctl restart nginx
systemctl enable nginx

# Clean up
echo -e "[ ${green}INFO${NC} ] Cleaning up..."
if [[ -f /root/scdomain ]]; then
    rm /root/scdomain > /dev/null 2>&1
fi
mv /root/domain /etc/xray/
rm -f nginx-ssl.sh

echo -e "[ ${green}INFO${NC} ] All done!"
