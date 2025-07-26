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
                rev = "00a1009a78434bbc43a1efc54f5915dd466706a4";
                hash = "sha256-GAhGWt0eto+9jPpO4mG0rn3/9fcuGph9OdXANwzaZOc=";
              };
            });
            ffmpeg = prev.ffmpeg-full;
          }).overrideAttrs
            (oldAttrs: {
              pname = "mpv";
              version = "git";
              src = prev.fetchgit {
                url = "https://github.com/mpv-player/mpv.git";
                rev = "18defc8530caf7694b132a501e9c34476d4cef80";
                hash = "sha256-QHsdzy6xGD4UF5HB5O6e1donMzwF6fp5M0W+UjI+wnc=";
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
