{ inputs, lib, pkgs, system, ... }:
{
  jovian = {
    devices.steamdeck = {
      enableVendorDrivers = true;
      enableOsFanControl = true;
      enableDefaultCmdlineConfig = true;
      enableDefaultStage1Modules = true;
      enableSoundSupport = true;
    };
    steamos = {
      enableSysctlConfig = true;
      enableHdmiCecIntegration = true;
      enableDefaultCmdlineConfig = true;
    };
    hardware.has.amd.gpu = true;
  };
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_jovian;
  services.picom = {
    enable = true;
    package = inputs.picom.packages.${system}.default;
    backend = "egl";
    vSync = true;
  };
}
