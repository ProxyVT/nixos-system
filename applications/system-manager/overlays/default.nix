{ inputs, ... }:
let
  defaultConfig = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
in
{
  packages = final: _prev: {
    edge = import inputs.nixpkgs-edge {
      system = final.system;
      config = defaultConfig;
    };
    testing = import inputs.nixpkgs-testing {
      system = final.system;
      config = defaultConfig;
    };
    release = import inputs.nixpkgs-release {
      system = final.system;
      config = defaultConfig;
    };
    skype = import inputs.nixpkgs-skype {
      system = final.system;
      config = defaultConfig;
    };
  };

}
