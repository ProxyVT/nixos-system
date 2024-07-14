  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "9fa7220da45815855df6c6d62adf82ee7d9df5e3";
            hash = "sha256-MUR/zBdAM2j8eYdv9Z943BhxcicUvZAxRhCJJeGUNns=";
          };
          patches = [];
        });     
      })
    ];
  };
}