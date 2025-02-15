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
  legacy = import inputs.nixpkgs-legacy {
    system = final.system;
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
    allowUnfree = true;
  };
  edge = import inputs.nixpkgs-edge {
    system = final.system;
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
      allowUnsupportedSystem = true;
    };
  };
  testing = import inputs.nixpkgs-testing {
    system = final.system;
    config = {
      allowUnfree = true;
      nvidia.acceptLicense = true;
    };
  };
};

}
