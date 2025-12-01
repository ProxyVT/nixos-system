{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/*.tar.gz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "github:DeterminateSystems/determinate";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        determinate-nixd-aarch64-linux.follows = "";
        determinate-nixd-aarch64-darwin.follows = "";
      };
    };
    chaotic = {
      url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
      inputs = {
        flake-schemas.follows = "";
      };
    };
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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
      chaotic,
      home-manager,
      xlibre-overlay,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs system; };
      defaultModules = [
        ./nixos
        ./applications/system-manager
        determinate.nixosModules.default
        home-manager.nixosModules.default
        impermanence.nixosModules.default
        chaotic.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
      ];
      xlibreModules = [
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
        xlibre-overlay.nixosModules.nvidia-ignore-ABI
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
      nixosConfigurations = {
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        umka = mkNixosConfig {
          hardwareFile = ./hardware/umka.nix;
          enableXlibre = false;
        };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
        exampleIso = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./iso/configuration.nix ];
        };
      };
    };
}
