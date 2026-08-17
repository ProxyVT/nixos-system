{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor_git;
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
