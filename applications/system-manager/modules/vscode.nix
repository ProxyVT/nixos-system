{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.kiro;
    defaultEditor = true;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
  };
}
