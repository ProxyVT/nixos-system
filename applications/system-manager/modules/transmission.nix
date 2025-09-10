{ pkgs, ... }:
{
  services.transmission = {
    enable = true;
    home = "/home/ulad";
    package = pkgs.transmission_4;
    performanceNetParameters = true;
    downloadDirPermissions = "770";
    settings = {
      umask = 7;
      download-dir = "/home/ulad/Videos/Films/Transmission";
      utp-enabled = true;
      incomplete-dir-enabled = false;
    };
  };
}
