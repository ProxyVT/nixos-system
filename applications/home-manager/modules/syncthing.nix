{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.0.16";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-GHKm+K3KlvRZGlo0WrtXhFR/u+gg1299SW/fRqttRO0=";
      };
      vendorHash = "sha256-GcSAKrRn2mmsow6TlV1m6nC6p12umX9aHG0mdMrCsSo=";
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
      relaysEnabled = true;
      urAccepted = 3;
      order = "smallestFirst";
      numConnections = 16;
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
