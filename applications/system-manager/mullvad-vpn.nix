{ pkgs, ... }: {

  services.mullvad-vpn = {
    enable = true; 	                      # Mullvad VPN support
    package = pkgs.mullvad-vpn;
  };

}
