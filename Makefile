brew ?= brew
cfg_dir ?= $(HOME)/.config

default: dump

dump:
	$(brew) bundle dump --describe --force --file="./Brewfile"

recovery:
	$(brew) bundle --file="./Brewfile"
