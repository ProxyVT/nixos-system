let
  pkgs = import <nixpkgs> {};
in
{ pkgs }:
pkgs.callPackage ./libplacebo-master.nix {}


