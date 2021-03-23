{ config, pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
    bash.enableCompletion = true;
    thefuck.enable = true;
  };
}
