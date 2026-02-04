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
            version = "v7.358+data=2026-01-13";
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
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "v0.41.0+date=2026-02-02";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "db22a4528ff4ca77253c0dbc80fb96908c8c48f1";
              hash = "sha256-u1UyDWBIOBAzy4nYr/5hKzL8t4Gvy4+W1VzbTnRGCTc=";
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
