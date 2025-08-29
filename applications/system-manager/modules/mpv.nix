{ pkgs, ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped =
          (prev.mpv-unwrapped.override {
            libplacebo = prev.libplacebo.overrideAttrs rec {
              pname = "libplacebo";
              version = "a68b9680e42208350f141822714c3d969369ef95";
              src = prev.fetchFromGitLab {
                domain = "code.videolan.org";
                owner = "videolan";
                repo = "libplacebo";
                rev = version;
                hash = "sha256-JswtjDHZDfKTdsNgSmO9E1O7oF0VJRFlnhOZ1rdOnEc=";
              };
              patches = [ ];
            };
            ffmpeg = prev.ffmpeg-full;
          }).overrideAttrs
            rec {
              pname = "mpv";
              version = "9f153e2a20174147130a31387d022f62ddd94cf0";
              src = prev.fetchFromGitHub {
                owner = "mpv-player";
                repo = "mpv";
                rev = version;
                hash = "sha256-rlkAFsAzRQ3JNu+qLwfhA63Dr+843baR8glL+jsW2yk=";
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
