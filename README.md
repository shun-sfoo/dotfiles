# dotfiles

osx and linux dotfiles

## osx

### 不要安装的应用

原因：会安装太多依赖的软件，不符合极简

- [x] neofetch
- [x] youtube-dl
- [x] ffmpeg

## linux

clash for linux is important
should have config.yaml by visit subscribe url download
should have country.mmdb found in github `Dreamacro/maxmind-geoip`
should modify explorer proxy setting in manual proxy fit in ftp https port:7890 and socks5 port:7891
and zshrc

[link](https://instruction.lnds.top/software/linux/clash)

## nixos

nixos 目前来看是可以当作养老的 linux 版本.

## nixos 开发环境

nixos 通过 nix-shell 命令需要环境中的 default.nix 或者 shell.nix
配置文件生成配置中的开发环境，类似于 docker.
各配置文件参考文档.
也可以生成纯净环境,类似于`nix-shell -p rustc cargo`

## arch

archlinux dotfiles

### format

better format is parted see nixos installationo

### connect wifi

```shell
ip link
ip link set $device up
iwlist $device scan |grep ESSID
wpa_passphrase $wifi_name $password > $netfilename (iwctl)
wpa_supplicant -c $netfilename -i $device &
```

### dwm patches

alpha
hide-vacant-tags
