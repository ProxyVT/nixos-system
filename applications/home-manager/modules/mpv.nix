{ pkgs, ... }:
let
  mpv = pkgs.mpv.override {
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
    ];
    mpv = pkgs.mpv-unwrapped.overrideAttrs (oldAttrs: {
      patches = [ ];
      version = "git";
      src = pkgs.fetchFromGitHub {
        inherit (oldAttrs.src) owner repo;
        rev = "233e89698e69242209645f61472445bffb36fa42";
        hash = "sha256-m3PDmmfHFhBGUwhBxApqee5bzdMLrqRSA9eZLVZxN1o=";
      };
      ffmpeg = pkgs.ffmpeg_8-full;
      yt-dlp = pkgs.yt-dlp_git;
      libplacebo = pkgs.libplacebo.overrideAttrs (oldAttrs: {
        patches = [ ];
        version = "git";
        src = oldAttrs.src.override {
          rev = "9bffcaf2da915aecce18dbf4ecc469649115674a";
          hash = "sha256-MAvDaKXBOAnhZSoi0oIuVwR+G/mIFlAl3HmLTG5IMpY=";
        };
      });
    });
  };
in
{
  programs.mpv = {
    enable = true;
    package = mpv;
  };
}
