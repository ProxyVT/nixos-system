{ inputs, outputs, lib, config, pkgs, ... }: 
  
{
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
            rev = "c0f5d2391b32b79551502b85ce90285f55d1645c";
            hash = "sha256-UCeTrAs7SjX73Rs1ilLk57qk33xfSKYmM0kx4sU3Fiw=";
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