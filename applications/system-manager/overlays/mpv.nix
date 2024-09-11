{ inputs, outputs, lib, config, pkgs, ... }: {

  imports = [
    ./uosc.nix
  ];

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://github.com/haasn/libplacebo.git";
              rev = "efb89342b0c19b9773226624651839686172e88b";
              hash = "sha256-qFD+12dfusY7VVwJDVCtlYjg+duEdeEKWBuTEpBF7O4=";
            };
          });
          ffmpeg = prev.ffmpeg_7-full;
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "5edc8973ebdb2f80e1fa5b9c7b0ea7d12fd2fe3b";
            hash = "sha256-VsSB5amtuJ66ljfOJY7XTks2lmmUglOKLKC3qpD3eSw";
          };
          patches = [];
        });
        mpv-git = final.mpv.override {
          scripts = with pkgs; [
            uosc-git
            mpvScripts.thumbfast
          ];
        };
      })
    ];
  };
}
