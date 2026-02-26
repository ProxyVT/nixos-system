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
            version = "2026-02-18";
            patches = [ ];
            src = previousAttrs.src.override {
              rev = "c93aa134ab62365ce1177efff99b8e1e66a818e7";
              hash = "sha256-4lydvyPqHt1JbiVSa5uPEU6GrNSMlAViP6wPn83wZnU=";
            };
          }
        );
      }).overrideAttrs
        (
          finalAttrs: previousAttrs: {
            nativeInstallCheckInputs = [ ];
            patches = [ ];
            version = "2026-02-24";
            src = pkgs.fetchFromGitHub {
              inherit (previousAttrs.src) owner repo;
              rev = "4bb048c2270b6c4d1c516f29d48615c0309c8904";
              hash = "sha256-O6X3yQuypcUYBsCNb2ta/k2RIfBMI0bUOBnSJCx93N4=";
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
