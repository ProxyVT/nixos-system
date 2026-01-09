{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.0.13";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-yQZ4pPvGZdD8Ff34Ku0NCCd7kMXcFCCa35L/XYcvn6E=";
      };
      vendorHash = "sha256-+1bR83mAG00kbKZuaNnfqsUiKgXdoA/y7q6zpx3z1cE=";
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
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
