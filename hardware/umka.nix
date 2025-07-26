{ config, ... }:
{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
    powerManagement.enable = true;
    open = false;
  };

}
