{ inputs, ... }:
{

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  packages = final: _prev: {
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
    release = import inputs.nixpkgs-release {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
    bird = import inputs.nixpkgs-betterbird {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
    skype = import inputs.nixpkgs-skype {
      system = final.system;
      config = {
        allowUnfree = true;
        nvidia.acceptLicense = true;
      };
    };
  };

}
