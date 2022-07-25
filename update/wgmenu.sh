#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$y                          WIREGUARD $wh"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$yy 1$y. Buat Akun Wireguard"
echo -e "$yy 2$y. Hapus Akun Wireguard"
echo -e "$yy 3$y. Memperpanjang Masa Aktif Akun Wireguard"
echo -e "$yy 4$y. Menu"
echo -e "$yy 5$y. Keluar"
echo -e "$y-------------------------------------------------------------$wh"
read -p "Pilih Dari Opsi [ 1 - 5 ] : " menu
echo -e "$y-------------------------------------------------------------$wh"
echo -e ""
case $menu in
1)
addwg
;;
2)
delwg
;;
3)
renewwg
;;
4)
clear
menu
;;
5)
clear
exit
;;
*)
clear
menu
;;
esac
