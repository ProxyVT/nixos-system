{
  description = "Personal flake configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nixpkgs-release.url = "https://channels.nixos.org/nixos-25.05/nixexprs.tar.xz";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    impermanence.url = "github:nix-community/impermanence/home-manager-v2";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
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
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
      inputs = {
        nixpkgs.follows = "nixpkgs";
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
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
        xlibre-overlay.nixosModules.nvidia-ignore-ABI
      ];
      mkNixosConfig =
        hardwareFile:
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = defaultModules ++ [ hardwareFile ];
        };
    in
    {
      custom-packages = import ./applications/system-manager/overlays { inherit inputs system; };
      nixosConfigurations = {
        nixos = mkNixosConfig ./hardware/default.nix;
        acer = mkNixosConfig ./hardware/acer.nix;
        umka = mkNixosConfig ./hardware/umka.nix;
        nvidia = mkNixosConfig ./hardware/nvidia.nix;
        exampleIso = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = [ ./iso/configuration.nix ];
        };
      };
    };
}
