#!/bin/bash
#!/bin/bash
clear
m="\033[0;1;36m"
y="\033[0;1;37m"
yy="\033[0;1;32m"
yl="\033[0;1;33m"
wh="\033[0m"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$y                   PENGATURAN SISTEM$wh"
echo -e "$y-------------------------------------------------------------$wh"
echo -e "$yy 1$y.  Tambah Atau Ubah Subdomain Host Untuk VPS"
echo -e "$yy 2$y.  Ubah Port Beberapa Layanan"
echo -e "$yy 3$y.  VPS Data Cadangan Otomatis"
echo -e "$yy 4$y.  Cadangkan Data VPS"
echo -e "$yy 5$y.  Pulihkan Data VPS"
echo -e "$yy 6$y.  Webmin Menu"
echo -e "$yy 7$y.  Batasi Kecepatan Bandwidth Server"
echo -e "$yy 8$y.  Periksa Penggunaan RAM VPS"
echo -e "$yy 9$y.  Menyalakan Ulang VPS"
echo -e "$yy 10$y. Tes Kecepatan Bandwidth VPS"
echo -e "$yy 11$y. Menampilkan Informasi Sistem"
echo -e "$yy 12$y. Informasi Script VPS"
echo -e "$yy 13$y. Menu"
echo -e "$yy 14$y. Keluar"
echo -e "$y-------------------------------------------------------------$wh"
echo -e ""
read -p "Pilih Dari Opsi [ 1 - 60 ] : " menu
echo -e "$y-------------------------------------------------------------$wh"
echo -e ""
case $menu in
1)
addhost
;;
2)
changeport
;;
3)
autobackup
;;
4)
backup
;;
5)
restore
;;
6)
wbmn
;;
7)
limitspeed
;;
8)
ram
;;
9)
reboot
;;
10)
speedtest
;;
11)
info
;;
12)
about
;;
13)
clear
menu
;;
14)
clear
exit
;;
*)
clear
menu
;;
esac
