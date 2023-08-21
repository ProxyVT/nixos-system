{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidiaLegacy470" ];
  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
  };
}
