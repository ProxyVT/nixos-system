  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://code.videolan.org/videolan/libplacebo.git";
              rev = "e4e096be9512103381dd9c15f8c9a2669edf22c8";
              hash = "sha256-wITORt9pxzCi7HFC/HwGYomdV+Qi9i7N3Taw/LECuqg=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });
          ffmpeg = prev.ffmpeg_7-full;  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "e5d683e187d1e67fcfc944769a7c31cfcc2d0491";
            hash = "sha256-YNT5QQe+BucF713RDfOrsynH4Ym8ZV7eWAuS7W+jaIk=";
          };
          patches = [];
        });
        mpv-git = pkgs.wrapMpv final.mpv-unwrapped {
          scripts = with pkgs; [ 
            uosc-git
            mpvScripts.thumbfast
          ];
        };      
      })
    ];
  };
}