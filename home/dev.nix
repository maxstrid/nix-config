{ config, pkgs, ...}:

{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        setEnv = {
          "TERM" = "xterm-256color";
        };
      };
      "software.frc971.org" = {
        identityFile = "/home/max/.ssh/id_971_ed25519";
      };
      "github.com" = {
        identityFile = "/home/max/.ssh/id_github_ed25519";
      };
      "build" = {
        hostname = "build.frc971.org";
        port = 2222;
        identityFile = "/home/max/.ssh/id_971_ed25519";
        user = "maxwellh";
      };
      "971" = {
        hostname = "10.9.71.2";
        user = "admin";
      };
      "9971" = {
        hostname = "10.99.71.2";
        user = "admin";
      };
      "8971" = {
        hostname = "10.89.71.2";
        user = "admin";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Maxwell Henderson";
    userEmail = "maxwell.henderson@mailbox.org";
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs; [
      vscode-extensions.ms-vsliveshare.vsliveshare
      vscode-extensions.jdinhlife.gruvbox
      vscode-extensions.vscodevim.vim
    ];
  };
}
