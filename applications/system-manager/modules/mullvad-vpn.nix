{ pkgs, ... }:
{
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.release.mullvad-vpn;
  };
}
