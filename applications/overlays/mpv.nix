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
              rev = "1fd3c7bde7b943fe8985c893310b5269a09b46c5";
              hash = "sha256-lkpSyHYRG5uz9A90Yp5FAN1KP6llTfBjopVPZkNAYqs=";
            };
          });
          ffmpeg = prev.ffmpeg_7-full;  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "e509ec0aaffce74e520702e16e3e21ea0f168940";
            hash = "sha256-QTHQA+EjeKyWJ6oNcI56V6DUEmlw3bFbKLLzltcYPlc=";
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