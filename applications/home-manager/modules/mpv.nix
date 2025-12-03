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
              rev = "53719e45d264d90d422f51e1fa21a2957131bf1a";
              hash = "sha256-WRqziCWDMC9pw14tnp6tWREyc6wSqOtNNZkbObj0wD8=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            mesonFlags = lib.lists.filter (flag: !lib.strings.hasPrefix "-Dsdl2" flag) previousAttrs.mesonFlags;
            patches = [ ];
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "23f9381b8053ad7fcba11b61607497ce43eaebc7";
              hash = "sha256-53h5AbC2wNPoMIqiuNOcaFziUAKtZElhFz0NyZLSlq4=";
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
