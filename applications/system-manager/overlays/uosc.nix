  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "e184cfec5ec5a31c4c68ecc856bac39ad2660e5d";
            hash = "sha256-j5whB0NDdcpnclilpqZywISCpPwHmYiPHUkyo5jb9Yg=";
          };
          patches = [];
        });
      })
    ];
  };
}
