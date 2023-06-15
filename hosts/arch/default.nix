{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.nixgl.nixGLIntel
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
}
