{ inputs, outputs, lib, config, pkgs, ... }: {

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
              rev = "efb89342b0c19b9773226624651839686172e88b";
              hash = "sha256-Q9EiAT/7ePvNcF7rZyBUzYvfUFdmLnQWj5vH7+L6ciI=";
            };
          });
          ffmpeg = prev.ffmpeg_7-full;
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "7c672e33a5eab0564383127c8837b1034a84357b";
            hash = "sha256-qsMcBShrf0fY++dLM0u4CTKCMZh8OZLQehqW+77sEFk=";
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
