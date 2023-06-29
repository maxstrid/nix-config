{ config, pkgs, lib, sops, ... }:

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

  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      git
      vim
      curl
      wget
      rclone
    ];
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22 80 443
      # Jellyfin ports
      8096 8920
    ];
    allowedUDPPorts = [
      # Jellyfin ports
      1900 7359
    ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      intel-media-driver
      intel-compute-runtime
      libvdpau-va-gl
      vulkan-loader
      mesa
    ];
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no";
        LogLevel = "VERBOSE";
        PasswordAuthentication = false;
      };
    };

    nextcloud = {
      enable = true;
      package = pkgs.nextcloud27;
      hostName = "192.168.1.90";
      configureRedis = true;
      caching.apcu = false;
      config.adminpassFile = "${pkgs.writeText "adminpass" "${config.sops.secrets.home_server.nextcloud_password}"}";
    };

    jellyfin.enable = true;
  };

  system.stateVersion = "23.05";
}
