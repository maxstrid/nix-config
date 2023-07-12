{ pkgs, ... }:

let
  gimp = pkgs.gimp.override {
    withPython = true;
  };
in
{
  home.packages = [
    gimp
    pkgs.gimpPlugins.resynthesizer
  ];
}
