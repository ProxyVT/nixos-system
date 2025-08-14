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
                rev = "430d4921a2a89824dce3eecf7364f6a96f1e2d2e";
                hash = "sha256-yRiSjBlkSNJtVT2Fq+pMICk9vrQWnspdU7cJfmoiEXU=";
              };
            });
            ffmpeg = prev.ffmpeg-full;
          }).overrideAttrs
            (oldAttrs: {
              pname = "mpv";
              version = "git";
              src = prev.fetchgit {
                url = "https://github.com/mpv-player/mpv.git";
                rev = "3132ad62a38b1177e97182fce83271ebe96cff96";
                hash = "sha256-8GQ7rlkU1ziHKRqYl5aFsz/TJi066/lmOI7wvxbTRRk=";
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
