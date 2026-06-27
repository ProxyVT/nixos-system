{
  pkgs,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-05-23";
      src = previousAttrs.src.override {
        rev = "41040532f840b8089ae1bedba906071959347771";
        hash = "sha256-DG/c7dCaMbwjcno5XCnL2O63dXQ/U/TZPR7ECYrJJfg=";
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
            version = "2026-06-10";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "2d0979fb54e025e904c7372666fffbf5dae40f66";
              hash = "sha256-vy0sZj49/z+h9jn+8RIpMtDq5YB4Ks5bLihCMRQGw58=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            version = "2026-06-04";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "4013a3c9b6f6b3b4d2d8f971e91c2e1eab3f8184";
              hash = "sha256-hXegoyTeD4szr9yTLqqZlOKEO8sr7ChNRcfT1MkTW+A=";
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
