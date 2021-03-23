{ config, pkgs, callPackage, ... }:

{
  services = {
    printing.enable = true;

    tlp.enable = true;
    xserver = {
      enable = true;

      libinput.enable = true;

      xkbOptions = "ctrl:swapcaps";

      desktopManager = {
        xterm.enable = false;
      };

      displayManager = {
        defaultSession = "none+i3";
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu
          i3status
          i3lock
          i3blocks
        ];
        package = pkgs.i3-gaps;
      };
    };
  };
}
