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
echo -e "${NC}${LIGHT}Script by : thethemythwashere"
exit 0
fi
clear
source /etc/wireguard/params
	NUMBER_OF_CLIENTS=$(grep -c -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		clear
		echo ""
		echo "Anda tidak memiliki klien!"
		exit 1
	fi

	clear
	echo ""
	echo ""
	echo " Pilih klien yang ada yang ingin Anda hapus"
	echo " Tekan CTRL+C untuk kembali"
	echo " ==============================="
	echo "     Tidak Ada Pengguna yang Kedaluwarsa"
	grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih satu klien [1]: " CLIENT_NUMBER
		else
			read -rp "Pilih satu klien [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done

# match the selected number to a client name
CLIENT_NAME=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3-4 | sed -n "${CLIENT_NUMBER}"p)
user=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### Client" "/etc/wireguard/$SERVER_WG_NIC.conf" | cut -d ' ' -f 4 | sed -n "${CLIENT_NUMBER}"p)

# remove [Peer] block matching $CLIENT_NAME
sed -i "/^### Client $user $exp/,/^AllowedIPs/d" /etc/wireguard/wg0.conf
# remove generated client file
rm -f "/home/vps/public_html/$user.conf"

# restart wireguard to apply changes
systemctl restart "wg-quick@$SERVER_WG_NIC"
service cron restart
clear
echo ""
echo "============================="
echo "    Akun Wireguard Dihapus   "
echo "============================="
echo "Nama Pengguna : $user"
echo "Kadaluarsa    : $exp"
echo "============================="
echo "Script By SaniVPN"