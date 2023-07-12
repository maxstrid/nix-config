{ pkgs, ... }:

{
  home.packages = [
    pkgs.gimp
    pkgs.gimpPlugins.resynthesizer
  ];
}
