  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-git = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://code.videolan.org/videolan/libplacebo.git";
              rev = "1fd3c7bde7b943fe8985c893310b5269a09b46c5";
              hash = "sha256-lkpSyHYRG5uz9A90Yp5FAN1KP6llTfBjopVPZkNAYqs=";
            };
            #buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });
          ffmpeg = prev.ffmpeg_7-full;  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "68a1a3879ca5b65ecd1f7b63b09b615f968d807a";
            hash = "sha256-jbo+1uwAHYZRhvkkfcU1XE7hs7rPeeCEK+ceH4YK7zA=";
          };
          patches = [];
        });     
      })
    ];
  };
}