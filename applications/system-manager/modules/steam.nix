{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.edge.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
