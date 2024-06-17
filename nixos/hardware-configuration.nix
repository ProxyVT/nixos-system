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
    bcache.enable = true;
  };

  fileSystems."/" =
    { device = "none";
      fsType = "tmpfs";
      options = [ "defaults" "size=25%" "mode=755" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-partlabel/nix";
      fsType = "f2fs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-partlabel/boot";
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

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu = {
    intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
