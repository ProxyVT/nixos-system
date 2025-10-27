{
  description = "Basic flake for packages testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            nvidia.acceptLicense = true;
          };
        };
      in
      {
        packages = {
          xfce4-alsa-plugin = pkgs.xfce.callPackage ./xfce4-alsa-plugin/default.nix { };
          qmplay2 = pkgs.callPackage ./qmplay2/package.nix { };
          vivaldi = pkgs.callPackage ./vivaldi/package.nix { };
          ffmpeg-progress-yield = pkgs.python3Packages.callPackage ./ffmpeg-progress-yield/default.nix { };
          ariang = pkgs.callPackage ./ariang/package.nix { };
          ariang-native = pkgs.callPackage ./ariang-native/package.nix { };
          lite-xl = pkgs.callPackage ./lite-xl/package.nix { };
          betterbird = pkgs.callPackage ./betterbird/package.nix { };
        };
      }
    );
}
