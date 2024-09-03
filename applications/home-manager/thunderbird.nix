{ lib, config, pkgs, ... }: {

  programs.thunderbird = {
    enable = true;
    package = pkgs.stable.thunderbird;
    profiles.ulad = {
      isDefault = true;
    };
  };

}
