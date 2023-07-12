{ pkgs, ... }:

let
  gimp = pkgs.gimp.override {
    withPython = true;
  };
in
{
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.6-env"
  ];

  home.packages = [
    gimp
    pkgs.gimpPlugins.resynthesizer
  ];
}
