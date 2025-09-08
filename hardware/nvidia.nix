{ config, ... }:
{

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    powerManagement.enable = true;
    open = true;
  };

}
