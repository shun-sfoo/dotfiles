pwd = $(shell pwd)

dirs = ~/.config ~/.local/share/fonts
dotfiles= fonts.conf inputrc bashrc bash_profile bash_aliases
config = kitty hypr waybar 
fonts = Operator_Mono_with_Lig
copyconfig = fcitx5

all: dir env conf font cp

.PHONY: dir
dir: $(dirs)

# NOTE: if a target don't executed, consider target file existed!!!
# target = file, so if file/dir isn't exist to create it, so dir existed the target will not executed.
$(dirs):
	@if ! test -d "$@"; then echo "mkdir $@ done" && mkdir -p $@; fi

.PHONY: env
env: $(dotfiles)

$(dotfiles): 
	@if ! test -e ~/.$@; then echo "link $@ done" &&  ln -s $(pwd)/env/$@  ~/.$@; else echo "$@ existed"; fi

.PHONY: conf
conf: $(config)

$(config):
	@if ! test -e ~/.config/$@; then echo "link $@ done" &&  ln -s $(pwd)/config/$@ ~/.config/$@; else echo "$@ existed"; fi

.PHONY: font
font: $(fonts)

$(fonts):
	@if ! test -d ~/.local/share/fonts/$@; then echo "copy $@ done" &&  cp -r $(pwd)/share/fonts/$@ ~/.local/share/fonts/; else echo "$@ existed"; fi

.PHONY: cp
cp: $(copyconfig)

$(copyconfig):
	@if ! test -e ~/.config/$@; then echo "copy $@ done" && cp -r $(pwd)/config/$@ ~/.config/$@; else echo "$@ existed"; fi
