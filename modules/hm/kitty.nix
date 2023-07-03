{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    font = {
      package =
        (pkgs.nerdfonts.override {
          fonts = [
            "JetBrainsMono"
          ];
        });
      name = "JetBrainsMono NF";
    };
    settings = {
      scrollback_lines = 10000;
      enable_audio_bell = false;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Gruvbox Dark";
  };
}
