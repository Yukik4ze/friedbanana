#!/bin/bash
# Ohp Script
# Oh Yeah! : thethemythwashere
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Persiapan VPS
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Memeriksa VPS"
IZIN=$( curl https://raw.githubusercontent.com/Yukik4ze/perizinan/main/ipvps.txt | grep $MYIP )
if [ $MYIP = $MYIP ]; then
echo -e "${NC}${GREEN}Diijinkan...${NC}"
else
echo -e "${NC}${RED}Tidak Diijinkan${NC}";
#
echo -e "${NC}${LIGHT}Script by : thethemythwashere"
exit 0
fi

# Download File Ohp
wget https://github.com/lfasmpao/open-http-puncher/releases/download/0.1/ohpserver-linux32.zip
unzip ohpserver-linux32.zip
chmod +x ohpserver
cp ohpserver /usr/local/bin/ohpserver
/bin/rm -rf ohpserver*

# Installing Service
# SSH OHP Port 8181
cat > /etc/systemd/system/ssh-ohp.service << END
[Unit]
Description=SSH OHP Redirection Service
Documentation=thethemythwashere
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8181 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:22
Restart=on-failure
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
END

# Dropbear OHP 8282
cat > /etc/systemd/system/dropbear-ohp.service << END
[Unit]]
Description=Dropbear OHP Redirection Service
Documentation=thethemythwashere
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8282 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:109
Restart=on-failure
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
END

# OpenVPN OHP 8383
cat > /etc/systemd/system/openvpn-ohp.service << END
[Unit]]
Description=OpenVPN OHP Redirection Service
Documentation=thethemythwashere
After=network.target nss-lookup.target

[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/ohpserver -port 8383 -proxy 127.0.0.1:3128 -tunnel 127.0.0.1:1194
Restart=on-failure
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload
systemctl enable ssh-ohp
systemctl restart ssh-ohp
systemctl enable dropbear-ohp
systemctl restart dropbear-ohp
systemctl enable openvpn-ohp
systemctl restart openvpn-ohp
#------------------------------
printf 'INSTALLATION COMPLETED !\n'
sleep 0.5
printf 'CHECKING LISTENING PORT\n'
if [ -n "$(ss -tupln | grep ohpserver | grep -w 8181)" ]
then
	echo 'Pengalihan SSH OHP Berjalan'
else
	echo 'Pengalihan SSH OHP Tidak Ditemukan, silakan periksa secara manual'
fi
sleep 0.5
if [ -n "$(ss -tupln | grep ohpserver | grep -w 8282)" ]
then
	echo 'Dropbear OHP Redirection Menjalankan'
else
	echo 'Dropbear OHP Redirection Tidak Ditemukan, silakan periksa secara manual'
fi
sleep 0.5
if [ -n "$(ss -tupln | grep ohpserver | grep -w 8383)" ]
then
	echo 'OpenVPN OHP Redirection Berjalan'
else
	echo 'OpenVPN OHP Redirection Tidak Ditemukan, silakan periksa secara manual'
fi
sleep 0.5