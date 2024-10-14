{ lib, config, pkgs, ... }: {

  programs.bash = {
    enable = true;
    bashrcExtra = "
      alias sudo=doas
    ";
  };

}
