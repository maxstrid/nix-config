{ lib, pkgs, ...}:

let
  rustPlatform = pkgs.makeRustPlatform {
    cargo = pkgs.rust-bin.stable.latest.minimal;
    rustc = pkgs.rust-bin.stable.latest.minimal;
  };
in
rustPlatform.buildRustPackage rec {
  name = "profiles";
  pname = "ff-profile-manager";

  src = pkgs.fetchFromGitHub {
    owner = "maxstrid";
    repo = pname;
    rev = "e0346f3ac814e08a9dca5c97429998d163702993";
    hash = "e0346f3ac814e08a9dca5c97429998d163702993";
  };

  cargoHash = "sha256-9pgzCX40GvdO9LGDIiwWM5e1fJOMMMAe6WZqZTZGxgU=";

  meta = with lib; {
    description = "A gui profile swithcer for firefox";
    homepage = "https://github.com/maxstrid/ff-profile-switcher";
    license = licenses.mit;
    maintaners = [ maintaners.tailhook ];
  };
}
