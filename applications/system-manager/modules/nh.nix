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
          version = "4.2.0-beta5";
          src = oldAttrs.src.override {
            hash = "sha256-DvonqSRDrGDZmsRCCBegFWtGvb+7SktKn5Rzxgngw+4=";
          };
          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-cQlOOZwqaKae16EWOykftioNVn5zwCAG6fwX+Bg/8rA=";
          };
        });
      })
    ];
  };
}
