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
            version = "2026-06-01";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "50db5d92f1931c9e4b4daeb4e37e8ffae3a3930b";
              hash = "sha256-9+Ef0QVsGY70NB0Z9GmFJDvQwkWNm6q3jSv2yWZ4E4s=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-06-01";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "f5d4d9b029affa4d5b7eb13b28d91a96e6a92280";
              hash = "sha256-NdQX+/M/d01TGAUfhBbGUpBw6I+abmK3zQxZB5OgtnU=";
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
