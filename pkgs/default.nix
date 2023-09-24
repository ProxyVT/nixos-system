{ inputs, outputs, lib, config, pkgs, ... }:
# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  mpv-git = pkgs.callPackage ./mpv-git.nix { };
}
