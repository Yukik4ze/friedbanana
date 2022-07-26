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
# Muat parameter
source /etc/wireguard/params
source /var/lib/sanistorevpn/ipvps.conf
if [[ "$IP" = "" ]]; then
SERVER_PUB_IP=$(wget -qO- ipinfo.io/ip);
else
SERVER_PUB_IP=$IP
fi
source /var/lib/sanistorevpn/ipvps.conf
if [[ "$IP2" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP2
fi
echo ""
portwg="$(cat ~/log-install.txt | grep -w "Wireguard" | cut -d: -f2|sed 's/ //g')"
until [[ ${CLIENT_NAME} =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
	read -rp "Username : " -e CLIENT_NAME
	CLIENT_EXISTS=$(grep -w $CLIENT_NAME /etc/wireguard/wg0.conf | wc -l)

	if [[ ${CLIENT_EXISTS} == '1' ]]; then
		echo ""
		echo -e "Username ${RED}${CLIENT_NAME}${NC} Sudah Digunakan Di VPS Silahkan Buat Username Lain"
		exit 1
	fi
done

echo "IPv4 Detected"
ENDPOINT="$domain:$SERVER_PORT"
WG_CONFIG="/etc/wireguard/wg0.conf"
LASTIP=$( grep "/32" $WG_CONFIG | tail -n1 | awk '{print $3}' | cut -d "/" -f 1 | cut -d "." -f 4 )
if [[ "$LASTIP" = "" ]]; then
CLIENT_ADDRESS="10.66.66.2"
else
CLIENT_ADDRESS="10.66.66.$((LASTIP+1))"
fi

# Adguard DNS secara default
CLIENT_DNS_1="176.103.130.130"

CLIENT_DNS_2="176.103.130.131"
MYIP=$(wget -qO- ifconfig.co);
read -p "Kadaluarsa    : (Hari) : " masaaktif
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

# Hasilkan pasangan kunci untuk klien
CLIENT_PRIV_KEY=$(wg genkey)
CLIENT_PUB_KEY=$(echo "$CLIENT_PRIV_KEY" | wg pubkey)
CLIENT_PRE_SHARED_KEY=$(wg genpsk)

# Buat file klien dan tambahkan server sebagai peer
echo "[Interface]
PrivateKey = $CLIENT_PRIV_KEY
Address = $CLIENT_ADDRESS/24
DNS = $CLIENT_DNS_1,$CLIENT_DNS_2

[Peer]
PublicKey = $SERVER_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
Endpoint = $ENDPOINT
AllowedIPs = 0.0.0.0/0,::/0" >>"$HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf"

# Tambahkan klien sebagai rekan ke server
echo -e "### Client $CLIENT_NAME $exp
[Peer]
PublicKey = $CLIENT_PUB_KEY
PresharedKey = $CLIENT_PRE_SHARED_KEY
AllowedIPs = $CLIENT_ADDRESS/32" >>"/etc/wireguard/$SERVER_WG_NIC.conf"
systemctl restart "wg-quick@$SERVER_WG_NIC"
cp $HOME/$SERVER_WG_NIC-client-$CLIENT_NAME.conf /home/vps/public_html/$CLIENT_NAME.conf
clear
sleep 0.5
echo Generate PrivateKey
sleep 0.5
echo Generate PublicKey
sleep 0.5
echo Generate PresharedKey
clear
echo -e ""
echo -e "======---WIREGUARD---======"
echo -e "Remarks  : $CLIENT_NAME"
echo -e "IP/Host  : $MYIP"
echo -e "Domain   : $domain"
echo -e "Port     : $portwg"
echo -e "Dibuat   : $hariini"
echo -e "Kadaluarsa    : $exp"
echo -e "==========================="
echo -e "Link WG  : http://$MYIP:89/$CLIENT_NAME.conf"
echo -e "==========================="
echo -e "Script By SaniVPN"
rm -f /root/wg0-client-$CLIENT_NAME.conf
