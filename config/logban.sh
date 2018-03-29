            #!/bin/bash
            # Created by http://www.sshinjector.net
            red='\e[1;31m'
            green='\e[0;32m'
            NC='\e[0m'
            echo "Connecting to server..."
            sleep 0.1
            echo "Checking Permision..."
            sleep 0.2
            echo -e "${green}Permission Accepted...${NC}"
            sleep 0.5
            echo""

            echo "Script Created by Ahmad Thoriq Najahi";
            echo "Terimakasih sudah berlanggan di speedwushssh.net";
            echo ""
            echo "===============================================";
            echo " ";
            if [ -e "/root/log-ban.txt" ]; then
            echo "User yang diban oleh user-ban adalah";
            echo "Waktu - Username - Jumlah Multilogin"
            echo "-------------------------------------";
            cat /root/log-ban.txt
            else
            echo " Tidak ada user yang melakukan pelanggaran"
            echo " Atau"
            echo " Script user-ban belum dijalankan"
            fi
            echo " ";
            echo "===============================================";