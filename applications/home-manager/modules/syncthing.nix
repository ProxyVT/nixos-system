{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.1.2-rc.4";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-tR4yXoEYbCi8Uh3wCyATc+J4+cGvD7k0d9egjHS5H4k=";
      };
      vendorHash = "sha256-t2wjl4eWvcUHMaBS7KEPzZejqrlI+7c5fRqWqxuCZy8=";
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
