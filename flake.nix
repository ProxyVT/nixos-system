{
  description = "Personal flake configuration";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable-small/nixexprs.tar.xz";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    multios-usb = {
      url = "github:Mexit/MultiOS-USB";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    picom = {
      url = "github:yshui/picom";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      impermanence,
      nix-flatpak,
      home-manager,
      xlibre-overlay,
      agenix,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      inherit (chaotic.vendored) jovian;
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs system; };
      defaultModules = [
        ./nixos
        ./applications/system-manager
        home-manager.nixosModules.default
        chaotic.nixosModules.default
        jovian.nixosModules.default
        impermanence.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
        xlibre-overlay.nixosModules.overlay-xpra
        agenix.nixosModules.default
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
      nixosConfigurations = {
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        steam = mkNixosConfig { hardwareFile = ./hardware/steam.nix; };
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        umka = mkNixosConfig { hardwareFile = ./hardware/umka.nix; };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
      };
    };
}
