{
  description = "ISO flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-edge.url = "github:nixos/nixpkgs/master";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs:

  let
    inherit (self) outputs;
    system = [ "x86_64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs system;
  in {
    overlays = import ../applications/system-manager/overlays { inherit inputs; };
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
