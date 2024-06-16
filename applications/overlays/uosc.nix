  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "1c38d4d3a7405f1aac603ba02f846c3d84dac96b";
            hash = "sha256-mW76A80rFwj+CZdOHjDj4Wd8x1iaaklXgoiPhDIzduk=";
          };
          patches = [];
        });     
      })
    ];
  };
}