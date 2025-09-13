{
  config,
  ...
}:
{

  services.rtorrent = {
    enable = true;
    openFirewall = true;
    dataDir = "~/.local/share/rtorrent";
  };

  services.flood = {
    enable = true;
    openFirewall = true;
    extraArgs = [ "--rtsocket=${config.services.rtorrent.rpcSocket}" ];
  };
  # allow access to the socket by putting it in the same group as rtorrent service
  # the socket will have g+w permissions
  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.rtorrent.group ];
}
