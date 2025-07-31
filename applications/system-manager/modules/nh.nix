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
          pname = "nh";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/nix-community/nh.git";
            rev = "ec34a659652d98c225e2a97d100830365d7551c3";
            hash = "sha256-+MuFPjyJl3JbNVs3Xq9dATJEbEOvwF4LMUNMmmzO7mU=";
          };
          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit src;
            hash = "sha256-qqmcx0FyQN1YL1narJKKUk/svhow1mJdWr+uo3CdzA0=";
          };
          env.NH_REV = src.rev;
        });
      })
    ];
  };
}
