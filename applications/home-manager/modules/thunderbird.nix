{ pkgs, ... }:
let
  betterbird = pkgs.bird.betterbird.overrideAttrs (oldAttrs: {
    thunderbird-unwrapped = pkgs.bird.thunderbirdPackages.thunderbird-128;
    version = "128.9.0esr";
  });
in
{
  programs.thunderbird = {
    enable = true;
    package = betterbird;
    profiles.ulad = {
      isDefault = true;
    };
  };
}
