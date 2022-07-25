#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$y                 SSH & OpenVPN $wh"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$yy 1$y.  Buat Akun SSH & OpenVPN"
echo -e "$yy 2$y.  Hasilkan Akun Percobaan SSH & OpenVPN"
echo -e "$yy 3$y.  Memperpanjang Masa Aktif Akun SSH & OpenVPN"
echo -e "$yy 4$y.  Periksa Login Pengguna SSH & OpenVPN"
echo -e "$yy 5$y.  Daftar Member SSH & OpenVPN"
echo -e "$yy 6$y.  Hapus Akun SSH & OpenVpn"
echo -e "$yy 7$y.  Hapus Pengguna Kedaluwarsa SSH & OpenVPN"
echo -e "$yy 8$y.  Atur Auto Kill SSH"
echo -e "$yy 9$y.  Menampilkan Pengguna yang Melakukan Multi Login SSH"
echo -e "$yy 10$y. Mulai Ulang Semua Layanan"
echo -e "$yy 11$y. Menu Utama"
echo -e "$yy 12$y. Keluar"
echo -e "$y-------------------------------------------------------------$wh"
read -p "Pilih Dari Opsi [ 1 - 12 ] : " menu
echo -e "$y-------------------------------------------------------------$wh"
echo -e ""
case $menu in
1)
addssh
;;
2)
trialssh
;;
3)
renewssh
;;
4)
cekssh
;;
5)
member
;;
6)
delssh
;;
7)
delexp
;;
8)
autokill
;;
9)
ceklim
;;
10)
restart
;;
11)
menu
;;
12)
clear
exit
;;
*)
clear
menu
;;
esac
