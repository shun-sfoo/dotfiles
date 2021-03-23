{ config, pkgs, ...}:

{
  users.users.neo = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  users.defaultUserShell = pkgs.zsh;
}

