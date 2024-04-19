  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "e6a5fd981dadcc2a0d30ded64b7bcbd4481692cd";
            hash = "sha256-6jLhrvBzFfhFrqaF0xXXbdCd3hBOwfqn/ZJPqnwbj/E=";
          };
          patches = [];
        });     
      })
    ];
  };
}