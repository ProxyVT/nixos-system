{
  description = "Personal flake configuration";
  
  inputs = {
    #  Master branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-staging.url = "github:nixos/nixpkgs/staging";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
  	home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { 
    self, 
    nixpkgs, 
    home-manager, 
    ... 
  } @inputs: let
    inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    nixosConfigurations = {
      ulad-acer = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
	        ./nixos/configuration.nix
	        ./applications/environment.nix
          ./hardware/acer.nix
	       home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad = import ./applications/dotfiles.nix;
            };
          }
	      ];
      };
      ulad-gtx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./applications/environment.nix
          ./hardware/gtx.nix
	      home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad = import ./applications/dotfiles.nix;
            };
          }
	      ];
      };
      ulad-rtx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./applications/environment.nix
          ./hardware/rtx.nix
	      home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad = import ./applications/dotfiles.nix;
            };
          }
        ];
      };
    };
  };
}
