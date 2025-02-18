#!/bin/bash
# // String / Request Data
# Getting public IP and domain information
MYIP=$(wget -qO- ipinfo.io/ip)
clear

# Install necessary tools
apt update && apt install jq curl -y

# Generate random subdomain
sub=$(</dev/urandom tr -dc a-z | head -c4)
DOMAIN="kingvpn.my.id"
SUB_DOMAIN="${sub}.kingvpn.my.id"
CF_ID="hannaugo@gmail.com"
CF_KEY="e3341a6705e970eda3577f440d0cca6e3d682"

# Ensure script stops on error
set -euo pipefail

# Get the current external IP
IP=$(curl -sS ifconfig.me)

echo "Updating DNS for ${SUB_DOMAIN}..."

# Get zone ID for the domain
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
  -H "X-Auth-Email: ${CF_ID}" \
  -H "X-Auth-Key: ${CF_KEY}" \
  -H "Content-Type: application/json" | jq -r .result[0].id)

# Get the record ID if it exists
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
  -H "X-Auth-Email: ${CF_ID}" \
  -H "X-Auth-Key: ${CF_KEY}" \
  -H "Content-Type: application/json" | jq -r .result[0].id)

# Create a new DNS record if none exists
if [[ "${#RECORD}" -le 10 ]]; then
  RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
    -H "X-Auth-Email: ${CF_ID}" \
    -H "X-Auth-Key: ${CF_KEY}" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

# Update the DNS record
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
  -H "X-Auth-Email: ${CF_ID}" \
  -H "X-Auth-Key: ${CF_KEY}" \
  -H "Content-Type: application/json" \
  --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')

# Display the result
echo "Host: $SUB_DOMAIN"
echo "$SUB_DOMAIN" > /root/domain
echo "IP=$SUB_DOMAIN" > /var/lib/scrz-prem/ipvps.conf

# Notify user and proceed
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Domain added successfully.."
sleep 3

# Copy domain to xray configuration
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain

# Prompt to return to genssl
read -n 1 -s -r -p "Press any key to return to genssl"
genssl
