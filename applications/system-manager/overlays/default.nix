{ inputs, system, ... }:
let
  config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };
  mkChannel =
    input:
    import input {
      inherit config system;
    };
  pkgsCustom = {
    edge = mkChannel inputs.nixpkgs-edge;
    testing = mkChannel inputs.nixpkgs-testing;
    release = mkChannel inputs.nixpkgs-release;
    skype = mkChannel inputs.nixpkgs-skype;
  };
in
{
  default = final: prev: prev // pkgsCustom;
}
