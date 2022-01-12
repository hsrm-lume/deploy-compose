#!/bin/bash

set -ex

echo "Updating system"
apt update && apt upgrade -y -qq

echo "Installing Tools"
apt install nginx curl git -y -qq
curl -sSL https://get.docker.com/ | sh
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

read -p "Do you want to setup Docker HTTP-Proxy? [y/n]: " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Setup HTTP-Proxy for docker"
	mkdir -p /etc/systemd/system/docker.service.d
	echo "[Service]
Environment=\"HTTP_PROXY=http://proxy_url:proxy_port\" \"HTTPS_PROXY=http://proxy_url:proxy_port\" \"NO_PROXY=localhost,127.0.0.0/8\"
" > /etc/systemd/system/docker.service.d/http-proxy.conf
	systemctl daemon-reload
	systemctl restart docker
fi


echo "Cloning Repository"
git clone https://github.com/hsrm-lume/deploy-compose.git && cd deploy-compose

echo "Setup Nginx Vi-Hosts"
cat nginx-vhosts.conf > /etc/nginx/sites-available/default
nginx -s reload

echo "Done"


