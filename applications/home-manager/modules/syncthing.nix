{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.0.12";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-bWClKODxzcSbKiKFcgDKbRGih8KaSeVpltiFDAE8sHM=";
      };
      vendorHash = "sha256-Xiod2Bd+uXcOpZ0rt8my8jkNdkdUhuoz5fcce+6JMXY=";
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
