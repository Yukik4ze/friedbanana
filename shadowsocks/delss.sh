#!/bin/bash
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
echo -e "${NC}${LIGHT}Remade by : thethemythwashere"
exit 0
fi
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/shadowsocks-libev/akun.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Anda tidak memiliki klien!"
		exit 1
	fi

	clear
	echo ""
	echo " Pilih klien yang ada yang ingin Anda hapus"
	echo " Tekan CTRL+C untuk kembali"
	echo " ==============================="
	echo "     Tidak Ada Pengguna yang Kedaluwarsa"
	grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih salah satu[1]: " CLIENT_NUMBER
		else
			read -rp "Pilih salah satu [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
# match the selected number to a client name
CLIENT_NAME=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2-3 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/shadowsocks-libev/akun.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
# remove [Peer] block matching $CLIENT_NAME
sed -i "/^### $user $exp/,/^port_http/d" "/etc/shadowsocks-libev/akun.conf"
# remove generated client file
service cron restart
systemctl disable shadowsocks-libev-server@$user-tls.service
systemctl disable shadowsocks-libev-server@$user-http.service
systemctl stop shadowsocks-libev-server@$user-tls.service
systemctl stop shadowsocks-libev-server@$user-http.service
rm -f "/etc/shadowsocks-libev/$user-tls.json"
rm -f "/etc/shadowsocks-libev/$user-http.json"
clear
echo ""
echo "==========================="
echo "  SS OBFS Account Deleted  "
echo "==========================="
echo "Nama Pengguna : $user"
echo "Kadaluarsa    : $exp"
echo "==========================="
echo "Script By SaniVPN"