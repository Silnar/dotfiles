#!/bin/bash

HOSTNAME="archlinux"
USER="silnar"

# Print each command
set -x

# Check interet
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ ! $? -eq 0 ]]; then
  echo "Internet unavailable. Aborting..."
  exit 1
fi

# Create partitions
parted -s /dev/sda mktable msdos
parted -s /dev/sda mkpart primary 0% 100m
parted -s /dev/sda mkpart primary 100m 100%
PARTITION_BOOT=/dev/sda1
PARTITION_ROOT=/dev/sda2

# Create filesystems
mkfs.ext2 $PARTITION_BOOT
mkfs.ext4 $PARTITION_HOME

# Set up /mnt
mount /dev/sda2 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

# Rankmirrors to make this faster (though it takes a while)
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.orig
rankmirrors -n 6 /etc/pacman.d/mirrorlist.orig > /etc/pacman.d/mirrorlist
pacman -Syy

# Install base packages (take a coffee break if you have slow internet)
pacstrap /mnt base base-devel

# Generate fstab
genfstab -p /mnt >> /mnt/etc/fstab

# Copy ranked mirrorlist over
cp /etc/pacman.d/mirrorlist* /mnt/etc/pacman.d

# Chroot
arch-chroot /mnt /bin/bash <<EOF

# Set initial hostname
echo "$HOSTNAME" > /etc/hostname

# Set initial timezone
ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime

# Set initial locale
locale > /etc/locale.conf
sed -i '/^#en_GB.UTF-8 UTF-8/s/^#//' /etc/locale.conf
sed -i '/^#en_GB ISO-8859-1/s/^#//' /etc/locale.conf
sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.conf
sed -i '/^#en_US ISO-8859-1/s/^#//' /etc/locale.conf
sed -i '/^#pl_PL.UTF-8 UTF-8/s/^#//' /etc/locale.conf
sed -i '/^#pl_PL ISO-8859-2/s/^#//' /etc/locale.conf
locale-gen

# Configure vconsole
cat <<END > /etc/vconsole.conf
KEYMAP=pl
FONT=lat2-16
FONT_MAP=8859-2
END

# Create a new initial RAM disk
mkinitcpio -p linux

# Set root password to "root"
echo root:root | chpasswd

# Install syslinux bootloader
pacman -S syslinux --noconfirm
syslinux-install_update -i -a -m

# Update syslinux config with correct root disk
wget -O /boot/syslinux/splash.png https://projects.archlinux.org/archiso.git/plain/configs/releng/syslinux/splash.png
cat <<END > /boot/syslinux/syslinux.cfg
UI vesamenu.c32
DEFAULT arch
PROMPT 0
MENU TITLE Boot Menu
MENU BACKGROUND splash.png
TIMEOUT 50

MENU WIDTH 78
MENU MARGIN 4
MENU ROWS 5
MENU VSHIFT 10
MENU TIMEOUTROW 13
MENU TABMSGROW 11
MENU CMDLINEROW 11
MENU HELPMSGROW 16
MENU HELPMSGENDROW 29

# Refer to http://www.syslinux.org/wiki/index.php/Comboot/menu.c32

MENU COLOR border       30;44   #40ffffff #a0000000 std
MENU COLOR title        1;36;44 #9033ccff #a0000000 std
MENU COLOR sel          7;37;40 #e0ffffff #20ffffff all
MENU COLOR unsel        37;44   #50ffffff #a0000000 std
MENU COLOR help         37;40   #c0ffffff #a0000000 std
MENU COLOR timeout_msg  37;40   #80ffffff #00000000 std
MENU COLOR timeout      1;37;40 #c0ffffff #00000000 std
MENU COLOR msg07        37;40   #90ffffff #a0000000 std
MENU COLOR tabmsg       31;40   #30ffffff #00000000 std


LABEL arch
       MENU LABEL Arch Linux
       LINUX ../vmlinuz-linux
       APPEND root=$PARTITION_ROOT rw
       INITRD ../initramfs-linux.img


LABEL archfallback
       MENU LABEL Arch Linux Fallback
       LINUX ../vmlinuz-linux
       APPEND root=$PARTITION_ROOT rw
       INITRD ../initramfs-linux-fallback.img

LABEL hdt
       MENU LABEL HDT (Hardware Detection Tool)
       COM32 hdt.c32

LABEL reboot
       MENU LABEL Reboot
       COM32 reboot.c32

LABEL shutdown
       MENU LABEL Power Off
       COMBOOT poweroff.com
END


# end section sent to chroot
EOF

arch-chroot /mnt /bin/bash <<EOF
# Aur helper
function aur_install {
  local name=$1
  local url=$2

cat <<END | sudo -u $USER bash
mkdir /tmp/Aur
cd /tmp/Aur
wget "$url"
tar xzvf "$name".tar.gz
cd "$name"
makepkg -s --noconfirm
END

  pacman -U --noconfirm "/tmp/Aur/$name/$name"*.tar.xz
  rm -rf /tmp/Aur
}

# Install sudo
pacman -S --noconfirm sudo
sed -i '/^%wheel ALL=(ALL) ALL/s/^#//' /etc/sudoers

# Create user
useradd -m -G wheel -s /bin/bash $USER
echo $USER:$USER | chpasswd

# Install yaourt
aur_install package-query https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
aur_install yaourt https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz

# Install xorg-server
pacman -S --noconfirm - <<END
xorg-server
xorg-server-utils
xf86-video-vesa
END

# Install lxdm
pacman -S --noconfirm lxdm
aur_install industrial-arch-lxdm https://aur.archlinux.org/packages/in/industrial-arch-lxdm/industrial-arch-lxdm.tar.gz
sed -i 's/^theme=.*$/theme=industrial-arch-lxdm/' /etc/lxdm/lxdm.conf
systemctl enable lxdm

# Install i3
pacman -S --noconfirm - <<END
i3-wm
dmenu
i3status
i3lock
END

EOF

# Unmount
umount -R /mnt

echo "Done! Unmount the CD, then type 'reboot'."
