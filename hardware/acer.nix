{ config, lib, pkgs, modulesPath, ... }: {

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    prime = {
      reverseSync.enable = true;
      nvidiaBusId = "PCI:4:0:0";
      intelBusId = "PCI:0:2:0";
    };  
  };
}