pwd = $(shell pwd)

dirs = ~/.config ~/.local/share/fonts
dotfiles= fonts.conf pam_environment zprofile zshrc
config = alacritty fcitx5 kitty sway electron-flags.conf wayfire.ini
fonts = Operator_Mono_with_Lig

all: dir env conf font 

.PHONY: dir
dir: $(dirs)

# target = file, so if file/dir isn't exist to create it
$(dirs):
	@if ! test -d $@; then echo "mkdir $@" && mkdir -p $@; fi

.PHONY: env
env: $(dotfiles)

$(dotfiles): 
	@echo ln -s $(pwd)/env/$@  ~/.$@

.PHONY: conf
conf: $(config)

$(config):
	@echo ln -s $(pwd)/config/$@ ~/.config/$@


.PHONY: font
font: $(fonts)

$(fonts):
	@echo cp -r $(pwd)/share/fonts/$@ ~/.local/share/fonts/
