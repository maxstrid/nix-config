{ config, pkgs, ...}:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = "set -o vi";
    shellAliases = {
      nvim = "TERM=xterm-kitty nvim";
      ls = "exa";
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nix-config/.#t480";
      rm-branches = "git branch | grep -v master | xargs git branch -D";
    };
  };

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
    theme = "Gruvbox Material Dark Medium";
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];
  };
}
