# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ];

# Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

# Set your time zone.
  time.timeZone = "Asia/Shanghai";

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
# Per-interface useDHCP will be mandatory in the future, so this generated config
# replicates the default behaviour.
# networking.useDHCP = false;
# networking.interfaces.wlp2s0.useDHCP = true;

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
# };

  networking = {
    hostName = "matrix";
    networkmanager.enable = true;
    extraHosts =
      ''
      199.232.68.133	raw.githubusercontent.com
      '';
  };

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };



# Configure keymap in X11
# services.xserver.layout = "us";
# services.xserver.xkbOptions = "eurosign:e";

# Enable CUPS to print documents.
# services.printing.enable = true;

# Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.neo = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager"  ]; # Enable ‘sudo’ for the user.
    };

  };

# List packages installed in system profile. To search, run:
# $ nix search wget
  programs = {
    zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    };

    bash.enableCompletion = true;
    thefuck.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      wget
      neovim
      emacs
      git
      xclip
      bat
      exa
      fd
      ripgrep  
      starship
      zoxide
      tealdeer
      kitty
      neofetch
      firefox
    ];

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];
  };

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      fira-code
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

