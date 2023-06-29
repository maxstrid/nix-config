{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-colors.url = "github:misterio77/nix-colors";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , rust-overlay
    , sops-nix
    , nixos-hardware
    , nix-colors
    , nixgl
    , nur
    , ...
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
        config.allowUnfreePredicate = (_: true);
        overlays = [
          rust-overlay.overlays.default
          nur.overlay
        ];
      };
    in
    {
      # For my nix-on-arch setup
      homeConfigurations = {
        "max" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            nur.hmModules.nur
            ./home
            ./common/home
            ./hosts/arch
            ./modules/river.nix
          ];

          extraSpecialArgs = { inherit nix-colors nixgl; };
        };
      };
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          inherit pkgs;

          system = "x86_64-linux";
          specialArgs = { inherit nix-colors; };
          modules = [
            nur.nixosModules.nur
            ./hosts/t480
            ({ pkgs, ... }: {
              environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
            })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.max = import ./common/home;
            }
          ];
        };
        x220 = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          modules = [
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit nix-colors; };
              home-manager.users.max = ./common/home;
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-x220
            nur.nixosModules.nur
            ./hosts/x220
            ./modules/dwm.nix
          ];
          specialArgs = {
            inherit home-manager;
          };
        };
        home-server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit nix-colors; };
          modules = [
            nixos-hardware.nixosModules.common-cpu-intel
            sops-nix.nixosModules.sops
            nur.nixosModules.nur
            ({ pkgs, sops, ... }: {
              sops.defaultSopsFile = ./secrets/secrets.yaml;
              sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
              sops.age.keyFile = "/var/lib/sops-nix/key.txt";
              sops.age.generateKey = true;
              sops.secrets.home_server.nextcloud_password = {
                sopsFile = ./secrets/secrets.yaml;
              };
            })
            ./hosts/home-server
          ];
        };
      };
    };
}
