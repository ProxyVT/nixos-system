{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.kiro;
    profiles.default = {
      userSettings = {
        "kiroAgent.agentModelSelection" = "claude-sonnet-4";
        "kiroAgent.enableTabAutocomplete" = true;
      };
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        bbenoist.nix
        jnoortheen.nix-ide
      ];
      enableUpdateCheck = false;
    };
  };

  # Persist cache for saving loging info between reboots
  home.persistence."/persist".directories = [
    ".aws"
    ".kiro"
  ];
}
