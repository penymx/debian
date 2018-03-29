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


            if [ "$1" = "" ]
            then
        echo
        echo "Cara menggunakan: $0 Username"
        echo "Contoh:  $0 budi"
        echo
        exit 1
           fi

        Username=`cat /etc/passwd | grep -Ew ^$1 | cut -d":" -f1`

        if [ "$Username" = "" ]
        then
        echo "Username $1 Tidak dapat ditemukan"
        exit 2
        fi

        Userid=`cat /etc/passwd | grep -Ew ^$Username | cut -d":" -f3`
        UserPrimaryGroupId=`cat /etc/passwd | grep -Ew ^$Username | cut -d":" -f4`
        UserPrimaryGroup=`cat /etc/group | grep :"$UserPrimaryGroupId": | cut -d":" -f1`
        UserInfo=`cat /etc/passwd | grep -Ew ^$Username | cut -d":" -f5`
        UserHomeDir=`cat /etc/passwd | grep -Ew ^$Username | cut -d":" -f6`
        UserShell=`cat /etc/passwd | grep -Ew ^$Username | cut -d":" -f7`
        UserGroups=`groups $Username | awk -F": " '{print $2}'`
        PasswordExpiryDate=`chage -l $Username | grep "Password expires" | awk -F": " '{print $2}'`
        LastPasswordChangeDate=`chage -l $Username | grep "Last password change" | awk -F": " '{print $2}'`
        AccountExpiryDate=`chage -l $Username | grep "Account expires" | awk -F": " '{print $2}'`
        HomeDirSize=`du -hs $UserHomeDir | awk '{print $1}'`
        echo
        echo "Script by Ahmad Thoriq Najahi"
        echo "Terimakasih sudah berlangganan di speedwushssh.net"
        echo " "
        echo "Detail Account untuk username $Username"
        echo "---------------------------------------"
        printf "%-25s : %5s  [User Id - %s]\n" "Username                 " "$Username" "$Userid"
        printf "%-25s : %5s\n"                 "Password terakhir diganti" "$LastPasswordChangeDate"
        printf "%-25s : %5s\n"                 "Account Expired Pada     " "$AccountExpiryDate"
        echo "--------------------------------------"