{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.kitty
    pkgs.firefox
    pkgs.exa
    pkgs.alsa-utils
    pkgs.keepassxc
    pkgs.wl-clipboard
    pkgs.bazel
    pkgs.ripgrep
    pkgs.jdk
    (import ./backlight_script.nix { inherit pkgs; })
  ];
}
