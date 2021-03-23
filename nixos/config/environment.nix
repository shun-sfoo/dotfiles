{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
             url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
             }))
  ];

  environment = {
    pathsToLink = [ "/libexec"];
    systemPackages = with pkgs; [
      wget
      git
      xclip
      bat
      exa
      fd
      ripgrep
      starship
      zoxide
      rust-analyzer
      tealdeer
      firefox
      kitty
      lxappearance
      neofetch
      capitaine-cursors
      neovim-nightly
      picom
      ranger
    ];

    shells = [ 
      pkgs.bashInteractive 
      pkgs.zsh 
    ];
  };
}
