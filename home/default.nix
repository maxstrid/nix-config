{ config, pkgs, nix-colors, ... }:

{
  imports = [
    nix-colors.homeManagerModules.default
    ./editor.nix
    ./terminal.nix
    ./wm.nix
#    ./river.nix
#    ./chrome.nix
    ./dev.nix
#    ./packages.nix
  ];

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;

  home.username = "max";
  home.homeDirectory = "/home/max";

  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
