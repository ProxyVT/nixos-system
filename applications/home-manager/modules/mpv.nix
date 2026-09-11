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
            version = "2026-09-11";
            src = pkgs.fetchFromGitHub {
              owner = "FFmpeg";
              repo = "FFmpeg";
              rev = "5b614efc7e6134274fa5d05e240736be2dc203cc";
              hash = "sha256-nooegNH2qgT3y8ATga5bvkldKE71Qyw4FoBM8ZgguqQ=";
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
            version = "2026-09-11";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "14f2d48cbc7dda61adb4bd181e107a1f3f76e533";
              hash = "sha256-3pKNN+cyM7ut22y22FcEhiE+GBoYH5zEhu1duygqsF8=";
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
