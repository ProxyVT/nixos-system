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
              rev = "5788a82f459f617a999c4d56278d54d0edfc7b81";
              hash = "sha256-d7PoHcfUYS7HYxW4CJ9b0bxIdUuP6GF19/8nCYFMgxM=";
            };
          });
          ffmpeg = prev.ffmpeg_7-full;
        }).overrideAttrs ( oldAttrs: rec {
          pname = "mpv";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/mpv-player/mpv.git";
            rev = "70aaba71d6e3071a732069a1d222d1eb4293faf2";
            hash = "sha256-sRfmQdwt3l2O0Pik2K+4LTjLbxrAMZ7CvpAnk6zAkrI=";
          };
          patches = [];
          postPatch = lib.concatStringsSep "\n" [
            ''
            substituteInPlace meson.build \
              --replace-fail "conf_data.set_quoted('CONFIGURATION', meson.build_options())" \
                            "conf_data.set_quoted('CONFIGURATION', '<ommited>')"
            ''
            ''
            pushd TOOLS
            mv mpv_identify.sh mpv_identify
            patchShebangs *.py *.sh
            mv mpv_identify mpv_identify.sh
            popd
            ''
          ];
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
