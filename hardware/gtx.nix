{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidiaLegacy470" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}
