{ pkgs, ... }:
let
  yt-dlp-premium = pkgs.yt-dlp.overrideAttrs (finalAttrs: {
    pname = "yt-dlp-premium";
    version = "2026.01.29";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      tag = finalAttrs.version;
      hash = "sha256-nw/L71aoAJSCbW1y8ir8obrFPSbVlBA0UtlrxL6YtCQ=";
    };
  });
  yt-dlp-wrapper = pkgs.writeShellScriptBin "yt-dlp-premium" ''
    exec ${yt-dlp-premium}/bin/yt-dlp "$@"
  '';
in
{
  home.packages = [ yt-dlp-wrapper ];
  programs.yt-dlp = {
    enable = true;
    package = pkgs.edge.yt-dlp;
    settings = {
      downloader = "aria2c";
      merge-output-format = "mkv";
      mtime = true;
    };
  };
}
