{ config, pkgs, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidiaOptimus.disable = false;
    nvidia = {
      open = false;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      prime = {
        reverseSync.enable = true;
        nvidiaBusId = "PCI:4:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    graphics = {
      extraPackages = [ pkgs.intel-vaapi-driver ];
      extraPackages32 = [ pkgs.driversi686Linux.intel-vaapi-driver ];
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };
}
