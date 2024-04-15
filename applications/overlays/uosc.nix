  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "6fa34c31d0a5290dee83282205768d15111df7d8";
            hash = "sha256-qxyNZHmH33bKRp4heFSC+RtvSApIfbVFt4otfS351nE=";
          };
          patches = [];
        });     
      })
    ];
  };
}