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
        hash = "sha256-m39e5sb7QCMfezq11M0LwR4irPVvbXxQNNavHdALodw=";
      };
    });
    settings = {
      downloader = "aria2c";
      merge-output-format = "mkv";
      mtime = true;
      extractor-args = "youtube:player-client=visionos";
    };
  };
}
