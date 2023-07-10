{ pkgs, ... }:

{
  home.packages = [
    pkgs.swayidle
    # Swaylock doesn't work with home-manager off nixos
    # pkgs.swaylock
  ];

  home.file = {
    ".config/swaylock/config" = {
      text = ''
        image=/home/max/.config/bg.png
      '';
    };

    ".config/swayidle/config" = {
      text = ''
        timeout 360 "systemctl hybrid-sleep"
        before-sleep swaylock
        lock swaylock
      '';
    };
  };
}
