#!/bin/zsh

#  inspired by R0boter/ArchlinuxInstall

function cfg_gpu() {
	print "choose your gpu"
	select gpu (amd nvidia no) {
		if [[ "$gpu" == "amd" ]] {
			sudo pacman -S xf86-video-amdgpu --noconfirm
		} elif [[ "$gpu" == "nvidia" ]] {
			sudo pacman -S nvidia --noconfirm
		} else {
			print " gpu will not to install"
		}
		break
	}
}


function cfg_xorg() {
	 sudo pacman -S xorg xorg-xinit --noconfirm
   cp /etc/X11/xinit/xinitrc ~/.xinitrc
   sed -i '/twm/,$d' ~/.xinitrc
}

function cfg_desktop() {
	print "choose your desktop (kde is available)"
	select env (kde i3wm gnome) {
		[[ "$env" == "kde" ]] && {
			sudo pacman -S plasma dolphin --noconfirm
			sudo systemctl enable sddm
      echo "exec startplasma-x11 >> $HOME/.xinitrc" 
		}
		break
	}
}

function cfg_fonts() {
	sudo pacman -S fontconfig ttf-dejavu noto-fonts noto-fonts-cjk notot-fonts-emoji --noconfirm
}

function cfg_tools() { 
	sudo pacman -S base-devel kitty chromium  ripgrep ctags --noconfirm
}

cfg_gpu
cfg_fonts
cfg_xorg
cfg_desktop
cfg_tools
