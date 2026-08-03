{
  description = "Test machine for Michael";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    nix-flatpak.url = "https://flakehub.com/f/gmodena/nix-flatpak/0.6.0";
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-flatpak,
      home-manager,
      ...
    }@inputs:

    let
      inherit (self) outputs;
      system = "x86_64-linux";
      specialArgs = { inherit inputs outputs system; };
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          nvidia.acceptLicense = true;
        };
      };
      defaultModules = [
        ./default.nix
        home-manager.nixosModules.default
        nix-flatpak.nixosModules.nix-flatpak
      ];
    in
    {
      packages."${system}" = pkgs;
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          modules = defaultModules;
        };
      };
    };
}
