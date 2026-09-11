{ ... }:
{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default = {
      id = 0;
      name = "Default";
      settings = {
        "browser.sessionstore.restore_pinned_tabs_on_demand" = true;
        "browser.settings-redesign.enabled" = true;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.tabs.groups.smart.enabled" = true;
        "browser.tabs.hoverPreview.enabled" = false;
        "browser.taskbarTabs" = true;
        "browser.translations.automaticallyPopup" = false;
        "dom.webgpu.enabled" = true;
        "gfx.webrender.all" = true;
        "toolkit.tabbox.switchByScrolling" = false;
      };
    };
  };
}
