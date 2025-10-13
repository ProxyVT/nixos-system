{ ... }:
{
  services.aria2 = {
    enable = true;
    serviceUMask = "0002";
    rpcSecretFile = "/var/lib/aria2/secret";
    settings = {
      enable-rpc = true;
      rpc-listen-all = false;
      rpc-allow-origin-all = false;
      input-file = "/var/lib/aria2/aria2.session";
      disk-cache = "256M";
      force-save = true;
      continue = true;
      pause-metadata = true;
      auto-save-interval = 10;
      save-session-interval = 10;
      allow-overwrite = true;
      file-allocation = "none";
      bt-enable-lpd = true;
      bt-save-metadata = true;
      bt-load-saved-metadata = true;
      bt-remove-unselected-file = true;
      bt-detach-seed-only = true;
      bt-max-peers = 80;
      conditional-get = true;
      enable-dht6 = false;
      disable-ipv6 = true;
      dht-listen-port = "50000-50100";
      seed-ratio = 0;
      follow-torrent = "mem";
      max-concurrent-downloads = 8;
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/aria2"
  ];

  users.users.aria2.extraGroups = [ "users" ];
}
