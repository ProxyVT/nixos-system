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
        fps_limit = 0;
        fps_limit_method = "late";
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
