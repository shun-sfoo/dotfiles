{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true; # nmtui
    extraHosts =
    ''
    199.232.68.133	raw.githubusercontent.com
    '';
  };
}
