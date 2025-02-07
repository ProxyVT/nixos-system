{ pkgs, ... }: {

programs.yt-dlp = {
  enable = true;
  package = pkgs.edge.yt-dlp;
  settings = {
    downloader = "aria2c";
    merge-output-format = "mkv";
  };
};

}
