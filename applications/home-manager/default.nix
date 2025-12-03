{ lib, pkgs, ... }:
{
  imports = (lib.filesystem.listFilesRecursive ./modules);

  services = {
    easyeffects.enable = true;
    gpg-agent.enable = true;
    blueman-applet.enable = true;
    udiskie.enable = true;
  };

  programs = {
    aria2.enable = true;
    home-manager.enable = true;
    java.enable = true;
    gpg.enable = true;
  };

  xdg = {
    enable = true;
    autostart.enable = true;
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.common.default = "*";
    };
  };

  home.stateVersion = "24.11";
}
