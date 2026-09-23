{
  description = "Personal flake configuration";

  inputs = {
    determinate.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    multios-usb = {
      url = "github:Mexit/MultiOS-USB";
      inputs.nixpkgs.follows = "omniflake/nixpkgs";
    };
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    omniflake.url = "github:fzakaria/omniflake";
    picom = {
      url = "github:yshui/picom";
      inputs.nixpkgs.follows = "omniflake/nixpkgs";
    };
    xlibre-overlay = {
      url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
      inputs.nixpkgs.follows = "omniflake/nixpkgs";
    };
  };

  outputs =
    {
      omniflake,
      self,
      xlibre-overlay,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      nixpkgs = omniflake.unified.nixpkgs;
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs system extraPkgs overlaysList; };
      extraPkgs = {
        agenix = omniflake.unified.agenix.packages.${system}.default;
        multios-usb = inputs.multios-usb.packages.${system}.default;
        nh = omniflake.unified.nh.packages.${system}.default;
        nix = inputs.determinate.packages.${system}.default;
        nix-init = omniflake.unified.nix-init.packages.${system}.default;
        testing = inputs.nixpkgs-testing.legacyPackages.${system};
      };
      overlaysList = [
        omniflake.unified.nix-vscode-extensions.overlays.default
      ];
      defaultModules = [
        ./nixos
        ./applications/system-manager
        omniflake.pinned.nyx.nixosModules.default
        omniflake.unified.agenix.nixosModules.default
        omniflake.unified.home-manager.nixosModules.default
        omniflake.unified.impermanence.nixosModules.default
        omniflake.unified.jovian-nixos.nixosModules.default
        omniflake.unified.nix-flatpak.nixosModules.nix-flatpak
        omniflake.unified.nixpkgs-multiverse.nixosModules.default
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
      nixosConfigurations = {
        acer = mkNixosConfig { hardwareFile = ./hardware/acer.nix; };
        nixos = mkNixosConfig { hardwareFile = ./hardware/default.nix; };
        nvidia = mkNixosConfig { hardwareFile = ./hardware/nvidia.nix; };
        steam = mkNixosConfig { hardwareFile = ./hardware/steam.nix; };
        umka = mkNixosConfig { hardwareFile = ./hardware/umka.nix; };
      };
    };
}
