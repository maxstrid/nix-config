{ lib, config, pkgs, ... }:

{
  home.packages = [
    pkgs.firefox
    pkgs.exa
    pkgs.keepassxc
    pkgs.wl-clipboard
    pkgs.ripgrep
    pkgs.jdk
    (import ./backlight_script.nix { inherit pkgs; })
#    (import ./profile_script.nix { inherit lib; inherit pkgs; })
  ];
}
