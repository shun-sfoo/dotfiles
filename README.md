# Dotfiles

## kitty

To generate new default Configuration by `ctrl+shift+F2`.

When new version published if some new feature add. Use vim -d old new to compare.

## remote

Add gitee repo

## Use bash instead of zsh

## Waybar Configuration

## Fonts

If have any question about fonts, please refer to see `$HOME/.fonts.conf` and [link](https://catcat.cc/post/2021-03-07/)

## Packages

To backup  by use `pacman -Qqe > packages.list`

Count by `pacman -Qqe | wc -l`

Restore by `cat packages.list |tr '\n' ' '` to combine multiple line to one line
separator by space.

And then use `pacman -S --needed` the preview output.
