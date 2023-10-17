{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.nvidia.acceptLicense = true;
}
