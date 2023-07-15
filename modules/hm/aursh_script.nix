{ pkgs, ... }:

with pkgs;

stdenv.mkDerivation rec {
  name = "backlight";

  src = fetchFromGitHub {
    owner = "maxstrid";
    repo = "aursh";
    rev = "5dbf38497dc2fb119c41e4c15abecd803051ddac";
    sha256 = "sha256-Syrnbw8wYvu2V5sRYBtUFGmwdGOVIlmiZldV3YXlFbU=";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod +x aursh
    mv aursh $out/bin/backlight
  '';
}
