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
    pkgs.rust-bin.stable.latest.default
    (import ./backlight_script.nix { inherit pkgs; })
  ];
}
