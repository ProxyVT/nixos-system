{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./home-manager/default.nix
    ./environment.nix
  ];

}
