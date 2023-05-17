{ pkgs, ...}:

with pkgs;

stdenv.mkDerivation rec {
  name = "backlight";

  src = fetchFromGitHub {
    owner = "maxstrid";
    repo = "backlight";
    rev = "7a7b5fbdaf87cb80b65d283a8f70fcf860a92fbf";
    sha256 = "sha256-Syrnbw8wYvu2V5sRYBtUFGmwdGOVIlmiZldV3YXlFbU=";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod +x backlight.py
    mv backlight.py $out/bin/backlight
  '';
}
