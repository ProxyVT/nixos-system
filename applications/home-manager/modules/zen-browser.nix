{ pkgs, inputs, ... }:
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
        };
      };
    };
  };

  xdg.mimeApps =
    let
      value =
        let
          zen-browser = inputs.zen-browser.packages.x86_64-linux.beta;
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

  home.persistence."/persist".directories = [
    ".zen"
  ];
}
