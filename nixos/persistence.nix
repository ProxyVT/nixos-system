{ inputs, outputs, lib, config, ... }: {

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/etc/mullvad-vpn"
      { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
    ];
    files = [
      "/etc/machine-id"
      { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
    ];
    users.ulad = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "VirtualBox VMs"
        "nixos-system"
        ".gnupg"
        ".ssh"
        ".nixops"
        ".config"
        ".local"
        ".mozilla"
        ".thunderbird"
        ".cache/thumbnails"
        ".cache/aria2"
      ];
      files = [
        ".screenrc"
        ".bash_history"
      ];
    };
  };
}
