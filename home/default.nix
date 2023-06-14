{ config, pkgs, ... }:

{
  imports = [
#    ./editor.nix
#    ./terminal.nix
#    ./river.nix
#    ./chrome.nix
#    ./dev.nix
#    ./packages.nix
    ./zsh.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
