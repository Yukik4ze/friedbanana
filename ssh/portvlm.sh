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
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
echo -e "======================================"
echo -e ""
echo -e "[1]. Ubah Port Vmess TLS $tls"
echo -e "[2]. Ubah Port Vmess Non TLS $none"
echo -e "[3]. Keluar"
echo -e ""
echo -e "======================================"
echo -e ""
read -p "Pilih Dari Opsi [ 1-3 ] : " prot
echo -e ""
case $prot in
1)
read -p "Port Vmess TLS Baru : " tls1
if [ -z $tls1 ]; then
echo "Silahkan Masukan Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $tls1)
if [[ -z $cek ]]; then
sed -i "s/$tls/$tls1/g" /etc/xray/config.json
sed -i "s/   - XRAYS Vmess TLS         : $tls/   - XRAYS Vmess TLS         : $tls1/g" /root/log-install.txt
sed -i "s/   - XRAYS Vless TLS         : $tls/   - XRAYS Vless TLS         : $tls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $tls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $tls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $tls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $tls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray.service > /dev/null
echo -e "\e[032;1mModifikasi port $tls1 berhasil\e[0m"
else
echo "Port $tls1 Telah Digunakan"
fi
;;
2)
echo "Masukkan Hanya 2 Karakter (eg : 69)"
read -p "Port Vmess Non TLS Baru : " none1
if [ -z $none1 ]; then
echo "Silahkan Masukan Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $none1)
if [[ -z $cek ]]; then
sed -i "s/$none/$none1/g" /etc/xray/config.json
sed -i "s/   - XRAYS Vmess None TLS    : $none/   - XRAYS Vmess None TLS    : $none1/g" /root/log-install.txt
sed -i "s/   - XRAYS Vless None TLS    : $none/   - XRAYS Vless None TLS    : $none1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $none -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $none -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $none1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $none1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray.service > /dev/null
echo -e "\e[032;1mModifikasi Port $none1 Berhasil\e[0m"
else
echo "Port $none1 Telah Digunakan"
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
