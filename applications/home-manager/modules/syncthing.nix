{ pkgs, ... }:
{
  services.syncthing = {
    enable = true;
    package = pkgs.testing.syncthing;
    overrideDevices = false;
    overrideFolders = false;
    settings.options = {
      relaysEnabled = true;
      urAccepted = 3;
      order = "smallestFirst";
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
