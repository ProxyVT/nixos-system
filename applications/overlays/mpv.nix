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
              rev = "bc9de9c793722a0182b15ffda2e6a8d479c774a2";
              hash = "sha256-8f6DJenDWirUZpz36x0YigelFHm+qEiImw3W2EM3DEE=";
            };
            #buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });
          ffmpeg = prev.ffmpeg_7-full;  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "ab0a50874bccbf1e11cc15346e87c78ef50acae3";
            hash = "sha256-qskeLGfgxU/0VjM61PBpAqEGdx7BwxI4l1WPu3zhDdU=";
          };
        });     
      })
    ];
  };
}