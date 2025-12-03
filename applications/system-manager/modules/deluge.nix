{ pkgs, ... }:
{
  services.deluge = {
    enable = true;
    package = pkgs.deluged;
    declarative = true;
    web.enable = true;
    authFile = "/home/ulad/.local/state/deluge-auth";
  };

  environment.persistence."/persist".directories = [
    "/var/lib/deluge"
  ];

  users.users.deluge.extraGroups = [
    "users"
    "storage"
  ];
}
