{ config, pkgs, nixgl, ... }:

{
  nixpkgs.overlays = [ nixgl.overlay ];

  home.packages = [
    pkgs.nixgl.nixGLIntel
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);
}
