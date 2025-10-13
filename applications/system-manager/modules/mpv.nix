{ pkgs, ... }:
{

  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped =
          (prev.mpv-unwrapped.override {
            libplacebo = prev.libplacebo.overrideAttrs rec {
              pname = "libplacebo";
              version = "9bffcaf2da915aecce18dbf4ecc469649115674a";
              src = prev.fetchFromGitLab {
                domain = "code.videolan.org";
                owner = "videolan";
                repo = "libplacebo";
                rev = version;
                hash = "sha256-MAvDaKXBOAnhZSoi0oIuVwR+G/mIFlAl3HmLTG5IMpY=";
              };
              patches = [ ];
            };
            ffmpeg = prev.ffmpeg_8-full;
          }).overrideAttrs
            rec {
              pname = "mpv";
              version = "ad59ff1b4a7479e15cb01a96f64ada4fb4df4951";
              src = prev.fetchFromGitHub {
                owner = "mpv-player";
                repo = "mpv";
                rev = version;
                hash = "sha256-Q5fHIGZo91hUUULo8DusW/WPzlB0mMrUnDoCiwdT4P4=";
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
