{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [ (pkgs.callPackage ./mpv-git.nix {}) ];
}
