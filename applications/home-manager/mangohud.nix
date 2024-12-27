{ ... }: {

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settingsPerApplication = {
      mpv = {
        full = true;
        no_display = true;
      };
    };
    settings = {
      full = true;
    };
  };

}
