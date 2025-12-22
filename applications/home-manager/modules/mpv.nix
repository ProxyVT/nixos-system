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
              rev = "47587a2d47299f7261a01b77e989b74f80a99769";
              hash = "sha256-5VpUEEitsgLGO+P5XxECurfR01XwThkYC685h2iaNgQ=";
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
              rev = "c0433f064e1eaceeb01602b81174ed96ff6f8b51";
              hash = "sha256-o2K9eUkcHdOj266SKjrTmJ0jlOL7MuiojvvQoCwBGpM=";
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
