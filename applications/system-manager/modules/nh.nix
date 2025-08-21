{ pkgs, ... }:
{
  programs.nh = {
    enable = true;
    flake = "/home/ulad/nixos-system";
    package = pkgs.nh-git;
  };
  nixpkgs = {
    overlays = [
      (final: prev: {
        nh-git = prev.nh.overrideAttrs (oldAttrs: rec {
          version = "4.2.0-beta2";
          src = oldAttrs.src.override {
            hash = "sha256-IPwAGaR9LO4LasxIFPqOTmIfliDsnzWVgzsaIekzRG4=";
          };
          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-NVtf1TmPcXD9TcMK8zgfO8obn0rGdqdiiG+I4nuXR0I=";
          };
        });
      })
    ];
  };
}
