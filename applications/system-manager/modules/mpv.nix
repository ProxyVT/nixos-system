{ pkgs, ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped =
          (prev.mpv-unwrapped.override {
            libplacebo = prev.libplacebo.overrideAttrs rec {
              pname = "libplacebo";
              version = "515da9548ad734d923c7d0988398053f87b454d5";
              src = prev.fetchFromGitLab {
                domain = "code.videolan.org";
                owner = "videolan";
                repo = "libplacebo";
                rev = version;
                hash = "sha256-BVHN2c3z2+Tx7CI+RhALLfubDSz0p4V3wrug+N2RJcs=";
              };
              patches = [ ];
            };
            ffmpeg = prev.ffmpeg_8-full;
          }).overrideAttrs
            rec {
              pname = "mpv";
              version = "b9ceaf243dff844456d4ed37c188ffe6b9495ce7";
              src = prev.fetchFromGitHub {
                owner = "mpv-player";
                repo = "mpv";
                rev = version;
                hash = "sha256-/c4PjpXMn6zbaU0OOSBejG2SXuMRIZdz2+sf1ctIf4U=";
              };
              patches = [ ];
            };
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
