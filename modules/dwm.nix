{ config, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = builtins.fetchGit https://github.com/maxstrid/dwm; });
      st = prev.st.overrideAttrs (old: { src = builtins.fetchGit https://github.com/maxstrid/st; });
    })
  ];

  environment.systemPackages = [
    pkgs.dmenu
    pkgs.st
  ];

  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager = {
      dwm.enable = true;
      dwm.package = pkgs.dwm;
    };
  };

  home-manager.users.max.home.file = {
    ".xinitrc" = {
      enable = true;
      text = ''
        pipewire &
        exec dwm
      '';
    };
  };
}

