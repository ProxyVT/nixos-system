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
    multios-usb = inputs.multios-usb.packages.${system}.default;
  };
in
{
  default = final: prev: prev // pkgsCustom;
}
