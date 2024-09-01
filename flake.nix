{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-master,
    home-manager,
    impermanence,
    ...
  } @ inputs:
  let
    inherit (self) outputs;
      systems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    overlays = import ./applications/overlays { inherit inputs; };
    nixosConfigurations = {
      acer = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./nixos/persistence.nix
          ./hardware/acer.nix
          ./applications/system-manager/default.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad = import ./applications/home-manager/default.nix;
            };
          }
        ];
      };
      umka = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./nixos/persistence.nix
          ./hardware/umka.nix
          ./applications/system-manager/default.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad = import ./applications/home-manager/default.nix;
            };
          }
        ];
      };
    };
  };
}
