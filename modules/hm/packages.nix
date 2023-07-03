{ pkgs, ... }:

{
  home.packages = [
    pkgs.firefox
    pkgs.dolphin-emu
    pkgs.exa
    pkgs.keepassxc
    pkgs.wl-clipboard
    pkgs.ripgrep
    pkgs.jdk
    (import ./backlight_script.nix { inherit pkgs; })
  ];
}
