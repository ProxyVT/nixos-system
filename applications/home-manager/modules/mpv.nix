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
            version = "2026-09-02";
            src = pkgs.fetchFromGitHub {
              owner = "FFmpeg";
              repo = "FFmpeg";
              rev = "9fc8c785e2747c87121ec28f8f10ceab0562384b";
              hash = "sha256-9UUxp6fRri8nQf1+VBGh7jVDFBS2VCP5n4Z2rpAv+mo=";
            };
          }
        );
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            version = "2026-09-01";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "86bbd5df43fe579d0f173c538a94584ab79d7e10";
              hash = "sha256-hNkkH5yKymSXWJJXSXyzNkfo59aSib0nwsCTzehtYQU=";
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
            version = "2026-09-02";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "69e63f425a531f814431fba12750bdb3721357f2";
              hash = "sha256-hiuLY7tobXA4F0/iCnEqbMeD1qKROc37HyMR5pKY6g4=";
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
