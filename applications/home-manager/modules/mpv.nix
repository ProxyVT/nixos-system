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
            version = "2026-05-22";
            patches = [ ];
            src = pkgs.fetchFromGitLab {
              inherit (previousAttrs.src) owner repo;
              domain = "code.videolan.org";
              rev = "051cc36fd6e3ca06d64f848b6a38f708f98a2a91";
              hash = "sha256-iJPCOzPGOSzM/XCZYOTtzPCpYmECDkAOgtWG9BeZ0Lc=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-05-22";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "9e06c3248a67a14717909db4a02709bc22fe559e";
              hash = "sha256-ISG5kZBmaQ1RzmQpFN+FxM6Dvty4dnbr78siJvkgBIc=";
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
