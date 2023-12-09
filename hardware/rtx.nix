{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
  };
  nixpkgs.config.nvidia.acceptLicense = true;
}
