{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    package = pkgs.testing.syncthing;
    overrideDevices = false;
    overrideFolders = false;
    settings.options = {
      relaysEnabled = true;
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
