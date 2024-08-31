{ lib, config, pkgs, ... }: {

  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      name = "Default";
      settings = {
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "toolkit.tabbox.switchByScrolling" = false;
        "browser.tabs.hoverPreview.enabled" = false;
        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.translations.automaticallyPopup" = false;
        "browser.cache.check_doc_frequency" = 2;
      };
    };
  };

}
