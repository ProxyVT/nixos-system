{ pkgs, ... }:
{
  services.deluge = {
    enable = true;
    package = pkgs.deluged;
    user = "ulad";
    group = "users";
    declarative = true;
    web.enable = true;
    dataDir = "/home/ulad/.config";
    authFile = "/home/ulad/.local/state/deluge-auth";
  };
}
