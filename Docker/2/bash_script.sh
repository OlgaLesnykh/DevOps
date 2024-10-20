#!/bin/bash
sudo git clone https://github.com/OlgaLesnykh/shvirtd-python.git /opt/shvirtd-python
cd /opt/shvirtd-python
sudo bash -c 'cat << EOF > db.env
MYSQL_ROOT_PASSWORD="YtReWq4321"
MYSQL_DATABASE="virtd"
MYSQL_USER="app"
MYSQL_PASSWORD="QwErTy1234"
EOF'
sudo bash -c 'cat << EOF > web.env
DB_NAME="virtd"
DB_USER="app"
DB_PASSWORD="QwErTy1234"
DB_HOST='172.20.0.10'
EOF'
docker compose up -d