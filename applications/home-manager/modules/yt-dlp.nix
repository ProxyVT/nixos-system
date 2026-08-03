{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    package = pkgs.testing.yt-dlp.overrideAttrs (old: {
      version = "sabr";
      src = pkgs.fetchFromGitHub {
        owner = "bashonly";
        repo = "yt-dlp";
        rev = "sabr";
        hash = "sha256-I4ctJgjZiuzsOtdySOibGlZDJ5opg2o8ADIcfnc30Io=";
      };
    });
    settings = {
      downloader = "aria2c";
      merge-output-format = "mkv";
      mtime = true;
      downloader-args = "aria2c:\"-x 8 -s 8 -k 1M\"";
    };
  };
}
