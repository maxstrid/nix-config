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
    nix-colors.url = "github:misterio77/nix-colors";
    rust-overlay.url = "github:oxalica/rust-overlay";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, nix-colors, nixgl, nur, ... }:
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
  in {
    # For my nix-on-arch setup
    homeConfigurations = {
      "max" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          nur.hmModules.nur
          ./home
          ./hosts/arch
        ];

        extraSpecialArgs = { inherit nix-colors nixgl; };
      };
    };
    nixosConfigurations = {
      t480 = pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nix-colors; };
        modules = [
          nur.nixosModules.nur
          ./hosts/t480
          ({ pkgs, ... }: {
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.max = import ./home;
          }
        ];
      };
    };

  };
}
