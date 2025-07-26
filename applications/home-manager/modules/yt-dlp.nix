{ pkgs, ... }:
{

  programs.yt-dlp = {
    enable = true;
    package = pkgs.yt-dlp_git;
    settings = {
      downloader = "aria2c";
      merge-output-format = "mkv";
      mtime = true;
    };
  };

}
