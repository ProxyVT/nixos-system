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
            version = "2026-03-29";
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "54e527552fa74467bcc7692e6985d35540861d19";
              hash = "sha256-5Kop4K45ohsJUkEgRRlSU5XTXZExotXpk3KfXQw1WYE=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-04-12";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "da4789c2ddce92713347ecf1b5912fceb812ea39";
              hash = "sha256-GRmRMHdjT+v+yso7qGZOxTBJ8588ZY/BjBAxqVi/zlU=";
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
