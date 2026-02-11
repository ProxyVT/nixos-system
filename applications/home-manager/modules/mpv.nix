{
  pkgs,
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
            version = "v7.358+data=2026-02-09";
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "b2ea27dceb6418aabfe9121174c6dbb232942998";
              hash = "sha256-0d1coxOMDh5/Xi0dcI5rMgQVZojVE5j9Wt9LmsES3SM=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "v0.41.0+date=2026-02-10";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "3847a8157f6e44d7788dea2d1c172bc20bc50120";
              hash = "sha256-9fRzlxdOh1Na5h7CuNMUTQNVH9DZazC8kCFffQVFwus=";
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
