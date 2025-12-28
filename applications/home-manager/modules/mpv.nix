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
    mpv =
      (pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg_8-full;
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "bc90ef94944a3dcaab324b86d3e3769ad1d8698b";
              hash = "sha256-D+2MhG8NyAPUgt5w8CLlirT/kLuUtUT8dN4r5SccBoY=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            mesonFlags = lib.lists.filter (flag: !lib.strings.hasPrefix "-Dsdl2" flag) previousAttrs.mesonFlags;
            patches = [ ];
            version = "0.41.0";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "c0d989c83913fb9c990d961c44da4816b8d2de18";
              hash = "sha256-Gl6UxE9XbFqCjPaz3uLRpSNQF4eZ9wTre0sd4d7HW5g=";
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
