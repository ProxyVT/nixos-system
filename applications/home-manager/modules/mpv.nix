{
  pkgs,
  lib,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-08-03";
      src = previousAttrs.src.override {
        rev = "d124c2c930d69446448022851373e00ae592390d";
        hash = "sha256-5fHihGI2rodEByqTRs3NasmLUBjG3VY9l/YnKDCKSt8=";
      };
    }
  );
  mpv-git = pkgs.mpv.override {
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
    ];
    mpv-unwrapped =
      (pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg_8-full;
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            version = "2026-07-30";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "4d82c6898551068d4ae6a6b5538efcddc2c7cf64";
              hash = "sha256-QKOhccWH1dA2SbzE/H155gPIG4y/hmgE8ycnpQ3yHkI=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            outputs = [
              "out"
              "man"
              "doc"
            ];
            postPatch = lib.concatStringsSep "\n" [
              ''
                pushd TOOLS
                mv mpv_identify.sh mpv_identify
                patchShebangs *.py *.sh
                mv mpv_identify mpv_identify.sh
                popd
              ''
            ];
            version = "2026-07-31";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "1d15686142fd5d53c954aab7526cedab05ef9dc3";
              hash = "sha256-UBynMtyhzfThSu9f9BnXtGNjv2SkP1bH9+MTOPWqpjU=";
            };
          }
        );
  };
in
{
  programs.mpv = {
    enable = true;
    package = mpv-git;
  };
}
