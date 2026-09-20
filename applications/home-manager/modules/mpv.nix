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
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            version = "2026-09-18";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "e2972fdd09adacd383656738d7d280f0cd84a761";
              hash = "sha256-7xGBjcYXW4Ucl/W9RTcpe3n5F1CAqMmyGcVrWqoT9ew=";
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
            version = "2026-09-14";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "0b7ed670f7c353dd3dd4f8ae0fc788a181a15aa6";
              hash = "sha256-vIV6a17fCTjwgo6ObIUC3fGeWZUAOjFjb0P8F9whbgY=";
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
