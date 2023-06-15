{ config, pkgs, nix-colors, ... }:

# Nix config for my window manager
let 
  background_path = ".config/bg.png";
in {
  home.file = {
    ".config/bg.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/ngynLk/wallpapers/master/nature/florest-stair2.jpg";
        sha256 = "sha256-VaD6gCeW2QiK405J7nzdNtv9jmmDfQeUyfkwwvWSYS8=";
      };
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      image = "/home/max/${background_path}";
    };
  };

  services.mako = {
    enable = true;
    backgroundColor = "${config.colorScheme.colors.base00}";
    borderColor = "${config.colorScheme.colors.base0A}";
    width = 300;
    height = 110;
    borderSize = 2;
    defaultTimeout = 15000;
    icons = false;
    ignoreTimeout = true;
  };
}
