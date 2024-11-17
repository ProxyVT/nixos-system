# This file defines overlays
{ inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  packages = final: _prev: {
    release = import inputs.nixpkgs-release {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
      allowUnfree = true;
    };
    master = import inputs.nixpkgs-master {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
    local = import inputs.nixpkgs-local {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
  };
}
