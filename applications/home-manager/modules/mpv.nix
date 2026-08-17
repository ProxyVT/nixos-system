{
  pkgs,
  lib,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-08-30";
      src = previousAttrs.src.override {
        rev = "12b918fcbcae56ded0e073a965d769bb0c5d900e";
        hash = "sha256-T1zHFhjU3DHd/CRQGr1XVSo2duj1rjP6JZqAFdaLaPw=";
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
        ffmpeg = pkgs.ffmpeg.overrideAttrs (
          finalAttrs: previousAttrs: {
            doCheck = false;
            version = "2026-09-06";
            src = pkgs.fetchFromGitHub {
              owner = "FFmpeg";
              repo = "FFmpeg";
              rev = "ef533ef3a3ea063eb72edbf510d006684f260f7f";
              hash = "sha256-QE3RNKGZhWwh7m8zgLnx8q+x1euq1YgbasRdjHoU3b8=";
            };
          }
        );
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            version = "2026-09-03";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "3330a515d62139259c26239014f286e233bd3a5c";
              hash = "sha256-PbEDfszLeS/0GAGahZsGq3cdpLHzigkxgHGlzuXggRE=";
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
            version = "2026-09-03";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "f5bcfb195412e0ca733eac2e850879cd3b1ded18";
              hash = "sha256-f+CuOd/SJEXCqDzF/g0rgqMB6Yd6xyUPd2F8iNJrW/o=";
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
