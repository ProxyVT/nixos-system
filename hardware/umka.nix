{ inputs, outputs, lib, pkgs, config, modulesPath, ... }: {

services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia = {
  package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  powerManagement.enable = true;
};

}
