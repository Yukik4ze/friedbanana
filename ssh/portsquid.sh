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
sqd="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | head -n1)"
sqd2="$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | tail -n1)"
echo -e "======================================"
echo -e ""
echo -e "[1]. Ubah Port $sqd"
echo -e "[2]. Ubah Port $sqd2"
echo -e "[3]. Keluar"
echo -e ""
echo -e "======================================"
echo -e ""
read -p "Pilih Dari Opsi [ 1-3 ] : " prot
echo -e ""
case $prot in
1)
read -p "Port Squid Baru: " squid
if [ -z $squid ]; then
echo "Silahkan Masukan Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd/$squid/g" /etc/squid/squid.conf
sed -i "s/$sqd/$squid/g" /root/log-install.txt
/etc/init.d/squid restart > /dev/null
echo -e "\e[032;1mModifikasi Port $squid Berhasil\e[0m"
else
echo "Port $squid Telah Digunakan"
fi
;;
2)
read -p "Port Squid Baru: " squid
if [ -z $squid ]; then
echo "Silahkan Masukan Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $squid)
if [[ -z $cek ]]; then
sed -i "s/$sqd2/$squid/g" /etc/squid/squid.conf
sed -i "s/$sqd2/$squid/g" /root/log-install.txt
/etc/init.d/squid restart > /dev/null
echo -e "\e[032;1mModifikasi Port $squid Berhasil\e[0m"
else
echo "Port $squid Telah Digunakan"
fi
;;
3)
exit
menu
;;
*)
echo "Silakan masukkan nomor yang benar"
;;
esac

