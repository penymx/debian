            user-list.sh
            #!/bin/bash
            red='\e[1;31m'
            green='\e[0;32m'
            blue='\e[1;34m'
            NC='\e[0m'
            echo "Connecting to server..."
            sleep 0.2
            echo "Checking Permision..."
            sleep 0.3
            echo -e "${green}Permission Accepted...${NC}"
            sleep 1
            echo""


            read -p "Masukkan Username Yang Diganti Passwordnya: " username
            egrep "^$username" /etc/passwd >/dev/null
            if [ $? -eq 0 ]; then
            read -p "Masukkan Password baru untuk user $username: " password

            echo "Connecting to server..."
            sleep 0.5
            echo "Merubah Password..."
            sleep 0.5
            egrep "^$username" /etc/passwd >/dev/null
            echo -e "$password\n$password" | passwd $username
            echo""
            echo "Script by Ahmad Thoriq Najahi"
            echo "Terimakasih sudah berlangganan di speedwushssh.net"
            echo " "
            echo "---------------------------------------"
            echo -e "Password untuk user ${blue}$username${NC} Sudah berhasil di ganti."
            echo -e "Password baru untuk user ${blue}$username${NC} adalah ${red}$password${NC}"
            echo "--------------------------------------"

            else
            echo -e "Username ${red}$username${NC} tidak ditemukan di VPS anda"
            exit 0
            fi