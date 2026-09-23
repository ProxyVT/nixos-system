{ extraPkgs, ... }:
{
  programs.nix-init = {
    enable = true;
    package = extraPkgs.nix-init;
    settings = {
      maintainers = [ "ProxyVT" ];
    };
  };
}
