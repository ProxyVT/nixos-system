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
    release = mkChannel inputs.nixpkgs-release;
    testing = mkChannel inputs.nixpkgs-testing;
  };
in
{
  default = final: prev: prev // pkgsCustom;
}
