{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.11/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.xserver-meson-flags.follows = "xserver-meson-flags-local";
    };
    xserver-meson-flags-local = {
      url = "./xserver-meson-flags.nix";
      flake = false;
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
      determinate,
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
        determinate.nixosModules.default
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
          enableXlibre ? true,
        }:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = defaultModules ++ nixpkgs.lib.optionals enableXlibre xlibreModules ++ [ hardwareFile ];
        };
    in
    {
      custom-packages = import ./applications/system-manager/overlays { inherit inputs system; };
      packages."${system}" = pkgs;
      nixosConfigurations = {
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        umka = mkNixosConfig {
          hardwareFile = ./hardware/umka.nix;
          enableXlibre = true;
        };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
        exampleIso = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./iso/configuration.nix ];
        };
      };
    };
}
