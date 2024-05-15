apt install git -y
git clone https://github.com/davigalucio/debian.git

sed -i 's|non-free-firmware||' debian/update-upgrade.sh

sh debian/update-upgrade.sh

apt install -y build-essential lsb-release module-assistant ca-certificates software-properties-common aptitude sudo wget git gnupg curl cmake g++ gcc make automake autoconf net-tools plocate lzip tar unzip squashfs-tools

sudo apt install -y linux-headers-amd64 dkms debhelper libelf-dev mokutil
#sudo apt install -y linux-headers-$(uname -r)
apt install -y --no-install-recommends lxde-core

apt install -y xrdp

apt install -y anbox android-tools-adb android-tools-fastboot

git clone https://github.com/anbox/anbox-modules.git
cd anbox-modules
sudo chmod +x INSTALL.sh
./INSTALL.sh
cd ..

#ls -1 /dev/{ashmem,binder}
#ls -la /var/lib/dkms/
#ls -alh /dev/binder /dev/ashmem

#lsmod | grep -e ashmem_linux -e binder_linux

sudo apt install -y snapd
sudo snap install --devmode --edge anbox
cp /snap/anbox/current/android.img /var/lib/anbox/android.img

sudo systemctl enable --now systemd-networkd snap.anbox.container-manager.service
sudo systemctl start systemd-networkd.service snap.anbox.container-manager.service

snap start anbox

sudo snap set anbox rootfs-overlay.enable=true
sudo snap restart anbox.container-manager
sudo systemctl restart anbox-container-manager.service
sudo systemctl daemon-reload

###################################################
# Baixar e Instalar o PlayStore no Anbox          #
###################################################
cat << 'EOF' >> /opt/INSTALL-PlayStore.sh
wget -P /opt/ https://raw.githubusercontent.com/geeks-r-us/anbox-playstore-installer/master/install-playstore.sh
chmod +x /opt/install-playstore.sh
/opt/install-playstore.sh
sudo systemctl daemon-reload
sudo snap restart anbox.container-manager
sudo systemctl restart anbox-container-manager.service
sudo reboot
EOF
chmod +x /opt/INSTALL-PlayStore.sh
chmod 777 /opt/INSTALL-PlayStore.sh

###################################################
# Baixar e Instalar o WhatsApp                    #
###################################################
cat << EOF >> /opt/Whatsapp.sh
wget -P /opt/ https://files01.tchspt.com/down/WhatsApp-2.24.9.79.apk
adb install /opt/WhatsApp*.apk
EOF
# ------------------------------------------------#
# Para iniciar o WhatsApp
#/usr/bin/anbox launch --action=android.intent.action.MAIN --package=com.whatsapp --component=com.whatsapp.Main

sudo reboot
