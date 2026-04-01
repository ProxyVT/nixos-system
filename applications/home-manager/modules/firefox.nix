{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      settings = {
        "toolkit.tabbox.switchByScrolling" = false;
        "browser.taskbarTabs" = true;
        "browser.tabs.hoverPreview.enabled" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.tabs.groups.smart.enabled" = true;
        "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
        "browser.settings-redesign.enabled" = true;
        "dom.webgpu.enabled" = true;
        "gfx.webrender.all" = true;
      };
    };
  };
}
