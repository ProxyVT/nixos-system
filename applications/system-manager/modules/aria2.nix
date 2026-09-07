{ pkgs, ... }:
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
      disk-cache = "512M";
      force-save = true;
      continue = true;
      pause-metadata = true;
      save-session-interval = 10;
      allow-overwrite = true;
      no-file-allocation-limit = "64M";
      bt-enable-lpd = true;
      bt-max-peers = 128;
      disable-ipv6 = true;
      seed-ratio = 0;
      follow-torrent = "mem";
      max-concurrent-downloads = 50;
      optimize-concurrent-downloads = true;
      http-accept-gzip = true;
      remote-time = true;
      file-allocation = "none";
      bt-first-last-piece-first = true;
      bt-port-mapping = true;
      state-save-interval = 10;
      detach-share-only = true;
      listen-port = [
        { from = 6900; to = 6900; }
      ];
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/aria2"
  ];

  users.users.aria2.extraGroups = [
    "users"
    "storage"
  ];

  nixpkgs.overlays = [
    (final: prev: {
      aria2 = pkgs.testing.aria2-next.overrideAttrs (prev: {
        postFixup = ''
          ln -s aria2-next $out/bin/aria2c
        '';
      });
    })
  ];
}
