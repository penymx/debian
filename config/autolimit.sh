#!/bin/bash
# Created By Ahmad Thoriq Najahi
# Dilarang Keras Mengambil/mencuplik/mengcopy sebagian atau seluruh script ini.
# Hak Cipta speedwushssh.net (Dilindungi Undang-Undang nomor 19 Tahun 2002)
            echo""


             if [ ! -e /usr/local/bin/auto-limit-script.sh ]; then
            echo 'FATAL ERROR'
            echo 'Error Code: 404'
            echo 'Mohon update premium script Anda!'
             fi

            echo "--------------------------------------------------"
            echo "Menu Sistem Limit User (Kill Multi Login) otomatis"
            echo "--------------------------------------------------"
            echo "1.  Set Auto Kill Multi Login 3 menit sekali"
            echo "2.  Set Auto Kill Multi Login 5 menit sekali"
            echo "3.  Set Auto Kill Multi Login 7 menit sekali"
            echo "4.  Set Auto Kill Multi Login 10 menit sekali"
            echo "5.  Set Auto Kill Multi Login 15 menit sekali"
            echo "6.  Set Auto Kill Multi Login 30 menit sekali"
            echo "7.  Matikan Auto-Limit"
            echo "8.  Lihat log user yang melakukan multilogin"
            echo "9.  Hapus log limit"
            echo "--------------------------------------------------"
            read -p "Tulis Pilihan Anda (angka): " x

            if (($x<7)); then
            echo " "
            echo "--------------------------------------------------"
            read -p "jumlah multilogin maksimum yang diizinkan: " max

            fi
            if test $x -eq 1; then
            echo "*/3 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 3 menit sekali."
            elif test $x -eq 2; then
            echo "*/5 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 5 menit sekali."
            elif test $x -eq 3; then
            echo "*/7 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 7 menit sekali."
            elif test $x -eq 4; then
            echo "*/10 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 10 menit sekali."
            elif test $x -eq 5; then
            echo "*/15 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 15 menit sekali."
            elif test $x -eq 6; then
            echo "*/30 * * * *  root /usr/local/bin/auto-limit-script.sh $max" > /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil diset 30 menit sekali."
            elif test $x -eq 7; then
            rm -f /etc/cron.d/auto-limit-script.sh
            echo "User-Auto-Limit telah berhasil dimatikan."
            elif test $x -eq 8; then
            if [ ! -e /root/log-limit.txt ]; then
        	echo "Belum ada user yang melakukan multilogin yang terdeteksi"
        	else 
        	echo 'Log user yang terdeteksi melakukan multilogin'
        	echo "-------"
         	cat /root/log-limit.txt
            fi
            elif test $x -eq 9; then
            echo "" > /root/log-limit.txt
            echo "Log berhasil dihapus!"
            else
            echo "Pilihan Tidak Terdapat Di Menu."
            exit
            fi
