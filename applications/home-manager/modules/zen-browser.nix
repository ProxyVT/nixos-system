{ pkgs, ... }:
{
  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    profiles.default = {
      name = "NixOS Ulad";
      spacesForce = true;
      spaces = {
        "Garbage" = {
          id = "a5eddfe0-5e2e-4009-8374-31dde8d67fdc";
          position = 1000;
        };
        "Atomic Energy" = {
          id = "c050dd27-46f9-41f6-ad9a-fd3466fa0ba6";
          position = 2000;
          icon = "⚛️";
        };
        "Business" = {
          id = "771575a0-905b-4a2a-a634-3aeba4fba41a";
          position = 3000;
          icon = "💸";
        };
      };
    };
  };

  home.persistence."/persist".directories = [
    ".zen"
  ];
}
