  { inputs, outputs, lib, config, pkgs, ... }: {

  nixpkgs = {
    overlays = [
      (final: prev: {
        uosc-git = prev.mpvScripts.uosc.overrideAttrs (oldAttrs: rec {
          pname = "uosc";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tomasklaen/uosc.git";
            rev = "fe0d394435ad562176ae850175ebd5a083f0a6c2";
            hash = "sha256-jC//6o0FDudaY90A9Y92Abb1ZDmKsnvwLwtTM3a9t34=";
          };
          patches = [];
        });
      })
    ];
  };
}
