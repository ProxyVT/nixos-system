{ lib, config, pkgs, ... }: {

  programs.thunderbird = {
    enable = true;
    profiles.ulad = {
      isDefault = true;
    };
  };

}
