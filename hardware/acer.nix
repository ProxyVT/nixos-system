{ inputs, outputs, lib, config, pkgs, ... }:

{

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware = {
    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest; 
      prime = {
        sync.enable = false;
        offload = {
          enable = false;
			    enableOffloadCmd = false;
		    };
        nvidiaBusId = "PCI:4:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    opengl = {
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ vaapiIntel ];
    }; 
  };

  
}
