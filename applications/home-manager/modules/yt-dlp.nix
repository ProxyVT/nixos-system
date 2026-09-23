{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    package = pkgs.yt-dlp_git;
    settings = {
      downloader = "/home/ulad/.local/state/aria2-next/aria2c-wrapper";
      merge-output-format = "mkv";
      mtime = true;
      extractor-args = "youtube:player-client=visionos";
      embed-chapters = true;
    };
  };
}
