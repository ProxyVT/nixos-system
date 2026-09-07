{ omni, system, ... }:
{
  programs.nix-init = {
    enable = true;
    package = omni.unified.nix-init.packages.${system}.default;
    settings = {
      maintainers = [ "ProxyVT" ];
    };
  };
}
