  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "86c4ae0da01e211f8b4c5f18bd325c2766bf033a";
            hash = "sha256-L4npHny45w/PU7Tzz8GjmFnEGobfDVxEYOqO5YUFdBU=";
          };
          patches = [];
        });
      })
    ];
  };
}
