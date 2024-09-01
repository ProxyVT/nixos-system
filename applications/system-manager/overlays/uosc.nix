  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "0f48df315304efd1caf26215526d96660d113dcb";
            hash = "sha256-Ic7XdWqLT7kHdLPRtKGbH26JklMNPBdlTl7sbJSdugc=";
          };
          patches = [];
        });
      })
    ];
  };
}
