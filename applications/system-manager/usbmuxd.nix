{ lib, config, pkgs, ... }: {

usbmuxd = {
  enable = true;
  package = pkgs.usbmuxd2;
};

}
