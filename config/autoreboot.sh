            #!/bin/bash
            red='\e[1;31m'
            green='\e[0;32m'
            blue='\e[1;34m'
            NC='\e[0m'
            echo "Connecting to sshinjector.net..."
            sleep 0.2
            echo "Checking Permision..."
            sleep 0.3
            echo -e "${green}Permission Accepted...${NC}"
            sleep 1
            echo""


             if [ ! -e /usr/local/bin/reboot ]; then
             echo '#!/bin/bash' > /usr/local/bin/reboot 
             echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/local/bin/reboot 
             echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot 
             echo 'echo "Server telah berhasil direboot pada tanggal $tanggal pukul $waktu." >> /root/log-reboot.txt' >> /usr/local/bin/reboot
             echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot 
             chmod +x /usr/local/bin/reboot
             fi

             echo "-------------------------------------------"
             echo "Menu Sistem Reboot Otomatis"
             echo "-------------------------------------------"
             echo "1.  Set Auto-Reboot 1 jam sekali"
             echo "2.  Set Auto-Reboot 6 jam sekali"
             echo "3.  Set Auto-Reboot 12 jam sekali"
             echo "4.  Set Auto-Reboot 1 hari sekali"
             echo "5.  Set Auto-Reboot 1 minggu sekali"
             echo "6.  Set Auto-Reboot 1 bulan sekali"
             echo "7.  Matikan Auto-Reboot"
             echo "8.  Lihat log reboot"
             echo "9.  Hapus log reboot"
             echo "-------------------------------------------"
             read -p "Tulis Pilihan Anda (angka): " x

             if test $x -eq 1; then
             echo "10 * * * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 1 jam sekali."
             elif test $x -eq 2; then
             echo "10 */6 * * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 6 jam sekali."
             elif test $x -eq 3; then
             echo "10 */12 * * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 12 jam sekali."
             elif test $x -eq 4; then
             echo "10 0 * * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 1 hari sekali."
             elif test $x -eq 5; then
             echo "10 0 */7 * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 1 minggu sekali."
             elif test $x -eq 6; then
             echo "10 0 1 * * root /usr/local/bin/reboot" > /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil diset 1 bulan sekali."
             elif test $x -eq 7; then
             rm -f /etc/cron.d/reboot
             echo "Auto-Reboot telah berhasil dimatikan."
             elif test $x -eq 8; then
             if [ ! -e /root/log-reboot.txt ]; then
	         echo "Belum ada aktivitas reboot yang ditemukan"
	         else 
	         echo 'LOG REBOOT'
         	 echo "-------"
	         cat /root/log-reboot.txt
             fi
             elif test $x -eq 9; then
             echo "" > /root/log-reboot.txt
             echo "Log Auto Reboot berhasil dihapus!"
             else
             echo "Pilihan Tidak Terdapat Di Menu."
             exit
             fi