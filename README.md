
# Auto Script, By Ahmad Thoriq Najahi (089691858881)
=================================================================================

# debian7.sh
```
wget https://raw.githubusercontent.com/najahiiii/debian/master/debian7.sh && chmod +x ./debian7.sh && ./debian7.sh
```
# OPENVPN
```
wget -O openvpn.sh https://raw.githubusercontent.com/najahiiii/debian/master/openvpn.sh && chmod +x openvpn.sh && ./openvpn.sh
```
# TERIMA KASIH YA ALLAH SWT ATAS SEMUANYA
=================================================================================

DELETEUSER OTOMATIS

```
wget https://raw.githubusercontent.com/najahiiii/debian/master/config/deleteuserexpire.sh
```

```
wget https://raw.githubusercontent.com/najahiiii/debian/master/config/userban.sh
```

# crontab -e
```
59 23 * * * sudo bash ~/deleteuserexpire.sh > /dev/null 2>&1
* 3 * * * sudo bash ~/userban.sh > /dev/null 2>&1
```


# SSH SSL
```
https://tkjpedia.com/install-stunnel-ssh-ssl-untuk-kpn-revolution/
```

# Membuat Sertifikat SSL
```
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
```

# Konfigurasi Auto Start Stunnel
```
nano /etc/default/stunnel4
```
Ganti ENABLED dari 0 ke 1

# /etc/init.d/stunnel4 restart
