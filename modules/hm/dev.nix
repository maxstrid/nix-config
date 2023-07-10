{ ... }:

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
      "home-server" = {
        hostname = "192.168.1.90";
        identitiesOnly = true;
        identityFile = "/home/max/.ssh/id_home_server_ed25519";
        user = "admin";
      };
      "orange_pi" = {
        hostname = "192.168.1.200";
        identitiesOnly = true;
        identityFile = "/home/max/.ssh/id_orange_pi_ed25519";
        user = "admin";
      };
      "build" = {
        hostname = "build.frc971.org";
        forwardAgent = true;
        identitiesOnly = true;
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
      "7971" = {
        hostname = "10.79.71.2";
        user = "admin";
      };
      "pi1" = {
        hostname = "10.9.71.101";
        user = "pi";
      };
      "pi2" = {
        hostname = "10.9.71.102";
        user = "pi";
      };
      "pi3" = {
        hostname = "10.9.71.103";
        user = "pi";
      };
      "pi4" = {
        hostname = "10.9.71.104";
        user = "pi";
      };
      "pi5" = {
        hostname = "10.9.71.105";
        user = "pi";
      };
      "pi6" = {
        hostname = "10.9.71.106";
        user = "pi";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Maxwell Henderson";
    userEmail = "maxwell.henderson@mailbox.org";
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
