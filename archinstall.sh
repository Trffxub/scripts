#!/bin/bash
echo "Archlinux installation..."
mkfs.ext4 /dev/sda1>/dev/null
mount /dev/sda1 /mnt>/dev/null
pacstrap /mnt base linux linux-firmware sudo grub nano>/dev/null
genfstab -U /mnt>>/mnt/etc/fstab>/dev/null
arch-chroot /mnt /bin/bash <<EOF>/dev/null 2>&1
ln -sf /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
hwclock --systohc
echo "ru_RU.UTF-8 UTF-8">>/etc/locale.gen
locale-gen>/dev/null
echo "LANG=ru_RU.UTF-8>/etc/locale.conf
echo "Arch">/etc/hostname
uderadd -m user
passwd -d user
usermod -aG wheel,audio,video,storage user
echo "%wheel ALL=(ALL:ALL) ALL>>/etc/sudoers
grub-install --tagret=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
EOF
umount -R /mnt
echo "All Done! Now reboot your computer."
