{ pkgs, thunderbirdPackages, ... }:
{

  programs.thunderbird = {
    enable = true;
    package = pkgs.bird.betterbird;
    profiles.ulad = {
      isDefault = true;
    };
  };

  nixpkgs = {
    overlays = [
      (final: prev: {
        pkgs.bird.betterbird = prev.betterbird.overrideAttrs (oldAttrs: {
          thunderbird-unwrapped = thunderbirdPackages.thunderbird-128;
          version = "128.9.0esr";
        });
      })
    ];
  };

}
