{ pkgs, ... }:
{

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      settings = {
        "toolkit.tabbox.switchByScrolling" = false;
        "browser.tabs.hoverPreview.enabled" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.tabs.groups.smart.enabled" = true;
        "dom.webgpu.enabled" = true;
        "gfx.webrender.all" = true;
      };
    };
  };

}
