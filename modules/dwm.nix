{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (self: super: {
      dwm = super.dwm.overrideAttrs (oldAttrs: rec {
        src = builtins.fetchGit https://github.com/maxstrid/dwm;
      });
      st = super.st.overrideAttrs (oldAttrs: rec {
        src = builtins.fetchGit https://github.com/maxstrid/st;
      });
    })
  ];

  home.packages = [
    pkgs.dmenu
  ];

  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono"]; })
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    displayManager = {
      dwm.enable = true;
      startx.enable = true;
    };
  };

  home.file = {
    ".xinitrc" = {
      enable = true;
      text = ''
        pipewire &
        exec dwm
      '';
    };
  };
}
