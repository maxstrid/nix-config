{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.ms-vsliveshare.vsliveshare
      vscode-extensions.jdinhlife.gruvbox
      vscode-extensions.vscodevim.vim
    ];
  };
}
