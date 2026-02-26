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
    device = "none";
    fsType = "tmpfs";
    options = [
      "defaults"
      "size=100%"
      "mode=755"
    ];
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

  swapDevices = [
    {
      device = "/persist/var/lib/swapfile";
      priority = 10;
    }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware.cpu = {
    intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

}
