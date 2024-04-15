{ inputs, ... }:
let
  additions = final: _prev: import ../pkgs { pkgs = final; };
  modifications = final: prev: { };
  mpv = import ./mpv.nix;
in
inputs.nixpkgs.lib.composeManyExtensions [ additions modifications mpv ]