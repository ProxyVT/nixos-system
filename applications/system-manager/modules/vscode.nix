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

  # Persist cache for saving loging info between reboots
  environment.persistence."/persist" = {
    users.ulad.directories = [
      ".aws"
    ];
  };
}
