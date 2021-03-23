{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./config/boot.nix
    ./config/fonts.nix
    ./config/i18n.nix
    ./config/networking.nix
    ./config/services.nix
    ./config/programs.nix
    ./config/users.nix
    ./config/environment.nix
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  system.stateVersion = "20.09"; 
}
