{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    aggressiveResize = true;
    keyMode = "vi";
    historyLimit = 5000;
    newSession = true;
    sensibleOnTop = true;
    plugins = with pkgs.tmuxPlugins; [
      yank
      gruvbox
      tmux-thumbs
    ];
  };
}
