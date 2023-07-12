{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = false;

    # For gimp
    permittedInsecurePackages = [
      "python-2.7.18.6-env"
    ];
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For swaylock.
  security.pam.services.swaylock = { };

  boot.initrd.luks.devices = {
    crypt = {
      device = "/dev/disk/by-uuid/a7407632-441f-48c0-9b06-48b691457eef";
      preLVM = true;
    };
  };

  fonts.fonts = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  boot.loader.grub.efiSupport = true;

  networking.hostName = "x220";
  networking.wireless.iwd.enable = true;

  time.timeZone = "US/Pacific";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
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


  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.users.max = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl
  ];

  services.tlp.enable = true;
  services.upower.enable = true;

  system.stateVersion = "23.05";
}

