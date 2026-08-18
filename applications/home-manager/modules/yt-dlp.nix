{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    package = pkgs.yt-dlp_git;
    settings = {
      downloader = "wget";
      merge-output-format = "mkv";
      mtime = true;
      extractor-args = "youtube:player-client=visionos";
      embed-chapters = true;
    };
  };
}
