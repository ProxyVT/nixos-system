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
            version = "2e5a392b7f1e4c25d5a3f931e253d71ab566757f";
            src = previousAttrs.src.override {
              rev = finalAttrs.version;
              hash = "sha256-QpxCv2Gt989fp3Qyw6lszC40hUoxipw+hZq+unfyq3s=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            mesonFlags = lib.lists.filter (flag: !lib.strings.hasPrefix "-Dsdl2" flag) previousAttrs.mesonFlags;
            patches = [ ];
            version = "2e5e2938dd3f367b73fb58276208aa616e5d37a0";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = finalAttrs.version;
              hash = "sha256-hynMuJmVzoExXfYEztXd1QOAsUt/Po+OLQ6PFykd7xk=";
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
