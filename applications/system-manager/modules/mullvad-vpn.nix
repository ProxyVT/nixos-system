{ pkgs, ... }:
{
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.edge.mullvad-vpn;
  };
}
