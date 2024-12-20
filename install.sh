#!/data/data/com.termux/files/usr/bin/sh

#colours
R="$(printf '\033[1;31m')"
G="$(printf '\033[1;32m')"
Y="$(printf '\033[1;33m')"
W="$(printf '\033[1;37m')"
C="$(printf '\033[1;36m')"

banner(){
clear
printf ${Y}"UBUNTU CLI - TERMUX"${W}
printf ${Y}"github.com/abhiram79"${W}
}
CHROOT=$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu
install_ubuntu(){
echo
if [[ -d "$PREFIX/var/lib/proot-distro/installed-rootfs/ubuntu" ]]; then
echo ${G}"Existing Ubuntu installation found, Resetting it..."${W}
proot-distro reset ubuntu
else
echo ${G}"Installing Ubuntu..."${W}
echo
pkg install proot-distro
proot-distro install ubuntu
fi
}
adding_user(){
echo ${G}"Setting User."${W}
cat > $CHROOT/root/.bashrc <<- EOF
apt-get install sudo wget -y
sleep 2
useradd -m -s /bin/bash ubuntu
echo "ubuntu:ubuntu" | chpasswd
echo "ubuntu  ALL=(ALL:ALL) ALL" >> /etc/sudoers.d/ubuntu
sleep 2
exit
echo
EOF
proot-distro login ubuntu
echo "proot-distro login --user ubuntu ubuntu" >> $PREFIX/bin/ubuntu
chmod +x $PREFIX/bin/ubuntu
rm $CHROOT/root/.bashrc
}
final_banner(){
banner
echo
echo ${G}"Installion completed"
echo
echo "ubuntu  -  To start Ubuntu"
echo
echo "ubuntu  -  default ubuntu password"
echo
rm -rf ~/install.sh
}
banner
install_ubuntu
adding_user
final_banner
