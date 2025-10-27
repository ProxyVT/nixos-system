{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    nixpkgs-skype.url = "github:nixos/nixpkgs/7f345442bd1c23a44324598349b0f9a0b6f9718d";
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    determinate.url = "github:DeterminateSystems/determinate";
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
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay";
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
      nixpkgs-skype,
      nix-vscode-extensions,
      nix-flatpak,
      impermanence,
      determinate,
      chaotic,
      home-manager,
      xlibre-overlay,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      defaultModules = [
        ./nixos
        ./applications/system-manager
        determinate.nixosModules.default
        home-manager.nixosModules.home-manager
        impermanence.nixosModules.impermanence
        nix-flatpak.nixosModules.nix-flatpak
        chaotic.nixosModules.default
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
        xlibre-overlay.nixosModules.nvidia-ignore-ABI
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
