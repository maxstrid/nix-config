{ config, pkgs, ... }:

{
  imports = [
    ./sops.nix
    ./configuration.nix
  ];
}
