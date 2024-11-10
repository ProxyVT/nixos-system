{ pkgs, ... }: {

  programs.thunderbird = {
    enable = true;
    package = pkgs.release.thunderbird;
    profiles.ulad = {
      isDefault = true;
    };
  };

}
