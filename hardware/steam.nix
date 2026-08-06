{ inputs, lib, pkgs, ... }:
{
  nixpkgs.overlays = [ inputs.steam-deck-overlay.overlays.default ];
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
}
