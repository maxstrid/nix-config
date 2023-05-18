{ config, pkgs, ... }:

{
  imports = [
    ./editor.nix
    ./terminal.nix
    ./river.nix
    ./chrome.nix
    ./dev.nix
    ./packages.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";

  fonts.fontconfig.enable = true;
  home.stateVersion = "22.11";

  programs.home-manager.enable = true;
}
