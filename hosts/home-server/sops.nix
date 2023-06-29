{ config, pkgs, sops, ... }:

{
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.age.generateKey = true;
  sops.secrets = {
    nextcloud_password = {
      sopsFile = ./secrets.yaml;
      owner = config.users.users.admin.name;
      group = config.users.users.admin.group;
    };
  };
}
