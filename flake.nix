{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    multios-usb = {
      url = "github:Mexit/MultiOS-USB";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      impermanence,
      nix-flatpak,
      home-manager,
      xlibre-overlay,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs system; };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
      defaultModules = [
        ./nixos
        ./applications/system-manager
        home-manager.nixosModules.default
        impermanence.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
      ];
      xlibreModules = [
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
      ];
      mkNixosConfig =
        {
          hardwareFile,
        }:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = defaultModules ++ [ hardwareFile ];
        };
    in
    {
      custom-packages = import ./applications/system-manager/overlays { inherit inputs system; };
      packages."${system}" = pkgs;
      nixosConfigurations = {
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        umka = mkNixosConfig { hardwareFile = ./hardware/umka.nix; };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
        exampleIso = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./iso/configuration.nix ];
        };
      };
    };
}
