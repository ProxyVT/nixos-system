{ ... }: {

services.picom = {
  enable = true;
  vSync = true;
  backend = "egl";
  extraArgs = [
    "--unredir-if-possible"
    "--corner-radius=5"
    "--realtime"
  ];
};

}
