{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.kernelModules = [ "i915" ];

  boot.initrd.luks.devices = {
    crypt = {
      device = "/dev/disk/by-uuid/5c0424bd-6196-454c-99c8-b9c4dad58367";
      preLVM = true;
    };
  };

  networking.hostName = "t480";
  networking.wireless.iwd.enable = true;

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
  };

  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c river";
      };
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    clang
    gcc
    gnumake
    llvm
    libcxx
    python3
    greetd.tuigreet
  ];

  hardware.opengl.enable = true;

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    vaapiIntel
    libvdpau-va-gl
    intel-media-driver
    mesa
    vulkan-loader
  ];

  users.users.max.isNormalUser = true;
  users.users.max.extraGroups = [ "wheel" ];

  services.tlp.enable = true;
  services.upower.enable = true;

  system.stateVersion = "22.11";
}
