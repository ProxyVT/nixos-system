{ pkgs, ... }:
let
  yt-dlp-premium = pkgs.yt-dlp.overrideAttrs rec {
    pname = "yt-dlp-premium";
    version = "2025.06.21.224056";
    src = pkgs.fetchFromGitHub {
      owner = "coletdjnz";
      repo = "yt-dlp-dev";
      tag = version;
      hash = "sha256-BzxkaA59cQdM7UaU3erM8X4DDPkGRy/lPiAq0BCHfYE=";
    };
    postPatch = ''
      substituteInPlace yt_dlp/version.py \
        --replace-fail "UPDATE_HINT = None" 'UPDATE_HINT = "Nixpkgs/NixOS likely already contain an updated version.\n       To get it run nix-channel --update or nix flake update in your config directory."'
    '';
  };
  yt-dlp-wrapper = pkgs.writeShellScriptBin "yt-dlp-premium" ''
    exec ${yt-dlp-premium}/bin/yt-dlp "$@"
  '';
in
{
  home.packages = [ yt-dlp-wrapper ];
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
