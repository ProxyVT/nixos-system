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
            rev = "06470899dfd73069ee439ebe71b5c132de8fe54d";
            hash = "sha256-Q89hPC4K8Ink9jNOW7LJSglJ7aZNZmGICLCiWj32r6I=";
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
