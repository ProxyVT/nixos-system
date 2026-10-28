{ pkgs, ... }:
let
  syncthing-git = pkgs.syncthing.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2.1.7";
      src = previousAttrs.src.override {
        tag = "v${finalAttrs.version}";
        hash = "sha256-XJqXWzZ0gePbrXeMpCgwXhYN1Lqco16wmEESJDAhFiA=";
      };
      vendorHash = "sha256-gLbRwLPldH4GRuDu8nmZagBfFzg3FZ7Rpa2nDBRWcZo=";
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
