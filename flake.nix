{
  description = "My fist flake config";
  
  inputs = {
  	nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  	home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    #overlays = import ./overlays { inherit inputs; };
    nixosConfigurations = {
      ulad-acer = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
	        ./nixos/configuration.nix
	        ./applications/environment.nix
          ./hardware/acer.nix
	       home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ulad = import ./applications/dotfiles.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
	      ];
      };
      ulad-gtx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
          ./applications/environment.nix
          ./hardware/gtx.nix
	      home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ulad = import ./applications/dotfiles.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
	      ];
      };
      ulad-rtx = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./nixos/configuration.nix
	      ./applications/environment.nix
	      ./hardware/rtx.nix
	      home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ulad = import ./applications/dotfiles.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
      };
    };
  };
}
