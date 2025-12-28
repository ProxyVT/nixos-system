{ pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
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
