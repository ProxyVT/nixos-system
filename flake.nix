{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    nixpkgs-betterbird.url = "github:nixos/nixpkgs/f24617855643c0e041a83f7f8acffeda1d71f184";
    nixpkgs-skype.url = "github:nixos/nixpkgs/7f345442bd1c23a44324598349b0f9a0b6f9718d";
    impermanence.url = "github:nix-community/impermanence";
    chaotic.url = "github:chaotic-aur/nyx/nyxpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-release,
      nixpkgs-edge,
      nixpkgs-testing,
      nixpkgs-betterbird,
      nixpkgs-skype,
      impermanence,
      chaotic,
      home-manager,
      ...
    }@inputs:

    let
      inherit (self) outputs;
    in
    {
      overlays = import ./applications/system-manager/overlays { inherit inputs; };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos
            ./applications/system-manager
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            chaotic.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ulad = import ./applications/home-manager;
              };
            }
          ];
        };
        acer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos
            ./applications/system-manager
            ./hardware/acer.nix
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            chaotic.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ulad = import ./applications/home-manager;
              };
            }
          ];
        };
        umka = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos
            ./applications/system-manager
            ./hardware/umka.nix
            home-manager.nixosModules.home-manager
            impermanence.nixosModules.impermanence
            chaotic.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.ulad = import ./applications/home-manager;
              };
            }
          ];
        };
        exampleIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./iso/configuration.nix
          ];
        };
      };
    };
}
