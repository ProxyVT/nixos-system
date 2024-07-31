{ config, lib, pkgs, modulesPath, ... }: {

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };
}