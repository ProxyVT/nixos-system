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
            version = "2026-03-13";
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "33b5dfada6a84692912e4d41f673f895df79479e";
              hash = "sha256-6hHjnBhLgarXJudqxcE9qJMcBjrhStiJMocX1eDuZt4=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-03-17";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "ad9374d03eff4c5018cb6d66815f2223585ca21b";
              hash = "sha256-3fyqG3YkfRnSgxSUx7spqJtsvYgaqvTFCm5pCh4KVLU=";
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
