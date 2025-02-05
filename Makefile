pwd = $(shell pwd)

dirs = ~/.config
dotfiles = zshrc ideavimrc tmux.conf
config =  kitty
fonts = Operator_Mono_with_Lig

all: dir env conf

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
	cp -r $(pwd)/fonts/$@ ~/Library/Fonts/
