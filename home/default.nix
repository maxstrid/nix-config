{ config, pkgs, nix-colors, ... }:

{
  imports = [
    ./terminal.nix
    ./yambar.nix
    ./firefox.nix
    ./wm.nix
#    ./chrome.nix
    ./dev.nix
    ./packages.nix
  ];
}
