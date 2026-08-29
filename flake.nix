{
  description = "Personal flake configuration";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
    multios-usb.url = "github:Mexit/MultiOS-USB";
    multiverse.url = "github:fzakaria/nixpkgs-multiverse";
    nh.url = "github:nix-community/nh";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    picom.url = "github:yshui/picom";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
  };

  outputs =
    {
      agenix,
      chaotic,
      home-manager,
      impermanence,
      nix-flatpak,
      nixpkgs,
      self,
      xlibre-overlay,
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
        agenix.nixosModules.default
        chaotic.nixosModules.default
        home-manager.nixosModules.default
        impermanence.nixosModules.default
        jovian.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
        xlibre-overlay.nixosModules.overlay-all-xlibre-drivers
        xlibre-overlay.nixosModules.overlay-xlibre-xserver
        xlibre-overlay.nixosModules.overlay-xpra
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
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
        steam = mkNixosConfig { hardwareFile = ./hardware/steam.nix; };
        umka = mkNixosConfig { hardwareFile = ./hardware/umka.nix; };
      };
    };
}
