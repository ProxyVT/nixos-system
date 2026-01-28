{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.0.14-rc.2";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-EXoBmPL+uaigjY/ZygE8d4fqul2PUHv8hMW3uTAltNQ=";
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
