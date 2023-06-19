{ config, pkgs, nixgl, ... }:

{
  nixpkgs.overlays = [ nixgl.overlay ];

  home.packages = [
    pkgs.nixgl.nixGLIntel
    pkgs.rust-bin.stable.latest.default
  ];

  home.sessionVariables = {
    TERMINAL = "nixGLIntel kitty";
  };
}
