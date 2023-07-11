{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "viins";
    dotDir = ".config/zsh";
    initExtra = ''
      zle -N autosuggest-accept
      bindkey '^R' history-incremental-search-backward
      bindkey '^[[Z' autosuggest-accept

      PROMPT="%B%F{11}%n%f%b%B%F{9}@%f%b%B%F{13}%m%f%b %B%F{11}(%f%b%B%F{9}%~%f%b%B%F{11})%f%b %B%F{13}❱%f%b "
      RPROMPT="%?"

      # Manage packages using nixpkgs
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
    '';
    shellAliases = {
      nvim = "TERM=xterm-kitty nvim";
      ls = "exa";
      rebuild = "sudo nixos-rebuild switch --flake ~/.config/nix-config/.#$(cat /proc/sys/kernel/hostname)";
      hm-rebuild = "home-manager switch --flake ~/.config/nix-config/.#max";
      rm-branches = "git branch | grep -v master | xargs git branch -D";
    };
    history = {
      path = "/home/max/.config/zsh/histfile";
      ignoreDups = true;
      save = 10000;
      share = true;
    };
  };
}
