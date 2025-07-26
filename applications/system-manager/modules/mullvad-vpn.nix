{ pkgs, ... }: {

services.mullvad-vpn = {
  enable = true; 	                      # Mullvad VPN support
  package = pkgs.edge.mullvad-vpn;
};

}
