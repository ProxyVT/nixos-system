{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.kiro;
    profiles.default = {
      userSettings = {
        "kiroAgent.enableTabAutocomplete" = true;
      };
      extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
        bbenoist.nix
        jnoortheen.nix-ide
      ];
      enableUpdateCheck = false;
    };
  };

  home.persistence."/persist".directories = [
    ".aws"
    ".kiro"
  ];
}
