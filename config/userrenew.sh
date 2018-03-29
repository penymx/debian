            user-list.sh
	    #!/bin/bash
            # Created by http://www.sshinjector.net
            red='\e[1;31m'
            green='\e[0;32m'
            NC='\e[0m'
            echo "Connecting to server..."
            sleep 0.2
            echo "Checking Permision..."
            sleep 0.3
            echo -e "${green}Permission Accepted...${NC}"
            sleep 1
            echo""


            read -p "Masukkan Username Yang Akan Diperpanjang: " username
            egrep "^$username" /etc/passwd >/dev/null
            if [ $? -eq 0 ]; then
            read -p "Masukkan Tambahan Masa Aktif Account terhitung dari hari ini(Hari): " masa_aktif

            today=`date +%s`
            masa_aktif_detik=$(( $masa_aktif * 86400 ))
            saat_expired=$(($today + $masa_aktif_detik))
            tanggal_expired=$(date -u --date="1970-01-01 $saat_expired sec GMT" +%Y/%m/%d)
            tanggal_expired_display=$(date -u --date="1970-01-01 $saat_expired sec GMT" '+%d %B %Y')

            echo "Connecting to server..."
            sleep 0.5
            echo "Menambah Masa Aktif..."
            sleep 0.5
            passwd -u $username
            usermod -e  $tanggal_expired $username
            egrep "^$username" /etc/passwd >/dev/null
            echo -e "$password\n$password" | passwd $username
            echo""
            echo "Script by Ahmad Thoriq Najahi"
            echo "Terimakasih sudah berlangganan di speedwushssh.net"
            echo " "
            echo "Demikian Detail Account Yang Telah Diperpanjang"
            echo "---------------------------------------"
            echo "Username        : $username"
            echo "Masa aktif      : $masa_aktif Hari"
            echo "Tanggal Expired : $tanggal_expired_display"
            echo "--------------------------------------"

            else
            echo -e "Username ${red}$username${NC} tidak ditemukan di VPS anda"
            exit 0
            fi
