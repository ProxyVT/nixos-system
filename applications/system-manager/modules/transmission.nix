{ pkgs, ... }: {

services.transmission = {
  enable = true;
  package = pkgs.transmission_4;
  performanceNetParameters = true;
  settings = {
    umask = 0;
    utp-enabled = true;
    incomplete-dir-enabled = false;
  };
};

}
