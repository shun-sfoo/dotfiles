#!/bin/zsh

#  inspired by R0boter/ArchlinuxInstall

t_hdd=""
s_boot=""
s_root=""
s_swap=""
f_swap=false
function arch_chroot(){
	arch-chroot /mnt "bin/bash" -c "${1}"
}

function chk_uefi() {
	if (ls /sys/firmware/efi/efivars > /dev/null 2>&1) {
		# Succeed
		print "Your system is boot with UEFI! It's great!"
		read -p "Let's start your archlife!, If your are not ready, you can use ctrl-c to end."
	} else {
		# Failed
		print "Sorry, Please use UEFI to boot your system!"
		exit 0
	}
}


function select_hdd_type() {
	print "Choose your hdd type"
	select hdd (sda nvme0n1 mmcblk0) {
		t_hdd=$hdd
		if [[ "$hdd" == "sda" ]] {
			s_boot=$hdd"1"
			s_root=$hdd"2"
		} elif [[ "$hdd" == "mmcblk0" ]] {
			s_boot=$hdd"p1"
			s_root=$hdd"p2"
			s_swap=$hdd"p3"
			f_swap=true
		} else {
			s_boot=$hdd"p1"
			s_root=$hdd"p2"
		}
		break
	}
}

function format_disk() {
	print "y/n" |mkfs.ext4 /dev/$t_hdd
	print "n\n1\n\n+512M\nef00\nw\ny\n" | gdisk /dev/$t_hdd && yes | mkfs.fat -F32 /dev/$s_boot
	if (f_swap) {
	print "n\n3\n\n+4G\n8200\nw\ny\n" | gdisk /dev/$t_hdd
	mkswap /dev/$s_swap
	swapon /dev/$s_swap
	}
  printf "n\n2\n\n\n8300\nw\ny\n" | gdisk /dev/$t_hdd && yes | mkfs.ext4 /dev/$s_root
	mount /dev/$s_root /mnt && mkdir /mnt/boot && mount /dev/$s_boot /mnt/boot
}

function cfg_mirror(){
    mv -f /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
    curl -Lo mirrorlist "https://www.archlinux.org/mirrorlist/?country=CN&protocol=http&protocol=https&ip_version=4&ip_version=6"
    wait
    sed -i 's/^#Server/Server/g' ./mirrorlist
    mv -f ./mirrorlist /etc/pacman.d/mirrorlist
    chmod 644 /etc/pacman.d/mirrorlist
}

function install_base(){
	pacstrap /mnt base linux linux-firmware sudo zsh neovim
}

function cfg_system(){
    # creat fstab file
    genfstab -U /mnt >> /mnt/etc/fstab
    # set time zone
    arch_chroot "ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime"
    arch_chroot "hwclock --systohc"
    # set locale
    arch_chroot "sed -i 's/#\(en_US.UTF-8\)/\1/' /etc/locale.gen"
    arch_chroot "sed -i 's/#\(zh_CN.UTF-8\)/\1/' /etc/locale.gen"
    arch_chroot "sed -i 's/#\(zh_CN.GBK\)/\1/' /etc/locale.gen"
    arch_chroot "locale-gen"
    arch_chroot "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"
    # set hostname Archlinux is your hostname
    arch_chroot "echo 'Archlinux' > /etc/hostname"
    arch_chroot "echo '199.232.68.133	raw.githubusercontent.com' >> /etc/hosts"
    # set locale hosts file
    # arch_chroot "wget https://raw.githubusercontent.com/googlehosts/hosts/master/hosts-files/hosts -O /etc/hosts"
}

function cfg_boot(){
  arch_chroot "pacman -S intel-ucode os-prober grub efibootmgr --noconfirm"
  arch_chroot "grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub"
  arch_chroot "grub-mkconfig -o /boot/grub/grub.cfg"
}

function install_program(){
    arch_chroot "pacman -S which git wget curl dialog wpa_supplicant ntfs-3g networkmanager --noconfirm"
    arch_chroot "systemctl enable NetworkManager"
    arch_chroot "curl https://raw.githubusercontent.com/shun-sfoo/dotfiles/main/shell/archDesktop.sh > $HOME/archDesktop.sh"
}

function cfg_user(){
    # set root passwd
    arch_chroot "echo 'root:$toor' | chpasswd"
    # creat normal user raven and set passwd
    arch_chroot "useradd -m -g users -s /usr/bin/zsh -G wheel,uucp $username && echo '$username:$passwd' | chpasswd"
    # set sudo file
    arch_chroot "sed -i '/NOPASSWD/s/^#\ //' /etc/sudoers"
}

dhcpcd
timedatectl set-ntp true
select_hdd_type
format_disk
cfg_mirror
install_base
cfg_system
cfg_boot
install_program
cfg_user
