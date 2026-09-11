{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.1.5";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-8rrOfX6C96YEbvUh1IZP1V8x4RB99O0mC+y5h8579Vo=";
      };
      vendorHash = "sha256-YXzTGtALTC9HQTAeZtweS+GONdgyqrHOJdLZt0QhnJM=";
      buildPhase =
        builtins.replaceStrings [ "v${previousAttrs.version}" ] [ "v${finalAttrs.version}" ]
          previousAttrs.buildPhase;
    }
  );
in
{
  services.syncthing = {
    enable = true;
    package = syncthing-git;
    overrideDevices = false;
    overrideFolders = false;
    settings.options = {
      urAccepted = 3;
      copiers = 4;
      connectionPriorityOrder = [
        "quic"
        "tcp"
        "relay"
      ];
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
