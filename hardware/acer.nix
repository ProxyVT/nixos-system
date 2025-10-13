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
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        intel-vaapi-driver
      ];
    };
  };
}
