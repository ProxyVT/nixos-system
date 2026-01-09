{
  pkgs,
  lib,
  ...
}:
let
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
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "a01b6ebf72b56f8fd73c0c027bec49985ffa3d0a";
              hash = "sha256-y6wDbmOqLInThXPGefAT+bd1oYdNnhnYHG+QNGqKj10=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            patches = [ ];
            version = "0.41.0";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "85bf9f4ff46cd45686cfe2fd22f49828877db5cb";
              hash = "sha256-HsEr/lrdiqk2FmBSHdZm3+obQA2Cf/z2USiv7jlbSpg=";
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
