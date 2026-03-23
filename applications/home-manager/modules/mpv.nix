{
  pkgs,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-02-24";
      src = previousAttrs.src.override {
        rev = "99510d50b89e3724b6115d9ef06731e97a50b7cf";
        hash = "sha256-f1gMGZxITWh9ycbme0mYQtu3qwNa2DJ1Fh0ANL2jfrQ=";
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
        ffmpeg = pkgs.ffmpeg_8-full;
        libplacebo = pkgs.libplacebo.overrideAttrs (
          finalAttrs: previousAttrs: {
            version = "2026-03-06";
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "4c654e50a4eb63b16b6af3ffc480f910dd46b36a";
              hash = "sha256-qqFezc2qmFKH+Sd0h70DAjyvYut37K5HHjuKrHGOwsg=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-03-06";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "f9190e57f9d29a7a387b2b9f49671ebf19ea09bd";
              hash = "sha256-GoSnn8PTF86Mkrvtp2+pNOo/tJ8yX5csHzKWISe5NQs=";
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
