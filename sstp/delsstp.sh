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
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/var/lib/sanistorevpn/data-user-sstp")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "Anda tidak memiliki klien!"
		exit 1
	fi

	echo ""
	echo " Pilih klien yang ada yang ingin Anda hapus"
	echo " Tekan CTRL+C untuk kembali"
	echo " ==============================="
	echo "     Tidak Ada Pengguna yang Kedaluwarsa"
	grep -E "^### " "/var/lib/sanistorevpn/data-user-sstp" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
			read -rp "Pilih salah satu[1]: " CLIENT_NUMBER
		else
			read -rp "Pilih salah satu [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
		fi
	done
Client=$(grep -E "^###" /var/lib/sanistorevpn/data-user-sstp | cut -d ' ' -f 2-3 | sed -n "$CLIENT_NUMBER"p)
user=$(grep -E "^###" /var/lib/sanistorevpn/data-user-sstp | cut -d ' ' -f 2 | sed -n "$CLIENT_NUMBER"p)
exp=$(grep -E "^###" /var/lib/sanistorevpn/data-user-sstp | cut -d ' ' -f 3 | sed -n "$CLIENT_NUMBER"p)
sed -i "/^### $user $exp/d" /var/lib/sanistorevpn/data-user-sstp
sed -i '/^'"$user"'/d' /home/sstp/sstp_account
clear
echo ""
echo "=========================="
echo "   SSTP Account Deleted   "
echo "=========================="
echo "Nama Pengguna : $user"
echo "Kadaluarsa    : $exp"
echo "=========================="
echo "Script By SaniVPN"