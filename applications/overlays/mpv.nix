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
              rev = "82bf46ae8b4cacd2523f994da292e4d12312c026";
              hash = "sha256-gT/yqpIYoC0ohCp3mxma+pOKRqJDhq/7jr2U/+dY878=";
            };
          });
          ffmpeg = prev.ffmpeg_7-full;
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "70fad1daa6d49609d680f62b575239c2c4ac9352";
            hash = "sha256-D5lti3jRN/iMZV9wZ/B/bK1MAbgex6p38aPvLORVNNk=";
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
