{ pkgs, ... }:

{
  home.packages = [
    pkgs.wbg
  ];
  home.file = {
    ".config/bg.png" = {
      source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/AngelJumbo/gruvbox-wallpapers/main/wallpapers/minimalistic/gruvbox_grid.png";
        sha256 = "sha256-b7hN7xV/0a/7NVB3jLimPsaIO+ZLXGym7Hmvu5UsPoI=";
      };
    };
  };
}
