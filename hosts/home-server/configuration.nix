{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "i915" ];

  networking.hostName = "home-server";

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];


  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      libvdpau-va-gl
      intel-media-driver
      mesa
      vulkan-loader
    ];
  };

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      vim
      curl
      wget
    ];
  };

  services.openssh = {
    enable = true;
    ports = [ 2222 ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 2222 ];
      extraCommands = "iptables -t nat -A POSTROUTING -d 104.9.124.207 -p tcp -m tcp --dport 2222 -j MASQUERADE";
    };
    nat = {
      enable = true;
      internalInterfaces = [ "wg0" ];
      externalInterface = "eno1";
      forwardPorts = [{
        sourcePort = 2222;
        proto = "tcp";
        destination = "104.9.124.207";
      }];
    };
  };

  system.stateVersion = "23.05";
}
