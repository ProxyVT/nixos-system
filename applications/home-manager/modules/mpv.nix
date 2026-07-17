{
  pkgs,
  lib,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-05-23";
      src = previousAttrs.src.override {
        rev = "41040532f840b8089ae1bedba906071959347771";
        hash = "sha256-DG/c7dCaMbwjcno5XCnL2O63dXQ/U/TZPR7ECYrJJfg=";
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
            version = "2026-07-08";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "a7a18af88ff0a17c04840dcb3246047bb6b46df3";
              hash = "sha256-cA8+APhpu3m38z5hs2EhsNlLb/xHAy/Tcxi5loFS6j0=";
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
            version = "2026-07-14";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "94335ab87ab225ca3e36e0faeac831639d3e1d4e";
              hash = "sha256-UggUsEiO0xEGNy63iEb+qt/lYNce8TvRFj86riSekh8=";
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
