{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidiaLegacy470" ];
  nixpkgs.config.nvidia.acceptLicense = true;
}
