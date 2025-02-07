{ lib, pkgs, ... }: {

imports = [ ./uosc.nix ];

nixpkgs = {
  overlays = [
    (final: prev: {
      mpv-unwrapped = (prev.mpv-unwrapped.override {
        libplacebo = prev.libplacebo.overrideAttrs (oldAttrs: rec {
          pname = "libplacebo";
          version = "git";
          src = prev.fetchgit {
            url = "https://github.com/haasn/libplacebo.git";
            rev = "056b852018db04aa2ebc0982e27713afcea8106b";
            hash = "sha256-FESy3Bi967H43MG1472HYKaiNwOk6GnmXKCyT25SIFs=";
          };
        });
        ffmpeg = prev.ffmpeg-full;
      }).overrideAttrs ( oldAttrs: rec {
        pname = "mpv";
        version = "git";
        src = prev.fetchgit {
          url = "https://github.com/mpv-player/mpv.git";
          rev = "1dd0e49f83d5ca469ed803fd35782d61fcdd9bfb";
          hash = "sha256-fNg6Y0demvEi+aj8OKNfrXqY8RSLALLkPRBCBSHxk1A=";
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
