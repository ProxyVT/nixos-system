{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.0.15";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-v77ovjV+UoCRA1GteP+HDqC8dsRvtOhFX/IkSgSIf8Y=";
      };
      vendorHash = "sha256-boYTLgvH+iWlh3y3Z0LPvSVGEget3X94AthtJKphhCw=";
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
