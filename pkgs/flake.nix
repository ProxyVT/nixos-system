{
  description = "Basic flake for packages testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
    in
    {
      packages.x86_64-linux = {
        xfce4-alsa-plugin = pkgs.xfce.callPackage ./xfce4-alsa-plugin/default.nix { };
        qmplay2 = pkgs.callPackage ./qmplay2/package.nix { };
        vivaldi = pkgs.callPackage ./vivaldi/package.nix { };
      };
    };
}
