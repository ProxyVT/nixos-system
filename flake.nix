{
  description = "Personal flake configuration";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    impermanence,
    ... 
  } @inputs: let
    inherit (self) outputs;
      # Supported systems for your flake packages, shell, etc.
      systems = [ "x86_64-linux" ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    nixosConfigurations = {
      ulad = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./nixos/persistence.nix
          ./applications/environment.nix
          home-manager.nixosModules.home-manager
          impermanence.nixosModules.impermanence          
          {
            home-manager = {           
              useGlobalPkgs = true;
              useUserPackages = true;
              users.ulad.imports = [
                ./applications/dotfiles.nix
              ];      
            };
          }
        ];
      };
    };
  };
}
