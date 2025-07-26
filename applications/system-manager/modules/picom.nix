{ ... }:
{

  services.picom = {
    enable = true;
    vSync = true;
    backend = "egl";
    settings = {
      unredir-if-possible = true;
      corner-radius = 0;
    };
  };

}
