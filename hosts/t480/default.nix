{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];

  # Needs to be done b/c these are broken
  # on arch
  home.packages = [
    pkgs.swaylock
    pkgs.yambar
  ];

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}
