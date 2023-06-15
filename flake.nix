{
  description = "NixOS Configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, nix-colors, nixgl, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    # For my nix-on-arch setup
    homeConfigurations."max" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home ./hosts/arch ];
        extraSpecialArgs = { inherit nix-colors; inherit nixgl; };
    };
    nixosConfigurations = {
      t480 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit nix-colors; };
        modules = [
          ./hosts/t480
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
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
