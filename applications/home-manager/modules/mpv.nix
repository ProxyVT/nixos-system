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
              rev = "1dcaea8b601aa969ffd5bfa70088957ce3eaa273";
              hash = "sha256-lgPawUN0rMcAJU8eaPfFPSoJ8xH20+gUlZewNslabIs=";
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
              rev = "d1743b641b5b8a51115a9828124c7a9b527115e3";
              hash = "sha256-hNx1NtQd/DQr8jmPTnbibLimb4yWAcQqNCJpncEBH1E=";
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
