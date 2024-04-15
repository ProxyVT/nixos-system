  { inputs, outputs, lib, config, pkgs, ... }: {
  
  nixpkgs = {
    overlays = [
      (final: prev: {
        mpv-unwrapped = (prev.mpv-unwrapped.override {
          libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
            pname = "libplacebo";
            version = "git";
            src = prev.fetchgit {
              url = "https://code.videolan.org/videolan/libplacebo.git";
              rev = "311a59507f6a0465aaac9b783af65bf349755360";
              hash = "sha256-rwaufc4LfcX190ulHv0NPuER/D7//SwoLrSN4kKteqk=";
            };
            buildInputs = oldAttrs.buildInputs ++ [ pkgs.xxHash ];
          });  
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "2af3a6e294e829191dfa0c41396ecd6384d405d9";
            hash = "sha256-y4v4I88a9KRgrvuWJBGM8Q3lG1WUXrUW0O7qTCrk9nk=";
          };
          patches = [];
        });
        mpv-git = pkgs.wrapMpv final.mpv-unwrapped {
          scripts = with pkgs; [ 
            uosc-git
            mpvScripts.thumbfast
          ];
        };      
      })
    ];
  };
}