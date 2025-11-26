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
            version = "06992a53fafc1549843c8b36751e166cfe3a4079";
            src = previousAttrs.src.override {
              rev = finalAttrs.version;
              hash = "sha256-CQnE7Olg+YdbU3KfudpZWSEDup06rEiaqA7WPj9Jr/c=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            mesonFlags = lib.lists.filter (flag: !lib.strings.hasPrefix "-Dsdl2" flag) previousAttrs.mesonFlags;
            patches = [ ];
            version = "8469605191c1fb3c9ebf84617a4b2e2bada357fa";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = finalAttrs.version;
              hash = "sha256-XRMCJJs1v8NZPlYSJM5p+6P3TYdovO4lTV6YNqVFxEw=";
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
