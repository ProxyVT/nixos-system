{ config, lib, pkgs, modulesPath, ... }: {

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware = {
    nvidiaOptimus.disable = true;
    nvidia = {
      modesetting.enable = false;
      nvidiaSettings = false;
      prime = {
        reverseSync.enable = false;
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
