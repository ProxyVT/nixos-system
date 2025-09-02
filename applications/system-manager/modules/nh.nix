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
          version = "4.2.0-beta3";
          src = oldAttrs.src.override {
            hash = "sha256-1pxbBTSCew43iYpKGYBixZuhZaI38brfQj3HGEEiEwc=";
          };
          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-ald06MHHSNUo/zGj4nnqXBtMQ6z9+6gcJ+aAmib0dA0=";
          };
        });
      })
    ];
  };
}
