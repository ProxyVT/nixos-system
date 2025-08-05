{
  description = "Basic flake for packages testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      packages.x86_64-linux = {
        xfce4-alsa-plugin = pkgs.xfce.callPackage ./xfce4-alsa-plugin/default.nix { };
      };

    };
}
