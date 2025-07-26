{ pkgs, ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped =
          (prev.mpv-unwrapped.override {
            libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: {
              pname = "libplacebo";
              version = "git";
              src = prev.fetchgit {
                url = "https://github.com/haasn/libplacebo.git";
                rev = "2ffcfffa855c9bc8cbad0f64f5f4b9ac67e9a497";
                hash = "sha256-79QTIkeWAiLqk/qdtZsyGUUhhUYU3jE6CdvEl2TbQNk=";
              };
            });
            ffmpeg = prev.ffmpeg-full;
          }).overrideAttrs
            (oldAttrs: {
              pname = "mpv";
              version = "git";
              src = prev.fetchgit {
                url = "https://github.com/mpv-player/mpv.git";
                rev = "b47fd2842a295fca9d7681a7a85a8371faad0c47";
                hash = "sha256-h6Sl6nHw2Xmlv71gtnp/zGZ2xXSkeK9ksuw3/v7GK1c=";
              };
              patches = [ ];
            });
        mpv-git = final.mpv.override {
          scripts = with pkgs.mpvScripts; [
            uosc
            thumbfast
          ];
        };
      })
    ];
  };

}
