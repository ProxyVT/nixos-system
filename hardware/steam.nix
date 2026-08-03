{ lib, ... }:
{
  jovian = {
    devices.steamdeck = {
      enableVendorDrivers = true;
      enableOsFanControl = true;
      enableDefaultCmdlineConfig = true;
      enableDefaultStage1Modules = true;
    };
    steamos = {
      enableSysctlConfig = true;
      enableHdmiCecIntegration = true;
      enableDefaultCmdlineConfig = true;
    };
  };
  services.scx.enable = lib.mkForce false;
}
