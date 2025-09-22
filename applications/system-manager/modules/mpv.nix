{ pkgs, ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped =
          (prev.mpv-unwrapped.override {
            libplacebo = prev.libplacebo.overrideAttrs rec {
              pname = "libplacebo";
              version = "5592d8829c31aee686548cbc2c8b248ba46b0450";
              src = prev.fetchFromGitLab {
                domain = "code.videolan.org";
                owner = "videolan";
                repo = "libplacebo";
                rev = version;
                hash = "sha256-WjORJGb1j4HGvrjI0/yISfmVElL29GKTgUQbE9rGRYc=";
              };
              patches = [ ];
            };
            ffmpeg = prev.ffmpeg_8-full;
          }).overrideAttrs
            rec {
              pname = "mpv";
              version = "f147b133f0a06dd98baeb0b1cd3d08bacc346260";
              src = prev.fetchFromGitHub {
                owner = "mpv-player";
                repo = "mpv";
                rev = version;
                hash = "sha256-6jPvdXFLulL6OHLhcJKO0KpDEymmi0qu6+6catUnmO4=";
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
