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

clear
echo -e ""
echo -e "======================================"
echo -e ""
echo -e "[1]. Ubah Port OpenVPN"
echo -e "[2]. Ubah Port Wireguard"
echo -e "[3]. Ubah Port Vmess + Vless"
echo -e "[4]. Ubah Port Trojan"
echo -e "[5]. Ubah Port Squid"
echo -e "[6]. Ubah Port SSTP"
echo -e "[7]. Ubah Port SSH WS NON TLS"
echo -e "[8]. Ganti Port SSH WS TLS/SSL"
echo -e "[9]. Keluar"
echo -e ""
echo -e "======================================"
echo -e ""
read -p "Pilih Dari Opsi [ 1-7 ] : " port
echo -e ""
case $port in
1)
portovpn
;;
2)
portwg
;;
3)
portvlm
;;
4)
porttrojan
;;
5)
portsquid
;;
6)
portsstp
;;
7)
portsshnontls
;;
8)
portsshws
;;
9)
clear
menu
;;
*)
echo "Silakan masukkan nomor yang benar"
;;
esac
