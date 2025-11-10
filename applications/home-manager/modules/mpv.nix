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
    mpv =
      (pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg_8-full;
        libplacebo = pkgs.libplacebo.overrideAttrs (oldAttrs: {
          patches = [ ];
          version = "git";
          src = oldAttrs.src.override {
            rev = "06992a53fafc1549843c8b36751e166cfe3a4079";
            hash = "sha256-CQnE7Olg+YdbU3KfudpZWSEDup06rEiaqA7WPj9Jr/c=";
          };
        });
      }).overrideAttrs
        (oldAttrs: {
          mesonFlags = lib.lists.filter (flag: !lib.strings.hasPrefix "-Dsdl2" flag) oldAttrs.mesonFlags;
          patches = [ ];
          version = "git";
          src = pkgs.fetchFromGitHub {
            inherit (oldAttrs.src) owner repo;
            rev = "2e5e2938dd3f367b73fb58276208aa616e5d37a0";
            hash = "sha256-hynMuJmVzoExXfYEztXd1QOAsUt/Po+OLQ6PFykd7xk=";
          };
        });
  };
in
{
  programs.mpv = {
    enable = true;
    package = mpv-git;
  };
}
