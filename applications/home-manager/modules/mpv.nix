{
  pkgs,
  lib,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-10-16";
      src = previousAttrs.src.override {
        rev = "074b0869c7d758306d7b29d13f59801b73caaee2";
        hash = "sha256-ev4nlccqre/dzw6BZ4l6qtSLrBqFdXWAvYsH7bOBb4s=";
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
            version = "2026-10-18";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "ccb74c6c13b1676e3af368cbe9281bfe649c17c6";
              hash = "sha256-+6kS4lOXpQsj98zAKdwVYFLwGExEo2uVxohrryfgSX4=";
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
            version = "2026-10-18";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "6a262d11f63733d37e3ee6d5fafcb1be1ef83952";
              hash = "sha256-XM4W+aPxKe7gt7wSm9hL3UxWD071X9nbuvIjXFVjEq4=";
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
