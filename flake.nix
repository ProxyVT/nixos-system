{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    nixpkgs-betterbird.url = "github:nixos/nixpkgs/f24617855643c0e041a83f7f8acffeda1d71f184";
    nixpkgs-skype.url = "github:nixos/nixpkgs/7f345442bd1c23a44324598349b0f9a0b6f9718d";
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat = {
      url = "https://git.lix.systems/lix-project/flake-compat/archive/main.tar.gz";
      flake = false;
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
      nix-vscode-extensions,
      nix-flatpak,
      impermanence,
      chaotic,
      home-manager,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      defaultModules = [
        ./nixos
        ./applications/system-manager
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        nix-flatpak.nixosModules.nix-flatpak
        chaotic.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = ".backup";
            users.ulad.imports = [
              ./applications/home-manager
              impermanence.homeManagerModules.impermanence
            ];
          };
        }
      ];
    in
    {
      overlays = import ./applications/system-manager/overlays { inherit inputs; };
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = defaultModules;
        };
        acer = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = defaultModules ++ [ ./hardware/acer.nix ];
        };
        umka = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = defaultModules ++ [ ./hardware/umka.nix ];
        };
        nvidia = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = defaultModules ++ [ ./hardware/nvidia.nix ];
        };
        exampleIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [ ./iso/configuration.nix ];
        };
      };
    };
}
