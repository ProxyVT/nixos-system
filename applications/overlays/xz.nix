  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        xz-git = prev.xz.overrideAttrs (oldAttrs: rec {
          pname = "xz";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/tukaani-project/xz.git";
            rev = "eeca8f7c5baf1ad69606bb734d5001763466d58f";
            hash = "sha256-V/rNFTtk0bTognE6xszoDjJZriQtEHxLBi25hOUa53Q=";
          };
          #patches = [];
        });     
      })
    ];
  };
}