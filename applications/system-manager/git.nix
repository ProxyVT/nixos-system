{ lib, config, pkgs, ... }: {

programs.git = {
  enable = true;
  package = pkgs.gitFull;
  config = {
    user = {
      name = "ProxyVT";
      email = "tikit.us@outlook.com";
    };
    safe.directory = "/home/ulad/nixos-system/.git";
  };
};

}
