{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModprobeConfig = ''
      options usb-storage quirks=0bda:9210:u
    '';
    kernelParams = [
      "usbcore.autosuspend=-1"
      "usbcore.usb3_lpm=0"
    ];
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
      systemd.enable = true;
    };
    kernelModules = [
      "kvm-intel"
      "kvm-amd"
    ];
    extraModulePackages = [ ];
    supportedFilesystems = [
      "apfs"
      "bcachefs"
    ];
  };

  fileSystems."/" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "noatime"
      "size=100%"
      "mode=755"
    ];
    neededForBoot = true;
  };

  fileSystems."/nix/var/nix/builds" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [
      "nosuid"
      "nodev"
      "noatime"
      "mode=755"
      "size=200%"
    ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-partlabel/nix";
    fsType = "f2fs";
    options = [
      "relatime"
    ];
    neededForBoot = true;
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-partlabel/nix";
    fsType = "f2fs";
    options = [
      "relatime"
    ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/boot";
    fsType = "vfat";
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu = {
    intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
