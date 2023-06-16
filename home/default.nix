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

  # Based on morhetz gruvbox
  colorScheme = {
    slug = "gruvbox";
    name = "Gruvbox";
    author = "Morhetz (https://github.com/morhetz/gruvbox)";
    colors = {
      base00 = "#1D2021"; # BG
      base01 = "#282828"; # Lighter BG
      base02 = "504945"; # --
      base03 = "665c54"; # -
      base04 = "bdae93"; # +
      base05 = "d5c4a1"; # ++
      base06 = "ebdbb2"; # +++
      base07 = "fbf1c7"; # ++++
      base08 = "#CC241D"; # Red
      base09 = "#D65D0E"; # Orange
      base0A = "#D79921"; # Yellow
      base0B = "#98971A"; # Green
      base0C = "#689D6A"; # Aqua
      base0D = "#458588"; # Blue
      base0E = "#B16286"; # Purple
      base0F = "#D65D0E"; # Brown
    };
  };

  home.username = "max";
  home.homeDirectory = "/home/max";

  fonts.fontconfig.enable = true;
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}
