{ config, pkgs, nixgl, ... }:

{
  nixpkgs.overlays = [ nixgl.overlay ];

  home.packages = [
    pkgs.nixgl.nixGLIntel
  ];

  home.sessionVariables = {
    TERMINAL = "nixGLIntel kitty";
  };
}
