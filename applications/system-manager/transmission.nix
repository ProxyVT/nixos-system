{ pkgs, ... }: {

  services.transmission = {
    enable = true;
    package = pkgs.transmission_4-gtk;
    settings = {
      umask = 0;
    };
  };

}
