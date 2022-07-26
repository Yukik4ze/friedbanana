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
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# Autokill" /etc/cron.d/tendang)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e ""
echo -e "=============================================="
echo -e "       Status Matikan Otomatis $sts       "
echo -e "=============================================="
echo -e "1. Matikan Otomatis Setelah 5 Menit"
echo -e "2. Matikan Otomatis Setelah 10 Menit"
echo -e "3. Matikan Otomatis Setelah 15 Menit"
echo -e "4. Matikan Fitur Otomatis/MultiLogin"
echo -e "5. Keluar"
echo -e "=============================================="                                                                                                          
echo -e ""
read -p "Pilih Dari Opsi [1-4 or x] :  " AutoKill
read -p "Jumlah Maksimum Multilogin yang Diizinkan: " max
echo -e ""
case $AutoKill in
                1)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/5 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "=============================================="
                echo -e ""
                echo -e "      Diizinkan MultiLogin : $max"
                echo -e "      Matikan Otomatis Setiap     : 5 Minutes"      
                echo -e ""
                echo -e "=============================================="                                                                                                                                 
                exit                                                                  
                ;;
                2)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/10 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "=============================================="
                echo -e ""
                echo -e "      Diizinkan MultiLogin : $max"
                echo -e "      Matikan Otomatis Setiap     : 10 Minutes"
                echo -e ""
                echo -e "=============================================="
                exit
                ;;
                3)
                echo -e ""
                sleep 1
                clear
                echo > /etc/cron.d/tendang
                echo "# Autokill" >>/etc/cron.d/tendang
                echo "*/15 * * * *  root /usr/bin/tendang $max" >>/etc/cron.d/tendang
                echo -e ""
                echo -e "=============================================="
                echo -e ""
                echo -e "      Diizinkan MultiLogin        : $max"
                echo -e "      Matikan Otomatis Setiap     : 15 Minutes"
                echo -e ""
                echo -e "=============================================="
                exit
                ;;
                4)
                clear
                echo > /etc/cron.d/tendang
                echo -e ""
                echo -e "=============================================="
                echo -e ""
                echo -e "     Matikan Otomatis MultiLogin Dimatikan    "
                echo -e ""
                echo -e "=============================================="
                exit
                ;;
                x)
                clear
                exit
                ;;
        esac