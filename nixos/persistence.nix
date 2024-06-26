{ inputs, outputs, lib, config, ... }:
  
{
  environment.persistence."/nix" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.ulad = {
      home = "/nix/home/ulad";
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".local/share/Steam"
      ];
      files = [
        ".screenrc"
      ];
    };
  };
}
