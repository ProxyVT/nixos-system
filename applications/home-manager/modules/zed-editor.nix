{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor_git;
    defaultEditor = true;
    extensions = [
      "git-firefly"
      "html"
      "log"
      "nix"
      "xy-zed"
    ];
    extraPackages = with pkgs; [
      nil
      nixd
    ];
  };
}
