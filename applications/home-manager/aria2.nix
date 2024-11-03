{ ... }: {

  programs.aria2 = {
    enable = true;
    settings =  {
      enable-rpc = true;
      rpc-listen-all = true;
      rpc-allow-origin-all = true;
      rpc-secret = "september";
      disk-cache = "64M";
      force-save = true;
      continue = true;
      pause-metadata = true;
      save-session = "/home/ulad/.config/aria2/aria2.session";
      input-file = "/home/ulad/.config/aria2/aria2.session";
      auto-save-interval = 10;
      save-session-interval = 10;
      allow-overwrite = true;
      file-allocation = "none";
      bt-enable-lpd = true;
      bt-save-metadata = true;
      bt-load-saved-metadata = true;
      bt-remove-unselected-file = true;
      bt-detach-seed-only = true;
      bt-max-peers = 128;
      conditional-get = true;
      max-concurrent-downloads = 10;
      enable-dht6 = true;
      dht-listen-port = "50101-50109";
      seed-ratio = 0;
      follow-torrent = "mem";
      min-split-size = "1M";
    };
  };

}
