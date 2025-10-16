{ pkgs, ... }:
{
  programs.mangohud = {
    enable = true;
    package = pkgs.mangohud_git;
    settingsPerApplication = {
      mpv = {
        full = true;
        no_display = true;
        fps_sampling_period = 1000;
        throttling_status = false;
      };
    };
    enableSessionWide = true;
    settings = {
      full = true;
      no_display = true;
      fps_sampling_period = 1000;
    };
  };
}
