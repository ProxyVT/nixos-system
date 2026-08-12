{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.1.3";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-uTjmOAjis2eBm2SnZbyvDDiQXKN8De+DhjNHbFLLbn0=";
      };
      vendorHash = "sha256-ueUf9YEa5z7mG6MofIJ3Xco+PxVPi/85Rdi+1aean6c=";
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
    };
  };

  home.persistence."/persist".directories = [
    "Sync"
  ];
}
