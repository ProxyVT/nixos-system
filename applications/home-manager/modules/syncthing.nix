{ pkgs, ... }:
let
  syncthing = pkgs.syncthing.overrideAttrs (oldAttrs: rec {
    version = "2.0.10";
    src = oldAttrs.src.override {
      tag = "v${version}";
      hash = "sha256-N0+i5sj/cTPDv6q428b3Y0hsPRxIl96+RIuS1AyeTbc=";
    };
  });
in
{
  services.syncthing = {
    enable = true;
    package = syncthing;
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
