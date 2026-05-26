{
  pkgs,
  ...
}:
let
  uosc = pkgs.mpvScripts.uosc.overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "2026-04-18";
      src = previousAttrs.src.override {
        rev = "95dd6085643f009e8bdb4976fce32a0afc489511";
        hash = "sha256-fh/s5r5mOXcyl0cbBRpQ9C8e7CA0rxnHRD80ix1BqDk=";
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
