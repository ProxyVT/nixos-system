  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "8346db433f12608495dc9cd1bd27129990810e0e";
            hash = "sha256-ds3BK18YkRMgMh5P5cMnjp4NvI4c/lDrXC+4M08Tl7c=";
          };
          patches = [];
        });
      })
    ];
  };
}
