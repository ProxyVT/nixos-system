{ lib, config, pkgs, ... }: {

  programs.bash = {
    enable = true;
    historyControl = [ "erasedups" ];
    bashrcExtra = "
      alias sudo=doas";
  };

}
