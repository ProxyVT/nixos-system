{ ... }: {

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settingsPerApplication = {
      mpv = {
        no_display = true;
      };
    };
    settings = {
      full = true;
    };
  };

}
