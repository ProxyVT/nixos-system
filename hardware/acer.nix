{
  config,
  pkgs,
  ...
}:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    nvidiaOptimus.disable = false;
    nvidia = {
      open = false;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      forceFullCompositionPipeline = true;
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:4:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };
}
