{
  description = "Personal flake configuration";

  inputs = {
    multios-usb.url = "github:Mexit/MultiOS-USB";
    nixpkgs-testing.url = "github:ProxyVT/nixpkgs/testing";
    picom.url = "github:yshui/picom";
    xlibre-overlay.url = "git+https://codeberg.org/takagemacoed/xlibre-overlay?ref=dev-26.11";
    omniflake.url = "github:fzakaria/omniflake";
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
      inherit (omni.unified.nyx.vendored) jovian;
      nixpkgs = omni.unified.nixpkgs;
      system = "x86_64-linux";
      omni = {
        flaked = omniflake.flakes;
        pinned = omniflake.pinned;
        unified = omniflake.unified;
      };
      specialArgs = { inherit inputs outputs system omni; };
      defaultModules = [
        ./nixos
        ./applications/system-manager
        omni.pinned.determinate.nixosModules.default
        omni.pinned.nyx.nixosModules.default
        omni.unified.agenix.nixosModules.default
        omni.unified.home-manager.nixosModules.default
        omni.unified.impermanence.nixosModules.default
        omni.unified.nix-flatpak.nixosModules.nix-flatpak
        jovian.nixosModules.default
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
