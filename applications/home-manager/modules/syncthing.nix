{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.1.0";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-sTtFmZBPJIHMksaFFLmA3Abt9EhAC8Nz/ibdzg2LMd4=";
      };
      vendorHash = "sha256-rOsdg98WVAKqjV7AxH+m4oSf8Z4FPru4NSbgGFtUMVE=";
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
