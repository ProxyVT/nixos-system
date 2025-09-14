{ lib, ... }:
{
  imports = (lib.filesystem.listFilesRecursive ./modules);

  services = {
    easyeffects.enable = true;
    gpg-agent.enable = true;
    blueman-applet.enable = true;
  };

  programs = {
    home-manager.enable = true;
    java.enable = true;
    gpg.enable = true;
  };

  home.stateVersion = "24.11";
}
