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

  home.packages = [
    pkgs.nixgl.nixGLIntel
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  colorScheme = nix-colors.colorSchemes.gruvbox-dark-hard;

  home.username = "max";
  home.homeDirectory = "/home/max";

  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
