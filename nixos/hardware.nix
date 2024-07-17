{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot = {
    initrd = {
      availableKernelModules = [ 
        "xhci_pci"
        "ehci_pci" 
        "ahci" 
        "usbhid" 
        "usb_storage" 
        "uas" 
        "sd_mod" 
        "rtsx_usb_sdmmc" 
        "nvme" 
        ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-intel" "kvm-amd" ];
    extraModulePackages = [ ];
  };
  
  fileSystems."/" = { 
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=50%" "mode=755" ];
  }; 

  fileSystems."/persist" = { 
    device = "/dev/disk/by-partlabel/nix";
    fsType = "f2fs";
    neededForBoot = true;
  };

  fileSystems."/nix" = { 
    device = "/dev/disk/by-partlabel/nix";
    fsType = "f2fs";
  };

  fileSystems."/boot" = { 
    device = "/dev/disk/by-partlabel/boot";
    fsType = "vfat";
  };

  specialisation = {
    umka.configuration = {
      system.nixos.tags = [ "umka" ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        modesetting.enable = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
      };
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  
  hardware.nvidiaOptimus.disable = true;

  hardware.graphics = { # hardware.graphics on unstable
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
  };
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; }; # Force intel-media-driver

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu = {
    intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
